package kr.co.hany.controller.user.m02;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.user.m02.DictionDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class DictionController extends UserDefaultController{

	
	@Autowired
	DictionDAO dicDao;
	
	@RequestMapping ("/m02/02.do")
	public String v_02(Map<String, Object> map, HttpServletResponse response){
		try {
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 5;
			
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T2.s_name");
				param.put("whereSql", whereSql);
			}
			
			int totalCount  = dicDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			List<Map<String, Object>> list = dicDao.list(param);
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
		return "/m02/02"+Const.uTiles;
	}
	
	@RequestMapping ("/m02/02_view.do")
	public String v_02_view(Map<String, Object> map, HttpServletResponse response){
		try {
			Map<String, Object> view = dicDao.view(param);
			param.put("s_code", view.get("s_code"));
			param.put("b_code", view.get("b_code"));
			
			
			List<Map<String, Object>> subList = dicDao.sublist(param);
			
			map.put("subList", subList);
			map.put("bean", param);
			map.put("view", view);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/02_view"+Const.uTiles;
	}//
	
	
	@RequestMapping ("/m02/02_add_mydic.do")
	public @ResponseBody Map<String, Object> a_02_add_mydic( Map<String, Object> map
															,HttpServletResponse response){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			param.put("id", userSession.get("id"));
			
			String check_sname = param.getString("check_sname").replace("||",",");
			/*System.out.println(check_sname);*/
			param.put("check_sname", check_sname);
			
			int cnt = dicDao.mydic_count(param);
			
			System.out.println(param);
			
			if(cnt > 0){
				rtn.put("suc", false);		
				rtn.put("msg", "동일한 처방전이 기존에 등록되었습니다.");
				return rtn;
			}
			
			boolean flag =  dicDao.addMyDic(param);
			if(flag) {
				rtn.put("suc", true);		
				rtn.put("msg", "등록되었습니다.");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}//a_02_add_mydic
	
	
	
	@RequestMapping ("/m02/02_dictionary_popup.do")
	public String p_02_dictionary_popup(Map<String, Object> map, HttpServletResponse response){
		try {
			Map<String, Object> view = dicDao.view(param);
			param.put("s_code", view.get("s_code"));
			param.put("b_code", view.get("b_code"));
			
			
			List<Map<String, Object>> subList = dicDao.sublist(param);
			
			map.put("subList", subList);
			map.put("bean", param);
			map.put("view", view);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/02_dictionary_popup"+Const.uuTiles;
	}//
	
	
	@RequestMapping ("/m02/02_dic_sublist.do")
	public @ResponseBody List<Map<String, Object>> aj_02_dic_sublist( Map<String, Object> map
																	 ,HttpServletResponse response){
		List<Map<String, Object>> subList = null;
		try {
			Map<String, Object> view = dicDao.view(param);
			param.put("s_code", view.get("s_code"));
			param.put("b_code", view.get("b_code"));
			
			
			subList = dicDao.sublist(param);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return subList;
	}//
	
}

