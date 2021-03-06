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
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.session.UserSessionManager;
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
	
	@Autowired
	LoginDAO loginDao;
	
	
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
			
			System.out.println("m ajax cart = "+ userSession);
			System.out.println("param = "+ param);
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					System.out.println("user session create = " +info);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
				}catch (Exception e) {
					System.out.println("usersession create fail");
					e.printStackTrace();
				}
			}
			
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			
			// ?????????
			List<Map<String, Object>> list = yakCartDao.list(param);
			
			Map<String, Object> pointInfo = yakDao.select_point(param);
			if(pointInfo == null ) {
				pointInfo = new HashMap<String, Object>();
				pointInfo.put("tot_point", 0);
				pointInfo.put("p_point", 0);
				pointInfo.put("m_point", 0);
			}
			
			
			int useablePoint          = StringUtil.ObjectToInt(pointInfo.get("tot_point"));
			int use_point             = param.getInt("use_point");
			int use_point_focusout    = param.getInt("use_point_focusout");
			if(use_point > useablePoint) {
				PageUtil.scripAlertBack(response, "??????????????? ??????????????? ?????? ???????????? ?????????????????????.");
				return "";
			}
			
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
			
			/* ???????????? ??????... ?????? ????????? ?????????.. ?????? ?????????..
			if( (db_tot_price-sale_price+delivery_price)  != tot_price ){
				PageUtil.scripAlertBack(response, "??????????????? ???????????? ????????????1.");
			}// if
			*/
			// pay_ing  1,?????? 2// ?????????
			// order_ing 1 ???????????????		
			param.put("order_ing"      , 1);
			param.put("pay_ing"        , 2);
			
			boolean flag = yakCartDao.add_order_card(param, real_list);
			
			if(!flag) {
				PageUtil.scripAlertBack(response, "?????? ????????? ??????????????????. ?????? ??????????????????.");
			}else {
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_point"  , use_point);
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
				
				HttpSession session  = request.getSession();
				
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m/m03/02_order_result_cart.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "?????? ????????? ??????????????????. ?????? ??????????????????.");
		}
		return "";
	}
	
	@RequestMapping ("/m/m03/02_order_com_cart_card.do")
	public String v_02_order_com_cart_card( Map<String, Object> map
					   			 	  	   ,HttpServletResponse response){
		try {
			System.out.println("m ajax cart = "+ userSession);
			System.out.println("param = "+ param);
			
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			param.put("sale_per"       , userSession.get("sale_per"));
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					System.out.println("user session create 1= " +info);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
					param.put("id"             , userSession.get("id"));
					param.put("mem_seqno"      , userSession.get("seqno"));
					param.put("order_name"     , userSession.get("name"));
					param.put("order_handphone", userSession.get("handphone") );
					param.put("sale_per"       , userSession.get("sale_per"));
					
					userSession = info;
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
				
			}
			
			
			map.put("sc_url", "/m/m03/02.do");
			
			
			System.out.println("02_order_com_cart_card = "+param);
			System.out.println("02_order_com_cart_card = "+param);
			
			Map<String, Object> pointInfo = yakDao.select_point(param);
			if(pointInfo == null ) {
				pointInfo = new HashMap<String, Object>();
				pointInfo.put("tot_point", 0);
				pointInfo.put("p_point", 0);
				pointInfo.put("m_point", 0);
			}
			int useablePoint = StringUtil.ObjectToInt(pointInfo.get("tot_point"));
			int use_point    = param.getInt("use_point");
			
			
			if(use_point > useablePoint ) {
				map.put("sc_msg", "??????????????? ??????????????? ?????? ???????????? ?????????????????????.");
				return "/m/m03/fanc_location_alert"+Const.mmTiles;
			}
			
			
			// ?????????
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
			
			
			// pay_ing  1,?????? 2// ?????????
			// order_ing 1 ???????????????		
			param.put("order_ing"      , 1);
			param.put("pay_ing"        , 1);
											
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = "+ cardInfo);
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					System.out.println("user session create 2= " +info);
					System.out.println("param = "+ param);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
					param.put("id"             , userSession.get("id"));
					param.put("mem_seqno"      , userSession.get("seqno"));
					param.put("order_name"     , userSession.get("name"));
					param.put("order_handphone", userSession.get("handphone") );
					param.put("sale_per"       , userSession.get("sale_per"));
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
				
			}
			
			
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
			if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
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
					//info.put("result_price"  , tot_price);
					info.put("result_point"  , use_point);
					info.put("result_price"  , param.getString("Amt"));
					info.put("delivery_price", delivery_price);
					info.put("payment_kind"  , param.getString("payment_kind"));
					
					info.put("card_nm"     , param.getString("card_nm"));
					info.put("card_quota"  , param.getString("card_quota"));
					info.put("tid"  	   , param.getString("card_gu_no"));
					info.put("mid"  	   , param.getString("mid"));
					
					Date today = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					info.put("today"  	   , sdf.format(today));
					
					HttpSession session  = request.getSession();
					
					System.out.println("pay_yak_session = "+info);
					System.out.println("pay_yak_session = "+info);
					System.out.println("pay_yak_session = "+info);
					
					session.setAttribute("pay_yak_session", info);
					
					map.put("sc_url", "/m/m03/02_order_result_cart.do");
					
					
					return "/m/m03/fanc_location"+Const.mmTiles;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			//PageUtil.scripAlertBack(response, "?????? ????????? ??????????????????. ?????? ??????????????????.");
			map.put("sc_msg", "?????? ????????? ??????????????????. ?????? ??????????????????.");
			return "/m/m03/fanc_location_alert"+Const.mmTiles;
		}
		
	}
	
	@RequestMapping ("/m/m03/02_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("02_order_com_cancel = "+ param);
			
			// 1????????? ??????
			Thread.sleep(1000);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			
			param.put("href_url", "/m/m03/02.do");
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
		return "/m03/card_cancel"+Const.uuTiles;
	}
	
	@RequestMapping ("/m/m03/02_order_result_cart.do")
	public String cart_plus_order_result( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_yak_session");
			
			if(info == null){
				PageUtil.scriptAlert(response, "???????????? ????????? ????????????.", "/m/m03/02.do");
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
