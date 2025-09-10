<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <style>
        body{font-family:Inter,sans-serif;background:#f8fafc;text-align:center;padding:5rem}
        .btn{padding:12px 24px;background:#c800ff;color:white;border:none;border-radius:8px;text-decoration:none}
    </style>
</head>
<body>
    <h1>🔒 Access Denied</h1>
    <p>You are at <strong>${sessionScope.student.level}</strong> level and cannot access this content.</p>
    <a href="/student-dashboard" class="btn">Go to Dashboard</a>
</body>
</html>