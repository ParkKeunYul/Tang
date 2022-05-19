package kr.co.hany.util;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5
{
	/**
	 * MD5 인코딩
	 *
	 * @param strInput 인코딩 할 문자열
	 * @return 인코딩 된 문자열
	 */
	public static String Md5String( String strInput )
	{
		MessageDigest clsMd5;
    
		try
		{
			clsMd5 = MessageDigest.getInstance("MD5");
		}
		catch( NoSuchAlgorithmException e )
		{
			return null;
		}
  
		clsMd5.update( strInput.getBytes() );
		byte [] arrBuf = clsMd5.digest();
		int  iLen = arrBuf.length;
		StringBuffer clsBuffer = new StringBuffer();
		if( clsBuffer == null ) return null;
     
		for( int i = 0; i < iLen; ++i )
		{
			clsBuffer.append( String.format( "%02X", 0xFF & arrBuf[i] ) );
		}
   
		return clsBuffer.toString();
	}
}
