<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Lessons</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminstyle.css" />
    <style>
        .tabs{display:flex;gap:10px;margin:10px 0}
        .tab{padding:10px 16px;border-radius:8px;background:#f0f3f6;cursor:pointer}
        .tab.active{background:#111827;color:#fff}
        .panel{display:none}
        .panel.active{display:block}
        .grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
        .card{background:#fff;border:1px solid #e5e7eb;border-radius:10px;padding:16px}
        .card h3{margin:0 0 12px}
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
    <script>
        function showTab(id){
            document.querySelectorAll('.tab').forEach(t=>t.classList.remove('active'));
            document.querySelectorAll('.panel').forEach(p=>p.classList.remove('active'));
            document.getElementById('tab-'+id).classList.add('active');
            document.getElementById('panel-'+id).classList.add('active');
        }
        function getParam(name){
            const params = new URLSearchParams(window.location.search);
            return params.get(name);
        }
        function editReading(id,title,level,paragraph){
            document.getElementById('reading-id').value = id;
            document.getElementById('reading-level').value = level;
            document.getElementById('reading-title').value = title;
            document.getElementById('reading-paragraph').value = paragraph;
            showTab('reading');
        }
        function editGrammar(buttonEl){
            const d = buttonEl.dataset;
            document.getElementById('grammar-slug').value = d.slug || '';
            document.getElementById('grammar-title').value = d.title || '';
            document.getElementById('grammar-level').value = d.level || '';
            document.getElementById('grammar-description').value = d.description || '';
            document.getElementById('grammar-content').value = d.content || '';
            showTab('grammar');
        }
        function editListening(buttonEl){
            const d = buttonEl.dataset;
            document.getElementById('listening-id').value = d.id || '';
            document.getElementById('listening-level').value = d.level || '';
            document.getElementById('listening-title').value = d.title || '';
            document.getElementById('listening-audio').value = d.audio || '';
            document.getElementById('listening-transcript').value = d.transcript || '';
            showTab('listening');
        }
        function editVocabulary(id,category,word,definition,example,image,level){
            document.getElementById('vocab-id').value = id;
            if (level) document.getElementById('vocab-level').value = level;
            document.getElementById('vocab-category').value = category;
            document.getElementById('vocab-word').value = word;
            document.getElementById('vocab-definition').value = definition;
            document.getElementById('vocab-example').value = example || '';
            document.getElementById('vocab-image').value = image || '';
            showTab('vocabulary');
        }
        window.addEventListener('DOMContentLoaded',()=>{
            const tab = getParam('tab') || 'grammar';
            showTab(tab);
        })
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
<h2>Manage Lessons</h2>

<div class="tabs">
    <div id="tab-grammar" class="tab" onclick="showTab('grammar')">Grammar</div>
    <div id="tab-reading" class="tab" onclick="showTab('reading')">Reading</div>
    <div id="tab-listening" class="tab" onclick="showTab('listening')">Listening</div>
    <div id="tab-vocabulary" class="tab" onclick="showTab('vocabulary')">Vocabulary</div>
    <div style="margin-left:auto"><a class="btn" href="${pageContext.request.contextPath}/admin-dashboard">Back</a></div>
    </div>

<!-- Grammar -->
<div id="panel-grammar" class="panel">
  <div class="grid">
    <div class="card">
      <h3>Add / Edit Grammar Lesson</h3>
      <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/grammar/save">
        <input id="grammar-slug" name="slug" placeholder="Slug (unique)" required />
        <input id="grammar-title" name="title" placeholder="Title" required />
        <textarea id="grammar-description" name="description" placeholder="Short description"></textarea>
        <textarea id="grammar-content" name="contentHtml" placeholder="Content (HTML)"></textarea>
        <select id="grammar-level" name="level">
          <option>Beginner</option>
          <option>Pre-Intermediate</option>
          <option>Intermediate</option>
          <option>Advanced</option>
        </select>
        <button class="btn primary" type="submit">Save Lesson</button>
      </form>
    </div>
    <div class="card">
      <h3>Grammar Lessons</h3>
      <table>
        <tr><th>Slug</th><th>Title</th><th>Level</th><th>Actions</th></tr>
        <c:forEach var="g" items="${grammarLessons}">
          <tr>
            <td>${g.slug}</td>
            <td>${g.title}</td>
            <td>${g.level}</td>
            <td class="actions">
              <button class="btn" type="button"
                data-slug="${g.slug}"
                data-title="${g.title}"
                data-level="${g.level}"
                data-description="${fn:escapeXml(g.description)}"
                data-content="${fn:escapeXml(g.contentHtml)}"
                onclick="editGrammar(this)">Edit</button>
              <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/grammar/delete">
                <input type="hidden" name="slug" value="${g.slug}"/>
                <button class="btn danger" type="submit">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </div>
</div>

<!-- Reading -->
<div id="panel-reading" class="panel">
  <div class="grid">
    <div class="card">
      <h3>Add / Edit Reading Passage</h3>
      <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/reading/save">
        <input type="hidden" id="reading-id" name="id" />
        <select id="reading-level" name="level">
          <option>Beginner</option>
          <option>Pre-Intermediate</option>
          <option>Intermediate</option>
          <option>Advanced</option>
        </select>
        <input id="reading-title" name="title" placeholder="Title" required />
        <textarea id="reading-paragraph" name="paragraph" placeholder="Passage text" required></textarea>
        <button class="btn primary" type="submit">Save Passage</button>
      </form>
    </div>
    <div class="card">
      <h3>Passages</h3>
      <table>
        <tr><th>ID</th><th>Title</th><th>Level</th><th>Actions</th></tr>
        <c:forEach var="p" items="${readingPassages}">
          <tr>
            <td>${p.id}</td>
            <td>${p.title}</td>
            <td>${p.level}</td>
            <td class="actions">
              <button class="btn" type="button" onclick="editReading('${p.id}','${p.title}','${p.level}','${p.paragraph}')">Edit</button>
              <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/reading/delete">
                <input type="hidden" name="id" value="${p.id}"/>
                <button class="btn danger" type="submit">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </div>
</div>

<!-- Listening -->
<div id="panel-listening" class="panel">
  <div class="grid">
    <div class="card">
      <h3>Add / Edit Listening Exercise</h3>
      <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/listening/save">
        <input type="hidden" id="listening-id" name="id" />
        <select id="listening-level" name="level">
          <option>Beginner</option>
          <option>Pre-Intermediate</option>
          <option>Intermediate</option>
          <option>Advanced</option>
        </select>
        <input id="listening-title" name="title" placeholder="Title" required />
        <input id="listening-audio" name="audioFile" placeholder="Audio file URL" />
        <textarea id="listening-transcript" name="transcript" placeholder="Transcript"></textarea>
        <button class="btn primary" type="submit">Save Exercise</button>
      </form>
    </div>
    <div class="card">
      <h3>Exercises</h3>
      <table>
        <tr><th>ID</th><th>Title</th><th>Level</th><th>Actions</th></tr>
        <c:forEach var="e" items="${listeningExercises}">
          <tr>
            <td>${e.id}</td>
            <td>${e.title}</td>
            <td>${e.level}</td>
            <td class="actions">
              <button class="btn" type="button"
                data-id="${e.id}"
                data-level="${e.level}"
                data-title="${fn:escapeXml(e.title)}"
                data-audio="${fn:escapeXml(e.audioFile)}"
                data-transcript="${fn:escapeXml(e.transcript)}"
                onclick="editListening(this)">Edit</button>
              <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/listening/delete">
                <input type="hidden" name="id" value="${e.id}"/>
                <button class="btn danger" type="submit">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </div>
</div>

<!-- Vocabulary -->
<div id="panel-vocabulary" class="panel">
  <div class="grid">
    <div class="card">
      <h3>Add / Edit Vocabulary</h3>
      <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/vocabulary/save">
        <input type="hidden" id="vocab-id" name="id" />
        <select id="vocab-level" name="level">
          <option>Beginner</option>
          <option>Pre-Intermediate</option>
          <option>Intermediate</option>
          <option>Advanced</option>
        </select>
        <input id="vocab-category" name="category" placeholder="Category" required />
        <input id="vocab-word" name="word" placeholder="Word" required />
        <textarea id="vocab-definition" name="definition" placeholder="Definition" required></textarea>
        <textarea id="vocab-example" name="example" placeholder="Example"></textarea>
        <input id="vocab-image" name="image" placeholder="Image URL" />
        <button class="btn primary" type="submit">Save Vocabulary</button>
      </form>
    </div>
    <div class="card">
      <h3>Vocabulary</h3>
      <table>
        <tr><th>ID</th><th>Word</th><th>Category</th><th>Actions</th></tr>
        <c:forEach var="v" items="${vocabulary}">
          <tr>
            <td>${v.id}</td>
            <td>${v.word}</td>
            <td>${v.category}</td>
            <td class="actions">
              <button class="btn" type="button" onclick="editVocabulary('${v.id}','${v.category}','${v.word}','${fn:escapeXml(v.definition)}','${fn:escapeXml(v.example)}','${fn:escapeXml(v.image)}','${v.level}')">Edit</button>
              <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/vocabulary/delete">
                <input type="hidden" name="id" value="${v.id}"/>
                <button class="btn danger" type="submit">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </div>
</div>

</body>
</html>


