package kr.co.hany.controller.common;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.hany.common.Const;
import kr.co.hany.dao.admin.board.BoardTotDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

public class AdminBoardUtil {
	protected Map<String, Object> paramMulti  = null;
	protected String board_name  = null;
	
	public AdminBoardUtil(){}
	public AdminBoardUtil(String board_name){
		this.board_name = board_name;
	}
	
	public JsonObj list( JsonObj jsonObj
					   	,CommonMap param
					    ,BoardTotDAO boardtotDao ){
		try{
			
			//param.put("encodeSV", StringUtil.setSearchValue(param));						
			int total = boardtotDao.listCount(param);
			
			System.out.println("param = "+ param);
			System.out.println("total = "+ total);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
						
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(boardtotDao.list(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
			return jsonObj;
	}
	
	
	public CommonMap write( CommonMap param){
		
		try{
			if(  param.getInt("seq", 0) == 0){
					param.put("seq", 0);
					param.put("ref", 1);
					param.put("ref_step", 0);
					param.put("ref_level", 0);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return param;
	}
	
	public void  insert( BoardTotDAO boardtotDao
						,HttpServletRequest requests
						,Map<String, Object> adminSession
						,CommonMap param)throws Exception{
		try {
			
			param.put("id"        , adminSession.get("a_id"));
			param.put("name"      , adminSession.get("a_name"));
			param.put("member_seq", adminSession.get("a_seqno"));
			
			int iPreSeq =  boardtotDao.getMaxSeq()+1;
			
			// 답글 처리
			if( param.getInt("seq" , 0)  ==0  ){
				param.put("ref", iPreSeq);
			}else{
				boardtotDao.plus_ref_level(param);
			}
			
			param.put("seq", iPreSeq);
			
			String tempPath = Const.UPLOAD_ROOT+board_name;
			File file = new File(tempPath); 
			if(!file.exists()) { 
				file.mkdirs(); 
			}
			
			tempPath = Const.UPLOAD_ROOT+board_name+"/temp/";
			file = new File(tempPath); 
			if(!file.exists()) { 
				file.mkdirs(); 
			}
			
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "file1", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, iPreSeq,1,"ori_name1" , "re_name1",param.getString("board_name"));
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "file2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, iPreSeq,2,"ori_name2", "re_name2",param.getString("board_name"));
			
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "file3", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info3, tempPath, iPreSeq,3,"ori_name3", "re_name3",param.getString("board_name"));
			
			
			boardtotDao.insert(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void  update( BoardTotDAO boardtotDao
						,HttpServletRequest requests		
						,Map<String, Object> adminSession
						,CommonMap param)throws Exception{
		try {
			
			String board_name = param.getString("board_name");
			
			param.put("upt_id"        , adminSession.get("a_id"));
			
			String tempPath = Const.UPLOAD_ROOT+board_name+"/temp/";
			
			int seq = param.getInt("seq");
			
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "file1", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, seq,1,"ori_name1" , "re_name1",param.getString("board_name"));
			
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "file2", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, seq,2,"ori_name2", "re_name2",param.getString("board_name"));
			
			Map<String, Object> file_info3 = FileUploadUtil.getAttachFiles(requests, "file3", tempPath, "");
			param  = FileUploadUtil.getAttachFilesDbSet(param, file_info3, tempPath, seq,3,"ori_name3", "re_name3",param.getString("board_name"));
			
			if(file_info1 == null){
				String file_check = param.getString("file_check1", "");
				if("Y".equals(file_check)) {
					param.put("ori_name1", "");
					param.put("re_name1", "");
					FileUtil.delFile(Const.UPLOAD_ROOT+board_name+"/",param.getString("pre_re_name1"));
				}else {
					param.put("ori_name1", param.getString("pre_ori_name1"));
					param.put("re_name1",  param.getString("pre_re_name1"));
				}
			}
			
			if(file_info2 == null){
				String file_check = param.getString("file_check2", "");
				if("Y".equals(file_check)) {
					param.put("ori_name2", "");
					param.put("re_name2", "");
					FileUtil.delFile(Const.UPLOAD_ROOT+board_name+"/",param.getString("pre_re_name2"));
				}else {
					param.put("ori_name2", param.getString("pre_ori_name2"));
					param.put("re_name2",  param.getString("pre_re_name2"));
				}
			}
			
			if(file_info3 == null){
				String file_check = param.getString("file_check3", "");
				if("Y".equals(file_check)) {
					param.put("ori_name3", "");
					param.put("re_name3", "");
					
					FileUtil.delFile(Const.UPLOAD_ROOT+board_name+"/",param.getString("pre_re_name3"));
				}else {
					param.put("ori_name3", param.getString("pre_ori_name3"));
					param.put("re_name3",  param.getString("pre_re_name3"));
				}
				
			}
			
			boardtotDao.update(param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}// AdminBoardUtil
