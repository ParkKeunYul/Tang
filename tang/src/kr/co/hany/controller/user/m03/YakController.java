package kr.co.hany.controller.user.m03;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.controller.user.UserNoneDefaultController;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m02.DictionDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.dao.user.m05.MyDictionDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
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
	
	@RequestMapping ("/m03/01.do")
	public String v_01( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("seqno", userSession.get("seqno"));
			
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
			 
			 map.put("navi", PageUtil.getPage(list, param, listCount, lastCount, ""));
			
			 map.put("shop_code", codeDao.shop_group());
			 
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m03/01"+Const.uTiles;
	}
	
	@RequestMapping ("/m03/01_view.do")
	public String v_01_view( Map<String, Object> map
					   	    ,HttpServletResponse response){
		
		try {
			
			Map<String, Object> view = yakDao.goods_view(param);
			
			if(view == null) {
				PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
			}
			
			map.put("view", view);
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "처방가능한 상태가 아닙니다.", "/m03/01.do");
		}
		return "/m03/01_view"+Const.uTiles;
	}//v_01_view
	
	@RequestMapping ("/m03/01_add_cart.do")
	public @ResponseBody Map<String, Object> aj_01_add_cart( Map<String, Object> map
													  		,HttpServletResponse response
													  		,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			param.put("mem_sub_grade", userSession.get("mem_sub_grade"));
			
			
			Map<String, Object> goods_view = yakDao.goods_view(param);
			if(goods_view == null) {
				rtn.put("msg", "처방가능한 상태가 아닙니다.");
				return rtn;
			}
			
			goods_view.put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			goods_view.put("mem_seqno"	  , userSession.get("seqno"));
			goods_view.put("id"      	  , userSession.get("id"));
			goods_view.put("ea"           , param.getInt("ea"));
			
			
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
	
	
	@RequestMapping ("/m03/01_add_order.do")
	public String v_01_add_order( Map<String, Object> map
			                     ,HttpServletRequest request
					   			 ,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			System.out.println(referer);
			if( referer.indexOf("/m03/01_view.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/m03/01.do");
			}
			
			param.put("all_seqno", param.getString("p_seq"));
			
			System.out.println(param);
			
			// 처방불가 체크
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				PageUtil.scriptAlert(response, "처방불가능한 약속처방이 있습니다.", "/m03/01.do");
			}
			
			// 리스트
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			map.put("list", list);
			
			int goods_tot     = 0;
			String goods_name = "";
			int goods_seq     = 0;
			for(int i= (list.size()-1); i>=0 ; i--) {
				goods_tot += StringUtil.ObjectToInt(list.get(i).get("goods_tot") );
				goods_name = StringUtil.objToStr(list.get(i).get("p_name") , "");
				goods_seq  = StringUtil.ObjectToInt(list.get(i).get("p_seq") );
			}//for i
			if(goods_tot < 100000) {
				goods_tot = goods_tot + 4000;
			}
			
			param.put("goods_tot", goods_tot);
			param.put("goods_cnt", list.size());
			param.put("goods_name", goods_name);
			param.put("goods_seq" , goods_seq);
			
			
			param.put("sum_delivery_tot", Const.A_DELIVERY_PRICE);
			map.put("bean", param);
			
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scriptAlert(response, "오류가 발생했습니다.\n다시 시도해주세요.", "/m03/01_view.do?p_seq="+param.getString("p_seq")+"&page="+param.getString("page"));
		}
		return "/m03/01_add_order"+Const.uTiles;
	}
	
	@RequestMapping ("/m03/01_com_order.do")
	public String v_01_com_order( Map<String, Object> map
								 ,HttpServletRequest request
					   			 ,HttpServletResponse response){
		try {
			param.put("id"             , userSession.get("id"));
			param.put("mem_seqno"      , userSession.get("seqno"));
			param.put("order_name"     , userSession.get("name"));
			param.put("order_handphone", userSession.get("handphone") );
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m03/01_add_order.do")  == -1 ) {
	            map.put("sc_msg", "잘못된 접근입니다.");
				map.put("sc_url", "/m03/01.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			// 처방불가 체크
			int unuse = yakDao.unuse_goods(param);
			if(unuse > 0) {
				map.put("sc_msg", "처방불가능한 약속처방이 있습니다.");
				map.put("sc_url", "/m03/01.do");
				
				return "/scriptMsgLoc"+Const.uuTiles;
			}
			
			// 리스트
			List<Map<String, Object>> list = yakDao.goods_pay_view(param);
			list.get(0).put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			
			
			
			int delivery_price = param.getInt("delivery_price");
			int tot_price 	   = param.getInt("tot_price");
			
			int db_tot_price = 0;
			for(int i = 0 ; i<list.size(); i++) {
				Map<String, Object> info =  list.get(i);
				
				String goods_tot = StringUtil.objToStr(info.get("goods_tot") , "").replace(".0", "");
				db_tot_price += Integer.parseInt(goods_tot);
				
			}// for i
			
			
			if( db_tot_price  != tot_price ){
				map.put("sc_msg", "결제금액이 일치하지 않습니다.");
				map.put("sc_url", "/m03/01.do");
				
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
			
			
			boolean flag = yakCartDao.add_order_card(param, list);			
			if(!flag) {
				// 카드일경에는 돈 취소해줘야 하는데..		
				if("Bank".equals(param.get("payment_kind"))) {
					PageUtil.scripAlertBack(response, "결제 오류가 발생했습니다. 다시 시도해주세요.");
					
					map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
					return "/scriptMsg"+Const.uuTiles;
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
				session.setAttribute("pay_yak_session", info);
				
				return "redirect:/m03/02_order_result.do";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			map.put("sc_msg", "결제 오류가 발생했습니다. 다시 시도해주세요.");
			return "/scriptMsg"+Const.uuTiles;
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
			
			System.out.println("1 = "+cardInfo);
			System.out.println(cardInfo);
			System.out.println(cardInfo);
			System.out.println("1 = "+cardInfo);
			
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
	
	
	
}
