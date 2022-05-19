package kr.co.hany.controller.user.m05;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.AssertTrue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.user.m05.MyInfoDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class MyInfoController extends UserDefaultController{


	
	@Autowired
	LoginDAO loginDAO;
	
	@Autowired
	MyInfoDAO myInfoDAO;
	
	
	@RequestMapping ({"/m05/01.do" , "/m/m05/01.do"})
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			param.put("id", userSession.get("id"));
			
			Map<String, Object> info  = loginDAO.userIdCheck(param);
			map.put("info", info);
			
			System.out.println(info);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m05/01"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/01"+Const.uTiles;
	}
	
	@RequestMapping ("/m/m05/01_mypage.do")
	public @ResponseBody Map<String, Object> mypage_01_m( Map<String, Object> map
													   ,HttpServletResponse response
													   ,HttpServletRequest requests
													   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			param.put("seqno", userSession.get("seqno"));
			
			String password = param.getString("password", "");
			if(!"".equals(password)){
				param.put("password", SecurityUtil.getCryptoMD5String(password));				
			}
			
			
			param.put("jumin"    , param.getString("jumin1")+"-"+param.getString("jumin2")+"-"+ param.getString("jumin3"));
			param.put("handphone", param.getString("handphone01")+"-"+param.getString("handphone02")+"-"+ param.getString("handphone03"));
			param.put("email"    , param.getString("email1")+"@"+param.getString("email2"));
			param.put("biz_no"   , param.getString("biz_no_1")+"-"+param.getString("biz_no_2")+"-"+ param.getString("biz_no_3"));
			param.put("han_tel"  , param.getString("han_tel_1")+"-"+param.getString("han_tel_2")+"-"+ param.getString("han_tel_3"));
			param.put("han_fax"  , param.getString("han_fax_1")+"-"+param.getString("han_fax_2")+"-"+ param.getString("han_fax_3"));
			
			
			String tempPath  = Const.UPLOAD_ROOT+ "member_file/temp/";
			int next_seqno   = StringUtil.ObjectToInt(userSession.get("seqno"));
			String folder_nm = "member_file";
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "member_file", tempPath, "");
			if(file_info1 != null &&  "larger".equals( file_info1.get("fail")+"" )) {
				rtn.put("msg", Const.FILE_LIMIT+"메가 이상 파일은 첨부할 수 없습니다.");
				return rtn;
			}
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno, 1 , "member_file", folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "member_file2", tempPath, "");
			if(file_info2 != null && "larger".equals( file_info2.get("fail")+"'" )) {
				rtn.put("msg", Const.FILE_LIMIT+"메가 이상 파일은 첨부할 수 없습니다.");
				return rtn;
			}
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "member_file2",folder_nm);
			
			
			myInfoDAO.updateInfo(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("/m05/01_mypage.do")
	public String  mypage_01( Map<String, Object> map
						    ,HttpServletResponse response
						    ,HttpServletRequest requests
							,HttpSession session){
		try {
			
			param.put("seqno", userSession.get("seqno"));
			
			String password = param.getString("password", "");
			if(!"".equals(password)){
				param.put("password", SecurityUtil.getCryptoMD5String(password));				
			}
			
			
			param.put("jumin"    , param.getString("jumin1")+"-"+param.getString("jumin2")+"-"+ param.getString("jumin3"));
			param.put("handphone", param.getString("handphone01")+"-"+param.getString("handphone02")+"-"+ param.getString("handphone03"));
			param.put("email"    , param.getString("email1")+"@"+param.getString("email2"));
			param.put("biz_no"   , param.getString("biz_no_1")+"-"+param.getString("biz_no_2")+"-"+ param.getString("biz_no_3"));
			param.put("han_tel"  , param.getString("han_tel_1")+"-"+param.getString("han_tel_2")+"-"+ param.getString("han_tel_3"));
			param.put("han_fax"  , param.getString("han_fax_1")+"-"+param.getString("han_fax_2")+"-"+ param.getString("han_fax_3"));
			
			
			String tempPath  = Const.UPLOAD_ROOT+ "member_file/temp/";
			int next_seqno   = StringUtil.ObjectToInt(userSession.get("seqno"));
			String folder_nm = "member_file";
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "member_file", tempPath, "");
			if(file_info1 != null && "larger".equals( file_info1.get("fail")+"" ) ) {
				map.put("sc_msg", Const.FILE_LIMIT+"메가 이상 파일은 첨부할 수 없습니다.");
				return "/scriptMsg.mp";
			}
			System.out.println("file_info1 ="+ file_info1);
			if(file_info1 != null && !file_info1.isEmpty()) {
				param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno, 1 , "member_file", folder_nm);
			}
			
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "member_file2", tempPath, "");
			if(file_info2 != null &&"larger".equals( file_info2.get("fail")+"" )  ) {
				map.put("sc_msg", Const.FILE_LIMIT+"메가 이상 파일은 첨부할 수 없습니다.");
				return "/scriptMsg.mp";
			}
			System.out.println("file_info2 ="+ file_info2);
			if(file_info2!= null && !file_info2.isEmpty()) {
				param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "member_file2",folder_nm);
			}
			
			myInfoDAO.updateInfo(param);
			
		
			map.put("sc_msg", "저장되었습니다.");
			map.put("sc_url", "01.do");
			
			System.out.println(map);
		}catch (Exception e) {
			e.printStackTrace();
			map.put("sc_msg", "다시시도하세요");
			return "/scriptMsg.mp";
		}
						
		return "/scriptMsg.mp";
	}
	
	
	
	@RequestMapping ({"/m05/04.do" , "/m/m05/04.do"})
	public String contract( Map<String, Object> map
						   ,HttpServletResponse response
						   ,HttpSession session){
		
		try{
			param.put("id", userSession.get("id"));
			
			Map<String, Object> info  = loginDAO.userIdCheck(param);
			
			System.out.println(userSession.get("part"));
			System.out.println(userSession.get("part"));
			System.out.println(userSession.get("part"));
			System.out.println(userSession.get("part"));
			
			if("2".equals(userSession.get("part").toString())  ) {
				info.put("han_name"      , info.get("name"));
				info.put("biz_no"        , info.get(""));
				info.put("han_zipcode"   , info.get("zipcode"));
				info.put("han_address01" , info.get("address01"));
				info.put("han_address02" , info.get("address02"));
				info.put("han_tel"       , info.get("handphone"));
			}
			
			map.put("info", info);
			
			System.out.println(info);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m05/04"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04"+Const.uTiles;
	}
	
	
	
	@RequestMapping ({"/m05/04_pop.do" , "/m/m05/04_pop.do"})
	public String contract_pop( Map<String, Object> map
						   	   ,HttpServletResponse response
						   	   ,HttpSession session){
		
		try{
			map.put("bean", param);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m05/04_pop"+Const.mmTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04_pop"+Const.uuTiles;
	}
	
	
	@RequestMapping ({"/m05/05_pop.do" , "/m/m05/05_pop.do"})
	public String h_pop( Map<String, Object> map
						   	   ,HttpServletResponse response
						   	   ,HttpSession session){
		
		try{
			map.put("bean", param);
			
			
			param.put("id", userSession.get("id"));
			
			Map<String, Object> info  = loginDAO.userIdCheck(param);
			
			if("2".equals(userSession.get("part").toString())  ) {
				info.put("han_name"      , info.get("name"));
				info.put("biz_no"        , info.get(""));
				info.put("han_zipcode"   , info.get("zipcode"));
				info.put("han_address01" , info.get("address01"));
				info.put("han_address02" , info.get("address02"));
				info.put("han_tel"       , info.get("handphone"));
			}
			
			Date now = new Date();
			SimpleDateFormat sdf  = new SimpleDateFormat("YYYY");
			SimpleDateFormat sdf2 = new SimpleDateFormat("MM");
			SimpleDateFormat sdf3 = new SimpleDateFormat("dd");
			
			info.put("g_year" , sdf.format(now));
			info.put("g_month", sdf2.format(now));
			info.put("g_day"  , sdf3.format(now));
			
			
			info.put("han_fax", StringUtil.objToStr(info.get("han_fax"), "").replaceAll("--", "") );
			
			String jumin = StringUtil.objToStr(info.get("jumin"), "").replaceAll("-", "");
			
			if(jumin.indexOf("19") == 0 || jumin.indexOf("20") == 0) {
				jumin = jumin.substring(2, jumin.length());
			}
			
			
			info.put("jumin", jumin );
			
			
			map.put("info", info);
			map.put("bean", param);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m05/05_pop"+Const.mmTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/05_pop"+Const.uuTiles;
	}
	
	@RequestMapping ({"/m05/06_pop.do" , "/m/m05/06_pop.do"})
	public String v_06_pop( Map<String, Object> map
						   ,HttpServletResponse response
						   ,HttpSession session){
		
		try{
			map.put("bean", param);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m05/06_pop"+Const.mmTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/06_pop"+Const.uuTiles;
	}
	
}
