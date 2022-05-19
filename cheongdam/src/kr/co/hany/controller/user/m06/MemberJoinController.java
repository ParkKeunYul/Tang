package kr.co.hany.controller.user.m06;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.user.m06.MemberJoinDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;

@Controller
@RequestMapping(value="/m06/*")
public class MemberJoinController extends UserDefaultController{
	
	@Autowired
	MemberJoinDAO memberJoinDao;
	
	
	@RequestMapping ("/m06/01.do")
	public String login(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/01"+Const.uuTiles;
	}//main
	
	@RequestMapping ("/m06/01_step1_1.do")
	public String v_step1_1(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/01_step1_1"+Const.uuTiles;
	}//
	
	@RequestMapping ("/m06/01_step2_1.do")
	public String v_step2_1(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/01_step2_1"+Const.uuTiles;
	}//main
	
	
	@RequestMapping ("/m06/01_step1_2.do")
	public String v_step1_2(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/01_step1_2"+Const.uuTiles;
	}//
	
	@RequestMapping ("/m06/01_step2_2.do")
	public String v_step2_2(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/01_step2_2"+Const.uuTiles;
	}//main
	
	@RequestMapping ("/m06/join_end.do")
	public String join_end(Map<String, Object> map, HttpServletResponse response){
		
		try {
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/main"+Const.uTiles;
		return "/m06/join_end"+Const.uuTiles;
	}//main
	
	
	@RequestMapping (value="proc_01_step2_1.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> proc_01_step2_1( Map<String, Object> map
															 ,HttpServletResponse response
															 ,HttpServletRequest requests
															 ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String referer = request.getHeader("referer");
			System.out.println("referer = "+ referer);
			
			if(referer == null ) {
				rtn.put("suc", false);		
				rtn.put("msg", "정상적인 경로가 아닙니다.");
				return rtn;
			}
			
			if( "".equals(param.getString("part", "")) || "".equals(param.getString("check_value_re", "")) ||  "".equals(param.getString("name", "")) ||
				"".equals(param.getString("id", ""))   || "".equals(param.getString("password", "")) ){
				rtn.put("suc", false);		
				rtn.put("msg", "정상적인 경로가 아닙니다.");
				return rtn;
			}
			
			List<Map<String, Object>> list = memberJoinDao.duple_id(param);

			if(list.size() != 0) {
				rtn.put("suc", false);		
				rtn.put("msg", "사용불가능한 아이디입니다.");
				return rtn;
			}
			
			String password = param.getString("password", "");
			if(!"".equals(password)){
				param.put("password", SecurityUtil.getCryptoMD5String(password));				
			}
			
			
			String tempPath  = Const.UPLOAD_ROOT+ "member_file/temp/";
			int next_seqno   = memberJoinDao.select_next_seqno();
			String folder_nm = "member_file";
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "member_file", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno, 1 , "member_file", folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "member_file2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "member_file2",folder_nm);
			
			
			param.put("jumin"    , param.getString("jumin1")+"-"+param.getString("jumin2")+"-"+ param.getString("jumin3"));
			param.put("handphone", param.getString("handphone01")+"-"+param.getString("handphone02")+"-"+ param.getString("handphone03"));
			param.put("email"    , param.getString("email1")+"@"+param.getString("email2"));
			param.put("biz_no"   , param.getString("biz_no_1")+"-"+param.getString("biz_no_2")+"-"+ param.getString("biz_no_3"));
			param.put("han_tel"  , param.getString("han_tel_1")+"-"+param.getString("han_tel_2")+"-"+ param.getString("han_tel_3"));
			param.put("han_fax"  , param.getString("han_fax_1")+"-"+param.getString("han_fax_2")+"-"+ param.getString("han_fax_3"));
			
			memberJoinDao.add_member(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("duple_id.do")
	public @ResponseBody Map<String, Object> duple_id( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			List<Map<String, Object>> list = memberJoinDao.duple_id(param);

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
	
	
	
}
