package kr.co.hany.controller.admin.order;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import kr.co.hany.dao.admin.base.LoginhisDAO;
import kr.co.hany.dao.admin.base.ManageDAO;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.admin.order.PersonalDAO;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/order/personal/*")
public class PersonalController extends AdminDefaultController{

	
	@Autowired
	PersonalDAO personalDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	BaseDAO baseDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
					   ,HttpServletResponse response
						,HttpSession session){
		
		try{
			List<Map<String, Object>> mem_list = codeDao.member_grade();
			
			String mem_code = StringUtil.getSeletCode(mem_list, "seqno", "member_nm");
			
			map.put("mem_list", mem_list);
			map.put("mem_code", mem_code);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/personal_list"+Const.aTiles;
	}
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = personalDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}*/
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(personalDao.select(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("add.do")
	public String add( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			
			Map<String, Object> view = personalDao.view(param);
			
			
			String admin_confirm = StringUtil.objToStr(view.get("admin_confirm"), "");
			String pay_yn        = StringUtil.objToStr(view.get("pay_yn"), "");
			if("n".equals(admin_confirm) && "y".equals(pay_yn)) {
				
				param.put("admin_id"   , adminSession.get("a_id"));
				param.put("admin_seqno", adminSession.get("a_seqno"));
				param.put("admin_name" , adminSession.get("a_name"));
				
				personalDao.confirm_admin(param);
				
			}// if
			
			
			map.put("view", personalDao.view(param));
			map.put("detail_list", personalDao.select_detail(param));
			map.put("add_bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/personal_add"+Const.uaTiles;
	}
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("upt_user", adminSession.get("a_id"));
			
			personalDao.add(param);
		
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("upt_user", adminSession.get("a_id"));
			
			personalDao.mod(param);
		
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			int cnt = personalDao.detail_count(param); 
			if(cnt == 0) {
				personalDao.del(param);
			}
			
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				personalDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
		
	}
	
}
