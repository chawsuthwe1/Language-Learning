<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Speaking Practice</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body {
      font-family: 'Inter', system-ui, Segoe UI, Roboto, Arial, sans-serif;
      background: #faf9ff;
      margin: 0;
      padding: 40px;
    }
    h1 {
      font-size: 32px;
      font-weight: 900;
      text-align: center;
      margin: 0 0 8px;
      background: linear-gradient(90deg,#8b5cf6,#ec4899);
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
    }
    p.sub {
      color: #6b7280;
      text-align: center;
      margin: 0 0 24px;
    }
    .list {
      max-width: 900px;
      margin: 0 auto;
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
    .card {
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0,0,0,.06);
      padding: 18px 22px;
      display: block;
      text-decoration: none;
      color: inherit;
      transition: .18s;
    }
    .card:hover { transform: translateY(-3px); }
    .title { font-size: 18px; font-weight: 800; margin-bottom: 6px; }
    .preview { color: #6b7280; font-size: 14px; line-height: 1.5; }
    .tiny { font-size: 12px; color: #94a3b8; margin-top: 8px; }
  </style>
</head>
<body>
  <h1><i class="fa-solid fa-microphone"></i> Speaking Practice</h1>
  <p class="sub">Choose an exercise to start practicing pronunciation</p>

  <div class="list">
    <c:forEach var="e" items="${exercises}">
      <a class="card" href="${pageContext.request.contextPath}/student/speaking/${e.id}">
        <div class="title">${e.title}</div>
        <div class="preview">
          <c:choose>
            <c:when test="${fn:length(e.content) > 110}">
              <c:out value="${fn:substring(e.content,0,110)}"/>...
            </c:when>
            <c:otherwise><c:out value="${e.content}"/></c:otherwise>
          </c:choose>
        </div>
        
<!--         <div class="tiny"> -->
<%--           <c:if test="${not empty e.createdAt}"> --%>
<%--             Created: <c:out value="${e.createdAt}"/> --%>
<%--           </c:if> --%>
<!--         </div> -->
      </a>
    </c:forEach>
  </div>
  <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/student-dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
</body>
</html>
