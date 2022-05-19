package kr.co.hany.util;

import sun.misc.BASE64Encoder;

import com.oreilly.servlet.Base64Decoder;

public class Base64 {
	/**
	 * BASE64 인코딩
	 *
	 * @param strPlainText 인코딩 할 문자열
	 * @return 인코딩 된 문자열
	 */
	public static String Base64Encode(final String strPlainText) {
		if (strPlainText == null || strPlainText.length() == 0) return "";

		try {
			byte[] strBuff = strPlainText.getBytes();
			return new BASE64Encoder().encode(strBuff);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * BASE64 디코딩
	 *
	 * @param strEncodedText 인코딩된 문자열
	 * @return 디코딩 된 문자열
	 */
	public static String Base64Decode(final String strEncodedText) {
		if (strEncodedText == null || strEncodedText.length() == 0) return "";
		
		try {
			return new String(EncodeUtil.strConvertUTF8(Base64Decoder.decode(strEncodedText)));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
