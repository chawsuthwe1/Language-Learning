<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Manage Certificates</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --bg: #f4f7fc;
            --card: #ffffff;
            --text: #2c3e50;
            --accent: #27ae60;
            --danger: #e74c3c;
            --pending: #f39c12;
            --muted: #6b7280;
            --border: #e5e7eb;
        }
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: var(--bg); color: var(--text); padding: 40px; }
        h2 { text-align: center; font-size: 28px; margin-bottom: 6px; }
        .subtitle { text-align:center; color: var(--muted); margin-bottom: 24px; font-size: 13px; }
        .toolbar { max-width: 1000px; margin: 0 auto 16px; display: flex; gap: 10px; align-items: center; }
        .toolbar label { font-weight: 600; }
        .toolbar select, .toolbar button { padding: 8px 10px; border-radius: 8px; border: 1px solid var(--border); background: #fff; }
        .toolbar button { background:#2563eb; color:#fff; border: none; cursor:pointer; }
        .table-container { max-width: 1000px; margin: 0 auto; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; background-color: var(--card); box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-radius: 10px; overflow: hidden; }
        th, td { padding: 14px 16px; text-align: left; border-bottom: 1px solid #eee; vertical-align: middle; }
        th { background-color: #ecf0f1; font-weight: bold; }
        tr:hover { background-color: #f9f9f9; }
        .muted { color: var(--muted); font-size: 12px; }
        .status { font-weight: 600; padding: 6px 10px; border-radius: 999px; display: inline-block; border: 1px solid transparent; }
        .status.approved { background-color: #d4efdf; color: var(--accent); border-color:#c8e6d4; }
        .status.pending { background-color: #fef5e7; color: var(--pending); border-color:#f8e5c3; }
        .status.denied  { background-color: #f9ebea; color: var(--danger); border-color:#f2c7c6; }
        .status.paid    { background-color: #e8f5ff; color: #2563eb; border-color:#cfe7ff; }
        .status.issued  { background-color: #ede9fe; color: #6d28d9; border-color:#ddd6fe; }
        .status.generated { background-color:#ede9fe; color:#6d28d9; border-color:#ddd6fe; }
        
        .actions { display:flex; flex-wrap: wrap; gap: 8px; }
        .btn { text-decoration: none; font-weight: 600; padding: 8px 12px; border-radius: 8px; transition: transform .04s ease, opacity .2s ease; border: none; cursor: pointer; display: inline-flex; align-items:center; gap:8px; }
        .btn:active { transform: translateY(1px); }
        .btn-approve { background-color: var(--accent); color: white; }
        .btn-deny    { background-color: var(--danger); color: white; }
        .btn-action  { background-color: #2563eb; color: white; }
        .inline-form { display:inline-flex; gap:8px; align-items:center; flex-wrap:wrap; }
        .inline-form input[type="text"], .inline-form input[type="number"] { padding:8px 10px; border-radius:8px; border:1px solid var(--border); min-width:140px; }
        .empty { text-align:center; padding: 24px; color: var(--muted); }
        .flow { text-align:center; margin-bottom: 22px; color: var(--muted); }
        .pill { background:#eef2ff; color:#3730a3; padding:3px 8px; border-radius:999px; font-size:11px; border:1px solid #e0e7ff; }
    </style>
</head>
<body>

    <h2>🎓 Approve Certificates</h2>
    <div class="subtitle">
        <span class="pill">Flow</span>
        PENDING_ADMIN → GENERATED → ISSUED
    </div>

    <!-- Optional simple client-side filter (does not hit server) -->
    <div class="toolbar">
        <label for="statusFilter">Status:</label>
        <select id="statusFilter" onchange="filterRows()">
            <option value="">All</option>
            <option value="PENDING_ADMIN">PENDING_ADMIN</option>
            <option value="APPROVED">APPROVED</option>
            <option value="AWAITING_PAYMENT">AWAITING_PAYMENT</option>
            <option value="GENERATED">GENERATED</option>
            
            <option value="PAID">PAID</option>
            <option value="ISSUED">ISSUED</option>
            <option value="REJECTED">REJECTED</option>
        </select>
        <span class="muted">This filter only hides/shows rows on this page.</span>
    </div>

    <div class="table-container">
        <c:choose>
            <c:when test="${empty certificates}">
                <div class="empty">No certificate requests yet.</div>
            </c:when>
            <c:otherwise>
                <table id="certTable">
                    <thead>
                        <tr>
                            <th style="width:90px;">ID</th>
                            <th style="width:140px;">Student</th>
                            <th>Course</th>
                            <th style="width:140px;">Status</th>
                            <th style="width:420px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cert" items="${certificates}">
                            <tr data-status="${cert.status}">
                                <td>
                                    <div><strong>${cert.id}</strong></div>
                                    <div class="muted">${cert.certificateCode != null ? cert.certificateCode : '-'}</div>
                                </td>
                                <td>
                                    <div>#${cert.studentId}</div>
                                    <div class="muted">${cert.issueDate != null ? cert.issueDate : '-'}</div>
                                </td>
                                <td>${cert.courseName}</td>
                                <td>
                                   <c:set var="pillClass"
       value="${cert.status == 'APPROVED'  ? 'approved'  :
               cert.status == 'REJECTED'  ? 'denied'    :
               cert.status == 'PAID'      ? 'paid'      :
               cert.status == 'ISSUED'    ? 'issued'    :
               cert.status == 'GENERATED' ? 'generated' :
                                            'pending'}" />

                                    <span class="status ${pillClass}">${cert.status}</span>
                                </td>
                                <td>
                                    <div class="actions">
                                        <!-- PENDING_ADMIN: Approve / Reject -->
                                        <c:if test="${cert.status == 'PENDING_ADMIN'}">
                                            <form class="inline-form" action="${pageContext.request.contextPath}/cert/admin/${cert.id}/approve" method="post">
                                                <c:if test="${not empty _csrf}">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                </c:if>
                                                <button type="submit" class="btn btn-approve">
                                                    <i class="fas fa-check-circle"></i> Approve
                                                </button>
                                            </form>

                                            <form class="inline-form" action="${pageContext.request.contextPath}/cert/admin/${cert.id}/reject" method="post">
                                                <c:if test="${not empty _csrf}">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                </c:if>
                                                <button type="submit" class="btn btn-deny">
                                                    <i class="fas fa-times-circle"></i> Deny
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- APPROVED: Create Payment -->
                                        <c:if test="${cert.status == 'APPROVED'}">
                                            <form class="inline-form" action="${pageContext.request.contextPath}/cert/admin/${cert.id}/create-payment" method="post">
                                                <c:if test="${not empty _csrf}">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                </c:if>
                                                <input type="hidden" name="studentId" value="${cert.studentId}" />
                                                <input type="text"   name="amount" value="10.00" />
                                                <input type="text"   name="method" value="manual_bank" />
                                                <button type="submit" class="btn btn-action">
                                                    <i class="fas fa-money-check-dollar"></i> Create Payment
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- AWAITING_PAYMENT: Mark Paid -->
                                        <c:if test="${cert.status == 'AWAITING_PAYMENT'}">
                                            <form class="inline-form" action="${pageContext.request.contextPath}/cert/admin/${cert.id}/mark-paid" method="post">
                                                <c:if test="${not empty _csrf}">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                </c:if>
                                               
                                                <button type="submit" class="btn btn-action">
                                                    <i class="fas fa-check"></i> Mark Paid
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- PAID: Preview & Issue (no POST, go to preview screen) -->
<c:if test="${cert.status == 'PAID'}">
  <a class="btn btn-action"
     href="${pageContext.request.contextPath}/cert/admin/${cert.id}/preview">
    <i class="fas fa-award"></i> Issue Certificate
  </a>
</c:if>

                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
<div style="text-align: center; margin-top: 30px;">
           <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    <script>
        function filterRows() {
            var sel = document.getElementById('statusFilter').value;
            var rows = document.querySelectorAll('#certTable tbody tr');
            rows.forEach(function (tr) {
                var st = tr.getAttribute('data-status') || '';
                tr.style.display = (!sel || sel === st) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
