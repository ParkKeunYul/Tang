package kr.co.hany.util;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import kr.co.hany.common.Const;

public class PageUtil {
	
	
	
	public static Map<String, Object> procSet(){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("suc", false);		
		map.put("msg", "다시 시도해주세요");
		return map;
	}
	
	
	public static Map<String, Object> procSuc(){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("suc", true);		
		map.put("msg", "정상처리되었습니다");
		return map;
	}
	
	public static Map<String, Object> procSuc(String msg){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("suc", true);		
		map.put("msg", msg);
		return map;
	}
	
	
	public static CommonMap setListInfo( CommonMap param
			                            ,int total) {
		try {
			
			if(total > 0) {
				int page = param.getInt("page",1);
				
				if(page <0) {
					page = 1;
				}
				
				int row  = param.getInt("rows");
				
				param.put("start"  , (page-1) * row);
				param.put("pageing", row);
				
				
				int mok = total / row;
				int na  = total % row;
				if(na != 0) {
					mok  = mok + 1;
				}
				param.put("maxPage", mok);
				param.put("total", total);
			}else {
				
				param.put("maxPage", 0);
				param.put("total", total);
			}
			
			
			
			return param;
		}catch (Exception e) {
			return param;
		}
	}
	
	
	public static String getPage( List<Map<String, Object>> list
			                     ,CommonMap param
			                     ,int listCount
			                     ,int lastCount
			                     ,String url){
		String page = "";
		try{
			System.out.println(param);
			int iPage = ParamUtil.getIntValue(param.get("page"), 1);
			int iPageListno = ParamUtil.getIntValue( param.get("pagelistno"), 1);
			
			if(list.size() > 0){
				page+="<div class=\"paging\">";
				if(iPage > 10){
					page += "<a class='btn_prev' href='"+url+"?page="+ (iPageListno-1) *10; 
					page += "&pagelistno="+(iPageListno-1)+pageSearch(param)+"'>";
					page += "이전</a>\n";
					
				}
				
				int pagelistnoCnt = iPageListno *10 -9;
				int k = 1;
				for(int i = pagelistnoCnt ; i<=listCount ; i++){
					if(k<=10){
						if(i == iPage){
							page += "<a href='#' class='link_page on' title='현재페이지'>"+i+"</a>";
						}else{
							page +="<a  class='link_page' href='"+url+"?page="+i+""+pageSearch(param)+"'>"+i+"</a> \n";
						}
					}
					k++;
				}
				
				if( (iPageListno * 10) < listCount){
					page += "<a class='btn_next' href='"+url+"?page="+(iPageListno*10 +1 );
					page +=	"&pagelistno="+( iPageListno +1 )+pageSearch(param)+"'>";
					page += "다음</a> \n";			
				}
				page+="</div>";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return page;
	}
	
	public static String getPageMysql( List<Map<String, Object>> list
							          ,CommonMap param
							          ,int listCount
							          ,int lastCount
							          ,String url){
		
		String page = "";
		try{
			System.out.println(param);
			int iPage = ParamUtil.getIntValue(param.get("page"), 1);
			int iPageListno = ParamUtil.getIntValue( param.get("pagelistno"), 1);
			
			if(list.size() > 0){
				page+="<div class=\"paging\">";
				if(iPage > 10){
					page += "<a class='btn_prev' href='"+url+"?page="+ (iPageListno-1) *10; 
					page += "&pagelistno="+(iPageListno-1)+pageSearch(param)+"'>";
					page += "이전</a>\n"; 
				}
				
				int pagelistnoCnt = iPageListno *10 -9;
				int k = 1;
				for(int i = pagelistnoCnt ; i<=listCount ; i++){
					if(k<=10){
						if(i == iPage){
							page += "<a href='#' class='link_page on' title='현재페이지'>"+i+"</a>";
						}else{
							page +="<a  class='link_page' href='"+url+"?pagelistno="+(iPageListno)+"&page="+i+""+pageSearch(param)+"'>"+i+"</a> \n";
						}
					}
					k++;
				}
				
				if( (iPageListno * 10) < listCount){
					page += "<a class='btn_next' href='"+url+"?pagelistno="+(iPageListno+1)+"&page="+(iPageListno*10 +1 )+pageSearch(param)+"'>"+"다음</a> \n";
				}
				page+="</div>";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return page;
	}
	
	public static String getM_PageMysql( List<Map<String, Object>> list
							            ,CommonMap param
							            ,int listCount
							            ,int lastCount
							            ,String url){

		String page = "";
		try{
			System.out.println(param);
			int iPage = ParamUtil.getIntValue(param.get("page"), 1);
			int iPageListno = ParamUtil.getIntValue( param.get("pagelistno"), 1);
			
			if(list.size() > 0){
				page+="<div class=\"paginationBox\"><span>";
				if(iPage > 10){
					page += "<a class='btnPrev' href='"+url+"?page="+ (iPageListno-1) *10+pageSearch(param)+"'>"+"이전</a>\n"; 
				}
				
				int pagelistnoCnt = iPageListno *10 -9;
				int k = 1;
				for(int i = pagelistnoCnt ; i<=listCount ; i++){
					if(k<=10){
						if(i == iPage){
							page += "<a href='#' class='on' title='현재페이지'>"+i+"</a>";
						}else{
							//page +="<a  class='' href='"+url+"?page="+i+""+pageSearch(param)+"'>"+i+"</a> \n";
							page +="<a  class='' href='"+url+"?pagelistno="+(iPageListno)+"&page="+i+""+pageSearch(param)+"'>"+i+"</a> \n";
						}
					}
					k++;
				}
				
				if( (iPageListno * 10) < listCount){
					//page += "<a class='btn_next' href='"+url+"?page="+(iPageListno*10 +1 )+pageSearch(param)+"'>"+"다음</a> \n";
					page += "<a class='btn_next' href='"+url+"?pagelistno="+(iPageListno+1)+"&page="+(iPageListno*10 +1 )+pageSearch(param)+"'>"+"다음</a> \n";
				}
				page+="</span></div>";
			}
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return page;
	}
	
	
	public static String pageSearch(CommonMap bean){
		String search="";
		try{
			if( !StringUtil.StringNull( bean.get("search_value")).equals("") ){
				 search+="&search_title="+bean.get("search_title")+"&search_value="+bean.get("encodeSV");
			}
			

			if( !StringUtil.StringNull( bean.get("search_ch")).equals("") ){
				search+="&search_ch="+bean.get("search_ch");
			}
			
			
			if( !StringUtil.StringNull( bean.get("s_order_date")).equals("") ){
				search+="&s_order_date="+bean.get("s_order_date");
			}
			
			if( !StringUtil.StringNull( bean.get("e_order_date")).equals("") ){
				search+="&e_order_date="+bean.get("e_order_date");
			}
			
			if( !StringUtil.StringNull( bean.get("search_order_type")).equals("") ){
				search+="&search_order_type="+bean.get("search_order_type");
			}
			
			if( !StringUtil.StringNull( bean.get("search_order_type")).equals("") ){
				search+="&search_order_type="+bean.get("search_order_type");
			}
			
			if( !StringUtil.StringNull( bean.get("search_payment")).equals("") ){
				search+="&search_payment="+bean.get("search_payment");
			}
			
			if( !StringUtil.StringNull( bean.get("search_order_type")).equals("") ){
				search+="&search_order_type="+bean.get("search_order_type");
			}
			
			if( !StringUtil.StringNull( bean.get("search_date_type")).equals("") ){
				search+="&search_date_type="+bean.get("search_date_type");
			}
			
			if( !StringUtil.StringNull( bean.get("group_code")).equals("") ){
				search+="&group_code="+bean.get("group_code");
			}
			
			if( !StringUtil.StringNull( bean.get("sub_code")).equals("") ){
				search+="&sub_code="+bean.get("sub_code");
			}
			
			if( !StringUtil.StringNull( bean.get("search_cate")).equals("") ){
				search+="&search_cate="+bean.get("search_cate");
			}
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return search;
	}
	
	public static String pageUserSearch(CommonMap bean){
		String search="";
		try{
			
			if( !StringUtil.StringNull( bean.get("search_value")).equals("") ){
				 search+="&search_title="+bean.get("search_title")+"&search_value="+bean.get("encodeSV");
			}
			
			if( !StringUtil.StringNull( bean.get("search_ch")).equals("") ){
				search+="&search_ch="+bean.get("search_ch");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		return search;
	}
		
	//메뉴
	public static Map<String, Object> menu(String url,CommonMap param){
		Map<String, Object> menu = new HashMap<String, Object>();
		try{
			if(url.indexOf("/admin/base/") != -1){
				menu.put("fmenu", "1");
			}else if(url.indexOf("/admin/delivery/") != -1){
				menu.put("fmenu", "2");
			}else if(url.indexOf("/admin/order/") != -1 ){
				menu.put("fmenu", "3");
			}else if(url.indexOf("/admin/total/") != -1){
				menu.put("fmenu", "4");
			}else if(url.indexOf("/admin/item/") != -1){
				menu.put("fmenu", "5");
			}else if(url.indexOf("/admin/board/") != -1){
				menu.put("fmenu", "6");
			}
			menu.put("menu_url", url);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return menu;
	}
	
	
	public static Map<String, Object> user_menu(String href,CommonMap param){
		Map<String, Object> menu = new HashMap<String, Object>();
		String url=URI_Convert.ConvertingTest(href);
		//System.out.println("***************************url="+url);
		try{
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return menu;
	}
	
	
	public static void  scripAlertBack( HttpServletResponse response
			   					  	   ,String msg) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if(!"".equals(msg)) {
				out.println("alert('"+msg+"');   ");
			}
			out.println("history.go(-1);");
			out.println("</script>");
			
			out.flush();

		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void  scriptAlert(HttpServletResponse response
								   ,String msg
								   ,String url) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(!"".equals(msg)) {
				out.println("alert('"+msg+"');   ");
			}
			out.println("location.href='"+url+"';");
			out.println("</script>");
			
            out.flush();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
}
