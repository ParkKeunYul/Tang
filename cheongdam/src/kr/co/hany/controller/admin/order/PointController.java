package kr.co.hany.controller.admin.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.admin.item.AmountDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/order/point/*")
public class PointController extends AdminDefaultController{

	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	BaseDAO baseDao;
	
	@Autowired
	AmountDAO amountDao;
	
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
		return "/order/point"+Const.aTiles;
	}
	
	
	//
	// 국민 임한나 038 - 24 - 0453571
	//
	
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			System.out.println("2222222222222222222");
			System.out.println("2222222222222222222");
			System.out.println("2222222222222222222");
			System.out.println("2222222222222222222");
			
			int total = amountDao.selectOrder_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}*/
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(amountDao.selectOrder(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
}
