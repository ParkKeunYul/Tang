package kr.co.hany.controller.admin.base;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.icu.impl.StringUCharacterIterator;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.dao.admin.base.PopupDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/base/popup/*")
public class PopupController extends AdminDefaultController{

	
	@Autowired
	PopupDAO popDao;
	
	
	public String getPopype(String url){
		try{
			String a = url;
			       a = a.replace("/admin/base/popup/", "");
			       a = a.substring(0, a.indexOf("/"));
			return a;
		}catch (Exception e) {
			System.out.println("unknown url");
			return "notice";
		}
	}
	
	
	@RequestMapping ("*/list.do")
	public String list( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpServletRequest request
					,HttpSession session){
		
		String popType  = getPopype( request.getServletPath());
		
		try{
			System.out.println("popType ="+popType);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/popup/"+popType+"/list"+Const.aTiles;
	}
	
	@RequestMapping ("*/select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		
		String popType  = getPopype( request.getServletPath());
		
		try{
			param.put("pop_type", popType);
			
			int total = popDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(popDao.select(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("*/update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				popDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("*/add.do")
	public String add( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		String popType  = getPopype( request.getServletPath());
		try{
			param.put("pop_type", popType);
			map.put("add_param", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/base/popup/"+popType+"/add"+Const.uaTiles;
	}
	
	@RequestMapping ("*/add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		String popType  = getPopype( request.getServletPath());
		try {
			File file = new File(Const.UPLOAD_ROOT +"popup/");
			
			if(!file.exists()) { 
				file.mkdirs(); 
			}
			
			String tempPath  = Const.UPLOAD_ROOT+ "popup/temp/";			
			String folder_nm = "popup/"+ popType;
			int next_seqno   = popDao.select_next_seqno();
			
			Map<String, Object> file_info = FileUploadUtil.getAttachFiles(requests, "upfile", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info, tempPath, next_seqno,1, "upfile",folder_nm);
			
			popDao.add(param);
			
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// add_proc
	
	@RequestMapping ("*/mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		String popType  = getPopype( request.getServletPath());
		try {
			File file = new File(Const.UPLOAD_ROOT +"popup/");
			
			if(!file.exists()) { 
				file.mkdirs(); 
			}
			
			String tempPath  = Const.UPLOAD_ROOT+ "popup/temp/";			
			String folder_nm = "popup/"+ popType;
			int now_seqno    = param.getInt("seqno");
			
			Map<String, Object> file_info = FileUploadUtil.getAttachFiles(requests, "upfile", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info, tempPath, now_seqno,1, "upfile",folder_nm);
			
			popDao.mod(param);
			rtn = PageUtil.procSuc();
			
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// mod_proc
	
	
	@RequestMapping ("*/del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		String popType  = getPopype( request.getServletPath());
		try{
			
			List<Map<String, Object>> list = popDao.del_select(param);
			
			for(int i = 0; i< list.size() ; i++) {
				String upfile= StringUtil.objToStr(list.get(i).get("upfile"), "");
				if(!"".equals(upfile)) {
					FileUtil.delFile(Const.UPLOAD_ROOT+"popup/"+popType+"/",upfile);
				}
			}// for 
			
			
			popDao.del(param);
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
}
