package kr.co.hany.controller.admin.base;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.base.ManageDAO;
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
@RequestMapping(value="/admin/base/manage/*")
public class ManageController extends AdminDefaultController{
	
	@Autowired
	ManageDAO manageDao;
	
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/manage"+Const.aTiles;
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
		return "/base/manage_add"+Const.uaTiles;
	}
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_manage_proc( Map<String, Object> map
														     ,HttpServletResponse response
														     ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		System.out.println(rtn);
		try{
			
			param.put("a_hp", param.getString("a_hp01")+"-"+param.getString("a_hp02")+"-"+param.getString("a_hp03"));
			
			manageDao.add_manage(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	
	@RequestMapping ("mod.do")
	public String modManage( Map<String, Object> map
							,HttpServletResponse response
							,HttpSession session){
		
		try{
			
			param.put("start", 0);
			param.put("pageing", 1);
			
			map.put("info", manageDao.select_manage_one(param));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/manage_mod"+Const.uaTiles;
	}
	
	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		System.out.println(rtn);
		try{
			
			param.put("a_hp", param.getString("a_hp01")+"-"+param.getString("a_hp02")+"-"+param.getString("a_hp03"));
			
			String a_pass = param.getString("a_pass", "");
			if(!"".equals(a_pass)){
				param.put("a_pass", SecurityUtil.getCryptoMD5String(a_pass));				
			}
			
			manageDao.mod_manage(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	
	@RequestMapping ("del.do")
	public String del_manage( Map<String, Object> map
							 ,HttpServletResponse response
							 ,HttpSession session){
		
		try{
			
			
			System.out.println("del = "+param);			
			manageDao.delete_manage(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/manage_mod"+Const.uaTiles;
	}
	
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_admin( Map<String, Object> map
														  ,HttpServletResponse response
														  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = manageDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
		
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(manageDao.select_manage(param));
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
}
