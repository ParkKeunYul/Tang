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

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.item.GoodsDAO;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/goods/*")
public class GoodsController extends AdminDefaultController{

	
	@Autowired
	GoodsDAO goodsDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/goods"+Const.aTiles;
	}

	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = goodsDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(goodsDao.select(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("add.do")
	public String add( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			
			Map<String, Object> info = new HashMap<String, Object>();
			info.put("sort_seq", 0);
			map.put("info"    , info);
			
			map.put("add_param"    , param);
			map.put("shop_code"    , codeDao.shop_group());
			map.put("shop_sub_code", codeDao.shop_sub_group());
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/goods_add"+Const.uaTiles;
	}
	
	
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
	//		boxDao.del(param);
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		
		
	}
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				goodsDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath  = Const.UPLOAD_ROOT+ "goods/temp/";
			int next_seqno   = goodsDao.select_next_seqno();
			String folder_nm = "goods";
			
			String p_code = String.format("%010d", (next_seqno+100000));
			param.put("p_code", p_code);
			
			param.put("yak_design1" , param.getString("yak_name1"," ") +"|"+param.getString("yak_from1"," ") +"|"+param.getString("yak_g1"));
			param.put("yak_design2" , param.getString("yak_name2"," ") +"|"+param.getString("yak_from2"," ") +"|"+param.getString("yak_g2"));
			param.put("yak_design3" , param.getString("yak_name3"," ") +"|"+param.getString("yak_from3"," ") +"|"+param.getString("yak_g3"));
			param.put("yak_design4" , param.getString("yak_name4"," ") +"|"+param.getString("yak_from4"," ") +"|"+param.getString("yak_g4"));
			param.put("yak_design5" , param.getString("yak_name5"," ") +"|"+param.getString("yak_from5"," ") +"|"+param.getString("yak_g5"));
			param.put("yak_design6" , param.getString("yak_name6"," ") +"|"+param.getString("yak_from6"," ") +"|"+param.getString("yak_g6"));
			param.put("yak_design7" , param.getString("yak_name7"," ") +"|"+param.getString("yak_from7"," ") +"|"+param.getString("yak_g7"));
			param.put("yak_design8" , param.getString("yak_name8"," ") +"|"+param.getString("yak_from8"," ") +"|"+param.getString("yak_g8"));
			param.put("yak_design9" , param.getString("yak_name9"," ") +"|"+param.getString("yak_from9"," ") +"|"+param.getString("yak_g9"));
			param.put("yak_design10", param.getString("yak_name10"," ")+"|"+param.getString("yak_from10"," ")+"|"+param.getString("yak_g10"));
			param.put("yak_design11", param.getString("yak_name11"," ")+"|"+param.getString("yak_from11"," ")+"|"+param.getString("yak_g11"));
			param.put("yak_design12", param.getString("yak_name12"," ")+"|"+param.getString("yak_from12"," ")+"|"+param.getString("yak_g12"));
			param.put("yak_design13", param.getString("yak_name13"," ")+"|"+param.getString("yak_from13"," ")+"|"+param.getString("yak_g13"));
			param.put("yak_design14", param.getString("yak_name14"," ")+"|"+param.getString("yak_from14"," ")+"|"+param.getString("yak_g14"));
			param.put("yak_design15", param.getString("yak_name15"," ")+"|"+param.getString("yak_from15"," ")+"|"+param.getString("yak_g15"));
			
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "image", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno,1, "image",folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "image2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "image2",folder_nm);
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "image3", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info3, tempPath, next_seqno,3, "image3",folder_nm);
			
			param.put("p_seq", next_seqno);
			
			
			//System.out.println("param = "+ param);
			
			goodsDao.add(param);
			
			String p_bigpart_sub = param.getString("p_bigpart_sub").replace("]", "");
			if(p_bigpart_sub.length() > 2) {
				p_bigpart_sub = p_bigpart_sub.substring(1);
			}
			param.put("p_bigpart_sub", p_bigpart_sub);
			
			//System.out.println(p_bigpart_sub);
				
			goodsDao.add_sub_group_code(param);
			
			
			String json_option   = "["+param.getString("json_option","")+"]";
			List<Map<String, Object>> option_list =  StringUtil.jsonToArray(json_option);
			
			for(int i = 0; i< option_list.size() ; i++) {
				Map<String, Object> info = option_list.get(i);
				String sql_mode = StringUtil.objToStr(info.get("sql"), "");
				
				info.put("goods_seqno", next_seqno);
				
				if("add".equals(sql_mode)) {
					goodsDao.add_option(info);
				}else {
					goodsDao.mod_option(info);
				}
			}// 
			
			
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("mod.do")
	public String mod( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			map.put("add_param"    , param);
			map.put("shop_code"    , codeDao.shop_group());
			map.put("shop_sub_code", codeDao.shop_sub_group());
			map.put("info"         , goodsDao.select_one(param));
			map.put("ssgc"         , goodsDao.select_sub_group_code(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/goods_add"+Const.uaTiles;
	}
	
	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath  = Const.UPLOAD_ROOT+ "goods/temp/";
			int next_seqno   = param.getInt("p_seq");
			String folder_nm = "goods";
			
			String p_code = String.format("%010d", (next_seqno+100000));
			param.put("p_code", p_code);
			
			param.put("yak_design1" , param.getString("yak_name1"," ") +"|"+param.getString("yak_from1"," ") +"|"+param.getString("yak_g1"));
			param.put("yak_design2" , param.getString("yak_name2"," ") +"|"+param.getString("yak_from2"," ") +"|"+param.getString("yak_g2"));
			param.put("yak_design3" , param.getString("yak_name3"," ") +"|"+param.getString("yak_from3"," ") +"|"+param.getString("yak_g3"));
			param.put("yak_design4" , param.getString("yak_name4"," ") +"|"+param.getString("yak_from4"," ") +"|"+param.getString("yak_g4"));
			param.put("yak_design5" , param.getString("yak_name5"," ") +"|"+param.getString("yak_from5"," ") +"|"+param.getString("yak_g5"));
			param.put("yak_design6" , param.getString("yak_name6"," ") +"|"+param.getString("yak_from6"," ") +"|"+param.getString("yak_g6"));
			param.put("yak_design7" , param.getString("yak_name7"," ") +"|"+param.getString("yak_from7"," ") +"|"+param.getString("yak_g7"));
			param.put("yak_design8" , param.getString("yak_name8"," ") +"|"+param.getString("yak_from8"," ") +"|"+param.getString("yak_g8"));
			param.put("yak_design9" , param.getString("yak_name9"," ") +"|"+param.getString("yak_from9"," ") +"|"+param.getString("yak_g9"));
			param.put("yak_design10", param.getString("yak_name10"," ")+"|"+param.getString("yak_from10"," ")+"|"+param.getString("yak_g10"));
			param.put("yak_design11", param.getString("yak_name11"," ")+"|"+param.getString("yak_from11"," ")+"|"+param.getString("yak_g11"));
			param.put("yak_design12", param.getString("yak_name12"," ")+"|"+param.getString("yak_from12"," ")+"|"+param.getString("yak_g12"));
			param.put("yak_design13", param.getString("yak_name13"," ")+"|"+param.getString("yak_from13"," ")+"|"+param.getString("yak_g13"));
			param.put("yak_design14", param.getString("yak_name14"," ")+"|"+param.getString("yak_from14"," ")+"|"+param.getString("yak_g14"));
			param.put("yak_design15", param.getString("yak_name15"," ")+"|"+param.getString("yak_from15"," ")+"|"+param.getString("yak_g15"));
			
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "image", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno,1, "image",folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "image2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "image2",folder_nm);
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "image3", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info3, tempPath, next_seqno,3, "image3",folder_nm);
			
			
			goodsDao.mod(param);
			
			
			String p_bigpart_sub = param.getString("p_bigpart_sub").replace("]", "");
			if(p_bigpart_sub.length() > 2) {
				p_bigpart_sub = p_bigpart_sub.substring(1);
			}
			param.put("p_bigpart_sub", p_bigpart_sub);   	
			
			
			goodsDao.del_sub_group_code(param);
			goodsDao.add_sub_group_code(param);
			
			
			String json_option   = "["+param.getString("json_option","")+"]";
			List<Map<String, Object>> option_list =  StringUtil.jsonToArray(json_option);
			
			for(int i = 0; i< option_list.size() ; i++) {
				Map<String, Object> info = option_list.get(i);
				String sql_mode = StringUtil.objToStr(info.get("sql"), "");
				
				if("add".equals(sql_mode)) {
					goodsDao.add_option(info);
				}else {
					goodsDao.mod_option(info);
				}
				
			}// 
			
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("select_option.do")
	public @ResponseBody JsonObj  select_option( Map<String, Object> map
											    ,HttpServletResponse response
											    ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = 100;
			
			if(!"".equals(param.getString("goods_seqno", ""))){
				param = PageUtil.setListInfo(param, total); 
				
				jsonObj.setRecords(param.getInt("total"));    // total
				jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
				jsonObj.setPage(param.getInt("page"));        // 현재 페이지
				
				if( param.getInt("total")  > 0 ) {
					jsonObj.setRows(goodsDao.select_option(param));
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("del_option.do")
	public @ResponseBody Map<String, Object> del_option( Map<String, Object> map
													    ,HttpServletResponse response
													    ,HttpServletRequest requests
													    ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			goodsDao.del_option(param);
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
}
