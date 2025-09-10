package com.lingua.services;

import com.lingua.models.Certificate;
import com.lingua.models.Student;
import com.lingua.DAOS.CertificateDAO;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.util.ByteArrayDataSource;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
public class CertificateService {

    @Autowired private JavaMailSender mailSender;
    @Autowired private CertificateDAO certificateDAO; // keep if you need it elsewhere

    @Value("${mail.from}")            private String fromAddress;          // e.g. admin@uit.edu.mm
    @Value("${mail.cc.admin:false}")  private boolean ccAdmin;             // optional copy to admin

    // Generate PDF bytes for a certificate
    public byte[] generateCertificatePDF(Certificate cert, Student student) throws Exception {
        Document document = new Document();
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, out);
        document.open();

        Font titleFont   = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24);
        Font bodyFont    = FontFactory.getFont(FontFactory.HELVETICA, 18);

        Paragraph title = new Paragraph("Certificate of Completion", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        Paragraph studentName = new Paragraph("This certifies that " + safe(student.getName()), bodyFont);
        studentName.setAlignment(Element.ALIGN_CENTER);
        studentName.setSpacingAfter(10);
        document.add(studentName);

        Paragraph course = new Paragraph("has successfully completed the course: " + safe(cert.getCourseName()), bodyFont);
        course.setAlignment(Element.ALIGN_CENTER);
        course.setSpacingAfter(10);
        document.add(course);

        String codeText = cert.getCertificateCode() != null ? cert.getCertificateCode() : "(pending)";
        Paragraph code = new Paragraph("Certificate Code: " + codeText, bodyFont);
        code.setAlignment(Element.ALIGN_CENTER);
        document.add(code);

        if (cert.getIssueDate() != null) {
            String dateStr = cert.getIssueDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy"));
            Paragraph date = new Paragraph("Issued on: " + dateStr, bodyFont);
            date.setAlignment(Element.ALIGN_CENTER);
            document.add(date);
        }

        document.close();
        return out.toByteArray();
    }

    // Send certificate PDF via email (HTML body, UTF-8, proper From)
    public void sendCertificateByEmail(Certificate cert, Student student) {
        try {
            if (student.getEmail() == null || student.getEmail().isBlank()) {
                throw new IllegalArgumentException("Student email is empty");
            }

            byte[] pdfBytes = generateCertificatePDF(cert, student);

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            // From: admin@uit.edu.mm (must match your SMTP account or allowed sender)
            helper.setFrom(new InternetAddress(fromAddress, "UIT Certificates"));
            helper.setTo(student.getEmail());
            if (ccAdmin) helper.addCc(fromAddress);

            String subject = "Your Certificate: " + safe(cert.getCourseName());
            helper.setSubject(subject);

            String codeText = cert.getCertificateCode() != null ? cert.getCertificateCode() : "(pending)";
            String issueText = cert.getIssueDate() != null
                    ? cert.getIssueDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy"))
                    : "(pending)";

            String html = ""
                    + "<p>Dear " + safe(student.getName()) + ",</p>"
                    + "<p>Congratulations! Your certificate is attached.</p>"
                    + "<p><b>Course:</b> " + safe(cert.getCourseName()) + "<br/>"
                    + "<b>Code:</b> " + codeText + "<br/>"
                    + "<b>Issued:</b> " + issueText + "</p>"
                    + "<p>— UIT</p>";

            helper.setText(html, true); // HTML body
            helper.addAttachment("certificate-" + cert.getId() + ".pdf",
                    new ByteArrayDataSource(pdfBytes, "application/pdf"));

            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace(); // TODO: replace with proper logging
        }
    }

    private static String safe(String s) { return s == null ? "" : s; }

	public Certificate getCertificateById(int id) {
		// TODO Auto-generated method stub
		return null;
	}


}
