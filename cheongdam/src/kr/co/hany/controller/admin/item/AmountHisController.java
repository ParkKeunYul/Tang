package kr.co.hany.controller.admin.item;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.item.AmountDAO;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/amountHis/*")
public class AmountHisController extends AdminDefaultController{
	@Autowired
	AmountDAO amountDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/amountHis"+Const.aTiles;
	}
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			System.out.println("111111111" + param);
			int total = amountDao.selectHis_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(amountDao.selectHis(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("card_cancel.do")
	public @ResponseBody Map<String, Object> card_cancel( Map<String, Object> map
					  		 					 		 ,HttpServletResponse response
					  		 					 		 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
		//	System.out.println(adminSession);
			Map<String, Object>  cardInfo = NicePayUtil.cancelCard(param, request, response);
			
			if(cardInfo == null) {
				rtn.put("msg", "취소된 결제건 혹은,\n결제 취소중 에러가 발생했습니다.");
				return rtn;
			}
			
			if(!"2001".equals(cardInfo.get("resultCode"))){
				rtn.put("msg","다시시도해주세요.\n["+cardInfo.get("resultMsg")+"]");
				return rtn;
			}
			param.put("card_cancel_id", adminSession.get("a_id"));
			amountDao.card_cancel(param);
			amountDao.del_point(param);
			
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			rtn = PageUtil.procSuc();
			rtn.put("card_cancel_id", adminSession.get("a_id")+"/"+sdf.format(today));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("payinfo.do")
	public String view( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpSession session){
		
		try{
			System.out.println(param);
			
			map.put("info", amountDao.selectPayInfo(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/amount_payinfo"+Const.uaTiles;
	}
	
	@RequestMapping ("point_add.do")
	public String point_add( Map<String, Object> map
					 	    ,HttpServletResponse response
						    ,HttpSession session){
		
		try{
			System.out.println(param);
			
			map.put("info", amountDao.selectPayInfo(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/amount_point_add"+Const.uaTiles;
	}
	
	@RequestMapping ("point_add_proc.do")
	public @ResponseBody Map<String, Object> point_add_proc( Map<String, Object> map
												   		,HttpServletResponse response
												   		,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			param.put("admin_id", adminSession.get("a_id"));
			
			amountDao.point_manage(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
}
