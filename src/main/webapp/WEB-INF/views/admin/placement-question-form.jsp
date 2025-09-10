<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"  %>
<html>
<head>
    <title>${empty question.id ? 'Add' : 'Edit'} Placement Question</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <style>
        .form { max-width:800px; background:#fff; border:1px solid #eee; border-radius:10px; padding:16px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .row { display:flex; gap:16px; margin-bottom:12px; }
        .row label { min-width:140px; font-weight:600; padding-top:8px; }
        .row input[type=text], .row select, .row textarea { flex:1; padding:8px; border:1px solid #ddd; border-radius:6px; }
        .btn { padding:8px 12px; border-radius:6px; background:#5b2bd9; color:#fff; text-decoration:none; border:none; }
        .btn.secondary { background:#6c757d; }
        .help { color:#777; font-size:12px; margin-top:-6px; }
    </style>
</head>
<body>
<h2>${empty question.id ? 'Add' : 'Edit'} Placement Question</h2>

<form class="form" method="post" action="<c:url value='/admin/placement-questions' />" enctype="multipart/form-data">

    <c:if test="${not empty question.id}">
        <input type="hidden" name="id" value="${question.id}" />
    </c:if>

    <div class="row">
        <label for="section">Section</label>
        <select id="section" name="section">
            <c:forEach var="s" items="${['Vocabulary','Grammar']}">
                <option value="${s}" ${question.section == s ? 'selected' : ''}>${s}</option>
            </c:forEach>
        </select>
    </div>

    <div class="row">
        <label for="questionText">Question Text</label>
        <textarea id="questionText" name="questionText" rows="3">${question.questionText}</textarea>
    </div>

    <div class="row">
        <label for="optionA">Option A</label>
        <input type="text" id="optionA" name="optionA" value="${question.optionA}" />
    </div>
    <div class="row">
        <label for="optionB">Option B</label>
        <input type="text" id="optionB" name="optionB" value="${question.optionB}" />
    </div>
    <div class="row">
        <label for="optionC">Option C</label>
        <input type="text" id="optionC" name="optionC" value="${question.optionC}" />
    </div>
    <div class="row">
        <label for="optionD">Option D</label>
        <input type="text" id="optionD" name="optionD" value="${question.optionD}" />
    </div>

    <div class="row">
        <label for="correctOption">Correct Option</label>
        <select id="correctOption" name="correctOption">
            <c:forEach var="o" items="${['A','B','C','D']}">
                <option value="${o}" ${question.correctOption == o ? 'selected' : ''}>${o}</option>
            </c:forEach>
        </select>
    </div>





    <div class="row">
        <button type="submit" class="btn">Save</button>
        <a href="<c:url value='/admin/placement-questions' />" class="btn secondary">Cancel</a>
    </div>
</form>


</body>
</html>
