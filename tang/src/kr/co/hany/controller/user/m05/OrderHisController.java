package kr.co.hany.controller.user.m05;

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
import kr.co.hany.dao.user.m05.MyCartDAO;
import kr.co.hany.dao.user.m05.OrderHisDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class OrderHisController extends UserDefaultController{

	@Autowired
	OrderHisDAO orderHisDao;
	
	@Autowired
	MyCartDAO myCartDao;
	
	@RequestMapping ("/m05/03.do")
	public String v_03( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			
			param.put("id"   	     , userSession.get("id"));
			param.put("mem_seqno"    , userSession.get("seqno"));
			param.put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			param.put("mem_sub_grade", userSession.get("mem_sub_grade"));
			
			if("".equals(param.getString("search_sub_seqno",""))) {
				param.put("search_sub_seqno", param.get("mem_sub_seqno"));
			}
			
			map.put("sub_id", myCartDao.sub_id_list(param));
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 5;
			
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T2.s_name");
				param.put("whereSql", whereSql);
			}
			
			int totalCount  = orderHisDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			
			
			List<Map<String, Object>> list = orderHisDao.list(param);
			map.put("list", list);
		    map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			 
			map.put("navi", PageUtil.getPage(list, param, listCount, lastCount, ""));
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "에러가 발생했습니다.");
		}
		return "/m05/03"+Const.uTiles;
	}
	
	
	@RequestMapping ("/m05/03_yview.do")
	public String v_03_yview( Map<String, Object> map
					   ,HttpServletResponse response){
		
		try {
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> view = orderHisDao.yak_view(param);
			
			if(view == null) {
				PageUtil.scriptAlert(response, "주문내역이 없습니다.", "/m05/03.do");
			}
			
			param.put("order_no", view.get("order_no"));
			map.put("p_list", orderHisDao.yak_view_list(param));
			map.put("info", view);
			map.put("bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "에러가 발생했습니다.");
		}
		return "/m05/03_yview"+Const.uTiles;
	}
	
	
	@RequestMapping ("/m05/03_tview.do")
	public String v_03_tview( Map<String, Object> map
					   ,HttpServletResponse response){
		
		try {
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			Map<String, Object> view = orderHisDao.tang_view(param);
			
			if(view == null) {
				PageUtil.scriptAlert(response, "주문내역이 없습니다.", "/m05/03.do");
			}
			
			map.put("p_list", orderHisDao.tang_yakjae_list(param));
			
			map.put("info", view);
			map.put("bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "에러가 발생했습니다.");
		}
		return "/m05/03_tview"+Const.uTiles;
	}
	
	@RequestMapping ("/m05/03_cancel_order.do")
	public @ResponseBody Map<String, Object> aj_cancel_order( Map<String, Object> map
													  		 ,HttpServletResponse response
													  		 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			if( referer.indexOf("/m05/03.do")  == -1 ) {
	            PageUtil.scriptAlert(response, "잘못된 접근입니다.", "/main.do");
	            rtn.put("msg", "잘못된 접근입니다.");
	            return rtn;
			}
			
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			boolean flag = orderHisDao.order_cancel(param);
			
			if(flag){
				rtn.put("suc", true);		
				rtn.put("msg", "취소신청 완료되었습니다.");
			}
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}//aj_cancel_order
	
	
}
