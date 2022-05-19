package kr.co.hany.controller.admin.item;

import java.util.Date;
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
import kr.co.hany.dao.admin.item.BoxDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/box/*")
public class BoxController extends AdminDefaultController{

	
	@Autowired
	BoxDAO boxDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/box"+Const.aTiles;
	}

	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = boxDao.select_total();
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(boxDao.select(param));
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
			map.put("add_param", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/box_add"+Const.uaTiles;
	}
	
	/*@RequestMapping ("mod.do")
	public String mod( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			map.put("add_param", param);
		//	map.put("info", boxDao.select_one(param));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/box_add"+Const.uaTiles;
	}*/
	
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath = Const.UPLOAD_ROOT+ "box/temp/";
			
			int next_seqno = boxDao.select_next_seqno();
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "box_image", tempPath, "");
			if(file_info1 != null) {
				String oriFileName = StringUtil.objToStr(file_info1.get("fileName") , ""); 
				String box_image   = next_seqno+"_1"+"."+file_info1.get("fileExt");
				
				param.put("box_image", box_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "box/"+box_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "box_image2", tempPath, "");
			if(file_info2 != null) {
				String oriFileName = StringUtil.objToStr(file_info2.get("fileName") , ""); 
				String box_image   = next_seqno+"_2"+"."+file_info2.get("fileExt");
				
				param.put("box_image2", box_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "box/"+box_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "box_image3", tempPath, "");
			if(file_info3 != null) {
				String oriFileName = StringUtil.objToStr(file_info3.get("fileName") , ""); 
				String box_image   = next_seqno+"_3"+"."+file_info3.get("fileExt");
				
				param.put("box_image3", box_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "box/"+box_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			
			boxDao.add(param);
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
			
			String tempPath = Const.UPLOAD_ROOT+ "box/temp/";
			
			int now_seqno = param.getInt("seqno");
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "box_image", tempPath, "");
			if(file_info1 != null) {
				String oriFileName = StringUtil.objToStr(file_info1.get("fileName") , ""); 
				String box_image   = now_seqno+"_1"+"."+file_info1.get("fileExt");
				
				param.put("box_image", box_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "box/"+box_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "box_image2", tempPath, "");
			if(file_info2 != null) {
				String oriFileName = StringUtil.objToStr(file_info2.get("fileName") , ""); 
				String box_image   = now_seqno+"_2"+"."+file_info2.get("fileExt");
				
				param.put("box_image2", box_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "box/"+box_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "box_image3", tempPath, "");
			if(file_info3 != null) {
				String oriFileName = StringUtil.objToStr(file_info3.get("fileName") , ""); 
				String box_image   = now_seqno+"_3"+"."+file_info3.get("fileExt");
				
				param.put("box_image3", box_image);
				
				FileUploadUtil.copyTransfer(tempPath+oriFileName, Const.UPLOAD_ROOT+ "box/"+box_image);
				FileUtil.delFile(tempPath,oriFileName);
			}
			
			boxDao.mod(param);
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
				boxDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
		
	}
	
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			boxDao.del(param);
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	
}
