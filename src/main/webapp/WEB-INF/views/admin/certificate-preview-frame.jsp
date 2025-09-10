<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <style>
    body{margin:0;background:#f8fafc;font-family:Georgia, 'Times New Roman', serif}
    .cert{width:900px;margin:24px auto;padding:40px 50px;background:#fff;border:12px solid #e5e7eb;box-shadow:0 8px 24px rgba(0,0,0,.06)}
    .header{display:flex;justify-content:space-between;align-items:center;margin-bottom:24px}
    .org{font-size:28px;font-weight:700;color:#111827}
    .seal{font-size:12px;color:#6b7280;text-align:right}
    h1{font-size:40px;margin:8px 0 24px;text-align:center;letter-spacing:1px}
    .line{height:2px;background:#e5e7eb;margin:24px 0}
    .name{font-size:30px;text-align:center;margin:16px 0 8px}
    .course{text-align:center;color:#374151;font-size:18px}
    .meta{display:flex;justify-content:space-between;margin-top:36px;color:#374151}
    .meta div{width:48%}
    .label{font-size:12px;color:#6b7280}
    .value{font-size:16px;margin-top:4px}
  </style>
</head>
<body>
  <div class="cert">
    <div class="header">
      <div class="org">${orgName}</div>
      <div class="seal">
        <div>Official Certificate</div>
        <div>Preview</div>
      </div>
    </div>

    <h1>Certificate of Achievement</h1>

    <div class="name">${student != null ? student.name : '-'}</div>
    <div class="course">
      has successfully completed the course<br/>
      <strong>${cert.courseName}</strong>
    </div>

    <div class="line"></div>

    <div class="meta">
      <div>
        <div class="label">Certificate Code</div>
        <div class="value">
          <c:choose>
            <c:when test="${not empty cert.certificateCode}">${cert.certificateCode}</c:when>
            <c:otherwise>TBD (not issued)</c:otherwise>
          </c:choose>
        </div>
      </div>
      <div>
        <div class="label">Issue Date</div>
        <div class="value">
          <c:choose>
            <c:when test="${not empty cert.issueDate}">${cert.issueDate}</c:when>
            <c:otherwise>TBD</c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
