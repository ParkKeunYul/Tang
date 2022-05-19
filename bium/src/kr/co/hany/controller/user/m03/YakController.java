package kr.co.hany.controller.user.m03;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.controller.user.UserNoneDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m02.DictionDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.dao.user.m05.MyDictionDAO;
import kr.co.hany.session.UserSessionManager;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;
import kr.co.nicevan.nicepay.adapter.web.NicePayHttpServletRequestWrapper;
import kr.co.nicevan.nicepay.adapter.web.NicePayWEB;
import kr.co.nicevan.nicepay.adapter.web.dto.WebMessageDTO;

@Controller
public class YakController extends UserDefaultController{
	
	
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
	
	@Autowired
	LoginDAO loginDao;
	
	
	String title_text = "(가맹점)";
	
	//@RequestMapping({"/m/m01/*.do" , "/m/m03/*.do" , "/m/m04/*.do" , "/m/m05/*.do" , "/m/m06/*.do", "/m/m02/*.do"})
	@RequestMapping ( {"/m03/01.do" , "/m99/01.do"}  )
	public String v_01( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			
			
			
			String sale_type = "1";
			//param.put("title_text", title_text);
			if(request.getServletPath().indexOf("/m99/01") != -1) {
				sale_type = "2";
				param.put("title_text", "");
				param.put("ga_menu", "sel");
			}else {
				param.put("jungm_menu", "sel");
			}
			
			param.put("id", userSession.get("id"));
			param.put("seqno", userSession.get("seqno"));
			param.put("sale_type", sale_type);
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 9;
			
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
			map.put("navi", PageUtil.getPageMysql(list, param, listCount, lastCount, ""));			
			 
			map.put("shop_code", codeDao.shop_group());
			map.put("sub_code" , codeDao.shop_sub_group());
			
			 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/01"+Const.uTiles;
	}
	
