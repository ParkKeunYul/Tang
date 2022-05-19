package kr.co.hany.controller.admin.delivery;

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
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/delivery/base/*")
public class BaseController extends AdminDefaultController {

	@Autowired
	BaseDAO baseDao;
	
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/delivery/base"+Const.aTiles;
	}
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = baseDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(baseDao.select(param));
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
				if("sel_yn".equals(param.getString("cellName")) && "y".equals(param.getString("cellValue"))) {
					baseDao.update_sel_yn_all(param);
				}
				baseDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("add.do")
	public String add( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			map.put("add_param", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/delivery/base_add"+Const.uaTiles;
	}
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			baseDao.add(param);
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
}
