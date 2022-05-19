package kr.co.hany.controller.admin.board;

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

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.controller.common.AdminBoardUtil;
import kr.co.hany.dao.admin.board.BannerDAO;
import kr.co.hany.mail.MailSend;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/board/banner/*")
public class BannerController extends AdminDefaultController{

	
	@Autowired
	BannerDAO bannerDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpServletRequest request
					   ,HttpSession session){
		
		try{
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/board/banner/list"+Const.aTiles;
	}
	
	@RequestMapping ("select_list.do")
	public @ResponseBody JsonObj  select_list( Map<String, Object> map
											  ,HttpServletResponse response
											  ,HttpServletRequest request
											  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		
		try{
			int total = bannerDao.listCount(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(bannerDao.list(param));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/board/notice/pouch"+Const.aTiles;
		return jsonObj;
	}
	
	@RequestMapping ("add.do")
	public String add( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpServletRequest request
					   ,HttpSession session){
		try{
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/board/banner/add"+Const.uaTiles;
	}
	

	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			System.out.println(param);
			System.out.println(param);
			System.out.println(param);
			
			int iPreSeq =  bannerDao.getMaxSeq()+1;
			param.put("seq", iPreSeq);
			
			String tempPath = Const.UPLOAD_ROOT+"/banner/";
			File file = new File(tempPath); 
			if(!file.exists()) { 
				file.mkdirs(); 
			}
			
			tempPath = Const.UPLOAD_ROOT+"/banner//temp/";
			file = new File(tempPath); 
			if(!file.exists()) { 
				file.mkdirs(); 
			}
			
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "file", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, iPreSeq,1,"ori_name" , "re_name","/banner");
			
			bannerDao.insert(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				bannerDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	

	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			String tempPath = Const.UPLOAD_ROOT+"/banner/temp/";
			
			int seq = param.getInt("seq");
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "file", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, seq,1,"ori_name" , "re_name","/banner");
			
			if(file_info1 == null){
				param.put("ori_name", param.getString("pre_ori_name"));
				param.put("re_name",  param.getString("pre_re_name"));
			}
			
			bannerDao.update(param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		
		try{
			
			
			List<Map<String, Object>> list= bannerDao.del_list(param);
			
			for(int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> info = list.get(i);
				
				String re_name = StringUtil.objToStr(info.get("re_name"), "");
				if(!"".equals(re_name)) {
					FileUtil.delFile(Const.UPLOAD_ROOT+"/banner/",re_name);
				}
			}// for
			bannerDao.del(param);
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		
	}
}
