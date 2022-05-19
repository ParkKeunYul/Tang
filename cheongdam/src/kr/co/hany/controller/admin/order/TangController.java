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
import kr.co.hany.dao.admin.base.LoginhisDAO;
import kr.co.hany.dao.admin.base.ManageDAO;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/order/tang/*")
public class TangController extends AdminDefaultController{

	
	@Autowired
	TangDAO tangDao;
	
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
		return "/order/tang"+Const.aTiles;
	}
	
	@RequestMapping ("view.do")
	public String view( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpSession session){
		
		try{
			
			map.put("info", tangDao.select_view(param));
			List<Map<String, Object>> deli_list = codeDao.delivery_group();

			map.put("deli_list", deli_list);
			map.put("deli_seqno", baseDao.select_base(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_view"+Const.uaTiles;
	}
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = tangDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}*/
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(tangDao.select_order(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	
	@RequestMapping ("update_payment.do")
	public @ResponseBody Map<String, Object> update_payment( Map<String, Object> map
													  	 ,HttpServletResponse response
													  	 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		try{
			
			tangDao.update_payment(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	@RequestMapping ("update_order.do")
	public @ResponseBody Map<String, Object> update_order( Map<String, Object> map
													  	  ,HttpServletResponse response
													  	  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		try{
			
			tangDao.update_order(param);
			
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
				tangDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	@RequestMapping ("detail_view.do")
	public String order_detail_view( Map<String, Object> map
									,HttpServletResponse response
									,HttpSession session){
		
		try{
			
			Map<String, Object> info = tangDao.order_view_one(param);
			String bunch = StringUtil.objToStr(info.get("bunch"), "");
			param.put("bunch", bunch);
			
			if(!"n".equals(bunch)) {
				map.put("bunchList", tangDao.order_view_bunch(param));
			}
			
			map.put("param"  , param);
			map.put("info"   , info);
			map.put("yaklist", tangDao.order_view_yakjae(param));
			
			
			System.out.println("datail_view");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_detail_view"+Const.uaTiles;
	}
	
	
	@RequestMapping ("detail_view.excel.do")
	public String detail_view_excel( Map<String, Object> map
									,HttpServletResponse response
									,HttpSession session){
		
		try{
			
			System.out.println(param);
			
			Map<String, Object> info = tangDao.order_view_one(param);
			System.out.println(info);
			String bunch = StringUtil.objToStr(info.get("bunch"), "");
			param.put("bunch", bunch);
			
			if(!"n".equals(bunch)) {
				map.put("bunchList", tangDao.order_view_bunch(param));
			}
			
			map.put("param"  , param);
			map.put("info"   , info);
			map.put("yaklist", tangDao.order_view_yakjae(param));
			
			
			System.out.println("datail_view");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_detail_view_excel"+Const.uaTiles;
	}
	
	
	@RequestMapping ("detail_view2.do")
	public String detail_view2( Map<String, Object> map
							   ,HttpServletResponse response
							   ,HttpSession session){
		
		try{
			
			Map<String, Object> info = tangDao.order_view_one(param);
			String bunch = StringUtil.objToStr(info.get("bunch"), "");
			param.put("bunch", bunch);
			
			if(!"n".equals(bunch)) {
				map.put("bunchList", tangDao.order_view_bunch(param));
			}
			
			map.put("param"  , param);
			map.put("info"   , info);
			map.put("yaklist", tangDao.order_view_yakjae(param));
			
			
			System.out.println("datail_view");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_detail_view2"+Const.uaTiles;
	}
	
	@RequestMapping ("detail_view.excel2.do")
	public String detail_view_excel2( Map<String, Object> map
									,HttpServletResponse response
									,HttpSession session){
		
		try{
			
			System.out.println(param);
			
			Map<String, Object> info = tangDao.order_view_one(param);
			System.out.println(info);
			String bunch = StringUtil.objToStr(info.get("bunch"), "");
			param.put("bunch", bunch);
			
			if(!"n".equals(bunch)) {
				map.put("bunchList", tangDao.order_view_bunch(param));
			}
			
			map.put("param"  , param);
			map.put("info"   , info);
			map.put("yaklist", tangDao.order_view_yakjae(param));
			
			
			System.out.println("datail_view");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_detail_view_excel2"+Const.uaTiles;
	}
	
	@RequestMapping ("update_d_info.do")
	public @ResponseBody Map<String, Object> update_d_info( Map<String, Object> map
					  		 							   ,HttpServletResponse response
					  		 							   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			tangDao.update_d_info(param);
			
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
			
			tangDao.add_order_del(param);
			tangDao.del_order(param);
			
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
			System.out.println(cardInfo);
			System.out.println(cardInfo.get("resultCode"));
			
			if(!"2001".equals(cardInfo.get("resultCode"))){
				rtn.put("msg", cardInfo.get("resultMsg"));
				return rtn;
			}
			
			param.put("card_cancel_tid", cardInfo.get("tid"));
			param.put("card_cancel_id", adminSession.get("a_id"));
			tangDao.update_card_cancel(param);
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			rtn = PageUtil.procSuc();
			rtn.put("card_cancel_id", adminSession.get("a_id")+"/"+sdf.format(today)+"<br/>/"+cardInfo.get("tid"));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	@RequestMapping ("tang_bokyoung_print.do")
	public String tang_bokyoung_print( Map<String, Object> map
									  ,HttpServletResponse response
									  ,HttpSession session){
		
		try{
			
			Map<String, Object> info = tangDao.order_view_one(param);
			map.put("info"   , info);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_bokyoung_print"+Const.uaTiles;
	}
	
	@RequestMapping ("update_talk_send.do")
	public @ResponseBody Map<String, Object> update_talk_send( Map<String, Object> map
						  		 							 ,HttpServletResponse response
						  		 							 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			tangDao.update_talk_send(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("batch_pay.do")
	public @ResponseBody Map<String, Object> batch_pay( Map<String, Object> map
													   ,HttpServletResponse response
													   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		try{
			
			System.out.println(param);
			
			tangDao.batch_pay(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	@RequestMapping ("tang_excel.do")
	public String excel( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			map.put("list", tangDao.select_order_excel(param));
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/order/tang_excel"+Const.uaTiles;
	}
	
	
}
