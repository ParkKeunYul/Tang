package kr.co.hany.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticatior extends Authenticator{
	@Override
    protected PasswordAuthentication getPasswordAuthentication() {
       return new PasswordAuthentication("cdherb_user@cdherb.com","cjdeka78*&");
		//return new PasswordAuthentication("matrix1597","gksmf2!!@@nn");
    }

}
