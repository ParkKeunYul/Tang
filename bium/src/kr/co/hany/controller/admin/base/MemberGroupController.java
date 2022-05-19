package kr.co.hany.controller.admin.base;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.base.ManageDAO;
import kr.co.hany.dao.admin.base.MemberGradeDao;
import kr.co.hany.dao.admin.base.MemberGroupDao;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.session.AdminSessionMgr;
import kr.co.hany.util.StringUtil;
import kr.co.hany.util.URI_Convert;
import kr.co.hany.vo.JsonObj;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

@Controller
@RequestMapping(value="/admin/base/memGroup/*")
public class MemberGroupController extends AdminDefaultController{
	
	@Autowired
	MemberGroupDao memberGroupDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			List<Map<String, Object>> mem_list   = codeDao.member_grade();
			List<Map<String, Object>> group_list = codeDao.member_group();
			
			map.put("mem_code", StringUtil.getSeletCode(mem_list, "seqno"  , "member_nm"));
			map.put("group_code", StringUtil.getSeletCode(group_list, "seqno", "group_nm","선택"));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/member_group"+Const.aTiles;
	}
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_admin( Map<String, Object> map
														  ,HttpServletResponse response
														  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = memberGroupDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
		
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(memberGroupDao.select(param));
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("add.do")
	public String addManage( Map<String, Object> map
							,HttpServletResponse response
							,HttpSession session){
		
		try{
			System.out.println("add_manage");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/member_group_add"+Const.uaTiles;
	}
	
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_manage_proc( Map<String, Object> map
														     ,HttpServletResponse response
														     ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		
		try{
			
			param.put("a_id", adminSession.get("a_id"));
			
			memberGroupDao.add(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				memberGroupDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	
}
