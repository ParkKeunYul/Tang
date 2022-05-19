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
import kr.co.hany.dao.admin.item.PouchDAO;
import kr.co.hany.dao.admin.item.GoodsGroupDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
@RequestMapping(value="/admin/item/goodsGroup/*")
public class GoodsGroupController extends AdminDefaultController{

	
	@Autowired
	GoodsGroupDAO goodsGroupDao;
	
	@RequestMapping ("list.do")
	public String list( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/goodsGroup"+Const.aTiles;
	}

	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = goodsGroupDao.select_total();
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(goodsGroupDao.select(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("update_col.do")
	public @ResponseBody Map<String, Object> update_col( Map<String, Object> map
					  		 							,HttpServletResponse response
					  		 							,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try{
			
			String oper = param.getString("oper");
			
			if("edit".equals(oper)){
				goodsGroupDao.update_col(param);
			}// if
			
			rtn = PageUtil.procSuc();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
	
	@RequestMapping ("add.do")
	public String add( Map<String, Object> map
					  ,HttpServletResponse response
					  ,HttpSession session){
		
		try{
			if("".equals(param.getString("seqno", ""))) {
				param.put("sort_seq", goodsGroupDao.max_sort_seq());
			}
			
			
			map.put("add_param", param);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/item/goodsGroup_add"+Const.uaTiles;
	}
	
	
	
	@RequestMapping ("add_proc.do")
	public @ResponseBody Map<String, Object> add_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			goodsGroupDao.add(param);
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// add_proc
	
	@RequestMapping ("mod_proc.do")
	public @ResponseBody Map<String, Object> mod_proc( Map<String, Object> map
													  ,HttpServletResponse response
													  ,HttpServletRequest requests
													  ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			goodsGroupDao.mod(param);
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// add_proc
	
	@RequestMapping ("del.do")
	public @ResponseBody Map<String, Object> del( Map<String, Object> map
												 ,HttpServletResponse response
												 ,HttpServletRequest requests
												 ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			goodsGroupDao.del(param);
			rtn = PageUtil.procSuc();
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}// add_proc
}
