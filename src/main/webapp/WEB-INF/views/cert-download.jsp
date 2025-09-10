<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Download Certificate</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="card" style="max-width:600px; margin:50px auto; padding:2rem; border-radius:12px; box-shadow:0 4px 15px rgba(0,0,0,0.1); text-align:center;">
        <h2>⬇ Download Your Certificate</h2>
        <p><strong>Course:</strong> <c:out value="${cert.courseName}"/></p>
        <p><strong>Certificate ID:</strong> <c:out value="${cert.id}"/></p>
        <p><strong>Status:</strong> <c:out value="${cert.status}"/></p>

        <form action="${pageContext.request.contextPath}/cert/download-file/${cert.id}" method="get">
            <!-- This endpoint should generate PDF for download -->
            <button type="submit" class="btn btn-success" style="margin-top:20px;">
                <i class="fas fa-file-pdf"></i> Download PDF
            </button>
        </form>

        <div style="margin-top:1rem;">
            <a href="${pageContext.request.contextPath}/cert/status?cid=${cert.id}" class="btn btn-primary">
                ⬅ Back to Certificate Status
            </a>
        </div>
    </div>
</body>
</html>
