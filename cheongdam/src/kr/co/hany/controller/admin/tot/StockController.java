package kr.co.hany.controller.admin.tot;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.total.UseDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/total/stock/*")
public class StockController extends AdminDefaultController{

	
	@Autowired
	UseDAO useDao;
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/total/stock"+Const.aTiles;
	}
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = 1000000;
			
			
			String orderCol = param.getString("sidx","yak_name");
			String orderA   = param.getString("sord","asc");
			
			param.put("orderCol", orderCol);
			param.put("orderA", orderA);
			
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			
			System.out.println(param);
			
			jsonObj.setRows(useDao.select_all(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	

	@RequestMapping ("select_use.do")
	public @ResponseBody JsonObj  select_use( Map<String, Object> map
											 ,HttpServletResponse response
											 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = 1000000;
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			jsonObj.setRows(useDao.select_use_mon(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("select_add.do")
	public @ResponseBody JsonObj  select_add( Map<String, Object> map
											 ,HttpServletResponse response
											 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = 1000000;
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			jsonObj.setRows(useDao.select_add_mon(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
}
