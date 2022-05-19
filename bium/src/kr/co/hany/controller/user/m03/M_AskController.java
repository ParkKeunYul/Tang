package kr.co.hany.controller.user.m03;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.admin.delivery.BaseDAO;
import kr.co.hany.dao.user.m03.AskDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;


@Controller
@RequestMapping(value="/m/m03/*")
public class M_AskController extends UserDefaultController{

	@Autowired
	YakDAO yakDao;
	
	@Autowired
	AskDAO askDao;
	
	@RequestMapping ("03.do")
	public String v_03( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			
			param.put("id"   	 , userSession.get("id"));
			param.put("mem_seqno", userSession.get("seqno"));
			
			int page       = param.getInt("page", 1);
			int page_cnt   = 10;
			
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T2.s_name");
				param.put("whereSql", whereSql);
			}
			
			int totalCount  = askDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			
			List<Map<String, Object>> list = askDao.list(param);
			map.put("list", list);
		    map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			 
			map.put("navi", PageUtil.getM_PageMysql(list, param, listCount, lastCount, ""));
			
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, "에러가 발생했습니다.");
		}
		return "/m/m03/03"+Const.mTiles;
	}
}
