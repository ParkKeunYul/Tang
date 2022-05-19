package kr.co.hany.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ExceptionHandler;

public class MsgUtil {

	public static final String APPLY_PERIOD            = "신청기간이 아닙니다.";
	public static final String APPLY_DEADLINE          = "모집 마감되었습니다.";
	public static final String ACCOUT_PAYMENR_ERROR    = "";
	public static final String ACCESS_DENIED           = "사용권한이 없습니다.";
	public static final String TRY_AGAIN               = "다시 시도해주세요.";
	public static final String ADDED                   = "등록되었습니다.";
	public static final String DELETE                  = "삭제되었습니다.";
	public static final String TRADE_COMPLETE          = "거래 완료된 물품입니다.";
	public static final String ALREADY_PROCESS         = "거래 진행중인 물품입니다.";
	public static final String NOT_TRADE_PROCESS       = "거래 진행중인 물품이 아닙니다.";
	public static final String CANCEL_TRADE            = "거래를 취소하였습니다.";
	public static final String CHOICE                  = "선택되었습니다.";
	public static final String COMPLETE                = "완료돠었습니다.";
	public static final String UPDATE                  = "수정되었습니다.";
	public static final String NOT_EXIST               = "삭제되었거나 존재하지 않는 게시물입니다.";
	public static final String PREPARING               = "준비중입니다.";
	public static final String CASH_COMPLETE           = "무통장입금으로 강좌신청 접수 되었습니다.";
	public static final String CARD_COMPLETE           = "정상적으로 카드 결제 되었습니다.";
	public static final String IMAGE_DENIED            = "적합하지 않은 이미지 파일입니다.";
	public static final String NOT_LOGIN               = "로그인 후 사용하실 수 있습니다.";
	public static final String NOT_LOGIN_SIN           = "로그인 후 신청하실 수 있습니다.";
	public static final String MAIL_SHIPPING           = "메일이 발송되었습니다.";
	public static final String SECRET                  = "비밀글은 본인만 확인할수 있습니다.";
	public static final String NOT_FILE                = "파일이 존재하지 않습니다.";
	public static final String EXIST_ID                = "존재하는 아이디입니다.";
	public static final String MEMBER_REG              = "회원 가입되었습니다.";
	public static final String ITEM_LACK               = "작성하지 않은 항목이 있습니다.";
	public static final String NOT_FILE_EXTENTION      = " 확장자 파일은 첨부할수 없습니다.";
	public static final String CHANGE                  = " 변경되었습니다.";
	public static final String NOT_PWD_MATCH           = "비밀번호가 일치하지 않습니다.";
	public static final String NOT_PWD_WRITE           = "비회원으로 작성된 글이 아닙니다.";
	public static final String DOES_NOT_EXIST          = "존재하지 않는 게시글입니다.";
	public static final String NOT_ID_MATCH  = "본인글만 수정할수 있습니다.";
	public static final String CANCEL                  = "취소되었습니다.";
	
	
	public static  String Msg( Exception e 
							  ,HttpServletResponse response
							  ,String msg 
							  ,String url 
							  ,String statusCode ){
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.setStatus(Integer.parseInt(statusCode));
			String resultStr ="{ \"message\":\""+msg+"\",\"returnUrl\":\""+url+"\"}";
			System.out.println(resultStr);
			response.getWriter().print(resultStr);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return e.getMessage();
   }
	public static String Back( HttpServletResponse response
									  ,Map<String, Object> map
									  ,String msg				){
		try {
			map.put("msg", msg);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return "/process.test";
   }
	public static String MsgProcess ( CommonMap param
												  ,HttpServletResponse response
												  ,Map<String, Object> map
												  ,String msg								
												  ,String url												){
		map.put("msg", msg);
		map.put("url", url);
		return "/process.test";
	}
	
	
	public static String MsgProcess ( HttpServletResponse response
									  ,Map<String, Object> map
									  ,String msg								
									  ,String url	){
		map.put("msg", msg);
		map.put("url", url);
		return "/process.test";
	}
	
	public static String OpenerLocal ( Map<String, Object> map
												  ,String url
												  ,String msg){
		map.put("url", url);
		map.put("msg", msg);
		return "/opener_pop.test";
	}
	
	public static void back( HttpServletResponse response
									  ,String msg){
		try{
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();

			StringBuffer sb = new StringBuffer();
			sb.append("<script>");
			sb.append("alert('"+msg+"'); ");
			sb.append("history.back();");
			sb.append("</script>");
			out.print(sb.toString());
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
