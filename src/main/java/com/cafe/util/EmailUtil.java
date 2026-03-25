package com.cafe.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {
    public static void sendOTP(String toEmail, int otp) {

        final String fromEmail = "chetramanh2008@gmail.com";
        final String password = "njlv bpfw fpmf qoxw";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );

            message.setSubject("Mã OTP PolyCafe");
            message.setText("Mã OTP của bạn là: " + otp);

            Transport.send(message);

            System.out.println("Gửi email thành công!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
