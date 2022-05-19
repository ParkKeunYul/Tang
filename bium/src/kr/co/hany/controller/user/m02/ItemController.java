package kr.co.hany.controller.user.m02;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.user.m02.ItemDAO;
import kr.co.hany.util.PageUtil;

@Controller
public class ItemController extends UserDefaultController{
	
	@Autowired
	ItemDAO itemDao;
	
	@RequestMapping ("/m02/03.do")
	public String v_03(Map<String, Object> map, HttpServletResponse response){
		try {
			map.put("box_list", itemDao.select_box(param));
			map.put("pouch_list", itemDao.select_pouch(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/03"+Const.uTiles;
	};
	
	
	@RequestMapping ("/m02/04.do")
	public String v_04(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			
			map.put("box_list"  , itemDao.select_box(param));
			map.put("pouch_list", itemDao.select_pouch(param));
			map.put("sty_list"  , itemDao.select_sty(param));
			map.put("joje_list" , itemDao.select_joje(param));
			map.put("bok_list"   , itemDao.select_bokyong(param));
			
			map.put("setting"   , itemDao.select_setting(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/04"+Const.uTiles;
	};
	
	@RequestMapping ("/m02/04_setPorc.do")
	public @ResponseBody Map<String, Object> proc_01_step2_1( Map<String, Object> map
															 ,HttpServletResponse response
															 ,HttpServletRequest requests
															 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id",    userSession.get("id"));
			
			int duple = itemDao.exist_setting(param);
			//duple = 0;
			if(duple == 0) {
				rtn.put("suc", false);
				rtn.put("msg", "기존에 등록된 정보가 없어 상품정보를 수정할수 없습니다.\n고객센터에 문의바랍니다.");
			}
			
			boolean flag = itemDao.updateSetting(param);
			if(flag) {
				rtn = PageUtil.procSuc("저장되었습니다.");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
		
	}
	
	@RequestMapping ("/m02/04_base_joje_proc.do")
	public @ResponseBody Map<String, Object> proc_04_base_joj( Map<String, Object> map
															   ,HttpServletResponse response
															   ,HttpServletRequest requests
															   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			boolean flag = itemDao.updateBaseYn(param);
			if(flag) {
				rtn = PageUtil.procSuc("기본 설정으로 저장 되었습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("/m02/04_pop_joje.do")
	public String p_04_pop_joje(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			
			String action = param.getString("action");
			if("update".equals(action)) {
				map.put("j_view", itemDao.select_joje_view(param));
			}
			
			map.put("j_bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/04_pop_joje"+Const.uuTiles;
	};
	
	@RequestMapping ("/m02/04_pop_joje_proc.do")
	public @ResponseBody Map<String, Object> proc_04_pop_joje( Map<String, Object> map
															   ,HttpServletResponse response
															   ,HttpServletRequest requests
															   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			String action = param.getString("action");
			
			boolean flag  = false;
			if("add".equals(action)) {
				flag = itemDao.add_joje(param);
			}else {
				flag = itemDao.update_joje(param);
			}
			
			if(flag) {
				rtn = PageUtil.procSuc("저장되었습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("/m02/04_pop_joje_del.do")
	public @ResponseBody Map<String, Object> del_04_pop_joje( Map<String, Object> map
															 ,HttpServletResponse response
															 ,HttpServletRequest requests
															 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			boolean flag  = itemDao.del_joje(param);
			
			if(flag) {
				rtn = PageUtil.procSuc("삭제 되었습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	
	@RequestMapping ("/m02/04_base_bok_proc.do")
	public @ResponseBody Map<String, Object> proc_04_bok_joj( Map<String, Object> map
														     ,HttpServletResponse response
															 ,HttpServletRequest requests
															 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			boolean flag = itemDao.updateBokBaseYn(param);
			if(flag) {
				rtn = PageUtil.procSuc("기본 설정으로 저장 되었습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("/m02/04_pop_bok.do")
	public String p_04_pop_bok(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			
			String action = param.getString("action");
			if("update".equals(action)) {
				map.put("b_view", itemDao.select_bok_view(param));
			}
			
			map.put("b_bean", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/04_pop_bok"+Const.uuTiles;
	};
	
	
	@RequestMapping ("/m02/04_pop_bok_proc.do")
	public @ResponseBody Map<String, Object> proc_04_pop_bok( Map<String, Object> map
															 ,HttpServletResponse response
															 ,HttpServletRequest requests
															 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			String action = param.getString("action");
			
			boolean flag  = false;
			if("add".equals(action)) {
				flag = itemDao.add_bok(param);
			}else {
				flag = itemDao.update_bok(param);
			}
			
			if(flag) {
				rtn = PageUtil.procSuc("저장되었습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
	@RequestMapping ("/m02/04_pop_bok_del.do")
	public @ResponseBody Map<String, Object> del_04_pop_bok( Map<String, Object> map
															,HttpServletResponse response
															,HttpServletRequest requests
															,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			boolean flag  = itemDao.del_bok(param);
			
			if(flag) {
				rtn = PageUtil.procSuc("삭제 되었습니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		return rtn;
	}
	
}
