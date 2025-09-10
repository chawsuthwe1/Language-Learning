<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>My Certificate</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .btn {
            padding: 10px 15px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }
        .btn-download { background:#28a745; color:white; }
        .btn-back { background:#6c757d; color:white; }
    </style>
</head>
<body>
    <h2>🎓 My Certificate</h2>

    <p>
        <strong>Student:</strong> ${student.name} (ID #${student.id})<br>
        <strong>Course/Level:</strong> ${certificate.courseLevel}<br>
        <strong>Organization:</strong> ${certificate.organization}
    </p>

    <!-- Certificate Preview -->
    <iframe src="${pageContext.request.contextPath}/certificate/preview/${certificate.id}"
            width="100%" height="500px"
            style="border:1px solid #ccc;">
    </iframe>

    <br><br>
    <!-- Download button -->
    <a href="${pageContext.request.contextPath}/certificate/download/${certificate.id}" class="btn btn-download">
        ⬇ Download PDF
    </a>
    &nbsp;
    <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-back">
        ⬅ Back to Dashboard
    </a>
</body>
</html>
