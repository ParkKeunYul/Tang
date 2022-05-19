package kr.co.hany.controller.user.m05;

import java.util.List;
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
import kr.co.hany.vo.JsonObj;

@Controller
public class MyInfoController extends UserDefaultController{


	
	@Autowired
	LoginDAO loginDAO;
	
	@Autowired
	MyInfoDAO myInfoDAO;
	
	
	@RequestMapping ("/m05/01.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			param.put("id", userSession.get("id"));
			
			
			
			if(!"0".equals( StringUtil.objToStr(userSession.get("mem_sub_seqno"), "") )) {
				PageUtil.scripAlertBack(response, "권한이 부족합니다.");
			}
			
			
			
			
			
			
			Map<String, Object> info  = loginDAO.userIdCheck(param);
			map.put("info", info);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/01"+Const.uTiles;
	}
	
	@RequestMapping ("/m05/01_mypage.do")
	public @ResponseBody Map<String, Object> mypage_01( Map<String, Object> map
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
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno, 1 , "member_file", folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "member_file2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "member_file2",folder_nm);
			
			
			myInfoDAO.updateInfo(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
		
	}
	
	
	@RequestMapping ("/m05/01_sub.do")
	public String v_01_sub( Map<String, Object> map
						   ,HttpServletResponse response
						   ,HttpSession session){
		
		try{
			
			if( StringUtil.ObjectToInt(userSession.get("mem_sub_seqno") ) != 0 ) {
				PageUtil.scripAlertBack(response, "권한이 부족합니다.");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/01_sub"+Const.uTiles;
	}
	
	@RequestMapping ("/m05/01_duple_sub_id.do")
	public @ResponseBody Map<String, Object> duple_sub_id( Map<String, Object> map
														  ,HttpServletResponse response
													      ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			List<Map<String, Object>> list = myInfoDAO.duple_sub_id(param);

			if(list.size() == 0) {
				rtn.put("check_id", 1);
				rtn.put("msg", "사용가능한 아이디입니다.");
			}else{
				rtn.put("check_id", 0);
				rtn.put("msg", "사용불가능한 아이디입니다..");
			}
			rtn.put("suc"     , true);
		}catch (Exception e) {
			e.printStackTrace();
			rtn.put("check_id", 0);
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("/m05/01_sub_id_proc.do")
	public @ResponseBody Map<String, Object> sub_id_proc( Map<String, Object> map
														 ,HttpServletResponse response
														 ,HttpServletRequest requests
														 ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			List<Map<String, Object>> list = myInfoDAO.duple_sub_id(param);

			if(list.size() != 0) {
				rtn.put("suc", false);		
				rtn.put("msg", "사용불가능한 아이디입니다.");
				return rtn;
			}
			
			String password = param.getString("password", "");
			if(!"".equals(password)){
				param.put("password", SecurityUtil.getCryptoMD5String(password));				
			}
			
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			boolean dbFlag =  myInfoDAO.add_sub_member(param);
			
			if(dbFlag) {
				rtn = PageUtil.procSuc();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("/m05/01_sub_list.do")
	public @ResponseBody JsonObj  jq_sub_list( Map<String, Object> map
										 	  ,HttpServletResponse response
										 	  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			param.put("mem_seqno", userSession.get("seqno"));
			
			int total = myInfoDAO.sub_listCount(param);
			
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(myInfoDAO.sub_list(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("/m05/01_sub_update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			
			String oper = param.getString("oper");
			if("edit".equals(oper)){
				
				if("password".equals( param.get("cellName") )) {
					String cellValue = param.getString("cellValue", "");
					param.put("cellValue", SecurityUtil.getCryptoMD5String(cellValue));				
				}
				
				myInfoDAO.sub_update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	@RequestMapping ("/m05/01_del_sub_id.do")
	public @ResponseBody Map<String, Object> del_sub_id( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			boolean dbFlag =  myInfoDAO.del_sub_id(param);
			
			if(dbFlag) {
				rtn = PageUtil.procSuc();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	
}
