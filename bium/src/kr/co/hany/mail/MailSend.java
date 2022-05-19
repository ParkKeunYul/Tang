package kr.co.hany.mail;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.co.hany.util.CommonMap;

import javax.mail.Message;
import javax.mail.Transport;


public class MailSend {

	
	public static boolean sendMail(CommonMap param) {
		try {
			
			Properties p = new Properties(); // 정보를 담을 객체
			  
			
			// Could not connect to SMTP host: mail.cdherb.com, port: 587; --> 587 , 587
			// 502 unimplemented (#5.5.1)  --> 587, 465
			// Could not connect to SMTP host: mail.cdherb.com, port: 465;  --> 465 , 587
			// 502 unimplemented (#5.5.1) --> 465, 465
			
			
			//p.put("mail.smtp.host","smtps.hiworks.com");
			// Could not connect to SMTP host: smtps.hiworks.com, port: 587;  --> 587 , 587
			// 502 unimplemented (#5.5.1) --> 465, 465
			
			//p.put("mail.smtp.host","pop3s.hiworks.com");
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.starttls.enable", "true");
			p.put("mail.smtp.host", "mail.cdherb.com");
			p.put("mail.smtp.port", "587");
			
			/* 465
			p.put("mail.smtp.host","mail.cdherb.com");
			p.put("mail.smtp.port", "587");
			p.put("mail.smtp.starttls.enable", "true");
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.debug", "true");
			p.put("mail.smtp.socketFactory.port", "587");
			p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			p.put("mail.smtp.socketFactory.fallback", "false");
			*/
			Authenticator auth = new SMTPAuthenticatior();
		    Session ses = Session.getInstance(p, auth);
		      
		    ses.setDebug(true);
		    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체 
		 
		    msg.setSubject("[청담원외탕전 답변]"+ param.getString("title")); //  제목
		    
		 
		    StringBuffer buffer = new StringBuffer();
		    buffer.append(mailForm(param));


		    Address fromAddr = new InternetAddress("cdherb_user@cdherb.com");
		    msg.setFrom(fromAddr); 
		 
		    Address toAddr = new InternetAddress(param.getString("email"));
		    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
		     
		    msg.setContent(buffer.toString(), "text/html;charset=UTF-8"); // 내용
		    Transport.send(msg); //

			
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public static String mailForm(CommonMap param) {
		StringBuffer sb  = new StringBuffer();
		sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
		sb.append("<html lang=\"ko\">");
		sb.append("<head>	");
		sb.append("	<title>청담원외탕전 문의내용</title>");
		sb.append("	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />");
		sb.append("	<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\"/>");
		sb.append("	<meta name=\"title\" content=\"청담원외탕전\">");
		sb.append("</head>");
		sb.append("<body>");
		sb.append("<div style=\"width:720px; margin-bottom:30px; padding:20px;letter-spacing:-1px;border:1px solid #dddddd;\">");
		sb.append("	<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:720px; margin:10px auto; font-size:11pt !important; font-family:'맑은 고딕';\">");
		sb.append("		<tr>");
		sb.append("			<td align=\"right\" style=\"border-bottom:2px solid #00b49c; padding-bottom:10px;\"><img src=\"http://cdherb.com/assets/user/pc/images/sub/bg_popuptit.png\" alt=\"\" /></td>");
		sb.append("		</tr>");
		sb.append("		<tr>");
		sb.append("			<td align=\"center\" style=\"padding:20px 0; border-bottom:1px solid #dddddd;\">청담원외탕전에 문의하신 내용에 대한 답변입니다.</td>");
		sb.append("		</tr>");
		sb.append("		<tr>");
		sb.append("			<td style=\"padding:20px 30px; color:#7a7a7a;\">");
		sb.append("				<p style=\"width:100%;\"><b>문의내용 :"+param.getString("title")+"</b></p>");
		sb.append("				<p style=\"width:100%;font-size:10pt !important; padding-left:20px; box-sizing: border-box;\">"+param.getString("content").replaceAll("\n", "<br/>")+"</p>");
		sb.append("			</td>");
		sb.append("		</tr>");
		sb.append("		<tr>");
		sb.append("			<td style=\"padding:20px 30px; border-top:1px dotted #7d7d7d; background:#f5f5f5;\">");
		sb.append("				<p style=\"width:100%;font-size:10pt !important; padding-left:20px; box-sizing: border-box;\">" + param.getString("re_content").replaceAll("\n", "<br/>"));		
		sb.append("				</p>");
		sb.append("			</td>");
		sb.append("		</tr>");
		sb.append("	</table>");
		sb.append("	<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:720px; margin:30px auto 0 auto; font-size:10pt !important; font-family:'맑은 고딕';\">");
		sb.append("		<tr>");
		sb.append("			<td style=\"padding:20px 10px; border-top:1px solid #dddddd;\">");
		sb.append("				<b>청담원외탕전</b><br/>");
		sb.append("				경상북도 포항시 북구 장량로 140번길 6 (장성동)  /  고객센터 : 054-242-1079  /  팩스 : 054-232-1079<br/>");
		sb.append("				<font style=\"color:#8b8b8b;\">Copyright ⓒ 청담원외탕전 All rights reserved.</font>");
		sb.append("			</td>");
		sb.append("		</tr>");
		sb.append("	</table>");
		sb.append("</div>");
		sb.append("</body>");
		sb.append("</html>");
		return sb.toString();
	}
}
