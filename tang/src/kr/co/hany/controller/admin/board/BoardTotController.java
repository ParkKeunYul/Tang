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

import kr.co.hany.common.BoardUtil;
import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.controller.common.AdminBoardUtil;
import kr.co.hany.dao.admin.board.BoardTotDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/board/*")
public class BoardTotController extends AdminDefaultController{

	/**
	 * URL에 따른 게시판 구분
	 */
	
	@Autowired
	BoardTotDAO boardtotDao;
	
	public String getBoardype(String url){
		try{
			String a = url;
			         a = a.replace("/admin/board/", "");
			         a = a.substring(0, a.indexOf("/"));
			return a;
		}catch (Exception e) {
			System.out.println("unknown url");
			return "notice";
		}
	}
	
	public String getRtnPath(String url){
		try{
			String a = url;
			         a = a.replace("/admin/board/", "");
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
		String board_name   = getBoardype( request.getServletPath());
		String rtnPath      = getRtnPath( request.getServletPath());
		try{
			param.put("board_name", board_name);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/board/"+rtnPath+"/list"+Const.aTiles;
	}
	
	@RequestMapping ("*/select_list.do")
	public @ResponseBody JsonObj  select_list( Map<String, Object> map
											  ,HttpServletResponse response
											  ,HttpServletRequest request
											  ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		
		String board_name   = getBoardype( request.getServletPath());
		
		try{
			param.put("board_name", board_name);
			
			AdminBoardUtil bu = new AdminBoardUtil(getBoardype( request.getServletPath()));
			jsonObj      = bu.list(jsonObj, param, boardtotDao);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		//return "/board/notice/pouch"+Const.aTiles;
		return jsonObj;
	}
	
	
	@RequestMapping ("*/add.do")
	public String add( Map<String, Object> map
					   ,HttpServletResponse response
					   ,HttpServletRequest request
					   ,HttpSession session){
		String board_name   = getBoardype( request.getServletPath());
		String rtnPath      = getRtnPath( request.getServletPath());
		try{
			param.put("board_name", board_name);
			
			AdminBoardUtil ab = new AdminBoardUtil();
			param = ab.write(param);
			
			map.put("add_bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/board/"+rtnPath+"/add"+Const.uaTiles;
	}
	
	@RequestMapping ("*/add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		String board_name   = getBoardype( request.getServletPath());
		try {
			param.put("board_name", board_name);
			
			AdminBoardUtil ab = new AdminBoardUtil();
			ab.insert(boardtotDao, requests, adminSession, param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("*/mod.do")
	public String mod( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpServletRequest request
					  ,HttpSession session){
		String board_name   = getBoardype( request.getServletPath());
		String rtnPath      = getRtnPath( request.getServletPath());
		try{
			param.put("board_name", board_name);
			
			map.put("add_bean", param);
			System.out.println(param);
			
			if("qna".equals(board_name)) {
				map.put("info", boardtotDao.view(param));
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/board/"+rtnPath+"/add"+Const.uaTiles;
	}
	
	@RequestMapping ("*/mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		String board_name   = getBoardype( request.getServletPath());
		try {
			param.put("board_name", board_name);
			
			AdminBoardUtil ab = new AdminBoardUtil();
			
			ab.update(boardtotDao, requests, adminSession, param);
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("*/del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
					  		 					 ,HttpServletResponse response
					  		 					 ,HttpSession session){
		
		Map<String, Object> rtn = PageUtil.procSet();
		String board_name   = getBoardype( request.getServletPath());
		
		try{
			
			
			List<Map<String, Object>> list= boardtotDao.del_list(param);
			
			for(int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> info = list.get(i);
				
				String re_name1 = StringUtil.objToStr(info.get("re_name1"), "");
				if(!"".equals(re_name1)) {
					FileUtil.delFile(Const.UPLOAD_ROOT+board_name+"/",re_name1);
				}
				
				String re_name2 = StringUtil.objToStr(info.get("re_name2"), "");
				if(!"".equals(re_name2)) {
					FileUtil.delFile(Const.UPLOAD_ROOT+board_name+"/",re_name2);
				}
				
				String re_name3 = StringUtil.objToStr(info.get("re_name3"), "");
				if(!"".equals(re_name3)) {
					FileUtil.delFile(Const.UPLOAD_ROOT+board_name+"/",re_name3);
				}
			}// for
			
			boardtotDao.del(param);
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		
	}
	
	@RequestMapping ("*/update_notice.do")
	public @ResponseBody Map<String, Object> update_notice( Map<String, Object> map
					  		 					 		   ,HttpServletResponse response
					  		 					 		   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			boardtotDao.update_notice_yn(param);
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		
	}
	
}