	@RequestMapping ( {"/m03/01_view.do" , "/m99/01_view.do"}  )
	public String v_01_view( Map<String, Object> map
					   	    ,HttpServletResponse response){
		
		try {
			
			String sale_type = "1";
		//	param.put("title_text", title_text);
			if(request.getServletPath().indexOf("/m99/01") != -1) {
				sale_type = "2";
				param.put("title_text", "");
				param.put("ga_menu", "sel");
			}else {
				param.put("jungm_menu", "sel");
			}
			
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("sale_type", sale_type);
			
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			Map<String, Object> view = yakDao.goods_view(param);
			
			if(view == null) {
				PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
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
			PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
		}
		return "/m03/01_view"+Const.uTiles;
	}//v_01_view
	
	@RequestMapping ({"/m03/01_add_cart.do", "/m99/01_add_cart.do"})
	public @ResponseBody Map<String, Object> aj_01_add_cart( Map<String, Object> map
													  		,HttpServletResponse response
													  		,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> goods_view = yakDao.goods_view(param);
			if(goods_view == null) {
				rtn.put("msg", "처방가능한 상태가 아닙니다.");
				return rtn;
			}
			
			if(request.getServletPath().indexOf("/m99/01") != -1) {
				param.put("ga_menu", "sel");
			}else {
				param.put("jungm_menu", "sel");
			}
			
			
			int ea = param.getInt("ea");
			String pre_seq = param.getString("pre_seq");
			
			if("Y".equals(pre_seq)) {
			Map<String, Object> pre_order = yakDao.select_pre_order(param);
				if(pre_order != null) {
					int order_cnt   = yakDao.order_cnt(param);
					int cart_cnt    = yakDao.cart_cnt(param);
					
					int pre_order_ea = StringUtil.ObjectToInt(pre_order.get("ea"));
						pre_order_ea = (pre_order_ea - order_cnt) - cart_cnt - ea;
						
					if(pre_order_ea < 0) {
						rtn.put("msg", "남은수량이 부족합니다. 새로고침후 남은수량을 확인하세요.");
						return rtn;
					}
				}else{
					rtn.put("msg", "남은수량이 부족합니다. 새로고침후 남은수량을 확인하세요.");
					return rtn;
				}
			}
			
			
			goods_view.put("mem_seqno"	 , userSession.get("seqno"));
			goods_view.put("id"      	 , userSession.get("id"));
			goods_view.put("ea"          , ea);
			goods_view.put("box_option_price"       , param.getInt("box_option_price"));
			goods_view.put("box_option_nm"          , param.getString("box_option_nm"));
			goods_view.put("box_option_seqno"       , param.getInt("box_option_seqno"));
			
			
			boolean flag = yakDao.add_cart(goods_view);
			
			if(flag){
				rtn = PageUtil.procSuc("보관함에 저장되었습니다.");
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// add_cart
	
	@RequestMapping ({"/m03/01_remain_ea.do" ,"/m99/01_remain_ea.do"})
	public @ResponseBody Map<String, Object> aj_remain_ea( Map<String, Object> map
												   		  ,HttpServletResponse response
													  	  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> goods_view = yakDao.goods_view(param);
			if(goods_view == null) {
				rtn.put("msg", "처방가능한 상태가 아닙니다.");
				return rtn;
			}
			
			int ea = param.getInt("ea");
			String pre_seq = param.getString("pre_seq");
			
			Map<String, Object> pre_order = yakDao.select_pre_order(param);
			if("Y".equals(pre_seq)) {
				if(pre_order != null) {
					int order_cnt   = yakDao.order_cnt(param);
					int cart_cnt    = yakDao.cart_cnt(param);
					
					int pre_order_ea = StringUtil.ObjectToInt(pre_order.get("ea"));
						pre_order_ea = (pre_order_ea - order_cnt) - cart_cnt - ea;
						
					if(pre_order_ea < 0) {
						rtn.put("msg", "남은수량이 부족합니다. 새로고침후 남은수량을 확인하세요.");
						return rtn;
					}
				}else{
					rtn.put("msg", "남은수량이 부족합니다. 새로고침후 남은수량을 확인하세요.");
					return rtn;
				}
			}
			
			rtn = PageUtil.procSuc();
			
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// add_cart
	
	
	
	
	@RequestMapping ({"/m03/01_add_order.do","/m/m03/01_add_order.do", "/m99/01_add_order.do"})
	public String v_01_add_order( Map<String, Object> map
			                     ,HttpServletRequest request
					   			 ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			int sale_per = StringUtil.ObjectToInt(userSession.get("sale_per")); 
			
			param.put("sale_per" , sale_per);
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			System.out.println(referer);
			if( referer.indexOf("/m03/01_view.do")  == -1  &&  referer.indexOf("/m99/01_view.do")  == -1) {
	            PageUtil.scripAlertBack(response, "잘못된 접근입니다.");
			}
			
			if(request.getServletPath().indexOf("/m99/01") != -1) {
				param.put("ga_menu", "sel");
			}else {
				param.put("jungm_menu", "sel");
			}
			
			
			Map<String, Object> taekbaeInfo =   baseDao.free_select(param).get(0);
			map.put("taekbaeInfo", taekbaeInfo);
			
			
			
			
			param.put("all_seqno", param.getString("p_seq"));
			
			
			// 처방불가 체크
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				PageUtil.scripAlertBack(response, "처방불가능한 약속처방이 있습니다.");
			}
			
			// 리스트
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			map.put("list", list);
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			int sale_price     = 0;
			
			int ori_goods_tot= 0;
			
			for(int i= (list.size()-1); i>=0 ; i--) {
				goods_tot += StringUtil.ObjectToInt(list.get(i).get("goods_tot") );
				goods_name = StringUtil.objToStr(list.get(i).get("p_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("p_seq") );
				
				if(sale_per > 0) {
					sale_price += (StringUtil.ObjectToInt(list.get(i).get("goods_tot") )* sale_per) / 100;					
				}
				
			}//for i
			
			
			ori_goods_tot = goods_tot;
			
			List<Map<String, Object>> d_list =  baseDao.free_select(param);
			int freeDeileveryLimit = StringUtil.ObjectToInt( d_list.get(0).get("price")) ;
			param.put("freeDeileveryLimit", freeDeileveryLimit);
			
			int delivery_price =  StringUtil.ObjectToInt(taekbaeInfo.get("box")); //Const.A_DELIVERY_PRICE;
			System.out.println("freeDeileveryLimit = "+ freeDeileveryLimit);
			System.out.println("freeDeileveryLimit = "+ freeDeileveryLimit);
			System.out.println("freeDeileveryLimit = "+ freeDeileveryLimit);
			
			if(goods_tot >= freeDeileveryLimit ) {
				
			}else {
				goods_tot = goods_tot + delivery_price;
			}
			
			/*
			System.out.println("sale_per ="+ sale_per);
			System.out.println("sale_price ="+ sale_price);
			*/
			
			/// 상품금액이 10만원 이상일경우에는  할인이 있더라도 배송비 포함하지 말자
			if(sale_per > 0 && goods_tot < ori_goods_tot) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			System.out.println("sale_price11 ="+ sale_price);
			
			
			param.put("goods_tot", goods_tot - sale_price);
			param.put("sale_price", sale_price);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			param.put("sum_delivery_tot", taekbaeInfo.get("box"));
			
			map.put("bean", param);
			
			String url = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m03/01_add_order"+Const.mTiles;
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			//PageUtil.scriptAlert(response, "오류가 발생했습니다.\n다시 시도해주세요.", "/m03/01_view.do?p_seq="+param.getString("p_seq")+"&page="+param.getString("page"));
			PageUtil.scripAlertBack(response, "오류가 발생했습니다.\n다시 시도해주세요.");
		}
		return "/m03/01_add_order"+Const.uTiles;
	}
	
	@RequestMapping ({"/m03/01_com_order_cms.do", "/m99/01_com_order_cms.do","/m99/01_com_order_cms.do"})
	public String v_01_com_order_cms( Map<String, Object> map
								     ,HttpServletRequest request
					   			    ,HttpServletResponse response){
		
		
		String cancel_url = "";
		String f_menu = "/m03";
		try {
			
			if(request.getServletPath().indexOf("/m99/") != -1) {
				f_menu = "/m99";
			}
			
			HttpSession session  = request.getSession(false);
			@SuppressWarnings("unchecked")
			Map<String, Object> cmsInfo = (Map<String, Object>)session.getAttribute("cmsYakSession");
			
			try {
				System.out.println("session  is");
				param.put("cms_txTid"    , cmsInfo.get("txTid"));
				param.put("cms_authToken", cmsInfo.get("authToken"));
				param.put("cms_payMethod", cmsInfo.get("payMethod"));
				param.put("cms_tid"      , cmsInfo.get("TID"));
				param.put("cms_moid"     , cmsInfo.get("moid"));
				
				param.put("easybank_name"     , cmsInfo.get("EasyBankName"));
				param.put("easybanK_account"  , cmsInfo.get("EasyBanKAccount"));
				param.put("authcode"          , cmsInfo.get("AuthCode"));
				param.put("authdate"          , cmsInfo.get("AuthDate"));
				param.put("signature"         , cmsInfo.get("AuthDate"));
				
			}catch (Exception e) {
				System.out.println("get cookie");
				
				String AuthCode = "";
				String AuthDate = "";
				param.put("mem_seqno"  , userSession.get("seqno"));
				if(!"".equals(AuthCode) && !"".equals(AuthDate)) {
					Cookie cookie[] = request.getCookies();
				  	for(int i = 0; i< cookie.length; i++){
				  		if("AuthCode".equals(cookie[i].getName())){
				  			AuthCode = cookie[i].getValue();
				  		}
				  		if("AuthDate".equals(cookie[i].getName())){
				  			AuthDate = cookie[i].getValue();
				  		}
				  	}
				  	
				  	System.out.println("COOKIE AuthCode = "+ AuthCode);
				  	System.out.println("COOKIE AuthDate = "+ AuthDate);
				  	
				  	param.put("AuthCode" , AuthCode);
					param.put("AuthDate" , AuthDate);
				  	
					cmsInfo = yakCartDao.select_cmspay_info(param);
				}else {
					cmsInfo = yakCartDao.select_cmspay_info_last(param);
				}
				param.put("cms_txTid"    , cmsInfo.get("txTid"));
				param.put("cms_authToken", cmsInfo.get("authToken"));
				param.put("cms_payMethod", cmsInfo.get("payMethod"));
				param.put("cms_tid"      , cmsInfo.get("TID"));
				param.put("cms_moid"     , cmsInfo.get("moid"));
				
				param.put("easybank_name"     , cmsInfo.get("EasyBankName"));
				param.put("easybanK_account"  , cmsInfo.get("EasyBanKAccount"));
				param.put("authcode"          , cmsInfo.get("AuthCode"));
				param.put("authdate"          , cmsInfo.get("AuthDate"));
				param.put("signature"         , cmsInfo.get("AuthDate"));
			}
			
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
		    cancel_url = "?CancelMsg=error_cancel";
		    cancel_url+= "&CancelAmt="+param.getString("cms_amt");
		    cancel_url+= "&PartialCancelCode=0";
		    cancel_url+= "&MID="+Const.NP_CMS_MID;
		    cancel_url+= "&MOID="+param.getString("cms_moid");
		    cancel_url+= "&TID="+param.getString("cms_tid");
		    cancel_url+= "&page="+param.getInt("page", 1);
		    cancel_url+= "&p_seq="+param.getString("p_seq");
			
			
			// 리스트
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			
			int delivery_price = param.getInt("delivery_price");
			int tot_price 	   = param.getInt("tot_price");
			int db_tot_price   = 0;
			
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
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중
			param.put("order_ing"      , 1);
			param.put("pay_ing"        , 1);
			
			
			boolean flag = false;
			
			try {
				flag = yakCartDao.add_order_card(param, list);
			}catch (Exception e) {
				flag = false;
			}
			
			if(!flag) {
			    return "redirect:/m03/01_order_com_cms_cancel.do"+cancel_url;
			}else {
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , param.getString("Amt"));
				info.put("payment_kind"  , param.getString("payment_kind"));
				info.put("delivery_price", delivery_price);
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				info.put("today"  	   , sdf.format(today));
				
				info.put("easybank_name"  , cmsInfo.get("EasyBankName"));
				info.put("easybanK_account"  , cmsInfo.get("EasyBanKAccount"));
				
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:"+f_menu+"/02_order_result.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return "redirect:"+f_menu+"/01_order_com_cms_cancel.do"+cancel_url;
		}
	}
	
	@RequestMapping ({"/m03/01_order_com_cms_cancel.do", "/m99/01_order_com_cms_cancel.do"})
	public String order_com_cms_cancel( Map<String, Object> map
					  		 	   	   ,HttpServletResponse response ){
		
		String f_menu = "/m03";
		try{
			System.out.println("01_order_com_cms_cancel = "+ param);
			
			if(request.getServletPath().indexOf("/m99/") != -1) {
				f_menu = "/m99";
			}
			
			// 1초후에 작동
			Thread.sleep(500);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCms(param, request, response);
			
			
			//param.put("href_url", "/m03/01_view.do?p_seq="+param.getString("p_seq")+"&page="+param.getInt("page", 1));
			param.put("href_url", f_menu+"/01.do");
			param.put("msg", "주문에러가 발생했습니다.다시 시도해주세요");
			
			if(cardInfo != null) {
				String resultCode  = StringUtil.objToStr(cardInfo.get("resultCode"), "");
				if("2001".equals(resultCode)) {
					param.put("msg", "주문 에러로 인한 간편결제를 취소했습니다.");
				}
			}				
			map.put("bean", param);
		}catch (Exception e) {			
			e.printStackTrace();
		//	PageUtil.scriptAlert(response, "카드결제취소중 에러가 발생했습니다.\n고객센터에 문의해주세요.", "/m03/02.do");
		}
		return f_menu+"/card_cancel"+Const.uuTiles;
	}
	
	
	@RequestMapping ({"/m03/01_com_order.do", "/m99/01_com_order.do"})
	public String v_01_com_order( Map<String, Object> map
								 ,HttpServletRequest request
					   			 ,HttpServletResponse response){
		try {
			
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
			
			
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			
			
			String f_menu = "/m03";
			if(request.getServletPath().indexOf("/m99/") != -1) {
				f_menu = "/m99";
			}
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/01_add_order.do")  == -1 && referer.indexOf("/m99/01_add_order.do")  == -1) {
				PageUtil.scriptAlert(response, "잘못된 접근입니다.", f_menu+"/01.do");
	            
			}
			// 처방불가 체크
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				PageUtil.scriptAlert(response, "처방불가능한 약속처방이 있습니다.", f_menu+"/01.do");
			}
			
			// 리스트
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
				/*
				System.out.println("-============================");
				System.out.println("info = "+ info);
				System.out.println("-============================");
				*/
				real_list.add(info);
			}// for i
			
			System.out.println("sale_price1 = "+ sale_price);
			System.out.println("sale_per = "+ sale_per);
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			System.out.println("db_tot_price   = "+db_tot_price);
			System.out.println("sale_price     = "+sale_price);
			System.out.println("delivery_price = "+delivery_price);
			System.out.println("tot_price      = "+tot_price);
			
			if( (db_tot_price-sale_price+delivery_price)  != tot_price ){
				param.put("msg", "결제금액이 일치하지 않습니다..");
				map.put("bean", param);
				return "/m03/card_cancel"+Const.uuTiles;
				//PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
			}// if
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중
			param.put("order_ing"      , 1);
			if("Bank".equals(param.get("payment_kind"))) {
				param.put("pay_ing"        , 2);
			}
			else if("Cms".equals(param.get("payment_kind"))) {
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				
				System.out.println("cardInfo = "+ cardInfo);
				System.out.println("cardInfo = "+ cardInfo);
				System.out.println("cardInfo = "+ cardInfo);
				/*
				cardInfo = {cardName=null, vbankBankName=null, vbankNum=null, resultCode=4000, mid=nicepay00m, amt=000000000950, bankName=국민은행, rcptTID=, tid=nicepay00m02012102151626411107, moid=cheongdamy00000007_20210215162604303, goodsName=경옥고 스틱(10g) 180포. 실속박스증정, easyBankUserNo=null, authDate=210215162642, bankCode=004, vbankBankCode=null, authCode=202102152708013, cardCode=null, cardQuota=null, rcptAuthCode=, buyerName=테스트, resultMsg=계좌이체 결제 성공, carrier=null, rcptType=0, dstAddr=null, mallUserID=, vbankExpDate=null}
				*/
			}else{
				param.put("pay_ing"        , 1);
												
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				System.out.println("cardInfo = "+ cardInfo);
				
				String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
				System.out.println("resultMsg= "+ resultMsg);
				if(!"3001".equals(cardInfo.get("resultCode")+"")) {
					param.put("msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
					map.put("bean", param);
					return "/m03/card_cancel"+Const.uuTiles;
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
			
			if(userSession == null || userSession.isEmpty()) {
				try { 
					param.put("cart_seqno", list.get(0).get("seqno"));
					
					Map<String, Object> nUserInfo = loginDao.userGetInfo(param);
					UserSessionManager usm = new UserSessionManager();
					
					
					param.put("id"             , userSession.get("id"));
					param.put("mem_seqno"      , userSession.get("seqno"));
					param.put("order_name"     , userSession.get("name"));
					param.put("order_handphone", userSession.get("handphone") );
					
					usm.setSession(nUserInfo, request);
					
				}catch (Exception e) {
					System.out.println("card pay  session create");
					e.printStackTrace();
				}
			}
			
			
			
			
			boolean flag = false;
			
			try {
				flag = yakCartDao.add_order_card(param, list);
			}catch (Exception e) {}
			
			if(!flag) {
				// 카드일경에는 돈 취소해줘야 하는데..		
				if("Bank".equals(param.get("payment_kind"))) {
					PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
					param.put("msg"     , "결제 오류가 발생했습니다. 다시 시도해주세요.");
					param.put("href_url", "/m03/01.do");
					map.put("bean", param);
					return "/m03/card_cancel"+Const.uuTiles;
				}else {
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&page="+param.getInt("page", 1);
					       url+= "&p_seq="+param.getString("p_seq");
					
					return "redirect:/m03/01_order_com_cancel.do"+url;
				}
			}else {
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				info.put("result_price"  , param.getString("Amt"));
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
				
				return "redirect:"+f_menu+"/02_order_result.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			param.put("msg"     , "결제금액이 일치하지 않습니다.");
			param.put("href_url", "/m03/01_view.do?p_seq="+param.getString("p_seq"));
			map.put("bean", param);
			return "/m03/card_cancel"+Const.uuTiles;
		}
	}
	
	@RequestMapping ("/m03/01_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("01_order_com_cancel = "+ param);
			
			// 1초후에 작동
			Thread.sleep(500);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			
			param.put("href_url", "/m03/01_view.do?p_seq="+param.getString("p_seq")+"&page="+param.getInt("page", 1));
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
	
	@RequestMapping ("/m03/lately.do")
	public String v_lately( Map<String, Object> map
					   	   ,HttpServletResponse response){		
		return "/m03/lately"+Const.uuTiles;
	}
	
	
	@RequestMapping ("/m03/select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			param.put("user_mem_seqno"      , userSession.get("seqno"));
			int total = shopDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(shopDao.select_shop(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ({"/m03/01_preorder.do", "/m99/01_preorder.do"})
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
		return "/m03/01_preorder"+Const.uuTiles;
	}// 01_preorder
	
	
	@RequestMapping ({"/m03/01_preorder_proc", "/m99/01_preorder_proc"})
	public @ResponseBody Map<String, Object> preorder_proc( Map<String, Object> map
													  	   ,HttpServletResponse response
													  	   ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			Map<String, Object> view = yakDao.select_pre_order(param);
			
			boolean flag = false;
			if(view == null) {
				flag = yakDao.add_preorder(param);
			}else {
				param.put("seqno", view.get("seqno"));
				flag = yakDao.mod_preorder(param);
			}
			
			if(flag) {
				rtn = PageUtil.procSuc("신청되었습니다.");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			rtn.put("check_id", 0);
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ({"/m03/01_add_order_iframe.do","/m/m03/01_add_order_iframe.do","/m99/01_add_order_iframe.do"})
	public String v_01_add_order_iframe( Map<String, Object> map
			                     		,HttpServletRequest request
			                     		,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("sale_per" , userSession.get("sale_per"));
			param.put("all_seqno", param.getString("p_seq"));
			
			Map<String, Object> taekbaeInfo =   baseDao.free_select(param).get(0);
			map.put("taekbaeInfo", taekbaeInfo);
			
			// 처방불가 체크
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
//				PageUtil.scripAlertBack(response, "처방불가능한 약속처방이 있습니다.");
			}
			
			// 리스트
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			map.put("list", list);
			
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			
			int ori_goods_tot = 0;
			
			int sale_per      = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price     = 0;
			
			for(int i= (list.size()-1); i>=0 ; i--) {
				goods_tot += StringUtil.ObjectToInt(list.get(i).get("goods_tot") );
				goods_name = StringUtil.objToStr(list.get(i).get("p_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("p_seq") );
				
				if(sale_per > 0) {
					sale_price += (StringUtil.ObjectToInt(list.get(i).get("goods_tot") )* sale_per) / 100;					
				}
				
			}//for i
			ori_goods_tot = goods_tot;
			
			List<Map<String, Object>> d_list =  baseDao.free_select(param);
			int freeDeileveryLimit = StringUtil.ObjectToInt( d_list.get(0).get("price")) ;
			param.put("freeDeileveryLimit", freeDeileveryLimit);
			
			int delivery_price = StringUtil.ObjectToInt(taekbaeInfo.get("box")); //Const.A_DELIVERY_PRICE;
			String ship_type_from = param.getString("ship_type_from");
			if(goods_tot >= freeDeileveryLimit) {
			}else {
				if(!"5".equals(ship_type_from)) {
					goods_tot = goods_tot + delivery_price;
				}
			}
			
			if(sale_per > 0 && ori_goods_tot < freeDeileveryLimit && !"5".equals(ship_type_from)) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			/*
			System.out.println("sale_per ="+ sale_per);
			System.out.println("sale_price ="+ sale_price);
			*/
			
			System.out.println("sale_price11 ="+ sale_price);
			
			
			param.put("goods_tot", goods_tot - sale_price);
			param.put("sale_price", sale_price);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			param.put("sum_delivery_tot", taekbaeInfo.get("box"));
			
			map.put("bean", param);
			
			String url = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m/m03/01_add_order_iframe"+Const.mmTiles;
			}
			
			
			if("Cms".equals(param.getString("payment_kind"))) {
				
				Map<String, Object> userData = loginDao.userIdCheck(param);
				param.put("cms_key", userData.get("cms_key"));
				
				map.put("bean", param);
				
				return "/m03/01_add_order_cms_iframe"+Const.uuTiles;
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/01_add_order_iframe"+Const.uuTiles;
	}
	
	
	@RequestMapping ({"/m03/01_com_order_ajax.do","/m99/01_com_order_ajax.do"})
	public @ResponseBody Map<String, Object> v_01_com_order_ajax( Map<String, Object> map
																 ,HttpServletRequest request
													   			 ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String Amt = param.getString("Amt");
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					System.out.println("user session create 1= " +info);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
				}catch (Exception e) {
					System.out.println("usersession create fail1");
					e.printStackTrace();
				}
				
			}
			
			
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			param.put("sale_per"       , userSession.get("sale_per"));
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/01_add_order.do")  == -1 ) {
	         //   PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/m03/01.do");
			}
			// 처방불가 체크
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				rtn.put("msg", "처방불가능한 약속처방이 있습니다.");
				return rtn;
			}
			
			// 리스트
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
			
			System.out.println("sale_price1 = "+ sale_price);
			System.out.println("sale_per = "+ sale_per);
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			System.out.println("sale_price     = "+sale_price);
			System.out.println("delivery_price = "+delivery_price);
			System.out.println("tot_price      = "+tot_price);
			/*
			if( (db_tot_price-sale_price+delivery_price)  != tot_price ){
				param.put("msg", "결제금액이 일치하지 않습니다..");
				map.put("bean", param);
				return "/m03/card_cancel"+Const.uuTiles;
			}// if
			*/
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중
			param.put("order_ing"      , 1);
			if("Bank".equals(param.get("payment_kind"))) {
				param.put("pay_ing"        , 2);
			}else{
				param.put("pay_ing"        , 1);
												
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				
				
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
				
				
				
				
				System.out.println("cardInfo = "+ cardInfo);
				
				String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
				System.out.println("resultMsg= "+ resultMsg);
				if(!"3001".equals(cardInfo.get("resultCode")+"")) {
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
			}
			
			
			boolean flag = yakCartDao.add_order_card(param, list);			
			if(!flag) {
				// 카드일경에는 돈 취소해줘야 하는데..		
				if("Bank".equals(param.get("payment_kind"))) {
					PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
				}else {
					rtn.put("CancelMsg", "error_cancel");
					rtn.put("CancelAmt", Amt);
					rtn.put("TID"      , param.getString("card_gu_no"));
					rtn.put("MID"      , param.getString("mid"));
					rtn.put("CancelPwd", Const.NP_c_pass);
					rtn.put("PartialCancelCode", 0);
					rtn.put("msg","에러가 발생했습니다. 카드결제를 취소합니다.");
					rtn.put("page", param.getString("page"));
					rtn.put("p_seq", param.getString("p_seq"));
					return rtn;
				}
			}else {
				
				Map<String, Object> info = new HashMap<String, Object>();
				info.put("all_cart_seqno", param.getString("all_seqno"));
				//info.put("result_price"  , delivery_price + tot_price);
				//info.put("result_price"  , tot_price);
				info.put("result_price"  , param.getString("Amt"));
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
				
				rtn.put("suc", true);
				rtn.put("msg", "정상적으로 주문처리 되었습니다.");
				return rtn;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			rtn.put("msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
		}
		return rtn;
	}
	
	@RequestMapping ({"/m03/card_cancel_ajax.do", "/m/m03/card_cancel_ajax.do"})
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
	
	
	
}
