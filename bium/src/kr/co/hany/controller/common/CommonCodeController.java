package kr.co.hany.controller.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.dao.common.CommonCodeDAO;

@Controller
@RequestMapping(value="/common/")
public class CommonCodeController {

	
	@Autowired
	CommonCodeDAO codeDao;
	
	
	@RequestMapping ("member_grade.do")
	public @ResponseBody String member_grade( Map<String, Object> map
																 ,HttpServletResponse response
																 ,HttpSession session){
		
		
		StringBuffer select = new StringBuffer();
		try {
			List<Map<String, Object>> list = codeDao.member_grade();
			
			select.append("<select>");
			for(int i = 0; i< list.size(); i++) {
				select.append("<option value='"+list.get(i).get("seqno")+"'>"+list.get(i).get("member_nm")+"</option>");
			}
			select.append("</select>");
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return select.toString();
	}
	
}
