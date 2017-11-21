package com.sshs.core.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

public class Configure {
	private static final Logger logger = Logger.getLogger(Configure.class);
	private static Properties props;
	static {
		loadProps();
	}

	synchronized static private void loadProps() {
		logger.info("开始加载properties文件内容.......");
		props = new Properties();
		InputStream in = null;
		try {
			/* 第一种，通过类加载器进行获取properties文件流- */
			in = Configure.class.getClassLoader().getResourceAsStream("config/configure.properties");
			props.load(in);

			String runMode = props.getProperty("core.runMode");
			if (StringUtils.isNotEmpty(runMode)) {
				in = Configure.class.getClassLoader()
						.getResourceAsStream("config/configure-" + runMode.toLowerCase() + ".properties");
				if (in != null) {
					props.load(in);
				}
			}
		} catch (FileNotFoundException e) {
			logger.error("jdbc.properties文件未找到");
		} catch (IOException e) {
			logger.error("出现IOException");
		} finally {
			try {
				if (null != in) {
					in.close();
				}
			} catch (IOException e) {
				logger.error("jdbc.properties文件流关闭出现异常");
			}
		}
		logger.info("加载properties文件内容完成...........");
		logger.info("properties文件内容：" + props);
	}

	public static String getProperty(String key) {
		if (null == props) {
			loadProps();
		}
		return props.getProperty(key);
	}

	public static String getProperty(String key, String defaultValue) {
		if (null == props) {
			loadProps();
		}
		return props.getProperty(key, defaultValue);
	}

	/**
	 * 获取classpath1
	 * 
	 * @return
	 */
	public static String getClasspath() {
		String path = (String.valueOf(Thread.currentThread().getContextClassLoader().getResource("")) + "../../")
				.replaceAll("file:/", "").replaceAll("%20", " ").trim();
		if (path.indexOf(":") != 1) {
			path = File.separator + path;
		}
		return path;
	}

	/**
	 * 获取classpath2
	 * 
	 * @return
	 */
	public static String getClassResources() {
		String path = (String.valueOf(Thread.currentThread().getContextClassLoader().getResource("")))
				.replaceAll("file:/", "").replaceAll("%20", " ").trim();
		if (path.indexOf(":") != 1) {
			path = File.separator + path;
		}
		return path;
	}

	/**
	 * 获取classpath下的指定文件URL
	 * 
	 * @param fileName
	 * @return
	 */
	public static URL getClassPathFileUrl(String fileName) {
		/**
		 * getResource()方法会去classpath下找这个文件，获取到url resource, 得到这个资源后，调用url.getFile获取到 文件
		 * 的绝对路径
		 */
		URL url = Configure.class.getResource(fileName);
		return url;
	}

	/**
	 * 获取classpath下的指定文件
	 * 
	 * @param fileName
	 * @return
	 */
	public static File getClassPathFile(String fileName) {
		URL url = getClassPathFileUrl(fileName);
		/**
		 * url.getFile() 得到这个文件的绝对路径
		 */
		logger.debug(">>>>>" + url.getFile());
		File file = new File(url.getFile());
		logger.debug(file.exists());
		return file;
	}

	/**
	 * 获取classpath下的指定文件的绝对路径
	 * 
	 * @param fileName
	 * @return
	 */
	public static String getClassPathFileName(String fileName) {
		URL url = getClassPathFileUrl(fileName);
		/**
		 * url.getFile() 得到这个文件的绝对路径
		 */
		logger.debug(">>>>>" + url.getFile());
		return url.getFile();
	}

	/**
	 * 获取classpath下的指定文件的绝对路径
	 * 
	 * @param fileName
	 * @return
	 */
	public static String getClassPathFileShortName(String fileName) {
		File file = getClassPathFile(fileName);
		return file.getName();
	}

	/**
	 * 获取classpath下的指定文件所在目录
	 * 
	 * @param fileName
	 * @return
	 */
	public static File getClassPathFileDir(String fileName) {
		File path = null;
		File file = getClassPathFile(fileName);
		logger.debug(file.exists());
		if (file.exists()) {
			path = file.getParentFile();
		}
		return path;
	}

	/**
	 * 获取classpath下的指定文件所在目录名
	 * 
	 * @param fileName
	 * @return
	 */
	public static String getClassPathFileDirName(String fileName) {
		File file = getClassPathFileDir(fileName);
		return file.getName();
	}
}