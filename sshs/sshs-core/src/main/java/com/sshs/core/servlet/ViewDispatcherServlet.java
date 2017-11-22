package com.sshs.core.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestContext;

import com.sshs.core.util.Configure;
import com.sshs.core.view.resolver.ViewResolver;

/**
 * @see 视图解析处理 Servlet implementation class ViewResolverServlet
 * 
 * @author Suny
 * @date 2017-11-15
 */
// @WebServlet(name = "viewResolverServlet", urlPatterns = { "*.w", "*.dw",
// "/scripts/*" }, loadOnStartup = 1)
public class ViewDispatcherServlet extends DispatcherServlet {

	private static final long serialVersionUID = 1L;

	Logger logger = Logger.getLogger(ViewDispatcherServlet.class);
	/**
	 * 页面缓存 容器
	 */
	private static Map<String, String> _cachedView = new HashMap<String, String>();

	/**
	 * html view模板文件
	 */
	private static String viewHtmlTemplate = "<!DOCTYPE html><html lang=\"zh-CN\"><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><base href=\"<!--_BasePath-->\">"
			+ "<!--_PageHeader--> </head> <!--_PageBody--> </html> <!--_PageFooter--> <!--_PageException-->";

	/**
	 * jsp view模板文件
	 */
	private static String viewJspTemplate = "";

	/**
	 * 运行模式
	 */
	private static String coreRunMode;

	/**
	 * 缓存标志
	 */
	private static boolean viewCacheFlag = true;

	/**
	 * view文件后缀名
	 */
	// private static String viewPattern = ".w.xml";

