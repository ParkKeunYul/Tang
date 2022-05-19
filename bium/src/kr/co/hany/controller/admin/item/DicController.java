package kr.co.hany.controller.admin.item;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.StringTokenizer;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.base.LoginhisDAO;
import kr.co.hany.dao.admin.base.ManageDAO;
import kr.co.hany.dao.admin.item.DicDAO;
import kr.co.hany.dao.admin.item.MediDAO;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/dic/*")
public class DicController extends AdminDefaultController{

	
	@Autowired
	DicDAO dicDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/dic"+Const.aTiles;
	}

	
	@RequestMapping ("select_group.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = dicDao.select_group_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(dicDao.select_group(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("select_name.do")
	public @ResponseBody JsonObj  select_name( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			String b_code = param.getString("b_code","");
			
			if(!"".equals(b_code)) {
				int total = dicDao.select_name_total(param);
				
				param = PageUtil.setListInfo(param, total); 
				
				jsonObj.setRecords(param.getInt("total"));    // total
				jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
				jsonObj.setPage(param.getInt("page"));        // 현재 페이지
				
				if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
					System.out.println("pageSearch");
					jsonObj.setPage(1);  // 현재 페이지
				}
							
				if( param.getInt("total")  > 0 ) {
					jsonObj.setRows(dicDao.select_name(param));
				}
			}else {
				jsonObj.setRecords(0);    // total
				jsonObj.setTotal(1);    // 최대페이지
				jsonObj.setPage(1);   
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("group_add.do")
	public @ResponseBody Map<String, Object> group_add( Map<String, Object> map
													   ,HttpServletResponse response
													   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();		
		try{
			
			int flag = dicDao.flag_group(param);
			if(flag > 0) {
				rtn.put("msg", "동일한 출전 그룹명이 존재합니다.");
				return rtn;
			}
			
			param.put("b_code",dicDao.select_max_groupcode(param));
			dicDao.group_add(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	@RequestMapping ("name_add.do")
	public String name_add( Map<String, Object> map
						   ,HttpServletResponse response
						   ,HttpSession session){
		
		try{
			
			param.put("start", 0);
			param.put("pageing", 10000);
			map.put("group", dicDao.select_group(param));
			
			String seqno  = param.getString("seqno", "");
			if(!"".equals(seqno)) {
				Map<String, Object> info = dicDao.select_name_one(param);
				map.put("info", info);
			}
			
			map.put("param", param);
			
			
			//map.put("info", tangDao.select_view(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/dic_name_add"+Const.uaTiles;
	}
	
	
	@RequestMapping ("name_add_proc.do")
	public @ResponseBody Map<String, Object> name_add_proc( Map<String, Object> map
														   ,HttpServletResponse response
														   ,HttpServletRequest requests
													       ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			
			Date today = new Date(); 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			String s_code =  sdf.format(today) + "_" + dicDao.select_name_max();
			param.put("s_code", s_code);
			
		
			dicDao.name_add(param);
			
			rtn = PageUtil.procSuc();
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("name_mod_proc.do")
	public @ResponseBody Map<String, Object> name_mod_proc( Map<String, Object> map
														   ,HttpServletResponse response
														   ,HttpServletRequest requests
													       ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			dicDao.name_mod(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	
	
	@RequestMapping ("select_all.do")
	public @ResponseBody JsonObj  select_all( Map<String, Object> map
											 ,HttpServletResponse response
											 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			
			int total = dicDao.select_all_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
						
			System.out.println(param);
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(dicDao.select_all(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("select_detail_price.do")
	public @ResponseBody JsonObj  select_detail_price( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			String b_code  = param.getString("b_code", "");
			String s_code  = param.getString("s_code", "");
			
			if("".equals(b_code) || "".equals(s_code)) {
				return jsonObj;
			}
			
			int total = dicDao.select_detail_price_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
						
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(dicDao.select_detail_price(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("price_update_stan.do")
	public @ResponseBody Map<String, Object> price_update_stan( Map<String, Object> map
														   	   ,HttpServletResponse response
														   	   ,HttpServletRequest requests
														   	   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			System.out.println(param);
			
			param.put("seqno", param.getString("id",""));
			
			dicDao.price_update_stan(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("dic_update_item.do")
	public String dic_price_update( Map<String, Object> map
								   ,HttpServletResponse response
								   ,HttpSession session){
		
		try{
			System.out.println(param);
			map.put("price_param", param);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/dic_price_update"+Const.uaTiles;
	}
	
	@RequestMapping ("select_dic_update_item.do")
	public @ResponseBody JsonObj  select_dic_update_item( Map<String, Object> map
													     ,HttpServletResponse response
													     ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = dicDao.select_price_group_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(dicDao.select_price_group(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("dic_update_item_proc.do")
	public @ResponseBody Map<String, Object> dic_update_item_proc( Map<String, Object> map
														   	   	  ,HttpServletResponse response
														   	   	  ,HttpServletRequest requests
														   	   	  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			int flag = dicDao.flag_price_dic_yakjae(param);
			
			if(flag > 0){
				rtn.put("msg","이미 등록된 약재입니다.");
				return rtn;
			}
			
			dicDao.price_item_update(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("dic_del_item_proc.do")
	public @ResponseBody Map<String, Object> dic_del_item_proc( Map<String, Object> map
														   	   	  ,HttpServletResponse response
														   	   	  ,HttpServletRequest requests
														   	   	  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			dicDao.price_item_delete(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("dic_add_item_proc.do")
	public @ResponseBody Map<String, Object> dic_add_item_proc( Map<String, Object> map
														   	   	  ,HttpServletResponse response
														   	   	  ,HttpServletRequest requests
														   	   	  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			param.put("new_yak_code", param.getString("dy_code"));
			
			int flag = dicDao.flag_price_dic_yakjae(param);
			
			if(flag > 0){
				rtn.put("msg","이미 등록된 약재입니다.");
				return rtn;
			}
			
			dicDao.price_item_add(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
}
