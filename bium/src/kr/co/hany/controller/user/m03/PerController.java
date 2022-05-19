package kr.co.hany.controller.user.m03;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.PerDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;


@Controller
public class PerController extends UserDefaultController{

	@Autowired
	YakDAO yakDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	YakCartDAO yakCartDao;
	
	@Autowired
	ShopDAO shopDao;
	
	@Autowired
	PerDAO perDao;
	
	@RequestMapping ({"/m03/personal.do", "/m/m03/personal.do", "/m99/personal.do"})
	public String personal( Map<String, Object> map
					   	   ,HttpServletResponse response){
		try {
			
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 10;
			
			
			param.put("jungm_menu", "sel");
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T2.s_name");
				param.put("whereSql", whereSql);
			}
			
			int totalCount  = perDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			
			List<Map<String, Object>> list = perDao.list(param);
			map.put("list", list);
		    map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			 
			
			map.put("shop_code", codeDao.shop_group());
			map.put("sub_code" , codeDao.shop_sub_group());
			
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));
				
				return "/m//m03/personal"+Const.mTiles;
			}else {
				map.put("navi", PageUtil.getPageMysql(list, param, listCount, lastCount, ""));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "에러가 발생했습니다.");
		}
		return "/m03/personal"+Const.uTiles;
	}
	
	
	@RequestMapping ({"/m03/personal_view.do", "/m/m03/personal_view.do"})
	public String personal_view( Map<String, Object> map
					   	    	,HttpServletResponse response){
		
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> view = perDao.view(param);
			if(view == null) {
				PageUtil.scripAlertBack(response, "개인결제 정보가 없습니다.");
			}

			map.put("view", view);
	//		map.put("deatil_list", perDao.view_detail(param));
			map.put("bean", param);
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				return "/m//m03/personal_view"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "개인결제 정보가 없습니다.");
		}
		return "/m03/personal_view"+Const.uTiles;
	}//personal_view
	
	@RequestMapping ({"/m03/personal_com.do","/m/m03/personal_com.do"})
	public String personal_com( Map<String, Object> map
					   	       ,HttpServletResponse response){
		
		try {
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				map.put("sc_close", "y");
			}
			
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> view = perDao.view(param);
			if(view == null) {
				PageUtil.scripAlertBack(response, "개인결제 정보가 없습니다.");
				map.put("sc_msg", "개인결제 정보가 없습니다.");
				map.put("sc_url", "/m03/personal.do");				
				return "/scriptMsg"+Const.uuTiles;
			}
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) == -1 && referer.indexOf("/m03/personal_view.do")  == -1 ) {
				PageUtil.scripAlertBack(response, "잘못된 접근입니다.");
	            map.put("sc_msg", "잘못된 접근입니다.");
				map.put("sc_url", "/main.do");
				return "/scriptMsg"+Const.uuTiles;
			}
			
			
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			String resultMsg             = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			if(!"3001".equals(cardInfo.get("resultCode")+"")) {
				map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
				map.put("sc_url", "/m03/personal_view.do?seqno="+view.get("seqno"));
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
			
			perDao.order_com(param);
			
			map.put("sc_msg", "결제되었습니다");
			map.put("sc_url", "/m03/personal_view.do?seqno="+view.get("seqno"));
			
		}catch (Exception e) {
			e.printStackTrace();
			map.put("sc_msg", "결제중 에러가 발생했습니다.");
			map.put("sc_url", "/m03/personal.do");
		}
		return "/scriptMsg"+Const.uuTiles;
	}//personal_com
	
}