	/**
	 * 
	 */
	private static String basePath = null;

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		coreRunMode = Configure.getProperty("core.runMode", "run");
		if ("false".equalsIgnoreCase(Configure.getProperty("view.cached"))) {
			viewCacheFlag = false;
		} else if (!coreRunMode.equalsIgnoreCase("run") && !coreRunMode.toLowerCase().contains("prod")) {
			viewCacheFlag = false;
		}
		InputStream htmlTemplate = config.getServletContext().getResourceAsStream(
				Configure.getProperty("view.html.template.path", "/template/view/w3c-html5-template.html"));
		if (htmlTemplate == null) {
			htmlTemplate = this.getClass().getResourceAsStream(
					Configure.getProperty("view.html.template.path", "/template/view/w3c-html5-template.html"));
		}
		if (htmlTemplate != null) {
			try {
				viewHtmlTemplate = IOUtils.toString(htmlTemplate, "UTF-8");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if (htmlTemplate != null) {
					try {
						htmlTemplate.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						htmlTemplate = null;
					}
				}
			}
		}
	}

	@Override
	protected void doService(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 从后台代码获取国际化信息
		RequestContext requestContext = new RequestContext(request);
		request.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, new Locale("zh_CN"));
		logger.debug(">>>>>>>>>>>>>>" + requestContext.getMessage("male"));
		String uri = request.getRequestURI();
		if (uri.endsWith(".w") || uri.endsWith(".dw")) {
			/**
			 * 初始化basePath
			 */
			if (basePath == null) {
				basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
						+ request.getContextPath() + "/";
				viewHtmlTemplate = viewHtmlTemplate.replaceAll("\\<\\!--\\_BasePath\\--\\>", basePath);
			}

			// TODO Auto-generated method stub
			String viewRequest = request.getRequestURI();
			if (StringUtils.isNotEmpty(viewRequest)) {
				viewRequest = URLDecoder.decode(viewRequest.replaceFirst(request.getContextPath(), ""), "ISO-8859-1");
			}

			String cachedView = null;

			if (viewCacheFlag) {
				cachedView = _cachedView.get(viewRequest);
			}
			if (StringUtils.isEmpty(cachedView)) {
				doRequest(viewRequest, request, response);
			} else {
				request.getRequestDispatcher(cachedView).forward(request, response);
			}
		} else {
			super.doService(request, response);
		}
	}

	/**
	 * 处理页面请求
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void doRequest(String viewRequest, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filePath = request.getServletContext().getRealPath("");
		String viewFileName = getViewNameNoPattern(viewRequest);
		String pattern = getViewNamePattern(viewRequest);
		InputStream view = null;
		String debugViewRoot = Configure.getProperty("debug.view.root");
		if ((viewRequest.endsWith(".w") || viewRequest.endsWith(".dw")) && coreRunMode.equalsIgnoreCase("debug")
				&& StringUtils.isNotEmpty(debugViewRoot)) {
			view = FileUtils.openInputStream(new File(debugViewRoot + viewFileName + pattern));
		}
		if (view == null) {
			view = request.getServletContext().getResourceAsStream(viewFileName + pattern);
		}
		if (view == null) {
			view = request.getClass().getResourceAsStream(viewFileName + pattern);
		}

		String cachedView = "/.cached" + viewFileName + pattern;
		if (pattern != null && (pattern.endsWith("html") || pattern.endsWith("htm") || pattern.endsWith("jsp"))) {
			String text = doPageRequest(request, view, viewFileName, pattern);
			if (text != null && text.contains("<%")) {
				pattern = ".jsp";
			}
			if (!viewCacheFlag && !".jsp".equalsIgnoreCase(pattern)) {
				PrintWriter out = response.getWriter();
				out.print(text);
				out.close();
				return;
			} else {
				cachedView = "/.cached" + viewFileName + pattern;

				FileUtils.writeStringToFile(new File(filePath + cachedView), text, "UTF-8");
				_cachedView.put(viewRequest, cachedView);
				if (view != null) {
					view.close();
				}
				request.getRequestDispatcher(cachedView).forward(request, response);
			}
			logger.debug(">>>>>viewRequest:" + viewFileName + pattern + "  >>>>>view-text:" + text);
		} else if (view != null) {
			doResourceRequest(view, filePath + cachedView);
			if (view != null) {
				view.close();
			}
			request.getRequestDispatcher(cachedView).forward(request, response);
		}
		if (view != null) {
			view.close();
		}

	}

	/**
	 * 处理页面请求
	 * 
	 * @param request
	 * @param input
	 * @param viewFileName
	 * @param pattern
	 * @param cachedName
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	protected String doPageRequest(HttpServletRequest request, InputStream input, String viewFileName, String pattern)
			throws ServletException, IOException {
		if (input == null) {
			throw new ServletException("请求的视图文件:[" + (viewFileName + pattern) + "]不存在！");
		}

		// 处理视图内容
		String text = "";
		String privateJs = "<script type=\"text/javascript\">var Model;\r\n require([ \"" + request.getContextPath()
				+ viewFileName + ".js.dw\" ], function(model) {\r\n" + "		Model = model;\r\n" + "	}); </script>";

		if (text != null && text.contains("<%")) {
			text = ViewResolver.resolve(input, viewJspTemplate, request.getParameter("_pageType"))
					.replaceAll("\\&lt;\\%", "\\<\\%").replaceAll("\\%\\&gt;", "\\%\\>");
		} else {
			text = ViewResolver.resolve(input, viewHtmlTemplate, request.getParameter("_pageType"));
		}
		if (StringUtils.isNotEmpty(privateJs)) {
			text += privateJs;
		}
		return text;
	}

	/**
	 * 处理资源请求
	 * 
	 * @param request
	 * @param input
	 * @param viewFileName
	 * @param pattern
	 * @param cachedName
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void doResourceRequest(InputStream input, String fileName) throws ServletException, IOException {
		if (input != null) {
			IOUtils.copy(input, FileUtils.openOutputStream(new File(fileName)));
		}
	}

	/**
	 * 获取view名称不包含后缀名
	 * 
	 * @param viewName
	 * @return
	 */
	private String getViewNameNoPattern(String viewName) {
		if (viewName.endsWith(".w")) {
			return viewName.substring(0, viewName.lastIndexOf(".w"));
		} else if (viewName.endsWith(".dw")) {
			viewName = viewName.substring(0, viewName.lastIndexOf(".dw"));
			if (viewName.contains(".")) {
				return viewName.substring(0, viewName.lastIndexOf("."));
			}
		}
		return viewName;
	}

	/**
	 * 获取view后缀名
	 * 
	 * @param viewName
	 * @return
	 */
	private String getViewNamePattern(String viewName) {
		if (viewName.endsWith(".w")) {
			return ".w.html";
		} else if (viewName.endsWith(".dw")) {
			viewName = viewName.substring(0, viewName.lastIndexOf(".dw"));
			if (viewName.contains(".")) {
				return viewName.substring(viewName.lastIndexOf("."));
			}
		}
		return "";
	}
}