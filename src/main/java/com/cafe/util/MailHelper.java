package com.cafe.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class MailHelper {
    private static final String FROM_EMAIL = "tmngoc732@gmail.com";
    private static final String APP_PASSWORD = "suvnpdccdhrhsmfp";

    public static boolean sendOTP(String toEmail, String otpCode) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);


        new Thread(() -> {
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(FROM_EMAIL));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                message.setSubject("MÃ OTP ĐĂNG NHẬP POLYCAFE", "UTF-8");

                String content = "<h2 style='color:brown;'>Mã xác nhận của bạn là: <span style='color:red;'>" + otpCode + "</span></h2>";
                message.setContent(content, "text/html; charset=UTF-8");

                Transport.send(message);
                System.out.println(">>> [SUCCESS] Da gui OTP thanh cong den: " + toEmail);
            } catch (MessagingException e) {
                System.out.println(">>> [ERROR] Loi gui mail trong Thread: " + e.getMessage());
                e.printStackTrace();
            }
        }).start();

        return true;
    }
}