package kr.co.hany.common;

import java.awt.Menu;
import java.util.HashMap;
import java.util.Map;

public class Const {
	public static String uTiles = ".bss";
	public static String aTiles = ".abss";
	public static String pTiles = ".pop";
	public static String uaTiles = ".a";
	public static String uuTiles = ".u";

	public static String Dir = "";

	
//	public static String DOMAIN = "http://localhost";
	
	// 기본 디렉토리 
	//public static String  UPLOAD_ROOT   = "/source/dalma_file/";
	/*
	public static String  UPLOAD_ROOT   = "C:/Yoon2/";
	public static String FILEURL        = "http://localhost/upload";
	*/
	
	public static String  UPLOAD_ROOT   = "/www/jsherb_com/www/upload/";
	public static String FILEURL        = "http://www.jsherb.ccom/upload";
	
	public static String UPLOAD_URL = "";
	
	public static String IMAGE_TEMP_DIR = "";
	public static String IMAGE_ORI_DIR= "/image";
	public static String IMAGE_REPLACE_DIR = "";
	public static int IMAGE_FILE_SIZE = 50;
	public static int NORMAL_FILE_SIZE = 50;
	public static String NORMAL_FILE_FOLDER = "/normal";
	
	
	public static final int FILE_LIMIT  = 10;
	public static final int PHOTO_LIMIT = 10;
	
	//url
	
	
	// 페이징 처리
	final public static int PAGESIZE           = 10;
	final public static int PAGESIZE4          = 4;
	final public static int PAGESIZE5          = 5; 
	final public static int PAGESIZE6          = 6;
	final public static int PAGESIZE10         = 10;
	final public static int PAGESIZE15         = 15;
	final public static int PAGESIZE20         = 20;
	final public static int PAGELISTNO       = 1; 
	final public static int COMMENT_PAGESIZE = 5;
	// 이메일
	public static String mailServerName = "127.0.0.1";
	public static String mailSendUserName = "";
	public static String mailSendAddr = "";
	
	public static String[] ALPA = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
	
	//년도
	public static String[] YEAR ={"2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"};
	//핸드폰 앞자리
    final public static String[] CEL1 = {"010","011","016","017","018","019"};
	//국번 앞자리
    final public static String[] TEL1 = {"02","031","032","041","042","043","051","052","053","054","055","061","062","063","064","070"};
       
    
    public static String errMsg = "다시시도해주세요.";
    public static String sucMsg = "정상처리되었습니다.";
    
    
    public static int A_DELIVERY_PRICE  = 4000;
    public static int A_DELIVERY_PLUS   = 2000;
    /*
 	public static String NP_encodeKey = "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg=="; 
   	public static String NP_MID       = "nicepay00m";
   	*/
    public static String NP_encodeKey = "6EBIxyBVEapBY1YAKTnOnwVTpIH56MWICJ19hUVgrBO4GLRn2a1SjqOcbIfVJdQu1lRK/XEQye6mnj4U8gx5dA==";
    public static String NP_MID       = "jsherb111m";
    public static String NP_moid      = "jsherb";    
    public static String NP_url       = "https://web.nicepay.co.kr/v3/webstd/js/nicepay-2.0.js";
    public static String NP_c_pass    = "123456";
    public static String NP_KeyIn     = "6EBIxyBVEapBY1YAKTnOnwVTpIH56MWICJ19hUVgrBO4GLRn2a1SjqOcbIfVJdQu1lRK/XEQye6mnj4U8gx5dA==";    
    public static String DOMAIN_NM    = "HSHERB";
    
}
