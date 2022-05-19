package kr.co.hany.common;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hany.dao.BoardDAO;
import kr.co.hany.dao.admin.board.BoardTotDAO;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.MsgUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.ParamUtil;
import kr.co.hany.util.StringUtil;

public class UserBoardUtil {
	protected Map<String, Object> paramMulti  = null;
	
	public Map<String, Object> list( Map<String, Object> map
								   	,CommonMap param
								    ,BoardTotDAO boardDAO
								    ,String listPage
								    ,int page_cnt){
		try{
			
			
			int page       = param.getInt("page", 1);  
			
			param.put("page", page);
			param.put("start"    , (page-1) *page_cnt);
			param.put("pageing"  , page_cnt);
			
			int totalCount  = boardDAO.listCount(param);
			int listCount   =  (totalCount / page_cnt);
			    listCount  += totalCount % page_cnt == 0 ? 0 : 1;
			 
			int lastCount  = (listCount / page_cnt);
			 	lastCount += listCount % page_cnt == 0 ? 0 : 1;
			
			 	 
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			
			List<Map<String, Object>> list = boardDAO.list(param);
			map.put("list", list);
			map.put("listCount", listCount);
			map.put("totalCount", totalCount);
			map.put("lastCount", lastCount);
			map.put("bean", param);
			map.put("pageCount", totalCount -(page -1)* page_cnt);
			
			//페이징처리 
			map.put("navi", PageUtil.getPageMysql(list, param, listCount, lastCount, listPage));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	
	public Map<String, Object> view(  Map<String, Object> map
								    ,CommonMap param
								    ,HttpServletResponse response
								    ,BoardTotDAO boardDAO){

		try{
			boardDAO.increaseHit(param);
			Map<String, Object> view = boardDAO.view(param);
			if(view == null || view.isEmpty()){
				map.put("check_exist", "1");
				return map; 
			}
			view.put("content", StringUtil.recoverContents(view.get("content")));
			map.put("bean", param);
			map.put("view", view);
			
			String encodeSV =StringUtil.setSearchValue(param);
			param.put("encodeSV", encodeSV);
			
			String search_value = param.getString("search_value","");
			if(!"".equals(search_value)) {
				param.put("search_value", URLDecoder.decode(encodeSV,"UTF-8"));
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
			map.put("check_exist", "1");
			return map; 
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
			param.put("encodeSV", StringUtil.setSearchValue(param));
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
						if(imgMap != null){
							imgMap.put("type", "image");
							imgMap.put("board_seq", param.get("seq"));
							imgMap.put("index_seq", index_seq++);
							boardDAO.fileinsert(imgMap );
						}
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
		return MsgUtil.MsgProcess(param, response, map,  MsgUtil.UPDATE, url+"?seq="+param.get("seq")+ParamUtil.pagingValue(param));
	}
	
	public String delete( Map<String, Object> map
							    ,CommonMap param
							    ,HttpServletResponse response
							    ,HttpServletRequest request
							    ,BoardDAO boardDAO
							    ,String listpage
							    ,Map<String, Object> homeSession){
		try{
			
			if(homeSession == null || homeSession.isEmpty()){
				return MsgUtil.Back(response, map, MsgUtil.NOT_LOGIN);
			}
			
			Map<String, Object> view = boardDAO.view(param);
			String db_id = StringUtil.StringNull(view.get("ID"));
			String se_id = StringUtil.StringNull(homeSession.get("ID"));
			if(!se_id.equals(db_id)){
				return MsgUtil.Back(response, map, MsgUtil.NOT_ID_MATCH);
			}
			
			param.put("board_seq", param.get("seq"));
			boardDAO.del(param);  //본문
		}catch (Exception e) {
			e.printStackTrace();
			return MsgUtil.MsgProcess(param, response, map, MsgUtil.TRY_AGAIN, "");
		}
		return MsgUtil.MsgProcess(param, response, map, MsgUtil.DELETE, listpage+"?seq="+param.get("seq")+"&board_name="+param.get("board_name")+ParamUtil.pagingValue(param));
	}
	
	public String cinsert( Map<String, Object> map
								  ,CommonMap param
								  ,HttpServletResponse response
								  ,HttpServletRequest request
								  ,BoardDAO boardDAO			
								  ,String url){
		try{
			boardDAO.commentinsert(param);
		}catch (Exception e) {
			e.printStackTrace();
			return MsgUtil.MsgProcess(param,response, map,  MsgUtil.TRY_AGAIN,"");
		}
		return MsgUtil.MsgProcess(param, response, map,  MsgUtil.ADDED, url+"?seq="+param.get("board_seq")+ParamUtil.pagingValue(param));
	}
	
	public int cModify(CommonMap param, BoardDAO boardDAO, Map<String, Object> homeSession){
		try{
			//로그인, 본인 체크
			if (homeSession == null ||  homeSession.isEmpty())  {
				return -2;
			}
			
			Map<String, Object> cView = boardDAO.commentView(param);
			
			String s_id = StringUtil.StringNull(cView.get("ID" ));
			String c_id = StringUtil.StringNull(homeSession.get("ID"));
			if(!s_id.equals(c_id)){
				return -3;
			}
			boardDAO.commentModify(param);
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int cdelete( CommonMap param
							 ,BoardDAO boardDAO
							 ,Map<String, Object> homeSession){

		try{
			
			//로그인, 본인 체크
			if (homeSession == null ||  homeSession.isEmpty())  {
				return -2;
			}
			
			Map<String, Object> cView = boardDAO.commentView(param);
			
			String s_id = StringUtil.StringNull(cView.get("ID" ));
			String c_id = StringUtil.StringNull(homeSession.get("ID"));
			if(!s_id.equals(c_id)){
				return -3;
			}
			
			boardDAO.commentdel(param.getString("seq"));
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
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
			System.out.println(file);
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
