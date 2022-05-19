/*
 * @(#)PropertyUtils.java
 *
 * Copyright (c) 2013 L&J System Co. All Rights Reserved.
 * 
 */
package kr.co.hany.util;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.HashMap;
import java.util.Properties;

/**
 * 프로퍼티를 컨트롤하는 유틸
 * src에 위치하는 Configuration.properties를 가져온다.
 *
 * @author  LHC
 */

public class PropertyUtils {
		private static String CONFIGURATION_PROPERTIES = "Configuration.properties";
	    private static HashMap<String, Properties> props = new HashMap<String, Properties>();
	    private static Object syncObj = new Object();

	    /**
	     * Configuration.properties의 데이터를 Properties 객체로 불러온다.
	     * 
	     * @return 요청한 Properties 객체 반환
	     */
	    public static Properties getProperties() {
	        return getProperties(CONFIGURATION_PROPERTIES);
	    }

	    /**
	     * Configuration.properties 에 존재하는 데이터를 가져온다.
	     * key를 기준으로 value를 반환한다.
	     * 
	     * @param key
	     * 				프로퍼티 객체에 정의된 key
	     * @return key에 매핑된 value 문자열을 반환
	     */
	    public static String getString(String key)
	    {
	        return getProperties() != null ? getProperties().getProperty(key) : null;
	    }

	    /**
	     * Configuration.properties 에 key, value로 데이터를 삽입한다.
	     * 
	     * @param key
	     * 				프로퍼티 객체에 정의할 key
	     * @param value
	     * 				프로퍼티 객체에 정의할 value
	     */
	    public static void setProperty(String key, String value) {
	        Properties pro = getProperties();
	        pro.setProperty(key, value);
	    }

	    public static Properties getProperties(String resource) {
	        if(!props.containsKey(resource))
	            synchronized(syncObj) {
	                if(!props.containsKey(resource))  {
	                    Properties p = null;
	                    URL url = locateFromClasspath(resource);
	                    if(url != null) {
	                        java.io.InputStream is = null;
	                        try {
	                            is = url.openStream();
	                            Properties tmp = new Properties();
	                            tmp.load(is);
	                            p = tmp;
	                        }
	                        catch(Exception exception) { }
	                    }
	                    if(p != null)
	                        props.put(resource, p);
	                }
	            }
	        return (Properties)props.get(resource);
	    }

	    public static URL locateFromClasspath(String resourceName) {
	        URL url = null;
	        ClassLoader loader = Thread.currentThread().getContextClassLoader();
	        if(loader != null)
	            url = loader.getResource(resourceName);
	        if(url == null)
	            url = ClassLoader.getSystemResource(resourceName);
	        return url;
	    }
}
