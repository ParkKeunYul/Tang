package kr.co.hany.controller.admin.item;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.base.MemberDAO;
import kr.co.hany.dao.admin.item.PreJojeDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/prejoje/*")
public class PreJojeController extends AdminDefaultController{

	@Autowired
	PreJojeDAO prejojeDao;
	
	@Autowired 
	MemberDAO memberDao;
	
	//order_ing
	/*
	 *  <option value="1" <c:if test="${info.order_ing eq 1 }">selected="selected"</c:if>>주문처리중</option>
		<option value="7" <c:if test="${info.order_ing eq 7 }">selected="selected"</c:if>>입금대기</option>
		<option value="2" <c:if test="${info.order_ing eq 2 }">selected="selected"</c:if>>배송준비</option>
		<option value="3" <c:if test="${info.order_ing eq 3 }">selected="selected"</c:if>>배송중</option>
		<option value="4" <c:if test="${info.order_ing eq 4 }">selected="selected"</c:if>>배송완료</option>
		<option value="6" <c:if test="${info.order_ing eq 6 }">selected="selected"</c:if>>예약발송</option>
		<option value="5" <c:if test="${info.order_ing eq 5 }">selected="selected"</c:if>>환불/취소</option>
	 * 
	 */
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/prejoje"+Const.aTiles;
	}
	
	@RequestMapping ("select_member.do")
	public @ResponseBody JsonObj  select_member( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			List<Map<String, Object>> list = prejojeDao.month_member_list(param);
			param = PageUtil.setListInfo(param, list.size()); 
			
			jsonObj.setRecords(list.size());    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("select_ea.do")
	public @ResponseBody JsonObj  select_ea( Map<String, Object> map
											,HttpServletResponse response
											,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			List<Map<String, Object>> list = prejojeDao.month_ea_list(param);
			param = PageUtil.setListInfo(param, list.size()); 
			
			jsonObj.setRecords(list.size());    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				
				int duple  = prejojeDao.duple_cnt(param);
				
				if(duple != 0) {
					prejojeDao.update_print_ea(param);
				}else {
					prejojeDao.add_print_ea(param);
				}
				
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
	@RequestMapping ("print.do")
	public String print( Map<String, Object> map
						,HttpServletResponse response
						,HttpSession session){
		
		try{
			param.put("seqno", param.getString("search_seqno"));
			
			map.put("info", memberDao.view(param));
			map.put("sign", prejojeDao.select_sign(param));
			map.put("list", prejojeDao.month_ea_list(param));
			map.put("bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/prejoje_pirnt"+Const.uaTiles;
	}
}
