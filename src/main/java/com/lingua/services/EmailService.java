package com.lingua.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.util.ByteArrayDataSource;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    // configure these in application.properties
    @Value("${mail.from}")
    private String fromAddress;                 // e.g. admin@uit.edu.mm
    @Value("${mail.cc.admin:false}")
    private boolean ccAdmin;                    // optional: send a copy to admin

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * Send an email (HTML supported) with a single PDF attachment.
     */
    public void sendEmailWithAttachment(
            String to,
            String subject,
            String htmlBody,         // pass HTML (or plain text if you want)
            String filename,         // e.g. "certificate-6.pdf"
            byte[] attachmentBytes
    ) throws Exception {

        if (to == null || to.isBlank()) {
            throw new IllegalArgumentException("Recipient email is empty");
        }

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        // From: admin@uit.edu.mm with a nice display name
        helper.setFrom(new InternetAddress(fromAddress, "UIT Certificates"));

        helper.setTo(to);
        if (ccAdmin) {
            helper.addCc(fromAddress);
        }

        helper.setSubject(subject);
        helper.setText(htmlBody, true); // true = HTML body

        // attach PDF
        helper.addAttachment(filename, new ByteArrayDataSource(attachmentBytes, "application/pdf"));

        mailSender.send(message);
    }
}
