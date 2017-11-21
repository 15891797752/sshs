package com.sshs.core.view.resolver;

import java.io.IOException;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.inject.Named;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.ParseSettings;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;

import com.sshs.core.util.ReflectHelper;
import com.sshs.core.util.SpringUtil;
import com.sshs.core.view.component.Component;

/**
 * @see 解析view
 * @author Suny
 * @date 2017-11-16
 */
public class ViewResolver {

	private static Logger logger = Logger.getLogger(ViewResolver.class);

	/**
	 * 
	 * @param doc
	 * @return
	 */
	public static String resolve(InputStream input, String viewTemplate, String pageType) {

		String text = "";
		try {
			Parser parser = Parser.htmlParser();
			parser.settings(new ParseSettings(true, true));
			Document doc = Jsoup.parse(input, "UTF-8", "", parser);

			StringBuffer headText = new StringBuffer();
			StringBuffer bodyText = new StringBuffer();
			Elements bodys = doc.getElementsByTag("body");
			if (bodys != null && bodys.size() > 0) {
				for (Element e : bodys) {
					bodyText.append(resolveBody(e));
				}
			}
			if (!"body".equalsIgnoreCase(pageType)) {
				Elements heads = doc.getElementsByTag("head");
				if (heads != null && heads.size() > 0) {
					for (Element e : heads) {
						headText.append(resolveHead(e));
					}
				}
				text = viewTemplate.replace("<!--_PageHeader-->", headText).replace("<!--_PageBody-->", bodyText)
						.replace("<!--_PageFooter-->", "").replace("<!--_PageException-->", "");
			} else {
				text = bodyText.toString();
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return text;
	}

	/**
	 * 
	 * @param body
	 * @return
	 */
	private static String resolveBody(Element body) {
		StringBuffer text = new StringBuffer();
		// text.append("<" + body.tagName() + body.attributes() + ">\n");
		text.append(body.ownText());
		Elements elements = body.children();
		for (Element e : elements) {
			text.append(resolveElement(e));
		}
		// text.append("</" + body.tagName() + ">");
		return text.toString();
	}

	/**
	 * 
	 * @param head
	 * @return
	 */
	private static String resolveHead(Element head) {
		StringBuffer text = new StringBuffer();
		text.append(head.children());
		return text.toString();
	}

	/**
	 * 
	 * @param element
	 * @return
	 */
	private static String resolveElement(Element element) {
		StringBuffer text = new StringBuffer();
		String name = element.tagName();
		String type = element.attr("type");
		if (StringUtils.isEmpty(type)) {
			if ("input".equalsIgnoreCase(name)) {
				type = "text";
			}
			if ("button".equalsIgnoreCase(name)) {
				type = "button";
			}
		}
		Object bean = SpringUtil.getComponent(name + ReflectHelper.capitalName(type));
		Component component = null;
		// start
		if (bean != null && bean instanceof Component) {
			component = (Component) bean;
			try {
				initComponent(component, element);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			String eleText = component.forStartTag();
			logger.debug(eleText);
			text.append(eleText);
		} else {
			text.append("<" + name + element.attributes() + ">\n");
		}
		// body
		text.append(element.data() + element.ownText());
		Elements elements = element.children();
		for (Element e : elements) {
			text.append(resolveElement(e));
		}
		// end
		if (component != null) {
			String eleText = component.forEndTag();
			logger.debug(eleText);
			text.append(eleText);
		} else {
			text.append("</" + name + ">\n");
		}

		return text.toString();
	}

	/**
	 * 通过element 初始化component
	 * 
	 * @param comp
	 * @param elment
	 * @return
	 */

	private static Element initComponent(Component component, Element element) {
		component.init();
		Element e = element.clone();
		Field[] fields = component.getClass().getFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			Object value = "";
			String attrName = "";
			if (element.hasAttr(fieldName)) {
				attrName = fieldName;
				value = element.attr(attrName);
			} else {
				Annotation[] annotations = field.getAnnotations();
				if (annotations != null && annotations.length > 0 && annotations[0] instanceof Named) {
					Named named = (Named) annotations[0];
					attrName = named.value();
					if (element.hasAttr(attrName)) {
						value = element.attr(attrName);
					}
				}
			}

			try {
				Method method = component.getClass().getMethod("set" + ReflectHelper.capitalName(fieldName),
						value.getClass());
				try {
					if (method != null) {
						method.invoke(component, value);
						e.removeAttr(attrName);
					}
				} catch (IllegalAccessException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (IllegalArgumentException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (InvocationTargetException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			} catch (NoSuchMethodException e1) {
				logger.error(e1.getMessage());
			} catch (SecurityException e1) {
				logger.error(e1.getMessage());
			}
		}
		return e;
	}
}