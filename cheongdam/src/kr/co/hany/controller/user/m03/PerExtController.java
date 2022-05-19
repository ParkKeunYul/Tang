package kr.co.hany.controller.user.m03;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.LoginDAO;
import kr.co.hany.dao.admin.order.ShopDAO;
import kr.co.hany.dao.common.CommonCodeDAO;
import kr.co.hany.dao.user.m03.PerDAO;
import kr.co.hany.dao.user.m03.YakCartDAO;
import kr.co.hany.dao.user.m03.YakDAO;
import kr.co.hany.session.UserSessionManager;
import kr.co.hany.util.NicePayUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;

@Controller
public class PerExtController extends UserDefaultController{
	
	@Autowired
	YakDAO yakDao;
	
	@Autowired
	CommonCodeDAO codeDao;
	
	@Autowired
	YakCartDAO yakCartDao;
	
	@Autowired
	ShopDAO shopDao;
	
	@Autowired
	PerDAO perDao;
	
	@Autowired
	LoginDAO loginDao;
	
	
	@RequestMapping ({"/m/ext/personal_com.do"})
	public String personal_com( Map<String, Object> map
					   	       ,HttpServletResponse response){
		
		try {
			String referer = StringUtil.objToStr(request.getHeader("REFERER"), "") ; 
			String url     = StringUtil.objToStr(request.getRequestURL(), "") ;
			
			String[] mValue = param.getString("m_value").split("abpdf");
			
			System.out.println(param);
			
			param.put("id",   mValue[1]);
			
			System.out.println("per userSession = "+ userSession);
			
			if(userSession == null || userSession.isEmpty()) {
				try {
					Map<String, Object> info = loginDao.userIdCheck(param);
					
					System.out.println("percard pay user session create 1= " +info);
					
					UserSessionManager usm = new UserSessionManager();
					usm.setLoginOut(request);
					usm.setSession(info, request);
					
					userSession = info;
					
					System.out.println("per userSession = "+ userSession);
					
					param.put("mem_seqno", userSession.get("seqno"));
				}catch (Exception e) {
					System.out.println("per cardpay usersession create fail1");
					e.printStackTrace();
				}
			}else {
				param.put("mem_seqno", userSession.get("seqno"));
			}
			
			
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) > -1) {
				map.put("sc_close", "y");
			}
			
			
			
			Map<String, Object> view = perDao.view(param);
			if(view == null) {
				PageUtil.scripAlertBack(response, "개인결제 정보가 없습니다.");
				map.put("sc_msg", "개인결제 정보가 없습니다.");
				map.put("sc_url", "/m03/personal.do");				
				return "/scriptMsg"+Const.uuTiles;
			}
			
			if(url.indexOf("http://"+Const.M_DOMAIN_NM) == -1 && referer.indexOf("/m03/personal_view.do")  == -1 ) {
				PageUtil.scripAlertBack(response, "잘못된 접근입니다.");
	            map.put("sc_msg", "잘못된 접근입니다.");
				map.put("sc_url", "/main.do");
				return "/scriptMsg"+Const.uuTiles;
			}
			
			
			Map<String, Object> cardInfo = NicePayUtil.reqPayResult(request, response);
			String resultMsg             = StringUtil.objToStr(cardInfo.get("resultMsg"), "");
			String resultCode= StringUtil.objToStr(cardInfo.get("resultCode"), "");
			if(  !("3001".equals(resultCode)|| "0000".equals(resultCode))  ) {
				map.put("sc_msg", "카드결제가 정상적으로 이루어지지 않았습니다. ["+resultMsg+"]");
				map.put("sc_url", "/m03/personal_view.do?seqno="+view.get("seqno"));
				return "/scriptMsg"+Const.uuTiles;
			}
			
			param.put("card_gu_no", cardInfo.get("tid"));
			param.put("card_ju_no", cardInfo.get("moid"));
			param.put("card_su_no", cardInfo.get("authCode"));
			param.put("card_nm"   , cardInfo.get("cardName"));
			param.put("card_code" , cardInfo.get("cardCode"));
			param.put("card_quota", cardInfo.get("cardQuota"));
			param.put("card_amt"  , cardInfo.get("amt"));
			param.put("mid"  	  , cardInfo.get("mid"));
			
			perDao.order_com(param);
			
			map.put("sc_msg", "결제되었습니다");
			map.put("sc_url", "/m03/personal_view.do?seqno="+view.get("seqno"));
			
		}catch (Exception e) {
			e.printStackTrace();
			map.put("sc_msg", "결제중 에러가 발생했습니다.");
			map.put("sc_url", "/m03/personal.do");
		}
		return "/scriptMsg"+Const.uuTiles;
	}//personal_com
}
