package kr.co.hany.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	/**
	 * 현재시간 가져오기
	 *
	 * @param 
	 * @return DateFormat "yyyy-MM-dd HH:mm:ss.SSS" 로 된 현재시간 문자열
	 */
	public static String getDate() {
		// 현재시간 가져오기
		Date getDate = new Date();
					 
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
		String getDateStr = df.format(getDate); 
					
		return getDateStr;
	}
	
	/**
	 * 현재날짜가 다른 일자(시작일와 종료일) 사이에 있는지 판단
	 *
	 * @param 시작일문자열
	 * @param 종료일 문자열
	 * @return boolean 값
	 */
	public static boolean isCurrent(String start_date, String end_date) throws ParseException {
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date product_start = date.parse(start_date);
		Date product_end = date.parse(end_date);
    	Date current = new Date();
	
    	return (current.after(product_start) && current.before(product_end));
	}
	
	/**
	 * 현재날짜가 종료일보다 뒤에있는지 판단
	 * @param 종료날자 문자열
	 * @return boolean 값
	 */
	public static boolean isFinished(String end_date) throws ParseException {
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date product_end = date.parse(end_date);
    	        Date current = new Date();
	
		return current.after(product_end);
	}
}
