package kr.co.hany.controller.user.m05;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.user.m02.DictionDAO;
import kr.co.hany.dao.user.m05.MyDictionDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
public class MyDictionController extends UserDefaultController{
	
	@Autowired
	MyDictionDAO myDictionDao;
	
	@Autowired
	DictionDAO dictionDao;
	
	@RequestMapping ("/m05/04.do")
	public String v_04( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			
			param.put("id", userSession.get("id"));
			param.put("seqno", userSession.get("seqno"));
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 5;
			
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T2.s_name");
				param.put("whereSql", whereSql);
			}
			
			int totalCount  = myDictionDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
						
			List<Map<String, Object>> list = myDictionDao.list(param);
			map.put("list", list);
		    map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			 
			map.put("navi", PageUtil.getPage(list, param, listCount, lastCount, ""));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04"+Const.uTiles;
	};
	
	@RequestMapping ("/m05/04_del.do")
	public @ResponseBody Map<String, Object> aj_del_cart( Map<String, Object> map
														 ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id"       , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			
			boolean flag = myDictionDao.delMydic(param);
			if(flag) {
				rtn  = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m05/04_view.do")
	public String v_04_view( Map<String, Object> map
					        ,HttpServletResponse response){
		try {
			
			param.put("id", userSession.get("id"));
			param.put("mem_seq", userSession.get("seqno"));
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			
			map.put("view", myDictionDao.view(param));
			
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04_view"+Const.uTiles;
	}//v_04_add
	
	@RequestMapping ("/m05/04_add.do")
	public String v_04_add( Map<String, Object> map
					       ,HttpServletResponse response){
		try {
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04_view"+Const.uTiles;
	}//v_04_add
	
	
	@RequestMapping ("/m05/04_select_main.do")
	public @ResponseBody JsonObj  jq_04_select_main( Map<String, Object> map
													,HttpServletResponse response
													,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
						
			param.put("id", userSession.get("id"));
			param.put("seqno", userSession.get("seqno"));
			
			
			List<Map<String, Object>> list = myDictionDao.select_main(param);
			
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
	
	
	@RequestMapping ("/m05/04_pop_yakjae.do")
	public String p_04_pop_yakjae( Map<String, Object> map
								  ,HttpServletResponse response){
		try {
			
			System.out.println("pop = "+ param);
			map.put("list", myDictionDao.select_group_yakjae(param));
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04_pop_yakjae"+Const.uuTiles;
	};
	
	
	@RequestMapping ("/m05/04_select_yakjae.do")
	public @ResponseBody JsonObj  jq_04_select_yakjae( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T1.yak_name");
				param.put("whereSql", whereSql);
			}
			
			
			int total = myDictionDao.listCount_yakjae(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				List<Map<String, Object>> list = myDictionDao.list_yakjae(param);
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m05/04_add_yakjae_multi.do")
	public @ResponseBody List<Map<String, Object>> aj_04_add_yakjae_multi( Map<String, Object> map
																		   ,HttpServletResponse response
																		   ,HttpSession session){
		List<Map<String, Object>> list =  new ArrayList<Map<String, Object>>();
		try {
			
			String search_value    = param.getString("search_value");
			String m_search_value  = "";
			String[] array = search_value.split(" ");
			
			for(int i = 0; i < array.length; i++) {
				param.put("m_search_value", array[i]);
				
				Map<String, Object>  yak = myDictionDao.add_yakjae_multi_new(param);
				if(yak != null) {
					list.add(yak);
				}
			}// for i
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	
	@RequestMapping ("/m05/04_select_dic.do")
	public @ResponseBody JsonObj  jq_04_select_dic( Map<String, Object> map
												   ,HttpServletResponse response
												   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T2.s_name");
				param.put("whereSql", whereSql);
			}
			
			
			int total = dictionDao.listCount(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				List<Map<String, Object>> list = dictionDao.list(param);
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	
	@RequestMapping ("/m05/04_select_mydic.do")
	public @ResponseBody JsonObj  jq_04_select_mydic( Map<String, Object> map
													 ,HttpServletResponse response
													 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			param.put("id", userSession.get("id"));
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T1.s_name");
				param.put("whereSql", whereSql);
			}
			
			int total = myDictionDao.listCount(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				List<Map<String, Object>> list = myDictionDao.list(param);
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m05/04_dictionary_popup.do")
	public String p_02_dictionary_popup( Map<String, Object> map
										,HttpServletResponse response){
		try {
			param.put("id", userSession.get("id"));
			
			
			Map<String, Object> view = myDictionDao.view(param);
			param.put("my_seqno", param.get("seqno"));
			List<Map<String, Object>> subList = myDictionDao.select_main(param);
			
			map.put("subList", subList);
			map.put("bean", param);
			map.put("view", view);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/04_dictionary_popup"+Const.uuTiles;
	}//
	
	
	@RequestMapping ("/m05/04_mydic_yakjaeInfo.do")
	public @ResponseBody List<Map<String, Object>> aj_mydic_yakjaeInfo( Map<String, Object> map
					        										  ,HttpServletResponse response){
		
		List<Map<String, Object>> list = null;
		try {
			param.put("id", userSession.get("id"));
			
			list= myDictionDao.select_main(param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}//v_04_add
	
	@RequestMapping ("/m05/04_save.do")
	public @ResponseBody Map<String, Object> aj_04_save( Map<String, Object> map
													   ,HttpServletResponse response
													   ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		
		
		try {
			
			param.put("id", userSession.get("id"));
			
			String json_yakjae   = "["+param.getString("json_yakjae","")+"]";
			List<Map<String, Object>> list =  StringUtil.jsonToArray(json_yakjae);
			
			
			
			String my_seqno   = param.getString("my_seqno", "");
			
			boolean flag = false;
			
			if(!"".equals(my_seqno)) { 
				flag = myDictionDao.updateMydic(param, list);
			}else {
				flag = myDictionDao.addMydic(param, list);
			}
			
			if(flag) {
				rtn = PageUtil.procSuc();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	 
	
	
}
