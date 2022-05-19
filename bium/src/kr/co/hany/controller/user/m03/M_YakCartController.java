package kr.co.hany.controller.user.m03;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class M_YakCartController extends UserDefaultController{
	
	
	@Autowired
	YakCartDAO yakCartDao;
	
	
	@Autowired
	YakDAO yakDao;
	
	@Autowired
	ShopDAO shopDao;
	
	@Autowired
	BaseDAO baseDao;
	
	
	@RequestMapping ("/m/m03/02.do")
	public String v_02( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			List<Map<String, Object>> d_list =  baseDao.free_select(param);
			int freeDeileveryLimit = StringUtil.ObjectToInt( d_list.get(0).get("price")) ;
			param.put("freeDeileveryLimit", freeDeileveryLimit);
			
			map.put("list", yakCartDao.list(param));
			map.put("bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m03/02"+Const.mTiles;
	}
	
	
	@RequestMapping ("/m/m03/lately.do")
	public String v_lately( Map<String, Object> map
					   	   ,HttpServletResponse response){	
		
		
		try {
			param.put("user_mem_seqno"      , userSession.get("seqno"));
			
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 5;
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			int totalCount  = shopDao.select_total(param);
			int listCount   = (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount   = (listCount / page_cnt);
			 	lastCount  += listCount % page_cnt == 0 ? 0 : 1;
			
			
			List<Map<String, Object>> list = shopDao.select_shop(param);
			map.put("list"      , list);
		    map.put("listCount" , listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount" , lastCount);
			map.put("pageCount" , totalCount -(page -1)* page_cnt);
			map.put("bean", param);
			map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/m/m03/lately"+Const.mmTiles;
	}
	
	
	@RequestMapping ("/m/m03/02_order_com_cart.do")
	public String v_02_order_com_cart( Map<String, Object> map
					   			 	  ,HttpServletResponse response){
		try {
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			
			int delivery_price = param.getInt("delivery_price");
			int tot_price 	   = param.getInt("tot_price");
			
			int db_tot_price = 0;
			
			List<Map<String, Object>> real_list = new ArrayList<Map<String, Object>>();
			//real_list = list;
			 			 
			int sale_per   = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price = 0;
			
			for(int i = 0 ; i<list.size(); i++) {
				Map<String, Object> info =  list.get(i);
				
				String goods_tot = StringUtil.objToStr(info.get("goods_tot") , "").replace(".0", "");
				db_tot_price += Integer.parseInt(goods_tot);
				
				if(sale_per > 0) {
					sale_price += (StringUtil.ObjectToInt(goods_tot) * sale_per) / 100;
					
					if(i == 0 && delivery_price > 0) {
						info.put("sale_price", ( (StringUtil.ObjectToInt(goods_tot)+delivery_price) * sale_per) / 100);
					}else {
						info.put("sale_price", (StringUtil.ObjectToInt(goods_tot) * sale_per) / 100);
					}
					
				}else {
					info.put("sale_price", 0);
				}
				
				info.put("sale_per"  , sale_per);
				
				real_list.add(info);
				
			}// for i
			
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			/* 검증하지 말자... 결제 됬는데 머하러.. 자꾸 틀린다..
			if( (db_tot_price-sale_price+delivery_price)  != tot_price ){
				PageUtil.scripAlertBack(response, "결제금액이 일치하지 않습니다1.");
			}// if
			*/
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중		
			param.put("order_ing"      , 1);
			param.put("pay_ing"        , 2);
			
			boolean flag = yakCartDao.add_order_card(param, real_list);
			
			if(!flag) {
				PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
			}else {
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , tot_price);
				info.put("delivery_price", delivery_price);
				info.put("payment_kind"  , param.getString("payment_kind"));
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession(false);
				
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m/m03/02_order_result_cart.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
		}
		return "";
	}
	
	@RequestMapping ("/m/m03/02_order_com_cart_card.do")
	public String v_02_order_com_cart_card( Map<String, Object> map
					   			 	  	   ,HttpServletResponse response){
		try {
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			
			map.put("sc_url", "/m/m03/02.do");
			
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			
			int delivery_price = param.getInt("delivery_price");
			int tot_price 	   = param.getInt("tot_price");
			
			int db_tot_price = 0;
			
			List<Map<String, Object>> real_list = new ArrayList<Map<String, Object>>(); 
			int sale_per   = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price = 0;
			
			for(int i = 0 ; i<list.size(); i++) {
				Map<String, Object> info =  list.get(i);
				
				String goods_tot = StringUtil.objToStr(info.get("goods_tot") , "").replace(".0", "");
				db_tot_price += Integer.parseInt(goods_tot);
				
				if(sale_per > 0) {
					sale_price += (StringUtil.ObjectToInt(goods_tot) * sale_per) / 100;
					
					if(i == 0 && delivery_price > 0) {
						info.put("sale_price", ( (StringUtil.ObjectToInt(goods_tot)+delivery_price) * sale_per) / 100);
					}else {
						info.put("sale_price", (StringUtil.ObjectToInt(goods_tot) * sale_per) / 100);
					}
					
				}else {
					info.put("sale_price", 0);
				}
				
				info.put("sale_per"  , sale_per);
				
				real_list.add(info);
				
			}// for i
			
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중		
			param.put("order_ing"      , 1);
			param.put("pay_ing"        , 1);
											
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = "+ cardInfo);
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			if(!"3001".equals(cardInfo.get("resultCode")+"")) {
				map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
				return "/m/m03/fanc_location_alert"+Const.mmTiles;
			}else {
				param.put("card_gu_no", cardInfo.get("tid"));
				param.put("card_ju_no", cardInfo.get("moid"));
				param.put("card_su_no", cardInfo.get("authCode"));
				param.put("card_nm"   , cardInfo.get("cardName"));
				param.put("card_code" , cardInfo.get("cardCode"));
				param.put("card_quota", cardInfo.get("cardQuota"));
				param.put("card_amt"  , cardInfo.get("amt"));
				param.put("mid"  	  , cardInfo.get("mid"));
				
				boolean flag = yakCartDao.add_order_card(param, real_list);
				
				if(!flag) {
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&PartialCancelCode=0";
					
					map.put("sc_url",url);
					return "/m/m03/fanc_location"+Const.mmTiles;
					
				}else {
					Map<String, Object> info = new HashMap<String, Object>();
					info.put("all_cart_seqno", param.getString("all_seqno"));
					info.put("result_price"  , tot_price);
					info.put("delivery_price", delivery_price);
					info.put("payment_kind"  , param.getString("payment_kind"));
					
					info.put("card_nm"     , param.getString("card_nm"));
					info.put("card_quota"  , param.getString("card_quota"));
					info.put("tid"  	   , param.getString("card_gu_no"));
					info.put("mid"  	   , param.getString("mid"));
					
					Date today = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					info.put("today"  	   , sdf.format(today));
					
					HttpSession session  = request.getSession(false);
					
					session.setAttribute("pay_yak_session", info);
					
					map.put("sc_url", "/m/m03/02_order_result_cart.do");
					
					
					return "/m/m03/fanc_location"+Const.mmTiles;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			//PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
			map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
			return "/m/m03/fanc_location_alert"+Const.mmTiles;
		}
		
	}
	
	@RequestMapping ("/m/m03/02_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("02_order_com_cancel = "+ param);
			
			// 1초후에 작동
			Thread.sleep(1000);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			
			param.put("href_url", "/m/m03/02.do");
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
	
	@RequestMapping ("/m/m03/02_order_result_cart.do")
	public String cart_plus_order_result( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession(false);
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_yak_session");
			
			if(info == null){
				PageUtil.scriptAlert(response, "정상적인 경로가 아닙니다.", "/m/m03/02.do");
			}
			System.out.println(info);
			map.put("bean", info);
			
			/*
			List<Map<String, Object>> list = yakCartDao.select_pay_result_list(info);
			
			map.put("list", list);
			map.put("sub", list.get(0));
			*/
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m03/02_order_result"+Const.mTiles; 
	}
	
}
