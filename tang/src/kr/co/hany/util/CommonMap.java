package kr.co.hany.util;

import java.io.Reader;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;


import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/**
 * request에 있는 모든 파라메터 정보들을 HashMap을 상속받은 CommonMap에 기억시킨다. 사용하기 쉽고, ibatis와 인서트 또는 업데이트 삭제, List로 가져올때 이클래스를 활용하면
 * 모델이 필요가없다. 이 자체자가 모델이므로 명칭은 CommonMap이다.
 * @author 송영문
 *
 */
public class CommonMap extends java.util.HashMap {

	//serialVersionUID 는 직렬화에 사용되는 고유 아이디
	private static final long serialVersionUID = -3671210048221588090L;

	private NumberFormat nf = NumberFormat.getInstance();

	private NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.KOREA);

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CommonMap.class);

	private boolean isSet = false;
	
	/**
	 * 
	 */
	public CommonMap() {
		super();
	}

	/**
	 * @param arg0
	 */
	public CommonMap(int arg0) {
		super(arg0);
	}

	/**
	 * @param arg0
	 * @param arg1
	 */
	public CommonMap(int arg0, float arg1) {
		super(arg0, arg1);
	}

	/**
	 * @param arg0
	 */
	public CommonMap(HttpServletRequest request) {
		//super(arg0);
		super();
		this.addAll(request.getParameterMap());
	}
	
	public CommonMap(String data) {
		//super(arg0);
		super();
		this.addAll(data);
	}	
	
	public void set() {
		this.isSet = true;
	}

	public boolean isSet() {
		return this.isSet;
	}

	public void addAll(Map map) {
		if (map == null) {
			return;
		}
		Iterator i$ = map.entrySet().iterator();
		do {
			if (!i$.hasNext()) {
				break;
			}
			java.util.Map.Entry entry = (java.util.Map.Entry) i$.next();
			Object value = entry.getValue();
			if (value != null) {
				Object toadd;
				if (value instanceof String[]) {
					String values[] = (String[]) (String[]) value;
					if (values.length > 1) {
						toadd = new ArrayList(Arrays.asList(values));
					} else {
						toadd = values[0];
					}
				} else {
					toadd = value;
				}
				//super.put(((String)entry.getKey()).toLowerCase(), toadd);
				super.put(((String)entry.getKey()), toadd);
			}
		} while (true);
	}
	
	public void addAll(String data) {
		if (data.equals("")) {
			return;
		}
		
		try{
			String[] arrayData = getSplit(data, "&");
			for(int i=0;i<arrayData.length;i++){
				String[] datas = getSplit(arrayData[i], "=");
				Object toadd;
				String key = datas[0];
				String val = "";
				if(datas.length > 1) val = datas[1];
				if(super.containsKey(key)){
					List tempList = new ArrayList();
					if(super.get(key) instanceof List){
						tempList = (List)super.get(key);
						tempList.add(URLDecoder.decode(val,"utf-8"));
					}else{
						tempList.add(super.get(key));
						tempList.add(URLDecoder.decode(val,"utf-8"));
					}
					toadd = tempList;
				}else{
					toadd = URLDecoder.decode(val,"utf-8");
				}
				super.put(key, toadd);		
			}
		}catch(Exception e){
			e.printStackTrace();
		}
//		do {
//			if (!i$.hasNext()) {
//				break;
//			}
//			java.util.Map.Entry entry = (java.util.Map.Entry) i$.next();
//			Object value = entry.getValue();
//			if (value != null) {
//				Object toadd;
//				if (value instanceof String[]) {
//					String values[] = (String[]) (String[]) value;
//					if (values.length > 1) {
//						toadd = new ArrayList(Arrays.asList(values));
//					} else {
//						toadd = values[0];
//					}
//				} else {
//					toadd = value;
//				}
//				//super.put(((String)entry.getKey()).toLowerCase(), toadd);
//				super.put(((String)entry.getKey()), toadd);
//			}
//		} while (true);
	}	
	
	public String getEscapeJs(String key)
	{
		return getEscapeJs(key, "");
	}
	
	public String getEscapeJs(String key, String def)
	{
		String str;
		
		if(get(key) == null)
			str = "";
		else
			str = String.valueOf(get(key));
		
		str = StringUtils.replace(str, "\\", "\\\\");
		str = StringUtils.replace(str, "\r\n", "\\n");
		str = StringUtils.replace(str, "'", "\\'");
		str = StringUtils.replace(str, "\"", "\\\"");

		if(str.equals(""))
			return def;
		else
			return str;
	}
	
	public String getEscapeHtml(String key)
	{
		return getEscapeHtml(key, "");
	}
	
	public String getEscapeHtml(String key, String def)
	{
		String str = String.valueOf(getString(key));
		
		if("".equals(str)){
			str = def;
		}else{
			str = StringUtils.replace(str, "&", "&amp;");
			str = StringUtils.replace(str, "<", "&lt;");
			str = StringUtils.replace(str, ">", "&gt;");
			str = StringUtils.replace(str, "\r\n", "<br>");
			str = StringUtils.replace(str, "\"", "&quot;");
			//str = StringUtils.replace(str, " ", "&nbsp;");
		}
		
		return str;
	}
	
	public String getEscapeTextarea(String key){
		return getEscapeTextarea(key, "");
	}
	
	public String getEscapeTextarea(String key, String def){
		String str = String.valueOf(getString(key));
		
		if("".equals(str)){
			str = def;
		}else{
			str = StringUtils.replace(str, "&", "&amp;");
			str = StringUtils.replace(str, "<", "&lt;");
			str = StringUtils.replace(str, ">", "&gt;");
			//str = StringUtils.replace(str, "\r\n", "<br>");
			str = StringUtils.replace(str, "\"", "&quot;");
			//str = StringUtils.replace(str, " ", "&nbsp;");
		}
		
		return str;
	}
	
	public long getLong(String key){
		return 	Long.parseLong(getString(key, "0"));	
	}
	
	public String getString(String key){
		return 	getString(key, "");	
	}
	
	public String getString(String key, String def) {
		
		//if(this.get(key.toLowerCase()) == null)
		if(this.get(key) == null)
			return def;
		else
		{
			// String str = this.getString(key.toUpperCase());
			//String str = String.valueOf(this.get(key.toLowerCase()));
			String str = String.valueOf(this.get(key));
			
			//str = Util.normalize(str);
			if (str.equals(""))
				str = def;
			
			return str;
		}
	}

	public int getInt(String key) {
		return getInt(key, 0);
	}
	
	public BigDecimal getBigDecimal(String key) {
		return new BigDecimal(getInt(key)).multiply(new BigDecimal(100));
	}
	
	public int getInt(String key, int def) {
		//Object obj = super.get(key.toLowerCase());
		Object obj = super.get(key);
		int ret = def;
		if (obj instanceof java.lang.Number) {
			ret = ((Number) obj).intValue();
		} else {
			try {
				ret = Integer.parseInt(obj.toString());
			} catch (Exception ex) {
				ret = def;
			}
		}
		return ret;
	}
	
	public int[] getInts(String key) {
		int[] ints = null;
		try{
			//String[] obj = (String[])super.get(key.toLowerCase());
			String[] obj = (String[])super.get(key);
			ints = new int[obj.length];
			for(int i=0;i<obj.length;i++){				
				ints[i] = getInt(obj[i]);				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return ints;		
	}

	public Integer getInteger(String key) {
		//return new Integer(this.getInt(key.toLowerCase()));
		return new Integer(this.getInt(key));
	}

	public double getDouble(String key) {
		double ret = 0;
		//Object obj = super.get(key.toLowerCase());
		Object obj = super.get(key);
		if (obj == null)
			return 0;
		try {
			ret = Double.parseDouble(obj.toString());
		} catch (Exception ex) {
			return 0;
		}
		return ret;
	}

	public String getPersent(String key) {
		String str = "";
		NumberFormat format = NumberFormat.getPercentInstance();
		double value = this.getDouble(key);
		str = format.format(value);
		return str;
	}

	public String getDateFormat(String key) {
		return getDateFormat(key, "yyyy-MM-dd");
	}
	
	public String getDateFormat(String key, String type) {
		String str = "";
		Object o = null;
		SimpleDateFormat in = new SimpleDateFormat("yyyyMMddkkmmss");
		SimpleDateFormat out = new SimpleDateFormat(type);

		//o = this.get(key.toLowerCase());
		o = this.get(key);
		if (o == null || o.toString().trim().equals(""))
			return "-";
		try {
			str = o instanceof String ? out.format(in.parse((String) o)) : out
					.format((Date) o);
		} catch (ParseException e) {
			logger.error("type=" + type + ",value=" + o, e);
			return "-";
		}

		return str;
	}

	public String getDateFormat(String key, String fType, String tType) {
		String str = "";
		String s = null;
		SimpleDateFormat in = new SimpleDateFormat(fType);
		SimpleDateFormat out = new SimpleDateFormat(tType);

		// s = this.getString(key.toLowerCase()).trim();
		//s = key.toLowerCase();
		s = key;
		if (s.equals(""))
			return "-";
		try {
			str = out.format(in.parse(s));
		} catch (ParseException e) {
			logger.error("type=" + tType + ",value=" + s, e);
			return "-";
		}

		return str;
	}

	public String getNumberFormat(String key) {
		String str = "";
		//str = nf.format(this.getDouble(key.toLowerCase()));
		str = nf.format(this.getDouble(key));
		return str;
	}

	public String getCurrencyFormat(String key) {
		String str = "";
		//double d = this.getDouble(key.toLowerCase());
		double d = this.getDouble(key);
		if (d == 0)
			return "-";
		str = cf.format(d);
		return str;
	}

	public Object put(Object arg0,Object arg1) {
		//arg0 = ((String)arg0).toLowerCase();
		arg0 = ((String)arg0);
		return super.put(arg0, arg1);
	}

	/**
	 * 현재 페이지 번호를 받아서 데이터베이스에서 가져올 시작번호와 끝번호를 commonMap에 기억시켜준다.
	 * @author 송영문(stylehosting
	 * @param page 현재페이지번호
	 * @param rows 리스트출력갯수
	 */
	public void setPageMap(int page, int rows) {
		int currentPage = page;
		int rowsPerPage = 0;
		if (rows != 0) {
			rowsPerPage = rows;
		}
		int startNum = (currentPage - 1) * rowsPerPage + 1;
		int endNum = currentPage * rowsPerPage;

		if (startNum == 1)
			startNum = 0;
		put("startNum", new Integer(startNum));
		put("endNum", new Integer(endNum));
		
	}
	
	public static String[] getSplit(String str, String delimiter)
	{
		int	cnt	= 0;
		String[] arrayData = null;

		if (str == null){
			return null;
		}

		if ( str != null && !str.equals("")){
			StringTokenizer	token =	new	StringTokenizer(str,delimiter);
			arrayData = new	String[token.countTokens()];

			while(token.hasMoreTokens()){
		   		arrayData[cnt++] = token.nextToken();
			}
		}
		return arrayData ;
	}

}
