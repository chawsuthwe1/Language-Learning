<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Advanced Quizzes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminstyle.css" />
    <style>
        .grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
        .card{background:#fff;border:1px solid #e5e7eb;border-radius:10px;padding:16px}
        table{width:100%;border-collapse:collapse}
        th,td{padding:10px;border-bottom:1px solid #eee;text-align:left}
        form.inline{display:flex;gap:8px;flex-wrap:wrap}
        input,select,textarea{width:100%;padding:8px;border:1px solid #d1d5db;border-radius:8px}
        .actions{display:flex;gap:8px}
        .btn{padding:8px 12px;border-radius:8px;border:0;cursor:pointer}
        .btn.primary{background:#2563eb;color:#fff}
        .btn.danger{background:#ef4444;color:#fff}
        body{background:#f8fafc;font-family:Inter,system-ui,-apple-system}
    </style>
</head>
<body>
<h2>Manage Advanced Quizzes</h2>

<div class="grid">
  <div class="card">
    <h3>Add / Edit Advanced Grammar</h3>
    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/grammar/save">
      <input type="hidden" name="id" />
      <input name="lessonSlug" placeholder="Lesson Slug" required />
      <textarea name="question" placeholder="Question" required></textarea>
      <textarea name="options" placeholder="Options (e.g., A) ...; B) ...; C) ...; D) ... )" required></textarea>
      <input name="answer" placeholder="Answer (e.g., A) ... )" required />
      <button class="btn primary" type="submit">Save</button>
    </form>
  </div>
  <div class="card">
    <h3>Advanced Grammar</h3>
    <table>
      <tr><th>ID</th><th>Lesson</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
      <c:forEach var="q" items="${grammar}">
        <tr>
          <td>${q.id}</td>
          <td>${q.lessonSlug}</td>
          <td>${q.question}</td>
          <td>${q.answer}</td>
          <td class="actions">
            <form method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/grammar/delete">
              <input type="hidden" name="id" value="${q.id}"/>
              <button class="btn danger" type="submit">Delete</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>

  <div class="card">
    <h3>Add / Edit Listening MCQ</h3>
    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/listening/mcq/save">
      <input type="hidden" name="id" />
      <input name="exerciseId" placeholder="Exercise ID" required />
      <textarea name="questionText" placeholder="Question" required></textarea>
      <textarea name="choices" placeholder="Choices (A; B; C; D)" required></textarea>
      <input name="correctAnswer" placeholder="Correct Answer (e.g., B) ... )" required />
      <button class="btn primary" type="submit">Save</button>
    </form>
  </div>
  <div class="card">
    <h3>Listening MCQ</h3>
    <table>
      <tr><th>ID</th><th>Exercise</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
      <c:forEach var="q" items="${listeningMCQ}">
        <tr>
          <td>${q.id}</td>
          <td>${q.exerciseId}</td>
          <td>${q.questionText}</td>
          <td>${q.correctAnswer}</td>
          <td class="actions">
            <form method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/listening/mcq/delete">
              <input type="hidden" name="id" value="${q.id}"/>
              <button class="btn danger" type="submit">Delete</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>

  <div class="card">
    <h3>Add / Edit Listening True/False</h3>
    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/listening/tf/save">
      <input type="hidden" name="id" />
      <input name="exerciseId" placeholder="Exercise ID" required />
      <textarea name="statement" placeholder="Statement" required></textarea>
      <select name="answer">
        <option>True</option>
        <option>False</option>
      </select>
      <button class="btn primary" type="submit">Save</button>
    </form>
  </div>
  <div class="card">
    <h3>Listening True/False</h3>
    <table>
      <tr><th>ID</th><th>Exercise</th><th>Statement</th><th>Answer</th><th>Actions</th></tr>
      <c:forEach var="q" items="${listeningTF}">
        <tr>
          <td>${q.id}</td>
          <td>${q.exerciseId}</td>
          <td>${q.statement}</td>
          <td>${q.answer}</td>
          <td class="actions">
            <form method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/listening/tf/delete">
              <input type="hidden" name="id" value="${q.id}"/>
              <button class="btn danger" type="submit">Delete</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>

  <div class="card">
    <h3>Add / Edit Reading Question</h3>
    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/reading/save">
      <input type="hidden" name="id" />
      <input name="readingId" placeholder="Reading ID" required />
      <textarea name="questionText" placeholder="Question" required></textarea>
      <textarea name="choices" placeholder="Choices (A; B; C; D)" required></textarea>
      <input name="correctAnswer" placeholder="Correct Answer" required />
      <button class="btn primary" type="submit">Save</button>
    </form>
  </div>
  <div class="card">
    <h3>Reading Questions</h3>
    <table>
      <tr><th>ID</th><th>Reading</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
      <c:forEach var="q" items="${reading}">
        <tr>
          <td>${q.id}</td>
          <td>${q.readingId}</td>
          <td>${q.questionText}</td>
          <td>${q.correctAnswer}</td>
          <td class="actions">
            <form method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/reading/delete">
              <input type="hidden" name="id" value="${q.id}"/>
              <button class="btn danger" type="submit">Delete</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>

  <div class="card">
    <h3>Add / Edit Vocabulary</h3>
    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/vocab/save">
      <input type="hidden" name="id" />
      <input name="category" placeholder="Category" required />
      <select name="questionType">
        <option>DEFINITION</option>
        <option>FILL_IN_BLANK</option>
      </select>
      <textarea name="questionText" placeholder="Question" required></textarea>
      <textarea name="optionA" placeholder="Option A" required></textarea>
      <textarea name="optionB" placeholder="Option B" required></textarea>
      <textarea name="optionC" placeholder="Option C" required></textarea>
      <textarea name="optionD" placeholder="Option D" required></textarea>
      <input name="correctAnswer" placeholder="Correct (A/B/C/D)" required />
      <input name="relatedWord" placeholder="Related Word (optional)" />
      <button class="btn primary" type="submit">Save</button>
    </form>
  </div>
  <div class="card">
    <h3>Vocabulary</h3>
    <table>
      <tr><th>ID</th><th>Category</th><th>Question</th><th>Correct</th><th>Actions</th></tr>
      <c:forEach var="q" items="${vocab}">
        <tr>
          <td>${q.id}</td>
          <td>${q.category}</td>
          <td>${q.questionText}</td>
          <td>${q.correctAnswer}</td>
          <td class="actions">
            <form method="post" action="${pageContext.request.contextPath}/admin/advanced-quizzes/vocab/delete">
              <input type="hidden" name="id" value="${q.id}"/>
              <button class="btn danger" type="submit">Delete</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </table>
  </div>

</div>

</body>
</html>


