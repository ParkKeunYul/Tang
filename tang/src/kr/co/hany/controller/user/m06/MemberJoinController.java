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
	
	@RequestMapping (value="proc_01_step2_1.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> proc_01_step2_1( Map<String, Object> map
															 ,HttpServletResponse response
															 ,HttpServletRequest requests
															 ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			
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
			
			try {
				Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "member_file", tempPath, "");
				if(file_info1 != null) {
					param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno, 1 , "member_file", folder_nm);
				}
				Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "member_file2", tempPath, "");
				if(file_info2 != null) {
					param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "member_file2",folder_nm);
				}
			}catch (Exception e) {}
			
			
			param.put("jumin"    , param.getString("jumin1")+"-"+param.getString("jumin2")+"-"+ param.getString("jumin3"));
			param.put("handphone", param.getString("handphone01")+"-"+param.getString("handphone02")+"-"+ param.getString("handphone03"));
			param.put("email"    , param.getString("email1")+"@"+param.getString("email2"));
			param.put("biz_no"   , param.getString("biz_no_1")+"-"+param.getString("biz_no_2")+"-"+ param.getString("biz_no_3"));
			param.put("han_tel"  , param.getString("han_tel_1")+"-"+param.getString("han_tel_2")+"-"+ param.getString("han_tel_3"));
			param.put("han_fax"  , param.getString("han_fax_1")+"-"+param.getString("han_fax_2")+"-"+ param.getString("han_fax_3"));
			
			boolean dbFlag =  memberJoinDao.add_member(param);
			
			if(dbFlag) {
				rtn = PageUtil.procSuc();
			}
			
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
