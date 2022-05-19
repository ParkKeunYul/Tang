package kr.co.hany.controller.admin.tot;

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
import kr.co.hany.dao.admin.total.InvenDAO;
import kr.co.hany.dao.admin.total.UseDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.FileUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;



@Controller
@RequestMapping(value="/admin/total/tang/*")
public class TangPriceController extends AdminDefaultController{
	
	
	@Autowired
	UseDAO useDao;
	
	@RequestMapping ("list.do")
	public String manage( Map<String, Object> map
						 ,HttpServletResponse response
						 ,HttpSession session){
		
		try{
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/total/tang"+Const.aTiles;
	}
	
	
	@RequestMapping ("select.do")
	public @ResponseBody JsonObj  select_group( Map<String, Object> map
											   ,HttpServletResponse response
											   ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			int total = 99999;
			
			param = PageUtil.setListInfo(param, total); 
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			jsonObj.setRows(useDao.price_total(param));
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
}
