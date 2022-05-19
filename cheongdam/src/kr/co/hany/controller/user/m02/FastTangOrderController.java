package kr.co.hany.controller.user.m02;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import kr.co.hany.dao.user.m02.FastTangOrderDAO;
import kr.co.hany.dao.user.m02.ItemDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
public class FastTangOrderController extends UserDefaultController{
	@Autowired
	ItemDAO itemDao;
	
	
	@Autowired
	FastTangOrderDAO fastTangOrderDao;
	
	@Autowired
	FastDAO fastDao;
	
	@RequestMapping ("/m02/06.do")
	public String v_06(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
			param.put("today", sdf.format(today));
			
			
			List<Map<String, Object>>  box_list   = itemDao.select_box(param); 
			List<Map<String, Object>>  pouch_list = itemDao.select_pouch(param);
			List<Map<String, Object>>  sty_list   = itemDao.select_sty(param);
			
			map.put("box_list"  , box_list);
			map.put("pouch_list", pouch_list);
			map.put("sty_list", sty_list);
			
			map.put("joje_list" , itemDao.select_joje(param));
			map.put("bok_list"  , itemDao.select_bokyong(param));
			
			
			map.put("bean"      , param);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/m02/06"+Const.uTiles;
	}
	
	
	@RequestMapping ("/m02/06_select_fast.do")
	public @ResponseBody JsonObj  jq_mycart_list( Map<String, Object> map
												 ,HttpServletResponse response
												 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			param.put("id", userSession.get("id"));
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "tang_name");
				param.put("whereSql", whereSql);
			}
			
			
			int total = fastTangOrderDao.select_fast_count(param);
			
			param = PageUtil.setListInfo(param, total);
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			
			
			param = PageUtil.setListInfo(param, total); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			if( param.getInt("total")  > 0 ) {
				List<Map<String, Object>> list = fastTangOrderDao.select_fast(param);
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m02/select_fast_yakjae.do")
	public @ResponseBody JsonObj  jq_select_fast_yakjae( Map<String, Object> map
														,HttpServletResponse response
														,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			System.out.println(param);
			List<Map<String, Object>> list = fastDao.detail_yakjae(param);
			
			int total = list.size();
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("/m02/06_pop.do")
	public String v_06_pop(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
		
			
			map.put("info", fastDao.view(param));
			map.put("ylist", fastDao.detail_yakjae(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/m02/06_pop"+Const.uuTiles;
	}
	
	
	@RequestMapping ("/m02/06_1000.do")
	public String v_06_1000(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
			param.put("today", sdf.format(today));
			
			
			List<Map<String, Object>>  box_list   = itemDao.select_box(param); 
			List<Map<String, Object>>  pouch_list = itemDao.select_pouch(param);
			List<Map<String, Object>>  sty_list   = itemDao.select_sty(param);
			
			map.put("box_list"  , box_list);
			map.put("pouch_list", pouch_list);
			map.put("sty_list", sty_list);
			
			map.put("joje_list" , itemDao.select_joje(param));
			map.put("bok_list"  , itemDao.select_bokyong(param));
			
			
			map.put("bean"      , param);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/m02/06_wid1000"+Const.uTiles;
	}
		
	
	
}
