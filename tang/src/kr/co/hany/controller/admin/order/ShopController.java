package kr.co.hany.controller.admin.order;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;


@Controller
@RequestMapping(value="/admin/order/shop/*")
public class ShopController extends AdminDefaultController{

	
	@Autowired
	ShopDAO shopDao;
	
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
		return "/order/shop"+Const.aTiles;
	}
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = shopDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}*/
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(shopDao.select_shop(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("view.do")
	public String view( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			List<Map<String, Object>> deli_list = codeDao.delivery_group();

			map.put("deli_list", deli_list);
			map.put("info", shopDao.select_view(param));
			map.put("p_list", shopDao.select_order_no(param));
			map.put("deli_seqno", baseDao.select_base(param));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/shop_view"+Const.uaTiles;
	}
	
	@RequestMapping ("update_order.do")
	public @ResponseBody Map<String, Object> update_order( Map<String, Object> map
													  	  ,HttpServletResponse response
													  	  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		try{
			
			shopDao.update_order(param);
			
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
				shopDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("update_delivery.do")
	public @ResponseBody Map<String, Object> update_delivery( Map<String, Object> map
						  		 							,HttpServletResponse response
						  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			shopDao.delivery_update(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("update_d_info.do")
	public @ResponseBody Map<String, Object> update_d_info( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			shopDao.update_d_info(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			shopDao.add_order_del(param);
			shopDao.del_order(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	@RequestMapping ("card_cancel.do")
	public @ResponseBody Map<String, Object> card_cancel( Map<String, Object> map
					  		 					 		 ,HttpServletResponse response
					  		 					 		 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
		//	System.out.println(adminSession);
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			if(cardInfo == null) {
				rtn.put("msg", "취소된 결제건 혹은,\n결제 취소중 에러가 발생했습니다.");
				return rtn;
			}
			
			if(!"2001".equals(cardInfo.get("resultCode"))){
				return rtn;
			}
			param.put("card_cancel_id", adminSession.get("a_id"));
			shopDao.update_card_cancel(param);
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			rtn = PageUtil.procSuc();
			rtn.put("card_cancel_id", adminSession.get("a_id")+"/"+sdf.format(today));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	@RequestMapping ("update_talk_send.do")
	public @ResponseBody Map<String, Object> update_talk_send( Map<String, Object> map
						  		 							 ,HttpServletResponse response
						  		 							 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			shopDao.update_talk_send(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
}//ShopController
