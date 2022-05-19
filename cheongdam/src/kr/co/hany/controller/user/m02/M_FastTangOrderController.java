package kr.co.hany.controller.user.m02;

import java.net.URLDecoder;
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
import kr.co.hany.dao.admin.item.FastDAO;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.dao.user.m02.FastTangOrderDAO;
import kr.co.hany.dao.user.m02.ItemDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class M_FastTangOrderController  extends UserDefaultController{

	@Autowired
	ItemDAO itemDao;
	
	
	@Autowired
	FastTangOrderDAO fastTangOrderDao;
	
	@Autowired
	FastDAO fastDao;
	
	@Autowired
	TangDAO tangDao;
	
	
	@RequestMapping ("/m/m02/06.do")
	public String v_06(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			
			param.put("m_view_yn", 'y');
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 6;
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			int totalCount  = fastDao.list_total(param);
			int listCount   = (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount   = (listCount / page_cnt);
			 	lastCount  += listCount % page_cnt == 0 ? 0 : 1;
			 	
			 	
		 	List<Map<String, Object>> list = fastDao.list(param);
			map.put("list"      , list);
		    map.put("listCount" , listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount" , lastCount);
			map.put("pageCount" , totalCount -(page -1)* page_cnt); 	
			
			map.put("bean"      , param);
			
			map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/m/m02/06"+Const.mTiles;
	}
	
	
	@RequestMapping ("/m/m02/06_view.do")
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
			
			Map<String, Object> view = fastDao.view(param);
			
			
			int sale_per      = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price    = 0;
			
			int tang_price    = StringUtil.ObjectToInt(view.get("price"));
			if(sale_per > 0) {
				sale_price += (tang_price * sale_per) / 100;
			}
			
			view.put("sale_per", sale_per);
			view.put("sale_price", sale_price);
			
			
			
			if(view == null || !"y".equals(StringUtil.objToStr(view.get("view_yn"), ""))) {
				PageUtil.scripAlertBack(response, "처방가능한 상태가 아닙니다.");
			}
			
			map.put("ylist", fastDao.detail_yakjae(param));
			
			
			
			map.put("view", view);
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
		}
		return "/m/m02/06_view"+Const.mTiles;
	}//v_01_view
	
	
	@RequestMapping ({"/m/m02/06_add_order.do"})
	public String v__06_add_order( Map<String, Object> map
						  		  ,HttpServletResponse response
						  		  ,HttpSession session){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> view = fastDao.view(param);
			
			if(view == null) {
				PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
			}
			
			int sale_per      = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price    = 0;
			
			int tang_price    = StringUtil.ObjectToInt(view.get("price"));
			if(sale_per > 0) {
				sale_price += (tang_price * sale_per) / 100;
			}
			
			view.put("sale_per"   , sale_per);
			view.put("sale_price" , sale_price);
			view.put("Amt"        , tang_price - sale_price);
			view.put("mem_seqno"  , userSession.get("seqno"));
			
			map.put("view", view);
			map.put("bean", param);
			

		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
		}
		return "/m/m02/06_add_order"+Const.mTiles;
	}// add_cart
	
	
	@RequestMapping ({"/m/m02/06_com_order.do"})
	public String v_06_com_order( Map<String, Object> map
						  		 ,HttpServletResponse response
						  		 ,HttpSession session){
		try {
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("name"            , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			
			param.put("d_to_handphone"   , param.getString("d_to_handphone01")+"-"+param.getString("d_to_handphone02")+"-"+ param.getString("d_to_handphone03"));
			param.put("d_from_handphone"   , param.getString("d_from_handphone01")+"-"+param.getString("d_from_handphone02")+"-"+ param.getString("d_from_handphone03"));
			
			
			Map<String, Object> view = fastDao.view(param);
			if(view == null) {
				PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요1.");
			}
			
			
			// pay_ing  1,입금 2// 미입급
			// order_ing 1 주문처리중
			param.put("order_ing"      , 1);
			param.put("payment", "2"); // 1 입금
			
			boolean flag = fastTangOrderDao.add_order(param, view);
			if(!flag) {				
				param.put("msg"     , "결제 오류가 발생했습니다. 다시 시도해주세요.");
				param.put("href_url", "/m/m02/06.do");
				map.put("bean", param);
				return "/m03/card_cancel"+Const.uuTiles;
			}
			
			
			Map<String, Object> info = new HashMap<String, Object>();
			info.put("seqno"         , param.getString("seqno"));
			info.put("result_price"  , param.getString("Amt"));
			info.put("delivery_price", 0);
			info.put("payment_kind"  , param.getString("payment_kind"));
			info.put("card_nm"       , param.getString("card_nm"));
			info.put("card_quota"    , param.getString("card_quota"));
			info.put("tid"  	     , param.getString("card_gu_no"));
			info.put("mid"  	     , param.getString("mid"));
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			info.put("today"  	   , sdf.format(today));
			
			
			session.setAttribute("pay_fast_session", info);
			
			return "redirect:/m/m02/06_order_result_cart.do";

		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
		}
		return "";
	}// add_cart
	
	@RequestMapping ("/m/m02/06_order_result_cart.do")
	public String cart_plus_order_result( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			HttpSession session  = request.getSession();
			
			@SuppressWarnings("unchecked")
			Map<String, Object> info = (Map<String, Object>)session.getAttribute("pay_fast_session");
			
			if(info == null){
				PageUtil.scriptAlert(response, "정상적인 경로가 아닙니다.", "/m/m02/06.do");
			}
			System.out.println(info);
			map.put("bean", info);
			
			//map.put("list", list);
			//map.put("sub", list.get(0));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m02/06_order_result"+Const.mTiles; 
	}
	
	
	@RequestMapping ("/m/m02/06_add_order_iframe.do")
	public String  v_06_add_order_iframe( Map<String, Object> map
			 							 ,HttpServletResponse response) {
		try {
			
			Map<String, Object> view = fastDao.view(param);
			
			int sale_per      = StringUtil.ObjectToInt(userSession.get("sale_per"));
			int sale_price    = 0;
			
			int tang_price    = StringUtil.ObjectToInt(view.get("price"));
			if(sale_per > 0) {
				sale_price += (tang_price * sale_per) / 100;
			}
			
			view.put("sale_per"   , sale_per);
			view.put("sale_price" , sale_price);
			view.put("Amt"        , tang_price - sale_price);
			view.put("mem_seqno"  , userSession.get("seqno"));
			
			map.put("view", view);
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m/m02/06_add_order_iframe"+Const.mmTiles; 
	}
	

	@RequestMapping ("/m/m02/06_com_order_card.do")
	public String v_06_com_order_card( Map<String, Object> map
			 					      ,HttpServletResponse response
			 					      ,HttpSession session) {
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			
			System.out.println(param);
			System.out.println(param);
			System.out.println(param);
			
			map.put("sc_url", "/m/m02/06.do");
			
			
			param.put("id"              , userSession.get("id"));
			param.put("mem_seqno"       , userSession.get("seqno"));
			param.put("name"            , userSession.get("name"));
			param.put("order_handphone" , userSession.get("handphone") );
			
			param.put("d_to_handphone"   , param.getString("d_to_handphone01")+"-"+param.getString("d_to_handphone02")+"-"+ param.getString("d_to_handphone03"));
			param.put("d_from_handphone"   , param.getString("d_from_handphone01")+"-"+param.getString("d_from_handphone02")+"-"+ param.getString("d_from_handphone03"));
			
			
			Map<String, Object> view = fastDao.view(param);
			
			param.put("payment", "1"); // 1 입금
			
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			System.out.println("cardInfo = "+ cardInfo);
			
			String resultMsg = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			
			String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
			if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
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
				
				boolean flag = fastTangOrderDao.add_order(param, view);
				//flag = false;
				if(!flag) {
					String url = "?CancelMsg=error_cancel";
				       url+= "&CancelAmt="+param.getString("card_amt");
				       url+= "&TID="+param.getString("card_gu_no");
				       url+= "&MID="+param.getString("mid");
				       url+= "&CancelPwd="+Const.NP_c_pass;
				       url+= "&page="+param.getInt("page", 1);
				       url+= "&p_seq="+param.getString("p_seq");
				
				       return "redirect:/m/m02/06_order_com_cancel.do"+url;
				}else {
					
					Map<String, Object> info = new HashMap<String, Object>();
					info.put("seqno"         , param.getString("seqno"));
					info.put("result_price"  , param.getString("Amt"));
					info.put("delivery_price", 0);
					info.put("payment_kind"  , param.getString("payment_kind"));
					info.put("card_nm"       , param.getString("card_nm"));
					info.put("card_quota"    , param.getString("card_quota"));
					info.put("tid"  	     , param.getString("card_gu_no"));
					info.put("mid"  	     , param.getString("mid"));
					Date today = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					info.put("today"  	   , sdf.format(today));
					
					session.setAttribute("pay_fast_session", info);
					
					return "redirect:/m/m02/06_order_result_cart.do";
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			
			map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
			return "/m/m03/fanc_location_alert"+Const.mmTiles;
		}
	}
	
	
	@RequestMapping ("/m/m02/06_order_com_cancel.do")
	public String order_com_cancel( Map<String, Object> map
					  		 	   ,HttpServletResponse response ){
		try{
			System.out.println("01_order_com_cancel = "+ param);
			
			// 1초후에 작동
			Thread.sleep(500);
			
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			
			param.put("href_url", "/m/m02/06.do");
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
	
	@RequestMapping ("/m/m02/lately.do")
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
			
			int totalCount  = tangDao.select_total(param);
			int listCount   = (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount   = (listCount / page_cnt);
			 	lastCount  += listCount % page_cnt == 0 ? 0 : 1;
			
			
			List<Map<String, Object>> list = tangDao.select_order(param);
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
		
		return "/m/m02/lately"+Const.mmTiles;
	}
	
}
