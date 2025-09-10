<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Preview Certificate</title>
  <style>
    body{font-family:Segoe UI,Arial,sans-serif;margin:0;background:#f7f8fb;color:#222}
    .wrap{max-width:1100px;margin:24px auto;padding:0 16px}
    .bar{display:flex;gap:8px;align-items:center;margin-bottom:12px}
    .bar a,.bar form button{
      background:#2563eb;color:#fff;border:none;border-radius:8px;padding:8px 12px;
      text-decoration:none;font-weight:600;cursor:pointer
    }
    .bar a.secondary{background:#10b981}
    .bar a.neutral{background:#6b7280}
    iframe{width:100%;height:80vh;border:1px solid #e5e7eb;border-radius:8px;background:#fff}
    .meta{margin:12px 0;color:#555}
  </style>
</head>
<body>
<div class="wrap">
  <h2>🎓 Preview Certificate</h2>
  <div class="meta">
    <div><b>Student:</b> ${student.fullname} (ID #${cert.studentId})</div>
    <div><b>Course/Level:</b> ${cert.courseName}</div>
    <div><b>Organization:</b> Lingua Fem</div>
  </div>

  <div class="bar">
    <a class="secondary" href="${pageContext.request.contextPath}/cert/admin/${cert.id}/download">Download PDF</a>
    <form action="${pageContext.request.contextPath}/cert/admin/${cert.id}/publish" method="post">
      <c:if test="${not empty _csrf}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      </c:if>
      <button type="submit">✅ Looks good — Publish (ISSUE)</button>
    </form>
    <a class="neutral" href="${pageContext.request.contextPath}/cert/admin/certificates">Back</a>
  </div>

  <iframe
  src="${pageContext.request.contextPath}/cert/admin/${cert.id}/preview.pdf"
  style="width:100%;height:75vh;border:1px solid #e5e7eb;border-radius:8px;background:#fff"
  title="PDF Preview">
</iframe>

</div>
</body>
</html>
