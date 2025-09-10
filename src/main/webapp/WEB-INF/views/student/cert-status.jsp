<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Certificate Status</title>
  <style>
    :root { --card:#fff; --muted:#64748b; --ok:#16a34a; --warn:#f59e0b; --danger:#ef4444; --blue:#2563eb; --bg:#f8fafc; }
    body { margin:0; font-family:Segoe UI,sans-serif; background:var(--bg); color:#0f172a; padding:28px; }
    .card { max-width:900px; margin:0 auto 18px; background:var(--card); border-radius:14px; padding:18px 20px; box-shadow:0 8px 30px rgba(0,0,0,.06); }
    .title { font-size:22px; font-weight:800; display:flex; gap:10px; align-items:center; margin-bottom:6px; }
    .muted { color:var(--muted); }
    .row { display:flex; justify-content:space-between; gap:12px; padding:12px 0; border-bottom:1px solid #e5e7eb; }
    .row:last-child { border-bottom:none; }
    .pill { padding:6px 10px; border-radius:999px; font-weight:700; font-size:12px; border:1px solid transparent; }
    .PENDING_ADMIN { background:#fff7ed; color:#b45309; border-color:#fde68a; }
    .APPROVED { background:#ecfdf5; color:#15803d; border-color:#bbf7d0; }
    .AWAITING_PAYMENT { background:#eef2ff; color:#3730a3; border-color:#e0e7ff; }
    .PAID { background:#e0f2fe; color:#075985; border-color:#bae6fd; }
    .ISSUED { background:#f5f3ff; color:#6d28d9; border-color:#ddd6fe; }
    .REJECTED { background:#fee2e2; color:#b91c1c; border-color:#fecaca; }
    .btn { display:inline-block; text-decoration:none; padding:12px 22px; border-radius:8px; font-weight:700; margin:6px; transition:all 0.3s ease; }
    .btn-primary { background:var(--blue); color:#fff; }
    .btn-success { background:var(--ok); color:#fff; }
    .btn-warning { background:var(--warn); color:#fff; }
    .btn-danger { background:var(--danger); color:#fff; }
    .btn:hover { transform:translateY(-2px); box-shadow:0 4px 12px rgba(0,0,0,0.2); }
    .list .item { padding:12px 0; border-bottom:1px dashed #e5e7eb; display:flex; justify-content:space-between; gap:10px; }
    .list .item:last-child{ border-bottom:none; }
  </style>
</head>
<body>

  <!-- Latest Certificate Request -->
  <div class="card">
    <div class="title">🎫 Certificate Request Status</div>

    <c:choose>
      <c:when test="${not empty cert}">
        <div class="muted" style="margin-bottom:10px;">
          Your request has been submitted. An administrator will review it. If approved, payment will be required before you can download your certificate.
        </div>

        <div class="row">
          <div>
            <div><strong>Certificate ID:</strong> <c:out value="${cert.id}"/></div>
            <div class="muted"><strong>Course:</strong> <c:out value="${cert.courseName}"/></div>
          </div>
          <div style="text-align:right;">
            <div class="pill ${cert.status}"><c:out value="${cert.status}"/></div>
            <div class="muted">
              <strong>Code:</strong> <c:out value="${cert.certificateCode != null ? cert.certificateCode : '-'}"/> &nbsp; 
              <strong>Issued:</strong> <c:out value="${cert.issueDate != null ? cert.issueDate : '-'}"/>
            </div>
          </div>
        </div>

        <!-- Dynamic Action Buttons -->
        <div style="margin-top:16px;">
          <c:choose>
            <c:when test="${cert.status == 'APPROVED'}">
              <a class="btn btn-success" href="${pageContext.request.contextPath}/cert/pay?cid=${cert.id}">💳 Pay & Download</a>
            </c:when>
            <c:when test="${cert.status == 'AWAITING_PAYMENT'}">
              <a class="btn btn-warning" href="${pageContext.request.contextPath}/cert/pay?cid=${cert.id}">💳 Complete Payment</a>
            </c:when>
            <c:when test="${cert.status == 'PAID' || cert.status == 'ISSUED'}">
              <a class="btn btn-success" href="${pageContext.request.contextPath}/cert/download/${cert.id}">⬇ Download Certificate</a>
            </c:when>
          </c:choose>

          <!-- Back to Dashboard -->
          <a class="btn btn-primary" href="${pageContext.request.contextPath}/student-dashboard">⬅ Back to Dashboard</a>
        </div>

        <!-- Status Legend -->
        <div style="margin-top:12px;">
          <span class="pill PENDING_ADMIN">Pending</span> 
          <span class="pill APPROVED">Approved</span> 
          <span class="pill AWAITING_PAYMENT">Awaiting Payment</span>
          <span class="pill PAID">Paid</span>
          <span class="pill ISSUED">Issued</span>
          <span class="pill REJECTED">Rejected</span>
        </div>

      </c:when>
      <c:otherwise>
        <div class="muted">No recent certificate request found.</div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- Past Certificates -->
  <div class="card">
    <div class="title">📄 Your Certificates</div>
    <div class="list">
      <c:forEach var="cft" items="${certificates}">
        <div class="item">
          <div>
            <div><strong>ID:</strong> <c:out value="${cft.id}"/> — <c:out value="${cft.courseName}"/></div>
            <div class="muted">
              <strong>Code:</strong> <c:out value="${cft.certificateCode != null ? cft.certificateCode : '-'}"/>
              &nbsp; <strong>Issued:</strong> <c:out value="${cft.issueDate != null ? cft.issueDate : '-'}"/>
            </div>
          </div>
          <div class="pill ${cft.status}"><c:out value="${cft.status}"/></div>
        </div>
      </c:forEach>
      <c:if test="${empty certificates}">
        <div class="muted">You have no certificates yet.</div>
      </c:if>
    </div>
  </div>
<div style="max-width:900px;margin:0 auto 18px;display:flex;gap:12px;align-items:center;">
  <!-- (1) Back to dashboard -->
  <a href="${pageContext.request.contextPath}/student-dashboard"
     class="btn btn-primary"
     style="text-decoration:none;">
    ⬅ Back to Dashboard
  </a>

  <!-- (2) Download your certificate (asks for ID) -->
  <button type="button"
          id="btnDownloadById"
          class="btn btn-success"
          style="border:none;cursor:pointer;">
    ⬇️ Download your certificate
  </button>
</div>
<div class="tips">
      <h4></i> Certificate Download Tips</h4>
      <ul>
        <li>The id requested if you click Download your certificate is the id of the certificate you want</li>
        <li>The certificate id will appear only if the admin appear</li>
        <li>Pay attention to the admin's response</li>
        <li>Please wait patiently</li>
      </ul>
    </div>
  <!-- Auto-refresh for pending requests -->
  <!-- Auto-refresh for pending requests only -->
<c:if test="${cert.status == 'PENDING_ADMIN'}">
  <script>
    setTimeout(() => { window.location.reload(); }, 60000); // refresh every 60 sec
  </script>
</c:if>

<!-- Download-by-ID handler: runs regardless of status -->
<script>
  (function () {
    var btn = document.getElementById('btnDownloadById');
    if (!btn) return;                    // button not present

    // Ensure your button has type="button" so it doesn't submit any surrounding form
    if (!btn.getAttribute('type')) btn.setAttribute('type', 'button');

    btn.addEventListener('click', function () {
      var id = prompt('Enter your certificate ID (number):');
      if (id === null) return;           // user cancelled
      id = (id || '').trim();

      if (!/^\d+$/.test(id)) {
        alert('Please enter a valid numeric ID.');
        return;
      }

      // Force-download endpoint (server validates login/ownership/status)
      window.location.href = '${pageContext.request.contextPath}/cert/file/' + id + '/download';

      // If you prefer to show the guard page first, use:
      // window.location.href = '${pageContext.request.contextPath}/cert/download/' + id;
    });
  })();
</script>

</body>
</html>
