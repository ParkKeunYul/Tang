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
@RequestMapping(value="/admin/base/memGrade/*")
public class MemberGardeController extends AdminDefaultController{
	
	@Autowired
	MemberGradeDao memberGradeDao;
	
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/member_grade"+Const.aTiles;
	}
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_admin( Map<String, Object> map
														  ,HttpServletResponse response
														  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = memberGradeDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
		
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(memberGradeDao.select(param));
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
				memberGradeDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
		
	}
	
}
