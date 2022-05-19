package kr.co.hany.controller.admin.base;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.base.LoginhisDAO;
import kr.co.hany.dao.admin.base.ManageDAO;
import kr.co.hany.dao.admin.base.MemberDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.session.UserSessionManager;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/base/member/*")
public class MemberController extends AdminDefaultController{

	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	LoginDAO loginDao;
	
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			StringBuffer mem_code = new StringBuffer();
			
			List<Map<String, Object>> mem_list   = codeDao.member_grade();
			List<Map<String, Object>> group_list = codeDao.member_group();
			
			map.put("mem_code", StringUtil.getSeletCode(mem_list, "seqno"  , "member_nm"));
			map.put("group_code", StringUtil.getSeletCode(group_list, "seqno", "group_nm","선택"));
			
			map.put("group_list", group_list);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/member"+Const.aTiles;
	}
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = memberDao.select_total(param);
			
			System.out.println(param);
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			jsonObj.setCnt(param.getInt("rows"));
			
			System.out.println(jsonObj.getCnt());
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				
				if("".equals(param.getString("sidx"))) {
					param.put("sidx", "seqno");
				}
				
				jsonObj.setRows(memberDao.select_member(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				memberDao.update_col(param);
				
				if("member_level".equals(param.getString("cellName"))) {
					if(param.getInt("cellValue") > 1) {
						int check = memberDao.check_setting(param);

						if(check == 0) {
							memberDao.addSetting(param);
						}
					}else{
						memberDao.delSetting(param);
					}
				}
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
		
	}
	
	
	@RequestMapping ("mod.do")
	public String add( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			map.put("mod_param", param);
			map.put("info", memberDao.view(param));
			
			
			param.put("mem_seqno", param.getString("seqno"));
			
			
			map.put("mem_point", memberDao.select_member_point(param));
			map.put("mem_list", codeDao.member_grade());
			map.put("group_list", codeDao.member_group());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/member_mod"+Const.uaTiles;
	}
	
	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		
		try{
			
			param.put("license_yn", param.getString("license_yn", "r"));
			param.put("bill_yn"   , param.getString("bill_yn", "r"));
			
			
			String password = param.getString("password", "");
			if(!"".equals(password)){
				param.put("password", SecurityUtil.getCryptoMD5String(password));				
			}

			if(param.getInt("member_level") > 1) {
				int check = memberDao.check_setting(param);

				if(check == 0) {
					memberDao.addSetting(param);
				}
			}else{
				memberDao.delSetting(param);
			}
			
			param.put("handphone", param.get("handphone_1")+"-"+param.get("handphone_2")+"-"+param.get("handphone_3"));
			param.put("tel"      , param.get("tel_1")+"-"+param.get("tel_2")+"-"+param.get("tel_3"));
			param.put("biz_no"   , param.get("biz_no_1")+"-"+param.get("biz_no_2")+"-"+param.get("biz_no_3"));
			param.put("han_tel"  , param.get("han_tel_1")+"-"+param.get("han_tel_2")+"-"+param.get("han_tel_3"));
			param.put("han_fax"  , param.get("han_fax_1")+"-"+param.get("han_fax_2")+"-"+param.get("han_fax_3"));
			
			String tempPath  = Const.UPLOAD_ROOT+ "member_file/temp/";
			String folder_nm = "member_file";
			int next_seqno   = param.getInt("seqno");
			
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
			
			memberDao.mod(param);
			
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	
	@RequestMapping ("out_member.do")
	public @ResponseBody Map<String, Object> out_member( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			memberDao.out_member(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("outlist.do")
	public String outlist( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			StringBuffer mem_code = new StringBuffer();
			
			List<Map<String, Object>> mem_list   = codeDao.member_grade();
			List<Map<String, Object>> group_list = codeDao.member_group();
			
			map.put("mem_code", StringUtil.getSeletCode(mem_list, "seqno"  , "member_nm"));
			map.put("group_code", StringUtil.getSeletCode(group_list, "seqno", "group_nm","선택"));
			
			map.put("group_list", group_list);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/member_out"+Const.aTiles;
	}
	
	
	@RequestMapping ("out_select.do")
	public @ResponseBody JsonObj  out_select( Map<String, Object> map
										 	 ,HttpServletResponse response
										 	 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = memberDao.select_out_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				
				if("".equals(param.getString("sidx"))) {
					param.put("sidx", "seqno");
				}
				
				jsonObj.setRows(memberDao.select_out_member(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("restore_member.do")
	public @ResponseBody Map<String, Object> restore_member( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			memberDao.restore_member(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("user.do")
	public String user( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		try{
			
			
			Map<String, Object> info = loginDao.userIdCheck(param);
			System.out.println(info);
			UserSessionManager usm = new UserSessionManager();
			usm.setLoginOut(request);
			usm.setSession(info, request);
			
			return "redirect:/main.do";
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/main.do";
	}
	
}
