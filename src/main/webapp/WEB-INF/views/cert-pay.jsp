<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Certificate Payment</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <style>
    body{font-family:Segoe UI, sans-serif; padding:2rem; background:#f8fafc; color:#0f172a;}
    .card{background:#fff; border-radius:15px; padding:2rem; box-shadow:0 4px 15px rgba(0,0,0,.1); max-width:640px; margin:2rem auto; text-align:center;}
    .btn{display:inline-block; padding:12px 24px; border-radius:10px; font-weight:700; text-decoration:none; margin-top:1rem; background:#2563eb; color:#fff}
    .btn.secondary{background:#64748b}
    img{max-width:260px; margin:1rem auto; border-radius:12px;}
  </style>
</head>
<body>
  <div class="card">
    <h2>💳 Pay for Certificate</h2>
    <p>Course: <strong><c:out value="${cert.courseName}"/></strong></p>
    <p>Certificate ID: <strong><c:out value="${cert.id}"/></strong></p>
    <p>Status: <span style="font-weight:700;color:#3730a3;">Awaiting Payment</span></p>

    <p>Please scan the QR below to pay via KPay:</p>
    <img src="${pageContext.request.contextPath}/assets/imgs/kpay-qr.jpg" alt="KPay QR">

    <form method="post" action="${pageContext.request.contextPath}/cert/pay/confirm" style="margin-top:16px;">
      <input type="hidden" name="cid" value="${cert.id}">
      <button type="submit" class="btn">✅ I have paid</button>
      <a href="${pageContext.request.contextPath}/student-dashboard" class="btn secondary">⬅ Back to Dashboard</a>
    </form>
  </div>
</body>
</html>
