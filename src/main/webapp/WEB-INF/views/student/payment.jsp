<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Certificate Payment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; padding: 2rem; background: #f8fafc; color: #0f172a; }
        .card { background: #fff; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1); max-width: 600px; margin: 2rem auto; text-align: center; }
        .btn { display: inline-block; padding: 12px 24px; border-radius: 8px; font-weight: 700; text-decoration: none; margin-top: 1rem; background: #2563eb; color: #fff; transition: all 0.3s ease; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.2); }
        img { max-width: 250px; margin-top: 1rem; border-radius: 12px; }
        h2 { margin-bottom: 1rem; }
    </style>
</head>
<body>
    <div class="card">
        <h2>💳 Payment for Certificate</h2>
        <p>Course: <strong><c:out value="${cert.courseName}"/></strong></p>
        <p>Certificate ID: <strong><c:out value="${cert.id}"/></strong></p>
        <p>Status: <span style="font-weight:700; color:#3730a3;">Awaiting Payment</span></p>

        <p>Please scan the QR code below to pay via KPay:</p>
        <img src="${pageContext.request.contextPath}/assets/imgs/kpay-qr.jpg" alt="KPay QR">

        <p>After completing the payment, click the button below to confirm:</p>
        <a href="${pageContext.request.contextPath}/cert/pay/confirm?cid=${cert.id}" class="btn">✅ I have paid</a>
        <br>
        <a href="${pageContext.request.contextPath}/student-dashboard" class="btn" style="background:#64748b;">⬅ Back to Dashboard</a>
    </div>
</body>
</html>
