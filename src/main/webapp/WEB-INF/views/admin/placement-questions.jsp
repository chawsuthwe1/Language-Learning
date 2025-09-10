<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Placement Questions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <style>
        .toolbar { display:flex; gap:10px; align-items:center; margin:10px 0; }
        .tabs { display:flex; gap:8px; flex-wrap:wrap; }
        .tab { padding:8px 12px; border:1px solid #ddd; border-radius:20px; text-decoration:none; color:#333; }
        .tab.active { background:#5b2bd9; color:#fff; border-color:#5b2bd9; }
        .search { margin-left:auto; }
        .search input { padding:8px 10px; border:1px solid #ddd; border-radius:6px; }
        .btn { padding:8px 12px; border-radius:6px; background:#5b2bd9; color:#fff; text-decoration:none; }
        .btn.secondary { background:#6c757d; }
        .card { background:#fff; border:1px solid #eee; border-radius:10px; padding:16px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th, td { border-bottom: 1px solid #eee; padding: 12px; text-align:left; }
        th { background: #fafafa; }
        tr:hover { background:#fcfcff; }
        .actions a, .actions button { margin-right:8px; }
        .empty { text-align:center; color:#777; padding:20px; }
        .badge { display:inline-block; padding:2px 8px; border-radius:12px; font-size:12px; }
        .badge.warn { background:#fff3cd; color:#664d03; border:1px solid #ffecb5; }
        .muted { color:#999; }
    </style>
</head>
<body>
<h2>Placement Questions</h2>

<div class="toolbar">
    <a href="<c:url value='/admin/dashboard' />" class="btn secondary">← Back to Dashboard</a>

    <div class="tabs">
        <a class="tab ${empty currentSection ? 'active' : ''}" href="<c:url value='/admin/placement-questions' />">All</a>
        <c:forEach var="s" items="${sections}">
            <a class="tab ${currentSection == s ? 'active' : ''}"
               href="<c:url value='/admin/placement-questions'><c:param name='section' value='${s}'/></c:url>">${s}</a>
        </c:forEach>
    </div>

    <form method="get" action="<c:url value='/admin/placement-questions' />" class="search">
        <input type="hidden" name="section" value="${currentSection}"/>
        <input type="text" name="q" value="${q}" placeholder="Search questions..."/>
    </form>

    <a href="<c:url value='/admin/placement-questions/new' />" class="btn">Add Question</a>
    <a href="<c:url value='/admin/placement-questions' />" class="btn secondary">Reset</a>
</div>

<div class="card">
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Section</th>
        <th>Question</th>
        <th>Correct</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="q" items="${questions}">
        <tr>
            <td>${q.id}</td>
            <td>${q.section}</td>
            <td><c:out value="${q.questionText}"/></td>
            <td>${q.correctOption}</td>

            <td class="actions">
                <a class="btn" href="<c:url value='/admin/placement-questions/${q.id}' />">Edit</a>
                <form action="<c:url value='/admin/placement-questions/${q.id}/delete' />" method="post" style="display:inline">
                    <button class="btn secondary" type="submit" onclick="return confirm('Delete this question?')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>

    <c:if test="${empty questions}">
        <tr><td colspan="6" class="empty">No questions found.</td></tr>
    </c:if>
    </tbody>
</table>
</div>
</body>
</html>
