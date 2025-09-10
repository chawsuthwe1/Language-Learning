<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>Approve Payments</title>
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>
  <style>
    body{margin:0;font-family:Segoe UI,Arial,sans-serif;background:#f3f5fb;color:#2c3e50;padding:32px}
    .wrap{max-width:1080px;margin:0 auto}
    h1{display:flex;align-items:center;gap:10px;font-size:28px;margin:0 0 8px}
    .flow{display:inline-block;background:#eef1ff;color:#5c6bc0;padding:2px 8px;border-radius:999px;font-size:12px;margin-bottom:18px}
    .toolbar{display:flex;align-items:center;gap:12px;margin:12px 0 18px}
    select{padding:6px 10px;border:1px solid #e1e5ee;border-radius:8px;background:#fff}
    table{width:100%;border-collapse:separate;border-spacing:0;background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 6px 18px rgba(0,0,0,.06)}
    thead th{background:#f0f3f9;text-align:left;padding:14px 16px;font-weight:700;font-size:14px;color:#566}
    tbody td{padding:14px 16px;border-top:1px solid #f1f3f8;font-size:14px}
    .pill{display:inline-block;padding:6px 12px;border-radius:999px;font-weight:600;font-size:12px}
    .pill.wait{background:#fff5e6;color:#d88c00;border:1px solid #ffe3b3}
    .pill.paid{background:#eafaf1;color:#2e7d32;border:1px solid #c8e6c9}
    .pill.other{background:#eef2f7;color:#445;border:1px solid #e1e6ef}
    .btn{display:inline-flex;align-items:center;gap:8px;padding:8px 14px;border-radius:999px;border:none;cursor:pointer;font-weight:700}
    .btn-approve{background:#2ecc71;color:#fff}
    .muted{color:#98a1b3;font-size:12px}
    input{padding:8px;border:1px solid #e1e5ee;border-radius:8px}
  </style>
</head>
<body>
<div class="wrap">
  <h1>💳 Approve Payments</h1>
  <div class="flow">Flow: AWAITING_PAYMENT → <b>PAID</b></div>

  <div class="toolbar">
    <label>Status:
      <select id="statusFilter">
  <option value="ALL" selected>All</option>
  <option value="AWAITING_PAYMENT">AWAITING_PAYMENT</option>
  <option value="PENDING_VERIFICATION">PENDING_VERIFICATION</option>
  <option value="PAID">PAID</option></label>
</select>

    <span class="muted">This filter only hides/shows rows on this page.</span>
  </div>

  <table>
    <thead>
      <tr>
        <th style="width:70px;">ID</th>
        <th style="width:120px;">Student</th>
        <th>Course</th>
        <th style="width:220px;">Status</th>
        <th style="width:340px;">Actions</th>
      </tr>
    </thead>
    <tbody id="rows"></tbody>
  </table>
</div>

<script>
  const ctx = '${pageContext.request.contextPath}';
  const CSRF_TOKEN  = document.querySelector('meta[name="_csrf"]')?.content;
  const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content;

  const rowsEl = document.getElementById('rows');
  const statusFilterEl = document.getElementById('statusFilter');

  function badge(status){
    if (status === 'PENDING_VERIFICATION') return '<span class="pill wait">PENDING_VERIFICATION</span>';
    if (status === 'PAID') return '<span class="pill paid">PAID</span>';
    return '<span class="pill other">'+ status +'</span>';
  }

  function actions(p){
    if (p.status === 'PENDING_VERIFICATION') {
      return ''
        + '<input id="pid-' + p.id + '" placeholder="Payment ID" style="margin-right:8px;width:160px;">'
        + '<input id="ref-' + p.id + '" placeholder="Txn Ref (optional)" style="margin-right:8px;width:180px;">'
        + '<button type="button" class="btn btn-approve" data-action="mark-paid" data-id="' + p.id + '">✔ Mark Paid</button>';
    }
    return '<span class="muted">No actions</span>';
  }

  function render(data){
    const want = statusFilterEl.value;
    rowsEl.innerHTML = '';
    if (!Array.isArray(data) || data.length === 0) {
      rowsEl.innerHTML = '<tr><td colspan="5" class="muted">No items</td></tr>';
      return;
    }
    data.forEach(p => {
      if (want !== 'ALL' && p.status !== want) return;
      const tr = document.createElement('tr');
      tr.innerHTML =
          '<td>' + p.id + '</td>'
        + '<td>#' + p.studentId + '<div class="muted">-</div></td>'
        + '<td>' + (p.courseName || '') + '</td>'
        + '<td>' + badge(p.status) + '</td>'
        + '<td>' + actions(p) + '</td>';
      rowsEl.appendChild(tr);
    });
  }

  async function markPaid(id){
	  const pidEl = document.getElementById('pid-' + id);
	  const refEl = document.getElementById('ref-' + id);

	  const params = new URLSearchParams();
	  params.append('id', id); // IMPORTANT
	  if (pidEl && pidEl.value.trim()) params.append('paymentId', pidEl.value.trim());
	  if (refEl && refEl.value.trim()) params.append('transactionId', refEl.value.trim());

	  const headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
	  if (CSRF_TOKEN && CSRF_HEADER) headers[CSRF_HEADER] = CSRF_TOKEN;

	  // Use the simple endpoint (no path variable)
	  const res = await fetch(ctx + '/cert/admin/mark-paid', {
	    method: 'POST',
	    headers,
	    body: params.toString(),
	    credentials: 'same-origin'
	  });

	  if (!res.ok) { alert('Failed to mark paid: HTTP ' + res.status); return; }
	  const j = await res.json();
	  if (j.ok === 'true') load(); else alert('Server did not return ok:true');
	}

  rowsEl.addEventListener('click', (e) => {
    const btn = e.target.closest('[data-action="mark-paid"]');
    if (btn) markPaid(btn.dataset.id);
  });

  statusFilterEl.addEventListener('change', load);
  load();
  setInterval(load, 15000);
  function load(){
	  const sel = statusFilterEl.value; // ALL | AWAITING_PAYMENT | PENDING_VERIFICATION | PAID
	  fetch(ctx + '/cert/payments/list?status=' + encodeURIComponent(sel))
	    .then(r => {
	      if (!r.ok) throw new Error('HTTP ' + r.status);
	      return r.json();
	    })
	    .then(render)
	    .catch(() => rowsEl.innerHTML = '<tr><td colspan="5">Failed to load</td></tr>');
	}

</script>
</body>
</html>
