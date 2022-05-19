package kr.co.hany.controller.user.m05;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.AssertTrue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.user.m05.MyInfoDAO;
import kr.co.hany.dao.user.m05.MyPatientDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
public class MyPatientController extends UserDefaultController{


	
	@Autowired
	MyPatientDAO myPatientDao;

	
	@RequestMapping ("/m05/05.do")
	public String v_04( Map<String, Object> map
					   ,HttpServletResponse response){
		try {
			
			param.put("id", userSession.get("id"));
			int page       = param.getInt("page", 1);
			int page_cnt   = 5;
			
			
			System.out.println(param);
			
			param.put("page"     , page);
			param.put("start"    , (page-1) * page_cnt);
			param.put("pageing"  , page_cnt);
			
			
			int totalCount  = myPatientDao.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			int lastCount   = (listCount / page_cnt);
			 	lastCount  += listCount % page_cnt == 0 ? 0 : 1;
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV); 	
			
			
			
			List<Map<String, Object>> list = myPatientDao.list(param);
			 map.put("list", list);
		     map.put("listCount", listCount);
			 map.put("totalCount", totalCount);
			 map.put("lastCount", lastCount);
			 map.put("bean", param);
			 map.put("pageCount", totalCount -(page -1)* page_cnt);
			 
			 map.put("navi", PageUtil.getPageMysql(list, param, listCount, lastCount, ""));
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/05"+Const.uTiles;
	};
	
	@RequestMapping ("/m05/05_select_patient.do")
	public @ResponseBody JsonObj  jq_04_patient( Map<String, Object> map
													 ,HttpServletResponse response
													 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			param.put("id", userSession.get("id"));
			
			if(!"".equals(param.getString("search_ch",""))){
				String whereSql = StringUtil.getJaSql(param.getString("search_ch"), "T1.name");
				param.put("whereSql", whereSql);
			}
			
			
			int total = myPatientDao.listCount(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				List<Map<String, Object>> list = myPatientDao.list(param);
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m05/05_add.do")
	public @ResponseBody Map<String, Object> aj_05_add( Map<String, Object> map
									  				,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			
			param.put("mem_seq", userSession.get("seqno"));
			param.put("id",   userSession.get("id"));
			
			param.put("tel"			, param.getString("tel01")+"-"+param.getString("tel02")+"-"+ param.getString("tel03"));
			param.put("handphone"	, param.getString("handphone01")+"-"+param.getString("handphone02")+"-"+ param.getString("handphone03"));
			param.put("birth_year"  , param.getString("birth_year")+"-"+param.getString("birth_month")+"-"+ param.getString("birth_day"));
			
			System.out.println(param);
			
			boolean flag = myPatientDao.addPatient(param);
			if(flag) {
				rtn = PageUtil.procSuc();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("/m05/05_mod.do")
	public @ResponseBody Map<String, Object> aj_05_mod( Map<String, Object> map
									  				   ,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			param.put("mem_seq", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			param.put("tel"			, param.getString("tel01")+"-"+param.getString("tel02")+"-"+ param.getString("tel03"));
			param.put("handphone"	, param.getString("handphone01")+"-"+param.getString("handphone02")+"-"+ param.getString("handphone03"));
			param.put("birth_year"  , param.getString("birth_year")+"-"+param.getString("birth_month")+"-"+ param.getString("birth_day"));
			
			System.out.println(param);
			
			boolean flag = myPatientDao.modPatient(param);
			if(flag) {
				rtn = PageUtil.procSuc();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	
	@RequestMapping ("/m05/05_view.do")
	public String v_04_view( Map<String, Object> map
					        ,HttpServletResponse response){
		try {
			
			param.put("mem_seq", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			
			map.put("view", myPatientDao.view(param));
			
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m05/05_view"+Const.uTiles;
	}//v_04_add
	
	
	@RequestMapping ("/m05/05_patient_order.do")
	public @ResponseBody JsonObj  jq_05_patient_order( Map<String, Object> map
												     ,HttpServletResponse response
													 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			param.put("id", userSession.get("id"));
			
			int total = myPatientDao.orderlistCount(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				List<Map<String, Object>> list = myPatientDao.orderlist(param);
				jsonObj.setRows(list);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("/m05/duple_chart.do")
	public @ResponseBody Map<String, Object> duple_id( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			param.put("id", userSession.get("id"));
			param.put("mem_seq", userSession.get("seqno"));
			
			List<Map<String, Object>> list = myPatientDao.duple_chart(param);

			if(list.size() == 0) {
				rtn.put("check_chart", 1);
				rtn.put("msg", "사용가능한 차트번호 입니다.");
			}else{
				rtn.put("check_chart", 0);
				rtn.put("msg", "사용불가능한 차트번호 입니다.");
			}
			rtn.put("suc"     , true);
		}catch (Exception e) {
			e.printStackTrace();
			rtn.put("check_id", 0);
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("/m05/05_del.do")
	public @ResponseBody Map<String, Object> aj_05_del( Map<String, Object> map
									  				,HttpServletResponse response){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			
			System.out.println(param);
			
			boolean flag = myPatientDao.del_patient(param);
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
