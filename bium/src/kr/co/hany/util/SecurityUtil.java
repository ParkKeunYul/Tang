package kr.co.hany.util;

import java.security.MessageDigest;


public class SecurityUtil {
	 public static String getCryptoMD5String(String inputValue) throws Exception {
        if( inputValue == null || inputValue.equals("")) return ""; 
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] ret = md.digest(inputValue.getBytes());
        String result = StringUtil.base64Encode(ret);    
        return result;
	 }
}
