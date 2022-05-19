package kr.co.hany.controller.user.m04;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.common.UserBoardUtil;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.admin.board.BoardTotDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.SecurityUtil;
import kr.co.hany.util.StringUtil;


@Controller
@RequestMapping({"/m04/*", "/m/m04/*"})
public class BoardController extends UserDefaultController{

	
	@Autowired
	BoardTotDAO boardDao;
	
	@RequestMapping ("01.do")
	public String v_01( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			String mType = "pc";
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				mType = "m";
			}
			
			
			param.put("board_name", "notice");
			UserBoardUtil bu = new UserBoardUtil();
			map = bu.list(map, param, boardDao, "01.do", 5, mType);
			
			
			if("m".equals(mType)) {
				return "/m/m04/01"+Const.mTiles;
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m04/01"+Const.uTiles;
	}
	
	@RequestMapping ("01_view.do")
	public String v_01_view( Map<String, Object> map
						 	,HttpServletResponse response
						 	,HttpSession session){
		
		try{
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			String mType = "pc";
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				mType = "m";
			}
			
			param.put("board_name", "notice");
			
			System.out.println(param);
			
			UserBoardUtil bu = new UserBoardUtil();
			
			map = bu.view(map, param, response, boardDao);
			
			
			if("m".equals(mType)) {
				return "/m/m04/01_view"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m04/01_view"+Const.uTiles;
	}
	
	@RequestMapping ("02.do")
	public String v_02( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			String mType = "pc";
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				mType = "m";
			}
			
			param.put("board_name", "data");
			
			UserBoardUtil bu = new UserBoardUtil();
			map = bu.list(map, param, boardDao, "/m04/02.do", 5 , mType);
			
			
			if("m".equals(mType)) {
				return "/m/m04/02"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//%B9%DA%B1%D9
		//%EB%B0%95%EA%B7%BC
		return "/m04/02"+Const.uTiles;
	}
	
	@RequestMapping ("02_view.do")
	public String v_02_view( Map<String, Object> map
						 	,HttpServletResponse response
						 	,HttpSession session){
		
		try{
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			String mType = "pc";
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				mType = "m";
			}
			
			param.put("board_name", "data");
			
			System.out.println(param);
			
			UserBoardUtil bu = new UserBoardUtil();
			
			map = bu.view(map, param, response, boardDao);
			
			if("m".equals(mType)) {
				return "/m/m04/02_view"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m04/02_view"+Const.uTiles;
	}
	
	
	@RequestMapping ("03.do")
	public String v_03( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
			String url   = StringUtil.objToStr(request.getRequestURL(), "") ;
			String mType = "pc";
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				mType = "m";
			}
			
			if("m".equals(mType)) {
				return "/m/m04/03"+Const.mTiles;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m04/03"+Const.uTiles;
	}
	
	
	@RequestMapping ("03_proc.do")
	public @ResponseBody Map<String, Object> v_03_proc( Map<String, Object> map
													   ,HttpServletResponse response
													   ,HttpServletRequest requests
													   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			
			
			param.put("board_name", "qna");
			String board_name = "qna";
			
			param.put("id"         , userSession.get("id"));
			param.put("name"       , userSession.get("name"));
			param.put("member_seq" , userSession.get("seqno"));
			
			int iPreSeq =  boardDao.getMaxSeq()+1;
			
			// 답글 처리
			if( param.getInt("seq" , 0)  ==0  ){
				param.put("ref", iPreSeq);
			}else{
				boardDao.plus_ref_level(param);
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
			
			boardDao.insert(param);
			
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
		
	}
}
