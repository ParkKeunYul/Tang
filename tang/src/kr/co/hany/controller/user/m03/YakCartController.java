package kr.co.hany.controller.user.m03;

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
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m05.MyCartDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class YakCartController extends UserDefaultController{
	
	
	@Autowired
	YakCartDAO yakCartDao;
	
	@Autowired
	MyCartDAO myCartDao;
	
	
	@RequestMapping ("/m03/02.do")
	public String v_02( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			param.put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			param.put("mem_sub_grade", userSession.get("mem_sub_grade"));
			
			if("".equals(param.getString("search_sub_seqno",""))) {
				param.put("search_sub_seqno", param.get("mem_sub_seqno"));
			}
			
			map.put("list"  , yakCartDao.list(param));
			map.put("sub_id", myCartDao.sub_id_list(param));
			map.put("bean"  , param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/02"+Const.uTiles;
	}
	
	@RequestMapping ("/m03/02_del_cart.do")
	public @ResponseBody Map<String, Object> aj_del_cart( Map<String, Object> map
														 ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			boolean flag = yakCartDao.del_cart(param);
			if(flag) {
				rtn  = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m03/02_order_app_cart.do")
	public String v_02_order_app_cart( Map<String, Object> map
					   			 	  ,HttpServletResponse response){
		try {
			param.put("id"           , userSession.get("id"));
			param.put("mem_seqno"    , userSession.get("seqno"));
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/02.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/m03/02.do");
			}
			
			// 처방불가 체크
			int unuse = yakCartDao.unuse_goods_cart(param);
			if(unuse > 0) {
				PageUtil.scriptAlert(response, "처방불가능한 약속처방이 있습니다.", "/m03/02.do");
			}
			
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			if(list.size() == 0) {
				PageUtil.scriptAlert(response, "장바구니에 담김 처방이 없습니다.", "/m03/02.do");
			}
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			for(int i= (list.size()-1); i>=0 ; i--) {
				
				String s_goods_tot = list.get(i).get("goods_tot")+"";
				System.out.println("s_goods_tot = "+ s_goods_tot);
				s_goods_tot = s_goods_tot.replace(".0", "");
				System.out.println("s_goods_tot = "+ s_goods_tot);
				
				goods_tot += StringUtil.ObjectToInt( s_goods_tot);
				goods_name = StringUtil.objToStr(list.get(i).get("p_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("p_seq") );
			}//for i
			
			System.out.println(goods_tot);
			
			if(goods_tot < 100000) {
				goods_tot = goods_tot + 4000;
			}
			System.out.println(goods_tot);
			
			if(list.size()>1) goods_name = goods_name + "외 "+ (list.size()-1)+ "건";
			
			param.put("goods_tot", goods_tot);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			map.put("list", list);
			param.put("sum_delivery_tot", Const.A_DELIVERY_PRICE);
			map.put("bean", param);
			
			
		}catch (Exception e) {
			PageUtil.scriptAlert(response, "다시 시도해주세요.", "/m03/02.do");
			e.printStackTrace();
		}
		return "/m03/02_order_app_cart"+Const.uTiles;
	}
	
	@RequestMapping ("/m03/02_mod_cart_ea.do")
	public @ResponseBody Map<String, Object> aj_mod_cart_ea( Map<String, Object> map
														    ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			boolean flag = yakCartDao.mod_cart(param);
			if(flag) {
				rtn  = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	
	@RequestMapping ("/m03/02_order_com_cart.do")
	public String v_02_order_com_cart( Map<String, Object> map
					   			 	  ,HttpServletResponse response){
		try {
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/02_order_app_cart.do")  == -1 ) {
	            map.put("sc_msg", "잘못된 접근입니다.");
				map.put("sc_url", "/m03/02.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			// 처방불가 체크
			int unuse = yakCartDao.unuse_goods_cart(param);
			if(unuse > 0) {
				map.put("sc_msg", "처방불가능한 약속처방이 있습니다.");
				map.put("sc_url", "/m03/02.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			
			int delivery_price = param.getInt("delivery_price");
			int tot_price 	   = param.getInt("tot_price");
			
			int db_tot_price = 0;
			for(int i = 0 ; i<list.size(); i++) {
				Map<String, Object> info =  list.get(i);
				
				String goods_tot = StringUtil.objToStr(info.get("goods_tot") , "").replace(".0", "");
				db_tot_price += Integer.parseInt(goods_tot);
				
			}// for i
			
			
			if( db_tot_price  != tot_price ){
				map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
				map.put("sc_url", "/m03/02.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}// if
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중		
			param.put("order_ing"      , 1);
			if("Bank".equals(param.get("payment_kind"))) {
				param.put("pay_ing"        , 2);
			}else{
				param.put("pay_ing"        , 1);
												
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				System.out.println("cardInfo = "+ cardInfo);
				
				String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
				if(!"3001".equals(cardInfo.get("resultCode")+"")) {
					
					map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
					map.put("sc_url", "/m03/02.do");
					
					return "/scriptMsgLoc"+Const.uuTiles;
					
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
			
			boolean flag = yakCartDao.add_order_card(param, list);
			
			if(!flag) {
				if("Bank".equals(param.get("payment_kind"))) {
					map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
					map.put("sc_url", "/m03/02.do");
					
					return "/scriptMsgLoc"+Const.uuTiles;
					
				}else {
					
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&PartialCancelCode=0";
					
					return "redirect:/m03/02_order_com_cancel.do"+url;
					
				}
				
			}else {
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , delivery_price + tot_price);
				info.put("payment_kind"  , param.getString("payment_kind"));
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession();
				//session.removeAttribute("pay_session");
				
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m03/02_order_result_cart.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
			map.put("sc_url", "/m03/02.do");
			
			return "/scriptMsgLoc"+Const.uuTiles;
		}
	}
	
	@RequestMapping ("/m03/02_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("02_order_com_cancel = "+ param);
			
			// 1초후에 작동
			Thread.sleep(1000);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			System.out.println(cardInfo);
			System.out.println(cardInfo);
			System.out.println(cardInfo);
			System.out.println(cardInfo);
			
			param.put("href_url", "/m03/02.do");
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
	
	
	
	
	
	@RequestMapping ("/m03/02_order_result_cart.do")
	public String cart_plus_order_result( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_yak_session");
			
			if(info == null){
				PageUtil.scriptAlert(response, "정상적인 경로가 아닙니다.", "/m03/02.do");
			}
			System.out.println(info);
			map.put("bean", info);
			
			
			map.put("list", yakCartDao.select_pay_result_list(info));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/02_order_result"+Const.uTiles; 
	}
	
	
	@RequestMapping ("/m03/02_order_result.do")
	public String cart_plus_order( Map<String, Object> map
			 					  ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			System.out.println(userSession);
			
			
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_yak_session");
			
			if(info == null){
				PageUtil.scriptAlert(response, "정상적인 경로가 아닙니다.", "/m03/02.do");
			}
			
			info.put("id"       , userSession.get("id"));
			info.put("mem_seqno", userSession.get("seqno"));
			
			System.out.println(info);
			map.put("bean", info);
			
			
			map.put("list", yakCartDao.select_immedi_pay_result_list(info));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/02_order_result"+Const.uTiles; 
	}
}
