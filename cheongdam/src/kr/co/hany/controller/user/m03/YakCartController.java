package kr.co.hany.controller.user.m03;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.session.UserSessionManager;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class YakCartController extends UserDefaultController{
	
	
	@Autowired
	YakCartDAO yakCartDao;
	
	
	@Autowired
	YakDAO yakDao;
	
	@Autowired
	BaseDAO baseDao;
	
	@Autowired
	LoginDAO loginDao;
	
	@RequestMapping ("/m03/02.do")
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
				rtn  = PageUtil.procSuc("삭제되었습니다.");
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m03/02_mod_cart_ea.do")
	public @ResponseBody Map<String, Object> aj_mod_cart_ea( Map<String, Object> map
														    ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			int ea = param.getInt("ea");
			String pre_req = param.getString("pre_req");
			param.put("call_type", "cart");
			
			
			if("Y".equals(pre_req)) {
				Map<String, Object> pre_order = yakDao.select_pre_order(param);
				if(pre_order != null) {
					int order_cnt   = yakDao.order_cnt(param);
					int cart_cnt    = yakDao.cart_cnt(param);
					
					int pre_order_ea = StringUtil.ObjectToInt(pre_order.get("ea"));
						pre_order_ea = (pre_order_ea - order_cnt) - cart_cnt;
						
					if((pre_order_ea - ea) < 0) {
						//rtn.put("msg", "남은수량이 부족합니다. 남은수량은  "+pre_order_ea +"개 입니다.");
						rtn.put("msg", "남은수량이 부족합니다. 상세페이지에서 남은수량을 확인하세요.");
						return rtn;
					}
				}else{
					rtn.put("msg", "남은수량이 부족합니다. 상세페이지에서 남은수량을 확인하세요.");
					return rtn;
				}
			}
			
			
			boolean flag = yakCartDao.mod_cart(param);
			if(flag) {
				rtn  = PageUtil.procSuc("수정되었습니다.");
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ({"/m03/02_order_app_cart.do" ,"/m/m03/02_order_app_cart.do"})
	public String v_02_order_app_cart( Map<String, Object> map
					   			 	  ,HttpServletResponse response){
		try {
			
			
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("sale_per" , userSession.get("sale_per"));
			
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/02.do")  == -1  ) {
	            PageUtil.scripAlertBack(response, "잘못된 접근입니다.");
			}
			
			
			Map<String, Object> taekbaeInfo =   baseDao.free_select(param).get(0);
			map.put("taekbaeInfo", taekbaeInfo);
			
			
			// 처방불가 체크
			int unuse = yakCartDao.unuse_goods_cart(param);
			if(unuse > 0) {
				PageUtil.scriptAlert(response, "처방불가능한 약속처방이 있습니다." , "02.do");
			}
			
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			if(list.size() == 0) {
				//PageUtil.scripAlertBack(response, "장바구니에 담김 처방이 없습니다.");
				PageUtil.scriptAlert(response, "장바구니에 담김 처방이 없습니다.", "02.do");
			}
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			
			int sale_per   = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price = 0;
			
			
			for(int i= (list.size()-1); i>=0 ; i--) {
				Map<String, Object> temp = list.get(i);
				
				String s_goods_tot = list.get(i).get("goods_tot")+"";
				System.out.println("s_goods_tot = "+ s_goods_tot);
				s_goods_tot = s_goods_tot.replace(".0", "");
				System.out.println("s_goods_tot = "+ s_goods_tot);
				
				goods_tot += StringUtil.ObjectToInt( s_goods_tot);
				goods_name = StringUtil.objToStr(list.get(i).get("p_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("p_seq") );
				
				if(sale_per > 0) {
					sale_price += (StringUtil.ObjectToInt( s_goods_tot) * sale_per) / 100;					
				}
				
			}//for i
			
			
			List<Map<String, Object>> d_list =  baseDao.free_select(param);
			int freeDeileveryLimit = StringUtil.ObjectToInt( d_list.get(0).get("price")) ;
			param.put("freeDeileveryLimit", freeDeileveryLimit);
			
			//int delivery_price = Const.A_DELIVERY_PRICE;
			int delivery_price =  StringUtil.ObjectToInt(taekbaeInfo.get("box")); //Const.A_DELIVERY_PRICE;
			System.out.println("delivery_price = "+ delivery_price);
			/*System.out.println("goods_tot = "+ goods_tot);
			System.out.println("goods_tot = "+ goods_tot);
			System.out.println("goods_tot = "+ goods_tot);
			System.out.println( (goods_tot < 100000) );*/
			if(goods_tot >= freeDeileveryLimit) {
			}else {
				goods_tot = goods_tot + delivery_price;
			}
			
			if(sale_per > 0 && goods_tot < freeDeileveryLimit) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			/*System.out.println("---->"+sale_price);
			System.out.println("---->"+sale_price);
			System.out.println("---->"+sale_price);
			System.out.println("---->"+sale_price);*/
			
			if(list.size()>1) goods_name = goods_name + "외 "+ (list.size()-1)+ "건";
			
			param.put("goods_tot", goods_tot - sale_price);
			param.put("sale_price", sale_price);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			
			Map<String, Object> member_point = yakDao.select_point(param);
			if(member_point == null ) {
				member_point = new HashMap<String, Object>();
				member_point.put("tot_point", 0);
				member_point.put("p_point", 0);
				member_point.put("m_point", 0);
			}
			
			map.put("member_point", member_point);
			
			map.put("list", list);
			//param.put("sum_delivery_tot", Const.A_DELIVERY_PRICE);
			param.put("sum_delivery_tot", taekbaeInfo.get("box"));
			map.put("bean", param);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m//m03/02_order_app_cart"+Const.mTiles;
			}
			
		}catch (Exception e) {
			PageUtil.scripAlertBack(response, "다시 시도해주세요.");
			e.printStackTrace();
		}
		return "/m03/02_order_app_cart"+Const.uTiles;
	}
	
	
	
	
	@RequestMapping ("/m03/02_order_com_cart.do")
	public String v_02_order_com_cart( Map<String, Object> map
					   			 	  ,HttpServletResponse response){
		try {
			
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
			
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/02_order_app_cart.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/m03/02.do");
			}
			// 처방불가 체크
			int unuse = yakCartDao.unuse_goods_cart(param);
			if(unuse > 0) {
				PageUtil.scriptAlert(response, "처방불가능한 약속처방이 있습니다.", "/m03/02.do");
			}
			
			
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
			int delivery_price        = param.getInt("delivery_price");
			int tot_price 	          = param.getInt("tot_price");
			
			if(use_point > useablePoint) {
				PageUtil.scripAlertBack(response, "사용가능한 포인트보다 많은 포인트가 입력되었습니다.");
				return "";
			}
			
			if("Point".equals(param.get("payment_kind"))  && use_point != tot_price  ) {
				PageUtil.scripAlertBack(response, "총 결제금액과 사용포인트가 일치하지 않습니다.");
				return "";
			}
			
			
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			
			
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
				// 896,350‬
				// 895,990
			}// for i
			
			
			if(sale_per > 0 &&  delivery_price > 0) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			System.out.println("db_tot_price   = "+db_tot_price);
			System.out.println("sale_price     = "+sale_price);
			System.out.println("delivery_price = "+delivery_price);
			System.out.println("tot_price      = "+tot_price);
			
			System.out.println("use_point      = "+use_point);
			System.out.println("use_point_focusout      = "+use_point_focusout);
			
			
			/* 검증하지 말자 자꾸 틀린다..
			if( (db_tot_price-sale_price+delivery_price)  != tot_price ){
				PageUtil.scripAlertBack(response, "결제금액이 일치하지 않습니다1.");
			}// if
			*/
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중		
			param.put("order_ing"      , 1);
			if("Bank".equals(param.get("payment_kind"))) {
				param.put("pay_ing"        , 2);
			}else if("Point".equals(param.get("payment_kind"))) {
				param.put("pay_ing"        , 1);
			}else{
				param.put("pay_ing"        , 1);
												
				Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
				System.out.println("cardInfo = "+ cardInfo);
				
				String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
				String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
				if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
					PageUtil.scripAlertBack(response, "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
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
			
			boolean flag = yakCartDao.add_order_card(param, real_list);
			
			if(!flag) {
				if("Bank".equals(param.get("payment_kind"))) {
					PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
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
				info.put("result_point"  , use_point);
				info.put("all_cart_seqno", param.getString("all_seqno"));
				//info.put("result_price"  , tot_price);
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
				//session.removeAttribute("pay_session");
				
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m03/02_order_result_cart.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
		}
		return "";
	}
	
	@RequestMapping ("/m03/02_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("02_order_com_cancel = "+ param);
			
			// 1초후에 작동
			Thread.sleep(1000);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			
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
			
			
			List<Map<String, Object>> list = yakCartDao.select_pay_result_list(info);
			
			//map.put("list", list);
			//map.put("sub", list.get(0));
			
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
			
			
			List<Map<String, Object>> list = yakCartDao.select_immedi_pay_result_list(info);
			map.put("list", list);
			
			map.put("sub", list.get(0));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/02_order_result"+Const.uTiles; 
	}
	
	
	
	@RequestMapping ({"/m03/02_order_app_cart_iframe.do" ,"/m/m03/02_order_app_cart_iframe.do"})
	public String v_02_order_app_cart_iframe( Map<String, Object> map
			 	  							 ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			Map<String, Object> taekbaeInfo =   baseDao.free_select(param).get(0);
			map.put("taekbaeInfo", taekbaeInfo);
			
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			
			int sale_per   = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price = 0;
			
			List<Map<String, Object>> list = yakCartDao.list(param);
			for(int i= (list.size()-1); i>=0 ; i--) {
				Map<String, Object> temp = list.get(i);
				
				String s_goods_tot = list.get(i).get("goods_tot")+"";
				System.out.println("s_goods_tot = "+ s_goods_tot);
				s_goods_tot = s_goods_tot.replace(".0", "");
				System.out.println("s_goods_tot = "+ s_goods_tot);
				
				goods_tot += StringUtil.ObjectToInt( s_goods_tot);
				goods_name = StringUtil.objToStr(list.get(i).get("p_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("p_seq") );
				
				if(sale_per > 0) {
					sale_price += (StringUtil.ObjectToInt( s_goods_tot) * sale_per) / 100;					
				}
				
			}//for i
			
			
			List<Map<String, Object>> d_list =  baseDao.free_select(param);
			int freeDeileveryLimit = StringUtil.ObjectToInt( d_list.get(0).get("price")) ;
			param.put("freeDeileveryLimit", freeDeileveryLimit);
			
			//int delivery_price = Const.A_DELIVERY_PRICE;
			int delivery_price =  StringUtil.ObjectToInt(taekbaeInfo.get("box")); //Const.A_DELIVERY_PRICE;
			String ship_type_from = param.getString("ship_type_from");
			if(goods_tot >= freeDeileveryLimit) {
			}else {
				if(!"5".equals(ship_type_from)) {
					goods_tot = goods_tot + delivery_price;
				}
			}
			
			if(sale_per > 0 && goods_tot < freeDeileveryLimit && !"5".equals(ship_type_from)) {
				sale_price += (delivery_price * sale_per) / 100;					
			}
			
			
			if(list.size()>1) goods_name = goods_name + "외 "+ (list.size()-1)+ "건";
			
			
			param.put("goods_tot", goods_tot - sale_price);
			param.put("sale_price", sale_price);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			
			map.put("list", list);
			param.put("sum_delivery_tot", Const.A_DELIVERY_PRICE);
			map.put("bean", param);
			
			
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m//m03/02_order_app_cart_iframe"+Const.mmTiles;
			}
			
		}catch (Exception e) {
			PageUtil.scripAlertBack(response, "다시 시도해주세요.");
			e.printStackTrace();
		}
		return "/m03/02_order_app_cart_iframe"+Const.uuTiles;
	}
	
	
	
	@RequestMapping ("/m03/02_order_com_cart_card.do")
	public @ResponseBody Map<String, Object> v_02_order_com_cart_card( Map<String, Object> map
					   			 	  	   ,HttpServletResponse response){
		
		Map<String, Object> rtn = new HashMap<String, Object>();
		try {
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			// 처방불가 체크
			int unuse = yakCartDao.unuse_goods_cart(param);
			if(unuse > 0) {
				//PageUtil.scriptAlert(response, "처방불가능한 약속처방이 있습니다.", "/m03/02.do");
			}
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			if(list.size() == 0) {
				rtn.put("msg", "상품정보를 정상적으로 불러오지 못했습니다. 다시 시도해주세요.");
				return rtn;
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
			
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중		
			
			param.put("pay_ing"        , 1);
											
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = "+ cardInfo);
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
			if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
				PageUtil.scripAlertBack(response, "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
			}
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
				if("Bank".equals(param.get("payment_kind"))) {
					PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
				}else {
					String url = "?CancelMsg=error_cancel";
					       url+= "&CancelAmt="+param.getString("card_amt");
					       url+= "&TID="+param.getString("card_gu_no");
					       url+= "&MID="+param.getString("mid");
					       url+= "&CancelPwd="+Const.NP_c_pass;
					       url+= "&PartialCancelCode=0";
					
					//return "redirect:/m03/02_order_com_cancel.do"+url;
				}
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
				
				HttpSession session  = request.getSession();
				//session.removeAttribute("pay_session");
				
				session.setAttribute("pay_yak_session", info);
				
				//return "redirect:/m03/02_order_result_cart.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			//PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
		}
		return rtn;
	}
	
	
	@RequestMapping (value="/m03/02_order_com_cart_ajax.do.do", method=RequestMethod.POST)
	public @ResponseBody Map<String, Object>  v_02_order_com_cart_ajax( Map<String, Object> map
										  	 					       ,HttpServletResponse response){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			
			System.out.println("/m03/02_order_com_cart_ajax.do.do = "+ userSession);
			System.out.println("param = "+ param);
			
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
			
			
			
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("order_name"      , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			param.put("sale_per"        , userSession.get("sale_per"));
			
			
			// 처방불가 체크
			int unuse = yakCartDao.unuse_goods_cart(param);
			if(unuse > 0) {
				rtn.put("msg", "처방불가능한 약속처방이 있습니다.");
				return rtn;
			}
			
			
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
				rtn.put("msg", "사용가능한 포인트보다 많은 포인트가 입력되었습니다.");
				return rtn;
			}
			
			// 리스트
			List<Map<String, Object>> list = yakCartDao.list(param);
			if(list.size() == 0) {
				rtn.put("msg", "장바구니에 담김 처방이 없습니다.");
				return rtn;
			}
			
			int delivery_price = param.getInt("delivery_price");
			int tot_price 	   = param.getInt("tot_price");
			
			
			List<Map<String, Object>> real_list = new ArrayList<Map<String, Object>>();
			int sale_per     = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price   = 0;
			int db_tot_price = 0;
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
				// 896,350‬
				// 895,990
			}
			//real_list = list;
			
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
					}catch (Exception e) {
						System.out.println("usersession create fail1");
						e.printStackTrace();
					}
				}
				
				System.out.println("cardInfo = "+ cardInfo);
				
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
			}
			
			boolean flag = yakCartDao.add_order_card(param, real_list);
			if(!flag) {
				rtn.put("CancelMsg", "error_cancel");
				rtn.put("CancelAmt", Amt);
				rtn.put("TID"      , param.getString("card_gu_no"));
				rtn.put("MID"      , param.getString("mid"));
				rtn.put("CancelPwd", Const.NP_c_pass);
				rtn.put("PartialCancelCode", 0);
				rtn.put("msg","에러가 발생했습니다. 카드결제를 취소합니다.");
				return rtn;
			}else {
				rtn.put("result_point"  , use_point);
				rtn.put("all_cart_seqno", param.getString("all_seqno"));
				//rtn.put("result_price"  , tot_price);
				rtn.put("result_price"  , param.getString("Amt"));
				rtn.put("delivery_price", delivery_price);
				rtn.put("payment_kind"  , param.getString("payment_kind"));
				
				rtn.put("card_nm"       , param.getString("card_nm"));
				rtn.put("card_quota"    , param.getString("card_quota"));
				rtn.put("tid"  	        , param.getString("card_gu_no"));
				rtn.put("mid"  	        , param.getString("mid"));
				
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				rtn.put("today"  	   , sdf.format(today));
				
				HttpSession session  = request.getSession();
				//session.removeAttribute("pay_session");
				
				session.setAttribute("pay_yak_session", rtn);
				
				rtn.put("suc", true);
				rtn.put("msg", "정상적으로 주문처리 되었습니다.");
				return rtn;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			
		}
		return rtn;
	}
	
}
