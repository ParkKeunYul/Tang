package kr.co.hany.controller.user.m05;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.dao.user.m05.MyCartDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
public class MyCartController extends UserDefaultController{

	@Autowired
	MyCartDAO myCartDao;
	
	
	@RequestMapping ("/m05/02.do")
	public String v_03(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno"           , userSession.get("seqno"));
			
			map.put("sub_id", myCartDao.sub_id_list(param));
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/02"+Const.uTiles;
	}
	
	@RequestMapping ("/m05/02_mycart_list.do")
	public @ResponseBody JsonObj  jq_mycart_list( Map<String, Object> map
												 ,HttpServletResponse response
												 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			param.put("id"           , userSession.get("id"));
			param.put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			param.put("mem_sub_grade", userSession.get("mem_sub_grade"));
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			List<Map<String, Object>> list = myCartDao.list(param);
			
			param = PageUtil.setListInfo(param, list.size()); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("/m05/02_mycart_bundle_list.do")
	public @ResponseBody JsonObj  jq_mycart_bundle_list( Map<String, Object> map
														,HttpServletResponse response){
		
		JsonObj jsonObj = new JsonObj();
		try{
			param.put("id", userSession.get("id"));
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			List<Map<String, Object>> list = myCartDao.bundle_list(param);
			
			param = PageUtil.setListInfo(param, list.size()); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m05/02_add_bunch.do")
	public @ResponseBody Map<String, Object> aj_add_bunch( Map<String, Object> map
														  ,HttpServletResponse response){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id", userSession.get("id"));
			
			boolean flag = myCartDao.add_bunch(param);
			if(flag) {
				rtn  = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m05/02_cancel_bunch.do")
	public @ResponseBody Map<String, Object> aj_cancel_bunch( Map<String, Object> map
															 ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id", userSession.get("id"));
			
			boolean flag = myCartDao.cancel_bunch(param);
			if(flag) {
				rtn  = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m05/02_del_cart.do")
	public @ResponseBody Map<String, Object> aj_del_cart( Map<String, Object> map
														 ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id", userSession.get("id"));
			
			boolean flag = myCartDao.del_cart(param);
			if(flag) {
				rtn  = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "오류가 발생했습니다.");
			return rtn;
		}
	}
	
	@RequestMapping ("/m05/02_cart_order.do")
	public String cart_order(Map<String, Object> map, HttpServletResponse response){
		try {
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m05/02.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/main.do");
			}
			
			List<Map<String, Object>> list = myCartDao.select_ordering_list(param);
			if(list.size() == 0) {
	            PageUtil.scriptAlert(response, "결제할 처방이 없습니다.", "/m05/02.do");
			}
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			for(int i= (list.size()-1); i>=0 ; i--) {
				
				String s_goods_tot = list.get(i).get("order_total_price")+"";
				System.out.println("s_goods_tot = "+ s_goods_tot);
				s_goods_tot = s_goods_tot.replace(".0", "");
				System.out.println("s_goods_tot = "+ StringUtil.ObjectToInt(s_goods_tot));
				
				goods_tot += StringUtil.ObjectToInt(s_goods_tot);
				
				goods_name = StringUtil.objToStr(list.get(i).get("s_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("seqno") );
			}//for i
			
			System.out.println("goods_tot = "+ goods_tot);
			if(list.size()>1) goods_name = goods_name + "외 "+ (list.size()-1)+ "건";
			param.put("goods_tot", goods_tot);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			map.put("list", list);
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "오류가 발생했습니다.");
		}
		return "/m05/02_cart_order"+Const.uTiles;
	}
	
	
	@RequestMapping ("/m05/02_cart_order_com.do")
	public String cart_order_com(Map<String, Object> map, HttpServletResponse response){
		param.put("order_handphone", userSession.get("handphone") );
		
		try {
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m05/02_cart_order.do")  == -1 ) {
	            
	            map.put("sc_msg", "잘못된 접근입니다.");
				map.put("sc_url", "/main.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			
			String payment_kind = param.getString("payment_kind","");
			if("".equals(payment_kind)){
				map.put("sc_msg", "결제금액 정보다 다릅니다");
				map.put("sc_url", "/m05/02.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			
			String[] cart_seqno = request.getParameterValues("cart_seqno");
			String pay_seqno ="";
			for(int i = 0; i < cart_seqno.length ; i++) {
				if(i == 0) {
					pay_seqno += cart_seqno[i];
				}else {
					pay_seqno += ","+cart_seqno[i];
				}				
			}// for i
			param.put("pay_seqno", pay_seqno);
			param.put("bill_handphone", param.getString("bill_handphone01")+"-"+param.getString("bill_handphone02")+"-"+ param.getString("bill_handphone03"));
			
			
			int pay_total_order_price = param.getInt("pay_total_order_price");
			int order_total_price     = myCartDao.select_order_price_sum(param);
			
			if(pay_total_order_price != order_total_price) {
				
				map.put("sc_msg", "결제금액 정보다 다릅니다");
				map.put("sc_url", "/m05/02.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			
			if("Bank".equals(payment_kind)) {
				param.put("payment", "2"); // 1 입금
			}else {
				param.put("payment", "1"); // 1 입금
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				System.out.println("cardInfo = "+ cardInfo);
				
				String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
				if(!"3001".equals(cardInfo.get("resultCode")+"")) {
					
					map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
					return "/scriptMsg"+Const.uuTiles;
					
				}
				
				param.put("card_gu_no", cardInfo.get("tid"));
				param.put("card_ju_no", cardInfo.get("moid"));
				param.put("card_su_no", cardInfo.get("authCode"));
				param.put("card_nm"   , cardInfo.get("cardName"));
				param.put("card_code" , cardInfo.get("cardCode"));
				param.put("card_quota", cardInfo.get("cardQuota"));
				param.put("card_amt"  , cardInfo.get("amt"));
				param.put("mid"  	  , cardInfo.get("mid"));
				
			}
			
			boolean flag = myCartDao.add_bank_order(param, cart_seqno);
			if(!flag) {
				if("Bank".equals(param.getString("payment_kind"))) {
					map.put("sc_msg", "잘못된 접근입니다.");
					map.put("sc_url", "/main.do");
					
					return "/scriptMsgLoc"+Const.uuTiles;
					
					//PageUtil.scriptAlert(response, "결제 오류가 발생했습니다. 다시 시도해주세요.", "/m05/02.do");
				}else {
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&page="+param.getInt("page", 1);
					       url+= "&p_seq="+param.getString("p_seq");
					
					       
					return "redirect:/m05/01_order_com_cancel.do"+url;
				}
			}else {
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", pay_seqno);
				info.put("result_price"  , pay_total_order_price);
				info.put("payment_kind"  , payment_kind);
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				
				HttpSession session  = request.getSession();
				session.removeAttribute("pay_session");
				
				session.setAttribute("pay_session", info);
				
				return "redirect:/m05/02_cart_plus_order_result.do";
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "오류가 발생했습니다.");
		}
		return "";
	}
	
	
	@RequestMapping ("/m05/02_cart_plus_order.do")
	public String cart_plus_order(Map<String, Object> map, HttpServletResponse response){
		try {
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m05/02.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/main.do");
			}
			
			int delivery_price = Const.A_DELIVERY_PRICE;
			int delivery_plus  = Const.A_DELIVERY_PLUS;
			int per            = StringUtil.ObjectToInt( userSession.get("sale_per") );
			int member_sale    = 0; 
			if(per != 0) {
				//member_sale = (delivery_price *  per) / 100;
				member_sale = (delivery_plus *  per) / 100;
			}
			
			map.put("delivery_price", delivery_plus - member_sale);
			map.put("member_sale", member_sale);
			
			List<Map<String, Object>> list = myCartDao.select_ordering_list(param);
			
			if(list.size() == 0) {
	            PageUtil.scriptAlert(response, "결제할 처방이 없습니다.", "/m05/02.do");
			}
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			for(int i= (list.size()-1); i>=0 ; i--) {
				
				String s_goods_tot = list.get(i).get("order_total_price")+"";			
				s_goods_tot = s_goods_tot.replace(".0", "");
				System.out.println("s_goods_tot = "+ StringUtil.ObjectToInt(s_goods_tot));
				
				goods_tot += StringUtil.ObjectToInt(s_goods_tot);
				
				goods_name = StringUtil.objToStr(list.get(i).get("s_name") , "")+"외 1건";
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("seqno") );
			}//for i
			
			param.put("goods_tot"  , goods_tot-delivery_plus+member_sale);
			param.put("goods_cnt"  , list.size());
			param.put("goods_name" , goods_name);
			param.put("goods_seq"  , goods_seq);
			
			
			map.put("list", list);
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "오류가 발생했습니다.");
		}
		return "/m05/02_cart_plus_order"+Const.uTiles;
	}
	
	@RequestMapping ("/m05/02_cart_plus_order_com.do")
	public String cart_plus_order_com( Map<String, Object> map
									 ,HttpServletResponse response){
		try {
			param.put("order_handphone", userSession.get("handphone") );
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m05/02_cart_plus_order.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/main.do");
			}
			
			String payment_kind = param.getString("payment_kind","");
			if("".equals(payment_kind)){
				map.put("sc_msg", "결제금액 정보다 다릅니다");
				map.put("sc_url", "/m05/02.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			
			param.put("bill_handphone", param.getString("bill_handphone01")+"-"+param.getString("bill_handphone02")+"-"+ param.getString("bill_handphone03"));
			
			String[] cart_seqno = request.getParameterValues("cart_seqno");
			String pay_seqno ="";
			for(int i = 0; i < cart_seqno.length ; i++) {
				if(i == 0) {
					pay_seqno += cart_seqno[i];
				}else {
					pay_seqno += ","+cart_seqno[i];
				}				
			}// for i
			param.put("pay_seqno", pay_seqno);
			
			int delivery_price        = param.getInt("delivery_price");
			int pay_total_order_price = param.getInt("pay_total_order_price");
			int order_total_price     = myCartDao.select_order_price_sum(param);
			
			if( (pay_total_order_price+delivery_price) != order_total_price) {
				PageUtil.scriptAlert(response, "결제금액 정보다 다릅니다", "/m05/02.do");
			}
			
			boolean flag = false;
			if("Bank".equals(payment_kind)) {
				param.put("payment", "2"); // 1 입금
			}else {
				param.put("payment", "1"); // 1 입금
				
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				System.out.println("cardInfo = "+ cardInfo);
				
				String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
				if(!"3001".equals(cardInfo.get("resultCode")+"")) {
					map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
					return "/scriptMsg"+Const.uuTiles;
				}
				
				param.put("card_gu_no", cardInfo.get("tid"));
				param.put("card_ju_no", cardInfo.get("moid"));
				param.put("card_su_no", cardInfo.get("authCode"));
				param.put("card_nm"   , cardInfo.get("cardName"));
				param.put("card_code" , cardInfo.get("cardCode"));
				param.put("card_quota", cardInfo.get("cardQuota"));
				param.put("card_amt"  , cardInfo.get("amt"));
				param.put("mid"  	  , cardInfo.get("mid"));
			}
			
			flag = myCartDao.add_plus_bank_order(param, cart_seqno);
			//flag = false;
			// 10퍼기준
			if(!flag) {
				if("Bank".equals(param.getString("payment_kind"))) {
					PageUtil.scriptAlert(response, "결제 오류가 발생했습니다. 다시 시도해주세요.", "/m05/02.do");
				}else {
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&page="+param.getInt("page", 1);
					       url+= "&p_seq="+param.getString("p_seq");
					
					return "redirect:/m05/01_order_com_cancel.do"+url;
				}
			}else{
				//order_delivery_price-2000
				//member_sale - 200
				//order_total_price-1800
				param.put("result_price", pay_total_order_price+delivery_price);
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", pay_seqno);
				info.put("result_price"  , pay_total_order_price);
				info.put("payment_kind"  , payment_kind);
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession();
				//session.removeAttribute("pay_session");
				
				session.setAttribute("pay_session", info);
				
				return "redirect:/m05/02_cart_plus_order_result.do";
			}
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "오류가 발생했습니다.");
		}
		return "";
	}
	
	@RequestMapping ("/m05/01_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("/m05/01_order_com_cancel = "+ param);
			
			// 1초후에 작동
			Thread.sleep(500);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			System.out.println("tt = "+cardInfo);
			System.out.println(cardInfo);
			System.out.println(cardInfo);
			System.out.println("tt = "+cardInfo);
			
			param.put("href_url", "/m05/02.do");
			param.put("msg", "카드결제취소중 에러가 발생했습니다. 고객센터에 문의해주세요.");
			
			if(cardInfo != null) {
				String resultCode  = StringUtil.objToStr(cardInfo.get("resultCode"), "");
				if("2001".equals(resultCode)) {
					param.put("msg", "주문 에러로 인한 카드결제를 취소했습니다.");
				}
			}				
			map.put("bean", param);
		}catch (Exception e) {			
			e.printStackTrace();
		//	PageUtil.scriptAlert(response, "카드결제취소중 에러가 발생했습니다.\n고객센터에 문의해주세요.", "/m03/02.do");
		}
		return "/m03/card_cancel"+Const.uuTiles;
	}
	
	
	@RequestMapping ("/m05/02_cart_plus_order_result.do")
	public String cart_plus_order_result( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_session");
			
			if(info == null){
				PageUtil.scriptAlert(response, "정상적인 경로가 아닙니다.", "/m05/02.do");
			}
			System.out.println(info);
			map.put("bean", info);
			
			//all_cart_seqno
			//session.removeAttribute("pay_session");
			
			map.put("list", myCartDao.select_pay_result_list(info));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/02_cart_order_end"+Const.uTiles; 
	}
	
	
}
