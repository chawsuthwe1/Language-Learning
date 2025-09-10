<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Lessons</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminstyle.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

        :root {
            --bg-color: #f0f4f8;
            --card-bg: #ffffff;
            --primary-color: #4f46e5;
            --danger-color: #ef4444;
            --text-color: #1f2937;
            --border-color: #e5e7eb;
            --header-bg: #1e293b;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            padding: 20px;
            margin: 0;
        }

        .container {
            max-width: 900px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: var(--header-bg);
            margin-bottom: 20px;
            font-weight: 600;
        }

        .tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
            background-color: var(--card-bg);
            padding: 8px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            justify-content: center;
        }

        .tab {
            padding: 12px 20px;
            border-radius: 8px;
            background: transparent;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            color: var(--text-color);
        }

        .tab:hover {
            background-color: var(--bg-color);
        }

        .tab.active {
            background: var(--primary-color);
            color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .panel {
            display: none;
        }

        .panel.active {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            margin: 0 0 20px;
            font-weight: 600;
            color: var(--primary-color);
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 15px;
            font-size: 1.5rem;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            font-size: 1rem;
        }
        
        th {
            background-color: #f9fafb;
            font-weight: 600;
            color: #6b7280;
            text-transform: uppercase;
        }
        
        tr {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
        }
        
        tr:hover {
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        form.inline {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        label {
            font-weight: 500;
            font-size: 1.1rem;
            color: #4b5563;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            font-size: 1rem;
        }
        
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }
        
        textarea {
            min-height: 150px;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .actions form {
            display: inline; /* This is the key change */
        }

        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            border: 0;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.1s ease;
            font-size: 1rem;
        }

        .btn.primary {
            background: var(--primary-color);
            color: #fff;
        }
        
        .btn.primary:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }
        
        .btn.danger {
            background: var(--danger-color);
            color: #fff;
        }
        
        .btn.danger:hover {
            background-color: #dc2626;
            transform: translateY(-1px);
        }
        
        .btn:active {
            transform: translateY(1px);
        }
        
        .btn.small {
            padding: 8px 14px;
            font-size: 0.9rem;
        }
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

        // Handle audio and image upload
        document.addEventListener('DOMContentLoaded', () => {
            // Audio Upload
            const audioUpload = document.getElementById('listening-audio-upload');
            const audioFilename = document.getElementById('listening-audio');

            if (audioUpload) {
                audioUpload.addEventListener('change', async function () {
                    const file = this.files[0];
                    if (!file) return;

                    const formData = new FormData();
                    formData.append('audioFile', file);

                    try {
                        const response = await fetch('${pageContext.request.contextPath}/admin/manage-lessons/listening/upload-audio', {
                            method: 'POST',
                            body: formData
                        });

                        const result = await response.json();
                        if (response.ok) {
                            audioFilename.value = result.filename;
                            alert('✅ Audio uploaded: ' + result.filename);
                        } else {
                            alert('❌ Upload failed: ' + result.error);
                        }
                    } catch (err) {
                        alert('❌ Network error: ' + err.message);
                    }
                });
            }

            // Image Upload
            const imageUpload = document.getElementById('vocab-image-upload');
            const imageFilename = document.getElementById('vocab-image');
            const categorySelect = document.getElementById('vocab-category');

            if (imageUpload) {
                imageUpload.addEventListener('change', async function () {
                    const file = this.files[0];
                    if (!file) return;

                    const formData = new FormData();
                    formData.append('imageFile', file);
                    formData.append('category', categorySelect ? categorySelect.value : '');

                    try {
                        const response = await fetch('${pageContext.request.contextPath}/admin/manage-lessons/vocabulary/upload-image', {
                            method: 'POST',
                            body: formData
                        });

                        const result = await response.json();
                        if (response.ok) {
                            imageFilename.value = result.filename; // Already includes 'assets/imgs/...'
                            alert('✅ Image uploaded: ' + result.filename);
                        } else {
                            alert('❌ Upload failed: ' + result.error);
                        }
                    } catch (err) {
                        alert('❌ Network error: ' + err.message);
                    }
                });
            }

            // Show current tab
            const tab = getParam('tab') || 'grammar';
            showTab(tab);
        });
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
<div class="container">
    <h2>Manage Lessons</h2>

    <div class="tabs">
        <div id="tab-grammar" class="tab" onclick="showTab('grammar')">Grammar</div>
        <div id="tab-reading" class="tab" onclick="showTab('reading')">Reading</div>
        <div id="tab-listening" class="tab" onclick="showTab('listening')">Listening</div>
        <div id="tab-vocabulary" class="tab" onclick="showTab('vocabulary')">Vocabulary</div>
        <div style="margin-left:auto"><a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">Back</a></div>
    </div>

    <div id="panel-grammar" class="panel">
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
                <thead>
                <tr><th>Slug</th><th>Title</th><th>Level</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="g" items="${grammarLessons}">
                    <tr>
                        <td>${g.slug}</td>
                        <td>${g.title}</td>
                        <td>${g.level}</td>
                        <td class="actions">
                            <button class="btn small" type="button"
                                    data-slug="${g.slug}"
                                    data-title="${g.title}"
                                    data-level="${g.level}"
                                    data-description="${fn:escapeXml(g.description)}"
                                    data-content="${fn:escapeXml(g.contentHtml)}"
                                    onclick="editGrammar(this)">Edit</button>
                            <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/grammar/delete">
                                <input type="hidden" name="slug" value="${g.slug}"/>
                                <button class="btn danger small" type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div id="panel-reading" class="panel">
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
                <thead>
                <tr><th>ID</th><th>Title</th><th>Level</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${readingPassages}">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.title}</td>
                        <td>${p.level}</td>
                        <td class="actions">
                            <button class="btn small" type="button" onclick="editReading('${p.id}','${p.title}','${p.level}','${p.paragraph}')">Edit</button>
                            <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/reading/delete">
                                <input type="hidden" name="id" value="${p.id}"/>
                                <button class="btn danger small" type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div id="panel-listening" class="panel">
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
                <label>Upload Audio File</label>
                <input type="file" id="listening-audio-upload" accept=".mp3,.wav,.ogg" />
                <input id="listening-audio" name="audioFile" placeholder="Audio filename will appear here" readonly required />
                <textarea id="listening-transcript" name="transcript" placeholder="Transcript"></textarea>
                <button class="btn primary" type="submit">Save Exercise</button>
            </form>
        </div>
        <div class="card">
            <h3>Exercises</h3>
            <table>
                <thead>
                <tr><th>ID</th><th>Title</th><th>Level</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="e" items="${listeningExercises}">
                    <tr>
                        <td>${e.id}</td>
                        <td>${e.title}</td>
                        <td>${e.level}</td>
                        <td class="actions">
                            <button class="btn small" type="button"
                                    data-id="${e.id}"
                                    data-level="${e.level}"
                                    data-title="${fn:escapeXml(e.title)}"
                                    data-audio="${fn:escapeXml(e.audioFile)}"
                                    data-transcript="${fn:escapeXml(e.transcript)}"
                                    onclick="editListening(this)">Edit</button>
                            <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/listening/delete">
                                <input type="hidden" name="id" value="${e.id}"/>
                                <button class="btn danger small" type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div id="panel-vocabulary" class="panel">
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
                <label>Upload Image</label>
                <input type="file" id="vocab-image-upload" accept=".jpg,.jpeg,.png,.gif" />
                <input id="vocab-image" name="image" placeholder="Image filename will appear here" readonly />
                <button class="btn primary" type="submit">Save Vocabulary</button>
            </form>
        </div>
        <div class="card">
            <h3>Vocabulary</h3>
            <table>
                <thead>
                <tr><th>ID</th><th>Word</th><th>Category</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <c:forEach var="v" items="${vocabulary}">
                    <tr>
                        <td>${v.id}</td>
                        <td>${v.word}</td>
                        <td>${v.category}</td>
                        <td class="actions">
                            <button class="btn small" type="button" onclick="editVocabulary('${v.id}','${v.category}','${v.word}','${fn:escapeXml(v.definition)}','${fn:escapeXml(v.example)}','${fn:escapeXml(v.image)}','${v.level}')">Edit</button>
                            <form method="post" action="${pageContext.request.contextPath}/admin/manage-lessons/vocabulary/delete">
                                <input type="hidden" name="id" value="${v.id}"/>
                                <button class="btn danger small" type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>