package kr.co.hany.util;

import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hany.common.Const;



public class EmailUtil {
public static int sendMailNew(HttpServletRequest request, HttpServletResponse response, Map<String, Object> param, Map<String, Object> info) throws Exception {
		
		Properties props = new Properties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", Const.mailServerName);
		props.put("mail.smtp.prot", "25");	
		
		//세션 인스터스 생성
		Session sess = Session.getInstance(props);		
		//메세지 객체 준비
		MimeMessage msg = new MimeMessage(sess);
		
		
		try{			
			System.out.println("mail send start");
			//Address객체 준비
			InternetAddress from = new InternetAddress("bss@bss.or.kr" ); //rammstein77@dbkeducation.com
			InternetAddress to = new InternetAddress(info.get("EMAIL")+"");
			
			//메세지 객체 정보추가
			msg.setHeader("content-type", "text/html;charset=UTF-8");
			msg.setFrom(from);
			msg.addRecipient(Message.RecipientType.TO, to);
			msg.setSubject(MimeUtility.encodeText(StringUtil.StringNull(param.get("title")), "UTF-8", "B"));
			msg.setContent(StringUtil.StringNull(info.get("mailContents")), "text/html;charset=UTF-8");
			msg.setSentDate(new java.util.Date());
			Transport.send(msg);
		
			System.out.println("mail send end");			
			return 1;
		}catch(MessagingException me){
			me.printStackTrace();
			System.out.println(me);
			return 0;
		}		
	}
}
