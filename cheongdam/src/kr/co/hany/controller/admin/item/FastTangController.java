package kr.co.hany.controller.admin.item;

import java.util.ArrayList;
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

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.item.BoxDAO;
import kr.co.hany.dao.admin.item.FastDAO;
import kr.co.hany.dao.user.m02.DictionDAO;
import kr.co.hany.dao.user.m02.ItemDAO;
import kr.co.hany.dao.user.m05.MyDictionDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/fast/*")
public class FastTangController extends AdminDefaultController{

	
	@Autowired
	FastDAO fastDao;
	
	
	@Autowired
	ItemDAO itemDao;
	
	@Autowired
	MyDictionDAO myDictionDao;
	
	@Autowired
	DictionDAO dictionDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/fast"+Const.aTiles;
	}
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = fastDao.list_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(fastDao.list(param));
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
			
			List<Map<String, Object>>  box_list   = itemDao.select_box(param); 
			List<Map<String, Object>>  pouch_list = itemDao.select_pouch(param);
			List<Map<String, Object>>  sty_list   = itemDao.select_sty(param);
			
			map.put("box_list"  , box_list);
			map.put("pouch_list", pouch_list);
			map.put("sty_list"  , sty_list);
			
			
			Map<String, Object> info = new HashMap<String, Object>();
			
			System.out.println(param);
			
			if(!"".equals(param.getString("seqno",""))) {
				info = fastDao.view(param);
			}else {
				info.put("c_chup_ea", 1);
			}
			
			map.put("info", info);
			map.put("add_param", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/fast_add"+Const.uaTiles;
	}
	
	@RequestMapping ("select_yakjae.do")
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
	
	@RequestMapping ("add_yakjae_multi.do")
	public @ResponseBody List<Map<String, Object>> add_yakjae_multi( Map<String, Object> map
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
	
	@RequestMapping ("select_dic.do")
	public @ResponseBody JsonObj  elect_dic( Map<String, Object> map
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
	
	@RequestMapping ("dic_sublist.do")
	public @ResponseBody List<Map<String, Object>> aj_02_dic_sublist( Map<String, Object> map
																	 ,HttpServletResponse response){
		List<Map<String, Object>> subList = null;
		try {
			Map<String, Object> view = dictionDao.view(param);
			param.put("s_code", view.get("s_code"));
			param.put("b_code", view.get("b_code"));
			
			
			subList = dictionDao.sublist(param);
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return subList;
	}
	
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath  = Const.UPLOAD_ROOT+ "fast/temp/";
			int next_seqno   = fastDao.select_next_seqno();
			String folder_nm = "fast";

						
			
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "image1", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno,1, "image1",folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "image2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "image2",folder_nm);
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "image3", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info3, tempPath, next_seqno,3, "image3",folder_nm);
			
			param.put("seqno", next_seqno);
			
			
			String json_option   = "["+param.getString("json_option","")+"]";
			List<Map<String, Object>> option_list =  StringUtil.jsonToArray(json_option);
			
			
			fastDao.add(param);
			for(int i = 0; i< option_list.size() ; i++) {
				Map<String, Object> info = option_list.get(i);
				
				
				System.out.println(info);
				
				info.put("t_seqno", next_seqno);
				
				
				info.put("p_from"   , info.get("yak_from"));
				info.put("p_joje"   , info.get("my_joje"));
				info.put("yak_price", info.get("yak_danga"));
				info.put("p_danga"  ,  StringUtil.objToStr(info.get("danga"), "").replaceAll("원", ""));
				info.put("total_yakjae", StringUtil.ObjectToInt(info.get("my_joje"))  *  param.getInt("c_chup_ea") );
				
				fastDao.add_yakjae(info);
			}
				
			
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath  = Const.UPLOAD_ROOT+ "fast/temp/";
			int next_seqno   = param.getInt("seqno");
			String folder_nm = "fast";

						
			
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "image1", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, next_seqno,1, "image1",folder_nm);
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "image2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, next_seqno,2, "image2",folder_nm);
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "image3", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info3, tempPath, next_seqno,3, "image3",folder_nm);
			
			param.put("seqno", next_seqno);
			
			
			String json_option   = "["+param.getString("json_option","")+"]";
			List<Map<String, Object>> option_list =  StringUtil.jsonToArray(json_option);
			
			
			fastDao.mod(param);
			fastDao.del_yakjae(param);
			for(int i = 0; i< option_list.size() ; i++) {
				Map<String, Object> info = option_list.get(i);
				
				
				System.out.println(info);
				
				info.put("t_seqno", next_seqno);
				info.put("p_from"       , info.get("yak_from"));
				info.put("p_joje"       , info.get("my_joje"));
				info.put("yak_price"    , info.get("yak_danga"));
				info.put("p_danga"      ,  StringUtil.objToStr(info.get("danga"), "").replaceAll("원", ""));
				info.put("total_yakjae" , StringUtil.ObjectToInt(info.get("my_joje"))  *  param.getInt("c_chup_ea") );
				
				fastDao.add_yakjae(info);
			}
				
			
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	
	
	@RequestMapping ("detail_yakjae.do")
	public @ResponseBody JsonObj  detail_yakjae( Map<String, Object> map
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
	
	
	
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
												 ,HttpServletResponse response
												 ,HttpServletRequest requests
												 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			fastDao.del(param);
			
			
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	
}
