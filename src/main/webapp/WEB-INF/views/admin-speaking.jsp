<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Manage Speaking</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    :root{
      --panel:#fff; --ink:#2b2d42; --muted:#6b7280;
      --brand1:#a855f7; --brand2:#ec4899; --ring:rgba(168,85,247,.25);
      --shadow:0 8px 24px rgba(0,0,0,.06);
    }
    body{margin:0;font-family:Inter,system-ui,Segoe UI,Roboto,Arial,sans-serif;background:
      radial-gradient(1200px 600px at -10% -10%, #fde7f3 0, transparent 50%),
      radial-gradient(1200px 600px at 110% -10%, #e9d5ff 0, transparent 50%),
      radial-gradient(1200px 600px at 50% 110%, #e0f2fe 0, transparent 50%),
      #faf9ff;color:var(--ink)}
    .wrap{max-width:1200px;margin:48px auto;padding:0 20px;}
    .headline{
      font-size:40px;font-weight:900;text-align:center;margin:8px 0 6px;
      background:linear-gradient(90deg,var(--brand1),var(--brand2));
      -webkit-background-clip:text;background-clip:text;color:transparent}
    .sub{color:var(--muted);text-align:center;margin:0 0 28px}
    .grid{display:grid;grid-template-columns:340px 1fr;gap:24px;align-items:start}
    @media (max-width:980px){.grid{grid-template-columns:1fr}}
    .card{background:var(--panel);border-radius:16px;box-shadow:var(--shadow)}
    .pane{padding:22px}
    .pane h3{margin:0 0 14px;font-size:20px;font-weight:800;display:flex;align-items:center;gap:8px}
    .muted{color:var(--muted);font-size:14px;margin:0 0 12px}
    .field{display:flex;flex-direction:column;gap:8px;margin:12px 0}
    .field input[type="text"], .field textarea{
      border:1px solid #e5e7eb;border-radius:12px;padding:12px 14px;font-size:14px;outline:0;
      transition:box-shadow .2s,border-color .2s;background:#fff}
    .field input:focus, .field textarea:focus{border-color:#c084fc;box-shadow:0 0 0 4px var(--ring)}
    .btn{
      display:inline-flex;align-items:center;gap:10px;border:0;border-radius:12px;padding:12px 16px;
      font-weight:700;color:#fff;background:linear-gradient(90deg,#8b5cf6,#ec4899);cursor:pointer}
    .list .hdr{display:grid;grid-template-columns:70px 1fr 2fr 140px;gap:12px;padding:12px 20px;color:#6b7280;font-weight:700}
    .row{display:grid;grid-template-columns:70px 1fr 2fr 140px;gap:12px;align-items:center;padding:16px 20px;border-top:1px solid #f1f5f9}
    .title{font-weight:800}
    .preview{color:#475569}
    .actions{display:flex;gap:12px}
    .iconbtn{background:transparent;border:0;cursor:pointer;font-size:16px;color:#374151}
    .iconbtn:hover{color:#111827}
    details summary{list-style:none;cursor:pointer}
    details[open] summary .caret{transform:rotate(180deg)}
    .editbox{background:#fafafa;border:1px dashed #e5e7eb;border-radius:12px;padding:14px;margin-top:10px}
    .editbox .field{margin:8px 0}
    .tiny{font-size:12px;color:#94a3b8}
  </style>
</head>
<body>
  <div class="wrap">
    <h1 class="headline"><i class="fa-solid fa-microphone"></i> Manage Speaking Exercises</h1>
    <p class="sub">Create and manage speaking practice exercises to help learners improve their pronunciation and fluency</p>

    <div class="grid">
      <!-- ADD NEW -->
      <div class="card pane">
        <h3><i class="fa-solid fa-plus"></i> Add New Exercise</h3>
        <form action="${pageContext.request.contextPath}/admin/speaking/add" method="post">
          <%-- If using Spring Security, include CSRF:
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          --%>
          <div class="field">
            <label>Exercise Title</label>
            <input type="text" name="title" placeholder="Enter exercise title..." required>
          </div>
          <div class="field">
            <label>Target Text</label>
            <textarea name="content" placeholder="Enter the text that learners should practice speaking..." rows="6" required></textarea>
          </div>
          <button class="btn" type="submit"><i class="fa-solid fa-plus"></i> Add Exercise</button>
        </form>
      </div>

      <!-- LIST -->
      <div class="card">
        <div class="pane">
          <h3><i class="fa-solid fa-microphone"></i> Speaking Exercises (<c:out value="${fn:length(exercises)}"/>)</h3>
        </div>
        <div class="list">
          <div class="hdr">
            <div>ID</div>
            <div>Title</div>
            <div>Preview</div>
            <div>Actions</div>
          </div>

          <c:forEach var="e" items="${exercises}">
            <div class="row">
              <div>#<c:out value="${e.id}"/></div>

              <div>
                <div class="title"><c:out value="${e.title}"/></div>
<!--                 <div class="tiny"> -->
<!--                   Created: -->
<%--                   <c:choose> --%>
<%--                     <c:when test="${not empty e.createdAt}"> --%>
<%--                       <c:out value="${e.createdAt}"/> --%>
<%--                     </c:when> --%>
<%--                     <c:otherwise>—</c:otherwise> --%>
<%--                   </c:choose> --%>
<!--                 </div> -->
              </div>

              <div class="preview">
                <c:choose>
                  <c:when test="${fn:length(e.content) > 80}">
                    <c:out value="${fn:substring(e.content,0,80)}"/>...
                  </c:when>
                  <c:otherwise>
                    <c:out value="${e.content}"/>
                  </c:otherwise>
                </c:choose>
              </div>

              <div class="actions">
                <!-- View (student practice page in a new tab) -->
                <a class="iconbtn" title="Preview" target="_blank"
                   href="${pageContext.request.contextPath}/student/speaking/${e.id}">
                  <i class="fa-regular fa-eye"></i>
                </a>

                <!-- Inline edit -->
                <details>
                  <summary class="iconbtn" title="Edit">
                    <i class="fa-regular fa-pen-to-square"></i> <i class="fa-solid fa-caret-down caret"></i>
                  </summary>
                  <div class="editbox">
                    <form action="${pageContext.request.contextPath}/admin/speaking/update/${e.id}" method="post">
                      <%-- CSRF if enabled
                      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      --%>
                      <div class="field">
                        <label>Title</label>
                        <input type="text" name="title" value="${e.title}" required>
                      </div>
                      <div class="field">
                        <label>Target Text</label>
                        <textarea name="content" rows="5" required>${e.content}</textarea>
                      </div>
                      <button class="btn" type="submit"><i class="fa-regular fa-floppy-disk"></i> Save</button>
                    </form>
                  </div>
                </details>

                <!-- Delete -->
                <form action="${pageContext.request.contextPath}/admin/speaking/delete/${e.id}" method="post"
                      onsubmit="return confirm('Delete this exercise?')">
                  <button class="iconbtn" type="submit" title="Delete"><i class="fa-regular fa-trash-can"></i></button>
                </form>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
  <div style="text-align: center; margin-top: 30px;">
           <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
</body>
</html>
