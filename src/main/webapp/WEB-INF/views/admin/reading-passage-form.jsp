<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>${passage.id == 0 ? 'New' : 'Edit'} Reading Passage</title>
    <style>
        .container { max-width: 900px; margin: 20px auto; }
        .card { background:#fff; border:1px solid #eee; border-radius:10px; padding:20px; box-shadow:0 4px 12px rgba(0,0,0,0.05); }
        form div { margin-bottom: 14px; }
        label { display:block; font-weight:600; margin-bottom:6px; }
        input[type=text], textarea { width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; }
        .actions { display:flex; gap:10px; justify-content:flex-end; }
        .btn { padding:10px 14px; border-radius:6px; border:none; background:#5b2bd9; color:#fff; cursor:pointer; text-decoration:none; }
        .btn.secondary { background:#6c757d; }
    </style>
</head>
<body>
<div class="container">
<div class="card">
<h2 style="margin-top:0;">${passage.id == 0 ? 'New' : 'Edit'} Reading Passage</h2>
<form action="<c:url value='/admin/reading-passages'/>" method="post">
    <input type="hidden" name="id" value="${passage.id}"/>
    <div>
        <label>Title</label>
        <input type="text" name="title" value="${passage.title}" required/>
    </div>
    <div>
        <label>Passage Content</label>
        <textarea name="content" rows="10" required>${passage.content}</textarea>
    </div>
    <div class="actions">
        <a href="<c:url value='/admin/reading-passages'/>" class="btn secondary">Cancel</a>
        <button type="submit" class="btn">Save</button>
    </div>
</form>
</div>
</div>
</body>
</html>


