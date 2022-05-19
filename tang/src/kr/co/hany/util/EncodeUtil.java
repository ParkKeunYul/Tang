package kr.co.hany.util;

import java.io.UnsupportedEncodingException;

public class EncodeUtil {

	/**
	 * 8859_1 문자열을  UTF-8 로 인코딩변경
	 * @param 8859_1 문자열
	 * @return UTF-8 로 인코딩변경된 문자열
	 */
	public static String strConvertUTF8(String str) throws UnsupportedEncodingException {
		/*
		try{
			if(str != null) str = new String(str.getBytes("8859_1"), "UTF-8");
		}catch (Exception e) {}
		*/
		return str;
	} 
}
