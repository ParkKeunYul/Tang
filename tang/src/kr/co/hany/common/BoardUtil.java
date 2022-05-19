package kr.co.hany.common;	

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import kr.co.hany.dao.BoardDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.ImageUpload;
import kr.co.hany.util.MsgUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.ParamUtil;
import kr.co.hany.util.StringUtil;

public class BoardUtil {
	protected Map<String, Object> paramMulti  = null;
	protected String board_name  = null;
	
	public BoardUtil(){}
	public BoardUtil(String board_name){
		this.board_name = board_name;
	}
	
	public Map<String, Object> list( Map<String, Object> map
											   	,CommonMap param
											    ,BoardDAO boardDAO
											    ,String listPage
											    ,int page_cnt){
		try{
			int page       =  param.getInt("page", 1);  
			int pagelistno = param.getInt("pagelistno", 1); 
			
			param.put("page", page);
			param.put("pagelistno", pagelistno);
			param.put("pagesize"  , page_cnt);
			
			int totalCount = boardDAO.listCount(param);
			int listCount  =  (totalCount / page_cnt);
			     listCount += totalCount % page_cnt == 0 ? 0 : 1;
			 
			int lastCount = (listCount / page_cnt);
			 	 lastCount += listCount % page_cnt == 0 ? 0 : 1;     
			     			 				 	
			 	
			 param.put("encodeSV", StringUtil.setSearchValue(param));
			 List<Map<String, Object>> list = boardDAO.list(param);
		     map.put("list", list);
		     map.put("listCount", listCount);
			 map.put("totalCount", totalCount);
			 map.put("lastCount", lastCount);
			 map.put("bean", param);
			 map.put("pageCount", totalCount -(page -1)* page_cnt);
			 //페이징처리 
			 map.put("navi", PageUtil.getPage(list, param, listCount, lastCount, listPage));
		
			 String board_name = param.getString("board_name","");
			 if( (board_name.equals("notice") || board_name.equals("debate") || board_name.equals("free") ) && page == 1 ){
				 map.put("notice_list", boardDAO.noticeList(param));
			 }
		}catch (Exception e) {
			e.printStackTrace();
		}
		return map;
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

	public String insert( Map<String, Object> map
								 ,CommonMap param
								 ,HttpServletResponse response
								 ,HttpServletRequest request
								 ,BoardDAO boardDAO 
								 ,String url){
		try{
			
			
			url = url+"?board_name="+param.get("board_name");
			int iPreSeq =  boardDAO.getMaxSeq()+1;
			// 답글 처리
			if( param.getInt("seq",0)  ==0  ){
				param.put("ref", iPreSeq);
			}else{
				boardDAO.plus_ref_level(param);
			}
			param.put("seq", iPreSeq);
			boardDAO.insert(param);
			int iSeq = boardDAO.getMaxSeq();
			
			
			if( iPreSeq  == iSeq){ // identiy가 mybatis에 안통해서 -_-+
				// 첨부파일 처리
				String []  imgInfo = request.getParameterValues("attach_image");
				String []  fileInfo = request.getParameterValues("attach_file");
				
				
				int index_seq = 0; 
				if(imgInfo != null){
					for(int i = 0; i< imgInfo.length; i++){
						Map<String, Object> imgMap = getImgInfo(imgInfo[i]);
						imgMap.put("type", "image");
						imgMap.put("board_seq", iPreSeq);
						imgMap.put("index_seq", index_seq++);
						boardDAO.fileinsert(imgMap );
					}
				}
				if(fileInfo != null){
					for(int i = 0; i< fileInfo.length; i++){
						Map<String, Object> fileMap = getFileInfo(fileInfo[i]);
						fileMap.put("type", "file");
						fileMap.put("board_seq", iPreSeq);
						fileMap.put("index_seq", index_seq++);
						boardDAO.fileinsert(fileMap );
					}
				}
				
			}
			else{
				return MsgUtil.MsgProcess(param,response,map, MsgUtil.TRY_AGAIN, "");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return MsgUtil.MsgProcess(param,response,map, MsgUtil.TRY_AGAIN,"");
		}
		
		return MsgUtil.MsgProcess(param, response, map, MsgUtil.ADDED, url);
	}
	
	public Map<String, Object> view(  Map<String, Object> map
												   ,CommonMap param
												   ,HttpServletResponse response
												   ,BoardDAO boardDAO
												   ,String id){

		try{
			if(!"admin".equals(id)){
				boardDAO.increaseHit(param);
			}
			Map<String, Object> view = boardDAO.view(param);
			view.put("CONTENT", StringUtil.recoverContents(view.get("CONTENT")));
			
			map.put("bean", param);
			map.put("view", view);
			
			
			param.put("filetype", "file");
			map.put("flist", boardDAO.filelist(param)); 
			map.put("clist", boardDAO.commentlist(param));
			map.put("fcount", boardDAO.filecount(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public String modify( Map<String, Object> map
								 ,CommonMap param
								 ,HttpServletResponse response
								 ,HttpServletRequest request
								 ,BoardDAO boardDAO){
		try{
			Map<String, Object> view = boardDAO.view(param);
			map.put("bean", param);
			map.put("view", view);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return request.getRequestURI()+"_"+param.get("menu_type")+"."+param.get("tiles");
	}
	
	public String delete( Map<String, Object> map
								 ,CommonMap param
								 ,HttpServletResponse response
								 ,HttpServletRequest request
								 ,BoardDAO boardDAO
								 ,String listpage){
		try{
			param.put("board_seq", param.get("seq"));
			boardDAO.del(param);  //본문
		}catch (Exception e) {
			e.printStackTrace();
			return MsgUtil.MsgProcess(param, response, map, MsgUtil.TRY_AGAIN, "");
		}
		return MsgUtil.MsgProcess(param, response, map, MsgUtil.DELETE, listpage+"?seq="+param.get("seq")+"&board_name="+param.get("board_name")+ParamUtil.pagingValue(param));
	}
		 
	public String update( Map<String, Object> map
								  ,CommonMap param
								  ,HttpServletResponse response
								  ,HttpServletRequest request
								  ,BoardDAO boardDAO
								  ,String url){
		try{
			
			
			boardDAO.update(param);
			
			String delfileseq = param.getString("delfileseq", "");
			if(!delfileseq.equals("")){ // 파일삭제처리
				delfileseq = delfileseq.substring(1, delfileseq.length());
				List<Map<String, Object>> fileList = boardDAO.delfileInfo(delfileseq) ;
				try{
					boolean check = false;
					for(int i  =0 ; i< fileList.size(); i++ ){
						check = FileUploadUtil.delFile(Const.UPLOAD_ROOT+fileList.get(i).get("PATH")+fileList.get(i).get("REFILENAME"));
					}
					if(check)boardDAO.deletefile(delfileseq);  // 디비파일삭제
				}catch (Exception e) {
					System.out.println("파일처리 에러");
					e.printStackTrace();
				}
			}
			
			
			// 추가파일처리
			String []  imgInfo = request.getParameterValues("attach_image");
			String []  fileInfo = request.getParameterValues("attach_file");
			int index_seq = 0; 
			if(imgInfo != null){
				for(int i = 0; i< imgInfo.length; i++){
					if(imgInfo != null){
						Map<String, Object> imgMap = getImgInfo(imgInfo[i]);
						imgMap.put("type", "image");
						imgMap.put("board_seq", param.get("seq"));
						imgMap.put("index_seq", index_seq++);
						boardDAO.fileinsert(imgMap );
					}
				}
			}
			if(fileInfo != null){
				for(int i = 0; i< fileInfo.length; i++){
					Map<String, Object> fileMap = getFileInfo(fileInfo[i]);
					if(fileMap != null){
						fileMap.put("type", "file");
						fileMap.put("board_seq", param.get("seq"));
						fileMap.put("index_seq", index_seq++);
						boardDAO.fileinsert(fileMap );
					}
					
					
				}
			}
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
			return MsgUtil.MsgProcess(param,response,map, MsgUtil.TRY_AGAIN, "");
		}
		return MsgUtil.MsgProcess(param, response, map,  MsgUtil.UPDATE, url+"?seq="+param.get("seq")+"&board_name="+param.get("board_name")+ParamUtil.pagingValue(param));
	}
	
	public int cdeleteAjax( CommonMap param
							,BoardDAO boardDAO){

		try{
			boardDAO.commentdel(param.getString("seq"));
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int delfile(String dirName){
		int check = 1;
		try{
			ImageUpload.delFile(dirName);
		}catch (Exception e) {
			e.printStackTrace();
			check = -1;
		}
		return check;
	}
	
	public Map<String, Object> fileList( Map<String, Object> map
			                            ,CommonMap param
			                            ,BoardDAO boardDAO
			                            ,HttpServletResponse response){
		
		try{
			map.put("flist", boardDAO.view(param));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public String cinsert( Map<String, Object> map
								  ,CommonMap param
								  ,HttpServletResponse response
								  ,HttpServletRequest request
								  ,BoardDAO boardDAO			){
		try{
			boardDAO.commentinsert(param);
		}catch (Exception e) {
			e.printStackTrace();
			return MsgUtil.MsgProcess(param,response, map,  MsgUtil.TRY_AGAIN,"");
		}
		return MsgUtil.MsgProcess(param, response, map,  MsgUtil.ADDED, "view?seq="+param.get("board_seq")+"&board_name="+param.get("board_name")+ParamUtil.pagingValue(param));
	}
	
	public int cmodify(CommonMap param, BoardDAO boardDAO	){
		try{
			boardDAO.commentModify(param);
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	
	
	

	/**  BoardUtil 에서만 사용하는 util **********************************************/
	public static String URLFind(Object board_type){
		try{
			String a= board_type.toString();
			
			return a;
			
		}catch (Exception e) {
			return "notify";
		}
	}
	
	public Map<String, Object> getImgInfo(String img){
		Map<String, Object> info = new HashMap<String, Object>();
		try{
			List<String> file = tokenSt(img);
			if(file != null ){
				info.put("filename"    , file.get(0));
				info.put("refilename"  , file.get(1));
				info.put("filesize"       , file.get(2));
				info.put("path"          , file.get(3));
				info.put("filecontentype"          , file.get(4));
				info.put("ext"            , file.get(5));
				
				if(!StringUtil.StringNull(file.get(6)).equals("0")){
					System.out.println("기존 파일");
					return null;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}
	
	public Map<String, Object> getFileInfo(String img){
		Map<String, Object> info = new HashMap<String, Object>();
		try{
			
			List<String> file = tokenSt(img);
			if(file != null ){
				info.put("filename"  , file.get(0));
				info.put("refilename", file.get(1));
				info.put("filesize"     , file.get(2));
				info.put("path"        , file.get(3));
				info.put("filecontentype"          , file.get(4));
				info.put("ext"          , file.get(6));
				
				// 수정시 파일정보만 넘어간다 ㅡ,.ㅡ
				// file_no가 0이 아닌것은 기존 첨부된 파일이다 무시해주자
				if(!StringUtil.StringNull(file.get(5)).equals("0")){
					System.out.println("기존 파일");
					return null;
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return info;
	}
	
	public List<String>   tokenSt(String info){
		try{
			List<String> list = new ArrayList<String>();
			StringTokenizer st = new StringTokenizer(info,"||");
			
			while (st.hasMoreElements()) {
				list.add(st.nextToken());
			}
			return list;
		}catch (Exception e) {
			return null;
		}
	}
	

		
}
