package kr.co.hany.controller.user.m03;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

public class M_YakController extends UserDefaultController{
	
	
	@Autowired
	YakDAO yakDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	YakCartDAO yakCartDao;
	
	@Autowired
	ShopDAO shopDao;
	
	@Autowired
	BaseDAO baseDao;
	
	
	@RequestMapping ("/m/m03/01.do")
	public String v_01( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("seqno", userSession.get("seqno"));
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			List<Map<String, Object>> d_list =  baseDao.free_select(param);
			int freeDeileveryLimit = StringUtil.ObjectToInt( d_list.get(0).get("price")) ;
			param.put("freeDeileveryLimit", freeDeileveryLimit);
			
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 6;
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			int totalCount  = yakDao.listCount(param);
			int listCount   = (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount   = (listCount / page_cnt);
			 	lastCount  += listCount % page_cnt == 0 ? 0 : 1;
			List<Map<String, Object>> list = yakDao.list(param);
			map.put("list"      , list);
		    map.put("listCount" , listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount" , lastCount);
			map.put("pageCount" , totalCount -(page -1)* page_cnt);
			map.put("bean", param);
			map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));			
			 
			map.put("shop_code", codeDao.shop_group());
			map.put("sub_code" , codeDao.shop_sub_group());
			
			 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m03/01"+Const.mTiles;
	}
	
	
	@RequestMapping ("/m/m03/01_view.do")
	public String v_01_view( Map<String, Object> map
					   	    ,HttpServletResponse response){
		
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			Map<String, Object> view = yakDao.goods_view(param);
			
			if(view == null) {
				PageUtil.scripAlertBack(response, "??????????????? ????????? ????????????.");
			}
			
			Map<String, Object> pre_order = yakDao.select_pre_order(param);
			if(pre_order != null) {
				int order_cnt   = yakDao.order_cnt(param);
				int cart_cnt    = yakDao.cart_cnt(param);
				
				int pre_order_ea = StringUtil.ObjectToInt(pre_order.get("ea"));
					pre_order_ea = (pre_order_ea - order_cnt) - cart_cnt;
				if(pre_order_ea < 0) {
					pre_order_ea = 0;
				}
				pre_order.put("ea", pre_order_ea);
			}

			
			map.put("option_list", yakDao.select_option(param));
			map.put("pre_order"  , pre_order);
			
			map.put("view", view);
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "??????????????? ????????? ????????????.", "/m03/01.do");
		}
		return "/m/m03/01_view"+Const.mTiles;
	}//v_01_view
	
	
	
	@RequestMapping ("/m/m03/01_preorder.do")
	public String preorder( Map<String, Object> map
					   	   ,HttpServletResponse response){
		
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			Map<String, Object> view = yakDao.goods_view(param);
			
			
			Map<String, Object> order_view = yakDao.select_pre_order(param);
			
			map.put("view", view);
			map.put("order_view", order_view);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m03/01_preorder"+Const.mmTiles;
	}// 01_preorder
	
	
	@RequestMapping ("/m/m03/01_com_order.do")
	public String v_01_com_order( Map<String, Object> map
								 ,HttpServletRequest request
					   			 ,HttpServletResponse response){
		try {
			
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));

			// ?????????
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			
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
				
				real_list.add(info);
			}// for i
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			// pay_ing  1,?????? 2// ?????????
			// order_ing 1 ???????????????
			param.put("order_ing"      , 1);
			param.put("pay_ing"        , 2);
			
			
			boolean flag = yakCartDao.add_order_card(param, list);			
			if(!flag) {
				PageUtil.scripAlertBack(response, "?????? ????????? ??????????????????. ?????? ??????????????????.");
			}else {
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , tot_price);
				info.put("payment_kind"  , param.getString("payment_kind"));
				info.put("delivery_price", delivery_price);
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession(false);
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m/m03/02_order_result.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "?????? ????????? ??????????????????. ?????? ??????????????????.", "/m/m03/01.do");
		}
		return "";
	}
	
	@RequestMapping ("/m/m03/01_com_order_card.do")
	public String v_01_com_order_card( Map<String, Object> map
									 ,HttpServletRequest request
						   			 ,HttpServletResponse response){
		try {
			
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			map.put("sc_url", "/m/m03/01.do");
			/*
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/01_add_order_iframe.do")  == -1 ) {
				map.put("sc_msg", "???????????? ????????? ????????????.");
				map.put("sc_url", "/m/m03/01.do");
				return "/m/m03/fanc_location_alert"+Const.mmTiles;
			}
			*/
			// ???????????? ??????
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				map.put("sc_msg", "?????????????????? ??????????????? ????????????.");
				return "/m/m03/fanc_location_alert"+Const.mmTiles;
			}
			
			// ?????????
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			
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
				System.out.println("-============================");
				System.out.println("info = "+ info);
				System.out.println("-============================");
				
				real_list.add(info);
			}// for i
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			// pay_ing  1,?????? 2// ?????????
			// order_ing 1 ???????????????
			param.put("pay_ing"        , 1);
			param.put("order_ing"      , 1);
											
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = "+ cardInfo);
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			if(!"3001".equals(cardInfo.get("resultCode")+"")) {
				map.put("sc_msg", "??????????????? ??????????????? ??????????????? ???????????????. ["+resultMsg+"]");
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
				
				
				boolean flag = yakCartDao.add_order_card(param, list);			
				if(!flag) {
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&page="+param.getInt("page", 1);
					       url+= "&p_seq="+param.getString("p_seq");
					
					map.put("sc_url",url);
					return "/m/m03/fanc_location"+Const.mmTiles;
					
				}else {
					
					Map<String, Object> info = new HashMap<String, Object>();
					info.put("all_cart_seqno", param.getString("all_seqno"));
					info.put("result_price"  , tot_price);
					info.put("payment_kind"  , param.getString("payment_kind"));
					info.put("delivery_price", delivery_price);
					
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
			//PageUtil.scriptAlert(response, "?????? ????????? ??????????????????. ?????? ??????????????????.", "/m/m03/01.do");
			map.put("sc_msg", "?????? ????????? ??????????????????. ?????? ??????????????????.");
			return "/m/m03/fanc_location_alert"+Const.mmTiles;
		}
	}
	
	/*
	@RequestMapping ("/m/m03/01_com_order_card.do")
	public String v_01_com_order_card( Map<String, Object> map
									 ,HttpServletRequest request
						   			 ,HttpServletResponse response){
		try {
			
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/01_add_order.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "????????? ???????????????.", "/m03/01.do");
			}
			// ???????????? ??????
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				PageUtil.scriptAlert(response, "?????????????????? ??????????????? ????????????.", "/m03/01.do");
			}
			
			// ?????????
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			
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
				System.out.println("-============================");
				System.out.println("info = "+ info);
				System.out.println("-============================");
				
				real_list.add(info);
			}// for i
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			// pay_ing  1,?????? 2// ?????????
			// order_ing 1 ???????????????
			param.put("pay_ing"        , 1);
			param.put("order_ing"      , 1);
											
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = "+ cardInfo);
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			if(!"3001".equals(cardInfo.get("resultCode")+"")) {
				PageUtil.scripAlertBack(response, "??????????????? ??????????????? ??????????????? ???????????????. ["+resultMsg+"]");
			}
			param.put("card_gu_no", cardInfo.get("tid"));
			param.put("card_ju_no", cardInfo.get("moid"));
			param.put("card_su_no", cardInfo.get("authCode"));
			param.put("card_nm"   , cardInfo.get("cardName"));
			param.put("card_code" , cardInfo.get("cardCode"));
			param.put("card_quota", cardInfo.get("cardQuota"));
			param.put("card_amt"  , cardInfo.get("amt"));
			param.put("mid"  	  , cardInfo.get("mid"));
			
			
			boolean flag = yakCartDao.add_order_card(param, list);			
			if(!flag) {
				String url = "?CancelMsg=error_cancel";
				       url+= "&CancelAmt="+param.getString("card_amt");
				       url+= "&TID="+param.getString("card_gu_no");
				       url+= "&MID="+param.getString("mid");
				       url+= "&CancelPwd="+Const.NP_c_pass;
				       url+= "&page="+param.getInt("page", 1);
				       url+= "&p_seq="+param.getString("p_seq");
				
				return "redirect:/m/m03/01_order_com_cancel.do"+url;
			}else {
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , tot_price);
				info.put("payment_kind"  , param.getString("payment_kind"));
				info.put("delivery_price", delivery_price);
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession(false);
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m/m03/02_order_result.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "?????? ????????? ??????????????????. ?????? ??????????????????.", "/m/m03/01.do");
		}
		return "";
	}
	
	*/
	@RequestMapping ("/m/m03/02_order_result.do")
	public String cart_plus_order( Map<String, Object> map
			 					  ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			System.out.println(userSession);
			
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_yak_session");
			
			
			
			info.put("id"       , userSession.get("id"));
			info.put("mem_seqno", userSession.get("seqno"));
			
			System.out.println(info);
			map.put("bean", info);
			
			List<Map<String, Object>> list = yakCartDao.select_immedi_pay_result_list(info);
			
			map.put("list", list);
			map.put("sub", list.get(0));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m03/02_order_result"+Const.mTiles; 
	}
	
	
	@RequestMapping ("/m/m03/01_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("01_order_com_cancel = "+ param);
			
			// 1????????? ??????
			Thread.sleep(500);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			
			param.put("href_url", "/m/m03/01_view.do?p_seq="+param.getString("p_seq")+"&page="+param.getInt("page", 1));
			param.put("msg", "????????????????????? ????????? ??????????????????. ??????????????? ??????????????????.");
			
			if(cardInfo != null) {
				String resultCode  = StringUtil.objToStr(cardInfo.get("resultCode"), "");
				if("2001".equals(resultCode)) {
					param.put("msg", "?????? ????????? ?????? ??????????????? ??????????????????.");
				}
			}				
			map.put("bean", param);
		}catch (Exception e) {			
			e.printStackTrace();
		//	PageUtil.scriptAlert(response, "????????????????????? ????????? ??????????????????.\n??????????????? ??????????????????.", "/m03/02.do");
		}
		return "/m/m03/card_cancel"+Const.uuTiles;
	}
	
}
