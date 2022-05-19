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
import kr.co.hany.dao.admin.item.MediDAO;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/medi/*")
public class MediController extends AdminDefaultController{

	
	@Autowired
	MediDAO mediDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/medi"+Const.aTiles;
	}

	
	@RequestMapping ("select_group.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = mediDao.select_group_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}*/
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(mediDao.select_group(param));
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
			
			int flag = mediDao.flag_group(param);
			if(flag > 0) {
				rtn.put("msg", "동일한 약재 그룹명이 존재합니다.");
				return rtn;
			}
			
			param.put("group_code",mediDao.select_max_groupcode(param));
			mediDao.group_add(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();			
			return rtn;
		}	
		return rtn;
	}
	
	
	
	@RequestMapping ("select_name.do")
	public @ResponseBody JsonObj  select_name( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			String group_code = param.getString("group_code","");
			
			if(!"".equals(group_code)) {
				int total = mediDao.select_name_total(param);
				
				param = PageUtil.setListInfo(param, total); 
				
				jsonObj.setRecords(param.getInt("total"));    // total
				jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
				jsonObj.setPage(param.getInt("page"));        // 현재 페이지
				
				/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
					System.out.println("pageSearch");
					jsonObj.setPage(1);  // 현재 페이지
				}*/
							
				if( param.getInt("total")  > 0 ) {
					jsonObj.setRows(mediDao.select_name(param));
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
	
	
	@RequestMapping ("name_add.do")
	public String name_add( Map<String, Object> map
						   ,HttpServletResponse response
						   ,HttpSession session){
		
		try{
			
			param.put("start", 0);
			param.put("pageing", 10000);
			map.put("group", mediDao.select_group(param));
			
			String seqno  = param.getString("seqno", "");
			if(!"".equals(seqno)) {
				Map<String, Object> info = mediDao.select_name_one(param);
				map.put("info", info);
			}
			
			map.put("param", param);
			
			
			//map.put("info", tangDao.select_view(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/medi_name_add"+Const.uaTiles;
	}
	
	@RequestMapping ("name_add_proc.do")
	public @ResponseBody Map<String, Object> name_add_proc( Map<String, Object> map
														   ,HttpServletResponse response
														   ,HttpServletRequest requests
													       ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath = Const.UPLOAD_ROOT+ "item/temp/";
			
			Date today = new Date(); 
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			String yak_code =  sdf.format(today) + "_" + mediDao.select_name_max();
			param.put("yak_code", yak_code);
			
			
			Map<String, Object> file_info = FileUploadUtil.getAttachFiles(requests, "yak_image", tempPath, "");
			
			if(file_info != null) {
				String oriFileName = StringUtil.objToStr(file_info.get("fileName") , ""); 
				String yak_image   = yak_code+"."+file_info.get("fileExt");
				
				param.put("yak_image", yak_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "item/"+yak_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			mediDao.name_add(param);
			
			
			
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
			
			String tempPath = Const.UPLOAD_ROOT+ "item/temp/";
			
			String yak_code = param.getString("yak_code");
			
			Map<String, Object> file_info = FileUploadUtil.getAttachFiles(requests, "yak_image", tempPath, "");
			
			if(file_info != null) {
				String oriFileName = StringUtil.objToStr(file_info.get("fileName") , ""); 
				String yak_image   = yak_code+"."+file_info.get("fileExt");
				param.put("yak_image", yak_image);
				
				
				FileUtil.delFile(Const.UPLOAD_ROOT+ "item/",yak_image); // 기존이미지 삭제
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "item/"+yak_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			mediDao.name_mod(param);
			
			
			
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
			
			
			int total = mediDao.select_all_total(param);
			
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			/*if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}*/
						
			System.out.println(param);
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(mediDao.select_all(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("update_col_yak.do")
	public @ResponseBody Map<String, Object> update_col_yak( Map<String, Object> map
					  		 								,HttpServletResponse response
					  		 								,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				mediDao.update_col_yak(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
		
	}
	
	
	@RequestMapping ("update_col_group.do")
	public @ResponseBody Map<String, Object> update_col_group( Map<String, Object> map
					  		 								,HttpServletResponse response
					  		 								,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				mediDao.update_col_group(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
		
	}
	
	
	@RequestMapping ("dic_info.do")
	public String dic_info( Map<String, Object> map
						   ,HttpServletResponse response
						   ,HttpSession session){
		
		try{
			System.out.println(param);
			
			param.put("start", 0);
			param.put("pageing", 1000);
			map.put("yak_list", mediDao.select_name(param));
			
			map.put("dic_list", mediDao.select_dic_yakjae(param));
			map.put("param", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/medi_dic_info"+Const.uaTiles;
	}
	
	@RequestMapping ("update_dic_yakjae.do")
	public @ResponseBody Map<String, Object> update_dic_yakjae( Map<String, Object> map
					  		 								  ,HttpServletResponse response
					  		 								  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			//String oper = param.getString("oper");
			
			System.out.println(param);

			mediDao.update_dic_yakjae(param);

			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;	
	}
	
	
	@RequestMapping ("del_yakjae.do")
	public @ResponseBody Map<String, Object> del_yakjae( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{					
			
			mediDao.movie_yakjae_info(param);
			mediDao.del_yakjae(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("del_yak_group.do")
	public @ResponseBody Map<String, Object> del_yak_group( Map<String, Object> map
					  		 							   ,HttpServletResponse response
					  		 							   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{					
			
			mediDao.movie_yak_group_info(param);
			mediDao.del_yakjae_group(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	
}
