<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Reading Passages</title>
    <style>
        .toolbar { display:flex; gap:10px; align-items:center; margin:10px 0; }
        .btn { padding:8px 12px; border-radius:6px; background:#5b2bd9; color:#fff; text-decoration:none; }
        .btn.secondary { background:#6c757d; }
        table { width:100%; border-collapse: collapse; }
        th, td { border-bottom:1px solid #eee; padding:12px; text-align:left; }
        th { background:#fafafa; }
    </style>
</head>
<body>
<h2>Reading Passages</h2>
<div class="toolbar">
    <a href="<c:url value='/admin/reading-passages/new'/>" class="btn">Add Passage</a>
    <a href="<c:url value='/admin/placement-questions?section=Reading'/>" class="btn secondary">Manage Reading Questions</a>
    <span style="margin-left:auto;color:#666;">${passages != null ? passages.size() : 0} passage(s)</span>
    </div>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Excerpt</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${passages}">
        <tr>
            <td>${p.id}</td>
            <td>${p.title}</td>
            <td><c:out value="${p.content.length() > 80 ? p.content.substring(0,80).concat('...') : p.content}"/></td>
            <td>
                <a class="btn" href="<c:url value='/admin/reading-passages/${p.id}'/>">Edit</a>
                <form action="<c:url value='/admin/reading-passages/${p.id}/delete'/>" method="post" style="display:inline">
                    <button class="btn secondary" type="submit" onclick="return confirm('Delete this passage?')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty passages}">
        <tr><td colspan="4" style="text-align:center;color:#777;">No passages yet.</td></tr>
    </c:if>
    </tbody>
</table>
</body>
</html>


