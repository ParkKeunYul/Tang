package kr.co.hany.controller.user.m03;

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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.item.AmountDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.AmountUserDAO;
import kr.co.hany.session.UserSessionManager;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;


@Controller
public class AmountUserController extends UserDefaultController{

	@Autowired
	AmountUserDAO amountDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	LoginDAO loginDao;
	
	@RequestMapping ({"/m03/amount.do","/m//m03/amount.do"})
	public String amount( Map<String, Object> map
					     ,HttpServletResponse response){
		
		String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
		try {
			
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 9;
			
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				page_cnt   = 6;
			}
			
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			
			int totalCount  = amountDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			
			List<Map<String, Object>> list = amountDao.list(param);
			map.put("list", list);
		    map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			 
			
			
			map.put("shop_code", codeDao.shop_group());
			map.put("sub_code" , codeDao.shop_sub_group());
			
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));
			}else {
				map.put("navi", PageUtil.getPageMysql(list, param, listCount, lastCount, ""));
			}
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "에러가 발생했습니다.");
		}
		
		if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
			return "/m/m03/amount"+Const.mTiles;
		}else {
			return "/m03/amount"+Const.uTiles;
		}
		
		
	}
	
	@RequestMapping ({"/m03/amount_view.do","/m//m03/amount_view.do"})
	public String amount_view( Map<String, Object> map
					   	      ,HttpServletResponse response){
		
		String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
		String dType  = "";
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				dType   = "/m";
			}
			
			
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			Map<String, Object> view = amountDao.view(param);
			map.put("view", view);
			map.put("bean", param);
	
			if(view == null) {
				PageUtil.scriptAlert(response, "결제가능한 상품이 아닙니다.", dType+"/m03/amount.do");
			}
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", dType+"/m03/amount.do");
		}
		if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
			return dType+"/m03/amount_view"+Const.mTiles;
		}else {
			return dType+"/m03/amount_view"+Const.uTiles;
		}
		
	}//v_01_view
	
	
	@RequestMapping ({"/m03/amount_view_iframe.do", "/m/m03/amount_view_iframe.do"})
	public String v_02_order_app_cart_iframe( Map<String, Object> map
			 	  							 ,HttpServletResponse response){
		String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
		try {
			
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			Map<String, Object> view = amountDao.view(param);
			
			
			param.put("goods_cnt", param.getString("ea"));
			param.put("goods_name", view.get("title"));
			param.put("goods_tot", param.getInt("ea") * StringUtil.ObjectToInt(view.get("price")) );
			param.put("goods_seq", view.get("a_code"));
			
			
			map.put("view", view);
			map.put("bean", param);
			
		}catch (Exception e) {
			PageUtil.scripAlertBack(response, "다시 시도해주세요.");
			e.printStackTrace();
		}
		
		
		if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
			System.out.println("1111");
			return "/m/m03/amount_iframe.mp";
		}else {
			return "/m03/amount_iframe"+Const.uuTiles;
		}
	}
	
	@RequestMapping ({"/m/m03/amount_order_card.do"})
	public String amount_order_card( Map<String, Object> map
					   	       ,HttpServletResponse response){
		
		try {
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				map.put("sc_close", "y");
			}
			
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
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
			}
			
			Map<String, Object> view = amountDao.view(param);
			
			
			int price = StringUtil.ObjectToInt(view.get("price"));
			int point = StringUtil.ObjectToInt(view.get("point"));
			int ea    = param.getInt("ea");
			
			
			param.put("amount_seqno", view.get("seqno"));
			param.put("amount_code" , view.get("a_code"));
			param.put("amount_price", view.get("price"));
			param.put("price"       , price);
			param.put("tot_price"   , price * ea);
			param.put("point"       , point);
			param.put("tot_point"   , point * ea);
			param.put("ea"          , ea);
			param.put("reason"      , "신용카드 충전");
			
			
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			String resultMsg             = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
			if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
				map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
				map.put("sc_url", "/m/m03/amount_view.do?seqno="+param.getString("seqno"));
				return "/scriptMsg"+Const.uuTiles;
			}
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
					param.put("id"             , userSession.get("id"));
					param.put("mem_seqno"      , userSession.get("seqno"));
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
			}
			param.put("card_gu_no", cardInfo.get("tid"));
			param.put("card_ju_no", cardInfo.get("moid"));
			param.put("card_su_no", cardInfo.get("authCode"));
			param.put("card_nm"   , cardInfo.get("cardName"));
			param.put("card_code" , cardInfo.get("cardCode"));
			param.put("card_quota", cardInfo.get("cardQuota"));
			param.put("card_amt"  , cardInfo.get("amt"));
			param.put("mid"  	  , cardInfo.get("mid"));
			
			
			boolean flag = amountDao.add_order_card(param);
			if(!flag) {
				
			}else {
				Map<String, Object> info = new HashMap<String, Object>();
				
				info.put("result_price"  , param.getString("Amt"));
				info.put("payment_kind"  , param.getString("payment_kind"));
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				info.put("tot_point"   , param.getString("tot_point"));
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession();
				session.setAttribute("pay_point_session", info);
				map.put("sc_url", "/m/m03/amount_result.do");
				
				return "/m/m03/fanc_location"+Const.mmTiles;
			}

			
			
		}catch (Exception e) {
			e.printStackTrace();
			map.put("sc_msg", "결제중 에러가 발생했습니다.");
			map.put("sc_url", "/m/m03/amount.do");
		}
		return "/scriptMsg"+Const.uuTiles;
	}//personal_com
	
	
	@RequestMapping ({"/m/m03/amount_result.do"})
	public String amount_result( Map<String, Object> map
 	  							 ,HttpServletResponse response){
		String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
		try {
			
			HttpSession session  = request.getSession();
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_point_session");
			
			
			System.out.println(info);
			map.put("bean", info);
			
			
		}catch (Exception e) {
			PageUtil.scripAlertBack(response, "다시 시도해주세요.");
			e.printStackTrace();
		}
		return "/m/m03/amount_result"+Const.mTiles;
	}
	
	
	
	@RequestMapping (value="/m03/amount_order_ajax.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object> amount_order_ajax( Map<String, Object> map
															   ,HttpServletRequest request
													   		   ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			System.out.println("/m03/amount_order_ajax.do = "+ userSession);
			System.out.println("param = "+ param);
			
			
			
			
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
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
				
			}
			
			Map<String, Object> view = amountDao.view(param);
			
			
			System.out.println(view);
			System.out.println(view);
			
			int price = StringUtil.ObjectToInt(view.get("price"));
			int point = StringUtil.ObjectToInt(view.get("point"));
			int ea    = param.getInt("ea");
			
			
			param.put("amount_seqno", view.get("seqno"));
			param.put("amount_code" , view.get("a_code"));
			param.put("amount_price", view.get("price"));
			param.put("amount_title", view.get("title"));
			param.put("price"       , price);
			param.put("tot_price"   , price * ea);
			param.put("point"       , point);
			param.put("tot_point"   , point * ea);
			param.put("ea"          , ea);
			param.put("reason"      , "신용카드 충전");
			
			
			System.out.println(param);
			
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = 1"+ cardInfo);
			
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
					param.put("id"             , userSession.get("id"));
					param.put("mem_seqno"      , userSession.get("seqno"));
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
			}
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
			
			if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
				rtn.put("msg","카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
				return rtn;
			}
			param.put("card_gu_no", cardInfo.get("tid"));
			param.put("card_ju_no", cardInfo.get("moid"));
			param.put("card_su_no", cardInfo.get("authCode"));
			param.put("card_nm"   , cardInfo.get("cardName"));
			param.put("card_code" , cardInfo.get("cardCode"));
			param.put("card_quota", cardInfo.get("cardQuota"));
			param.put("card_amt"  , cardInfo.get("amt"));
			param.put("mid"  	  , cardInfo.get("mid"));
			
			
			boolean flag = amountDao.add_order_card(param);			
			
			String u_id = StringUtil.objToStr(userSession.get("id"), "");
			/*
			if("matrix".equals(u_id)) {
				System.out.println("matrix false");
				flag = false;
			}
			*/
			if(!flag) {
				
				rtn.put("CancelMsg", "error_cancel");				
				rtn.put("CancelAmt", price * ea);
				rtn.put("TID"      , param.getString("card_gu_no"));
				rtn.put("MID"      , param.getString("mid"));
				rtn.put("CancelPwd", Const.NP_c_pass);
				rtn.put("PartialCancelCode", 0);
				rtn.put("msg","에러가 발생했습니다. 카드결제를 취소합니다.");
				rtn.put("page", param.getString("page"));
				rtn.put("seqno", param.getString("seqno"));
				
				System.out.println(" rtn = "+  rtn);
				
				return rtn;
			}else {
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , param.getString("Amt"));
				info.put("payment_kind"  , param.getString("payment_kind"));
				
				info.put("card_nm"     , param.getString("card_nm"));
				info.put("card_quota"  , param.getString("card_quota"));
				info.put("tid"  	   , param.getString("card_gu_no"));
				info.put("mid"  	   , param.getString("mid"));
				info.put("tot_point"   , param.getString("tot_point"));
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession();
				session.setAttribute("pay_amount_session", info);
				
				rtn.put("suc", true);
				rtn.put("msg", "정상적으로 결제 되었습니다.");
				return rtn;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			rtn.put("msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
		}
		return rtn;
	}
	
	
	@RequestMapping ({"/m03/amount_cancel_ajax.do", "/m/m03/amount_cancel_ajax.do"})
	public void amount_card_cancel( Map<String, Object> map
																 ,HttpServletResponse response
																 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
		//	System.out.println(adminSession);
			System.out.println("amount_card_cancel s");
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			System.out.println("amount_card_cancel e" + cardInfo);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping ("/m03/amount_result.do")
	public String cart_plus_order_result( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_amount_session");
			
			map.put("bean", info);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/amount_result"+Const.uTiles; 
	}
	
	
	
	
	@RequestMapping ({"/m05/99.do","/m/m05/99.do"})
	public String v_99( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpSession session){
		
		String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
		String dType = "";
		
		String returnPage = "/m05/99"+Const.uTiles;
		try{
			
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 10;
			
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			int totalCount  = amountDao.point_listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			
			List<Map<String, Object>> list = amountDao.point_list(param);
			map.put("list", list);
		    map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			map.put("point_all", amountDao.point_all(param));
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				returnPage = "/m/m05/99"+Const.mTiles;
				map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));
			}else {
				map.put("navi", PageUtil.getPageMysql(list, param, listCount, lastCount, ""));
			}
			System.out.println("returnPage = "+ returnPage);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return returnPage;
	}
}
