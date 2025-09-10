<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lesson Quizzes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminstyle.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

        :root {
            --bg: #f8fafc;
            --card-bg: #ffffff;
            --border: #e2e8f0;
            --primary: #2563eb;
            --danger: #ef4444;
            --warning: #f59e0b;
            --text: #1e293b;
            --text-secondary: #64748b;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #0f172a;
            margin-bottom: 20px;
            font-weight: 600;
        }

        /* Tabs */
        .tabs {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 12px;
            margin: 20px 0;
            padding: 6px;
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .tab {
            padding: 10px 20px;
            border-radius: 9px;
            background: var(--bg);
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-secondary);
            transition: all 0.2s ease;
        }

        .tab.active {
            background: var(--primary);
            color: white;
            box-shadow: var(--shadow);
        }

        /* Panels */
        .panel {
            display: none;
        }

        .panel.active {
            display: block;
        }

        /* Accordion Section Headers */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
            color: #1e40af;
            cursor: pointer;
            padding: 12px 16px;
            background: #eff6ff;
            border: 1px solid var(--border);
            border-radius: 8px;
            margin-bottom: 12px;
            font-size: 1.05rem;
        }

        .section-header::after {
            content: '+';
            font-weight: bold;
            color: #60a5fa;
        }

        .section.expanded .section-header::after {
            content: '−';
        }

        .section-content {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.4s ease-out, padding 0.4s ease-out;
    padding: 0 16px;
}

.section.expanded .section-content {
    max-height: 5000px;
    padding: 16px 16px;
}

/* Optional: ensure form stays visible */
.section.expanded .card form {
    opacity: 1;
    transition: opacity 0.2s;
}

        /* Card */
        .card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 16px;
        }

        .card h3 {
            margin: 0 0 16px;
            font-size: 1.25rem;
            color: var(--primary);
            font-weight: 600;
        }

        /* Form */
        form.inline {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
        }

        textarea {
            min-height: 90px;
            resize: vertical;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        th {
            background: #f1f5f9;
            color: var(--text-secondary);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
        }

        tr:hover {
            background: #f8fafc;
        }

        /* Buttons */
        .btn {
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn.primary {
            background: var(--primary);
            color: white;
        }

        .btn.danger {
            background: var(--danger);
            color: white;
        }

        .btn.edit {
            background: var(--warning);
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
        }

        /* Actions: Edit & Delete on same line */
        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        /* Success/Error Messages */
        .alert {
            max-width: 1000px;
            margin: 20px auto;
            padding: 14px;
            border-radius: 8px;
            text-align: center;
            font-weight: 500;
        }

        .alert.success {
            background: #d1fae5;
            color: #065f46;
        }

        .alert.error {
            background: #fee2e2;
            color: #b91c1c;
        }
        .panel {
    display: none;
    max-height: 75vh;
    overflow-y: auto;
    padding-right: 8px;
    margin-top: 8px;
}

.panel.active {
    display: block;
}

/* Optional: scrollbar styling */
.panel::-webkit-scrollbar {
    width: 6px;
}

.panel::-webkit-scrollbar-track {
    background: var(--bg);
    border-radius: 3px;
}

.panel::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 3px;
}

.panel::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}
    </style>
    <script>
    // Show tab based on hash or fallback
    function showTab(id) {
        window.location.hash = id;

        document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));

        const tab = document.getElementById('tab-' + id);
        const panel = document.getElementById('panel-' + id);

        if (tab && panel) {
            tab.classList.add('active');
            panel.classList.add('active');
        } else {
            document.getElementById('tab-basic').classList.add('active');
            document.getElementById('panel-basic').classList.add('active');
            window.location.hash = 'basic';
        }
    }

    // Toggle section and save state
    function toggleSection(element) {
        const section = element.parentElement;
        const isExpanding = !section.classList.contains('expanded');
        const level = section.closest('.panel').id.replace('panel-', ''); // basic, preintermediate, etc.
        const headerText = element.textContent.trim();
        const key = `sectionState_${level}_${headerText}`;

        section.classList.toggle('expanded');

        // Save state
        if (isExpanding) {
            localStorage.setItem(key, 'open');
        } else {
            localStorage.removeItem(key);
        }

        // Optional: Smooth animation
        const content = section.querySelector('.section-content');
        if (isExpanding) {
            content.style.maxHeight = content.scrollHeight + 'px';
        } else {
            content.style.maxHeight = '0';
        }
    }

    // Restore expanded sections on load
    function restoreSections() {
        document.querySelectorAll('.section').forEach(section => {
            const level = section.closest('.panel')?.id.replace('panel-', '');
            if (!level) return;

            const headerText = section.querySelector('.section-header')?.textContent.trim();
            if (!headerText) return;

            const key = `sectionState_${level}_${headerText}`;
            const saved = localStorage.getItem(key);

            if (saved === 'open') {
                section.classList.add('expanded');
                const content = section.querySelector('.section-content');
                if (content) {
                    content.style.maxHeight = content.scrollHeight + 'px';
                }
            }
        });
    }

    // On load: restore tab and sections
    window.addEventListener('DOMContentLoaded', () => {
        const hash = window.location.hash.substring(1);
        const savedTab = localStorage.getItem('lessonQuizTab');
        const editLevel = '${editLevel}';

        const tabToOpen = hash || savedTab || editLevel || 'basic';
        showTab(tabToOpen);
        localStorage.setItem('lessonQuizTab', tabToOpen);

        restoreSections();

        // Auto-expand section if we are editing something
        const editingForms = document.querySelectorAll('form.inline input[name="id"][value]:not([value=""])');
        if (editingForms.length > 0) {
            const formSection = editingForms[0].closest('.section');
            if (formSection && !formSection.classList.contains('expanded')) {
                formSection.classList.add('expanded');
                const content = formSection.querySelector('.section-content');
                if (content) {
                    content.style.maxHeight = content.scrollHeight + 'px';
                }

                // Save to localStorage
                const level = formSection.closest('.panel').id.replace('panel-', '');
                const headerText = formSection.querySelector('.section-header')?.textContent.trim();
                if (headerText) {
                    localStorage.setItem(`sectionState_${level}_${headerText}`, 'open');
                }
            }
        }
    });

    // Save current tab before leaving
    window.addEventListener('beforeunload', () => {
        const hash = window.location.hash.substring(1);
        if (hash) {
            localStorage.setItem('lessonQuizTab', hash);
        }
    });

    // Listen for hash changes (e.g. back/forward)
    window.addEventListener('hashchange', () => {
        const hash = window.location.hash.substring(1);
        if (hash) showTab(hash);
    });
</script>
</head>
<body>
<div class="container">
    <h2>Lesson Quizzes</h2>

    <!-- Success/Error Messages -->
    <c:if test="${not empty message}">
        <div class="alert success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert error">${error}</div>
    </c:if>

    <!-- Tabs -->
    <div class="tabs">
        <div id="tab-basic" class="tab" onclick="showTab('basic')">Basic</div>
        <div id="tab-preintermediate" class="tab" onclick="showTab('preintermediate')">Pre-Intermediate</div>
        <div id="tab-intermediate" class="tab" onclick="showTab('intermediate')">Intermediate</div>
        <div id="tab-advanced" class="tab" onclick="showTab('advanced')">Advanced</div>
    </div>

    <!-- =============== BASIC PANEL =============== -->
    <div id="panel-basic" class="panel">
        <!-- Grammar Quiz -->
        <div class="section">
            <div class="section-header" onclick="toggleSection(this)">Grammar Quiz</div>
            <div class="section-content">
                <div class="card">
                    <h3>Add / Edit Basic Grammar Quiz</h3>
                    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/save">
                        <c:if test="${_csrf != null}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </c:if>
                        <input type="hidden" name="id" value="${editQuiz.id}" />
                        <select name="lessonSlug" required>
                            <option value="">Select Lesson</option>
                            <c:forEach var="slug" items="${basicLessons}">
                                <option value="${slug}" ${editQuiz.lessonSlug == slug ? 'selected' : ''}>${slug}</option>
                            </c:forEach>
                        </select>
                        <textarea name="question" placeholder="Question" required>${editQuiz.question}</textarea>
                        <textarea name="options" placeholder="Options (A; B; C; D)" required>${editQuiz.options}</textarea>
                        <input name="answer" placeholder="Answer" value="${editQuiz.answer}" required />
                        <button class="btn primary" type="submit">Save</button>
                    </form>
                </div>
                <div class="card">
                    <h3>Basic Grammar Quizzes</h3>
                    <table>
                        <tr><th>ID</th><th>Lesson</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                        <c:forEach var="q" items="${basic}">
                            <tr>
                                <td>${q.id}</td>
                                <td>${q.lessonSlug}</td>
                                <td>${q.question}</td>
                                <td>${q.answer}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/edit?id=${q.id}" class="btn edit">Edit</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/delete">
                                        <c:if test="${_csrf != null}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </c:if>
                                        <input type="hidden" name="id" value="${q.id}"/>
                                        <button class="btn danger" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <!-- Reading Questions -->
        <div class="section">
            <div class="section-header" onclick="toggleSection(this)">Reading Questions</div>
            <div class="section-content">
                <div class="card">
                    <h3>Basic Reading Questions</h3>
                    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/reading/save">
                        <c:if test="${_csrf != null}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </c:if>
                        <input type="hidden" name="id" value="${editReading.id}" />
                        <input name="readingId" placeholder="Reading ID" value="${editReading.readingId}" required />
                        <textarea name="questionText" placeholder="Question" required>${editReading.questionText}</textarea>
                        <textarea name="choices" placeholder="Choices (A; B; C; D)">${editReading.choices}</textarea>
                        <input name="correctAnswer" placeholder="Correct Answer" value="${editReading.correctAnswer}" />
                        <button class="btn primary" type="submit">Save</button>
                    </form>
                    <table>
                        <tr><th>ID</th><th>Reading</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                        <c:forEach var="q" items="${rq_basic}">
                            <tr>
                                <td>${q.id}</td>
                                <td>${q.readingId}</td>
                                <td>${q.questionText}</td>
                                <td>${q.correctAnswer}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/reading/edit?id=${q.id}" class="btn edit">Edit</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/reading/delete">
                                        <c:if test="${_csrf != null}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </c:if>
                                        <input type="hidden" name="id" value="${q.id}"/>
                                        <button class="btn danger" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <!-- Listening True/False -->
        <div class="section">
            <div class="section-header" onclick="toggleSection(this)">Listening (True/False)</div>
            <div class="section-content">
                <div class="card">
                    <h3>Basic Listening True/False</h3>
                    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/listening/tf/save">
                        <c:if test="${_csrf != null}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </c:if>
                        <input type="hidden" name="id" value="${editListeningTF.id}" />
                        <input name="exerciseId" placeholder="Exercise ID" value="${editListeningTF.exerciseId}" required />
                        <textarea name="statement" placeholder="Statement" required>${editListeningTF.statement}</textarea>
                        <select name="answer">
                            <option value="True" ${editListeningTF.answer == 'True' ? 'selected' : ''}>True</option>
                            <option value="False" ${editListeningTF.answer == 'False' ? 'selected' : ''}>False</option>
                        </select>
                        <button class="btn primary" type="submit">Save</button>
                    </form>
                    <table>
                        <tr><th>ID</th><th>Exercise</th><th>Statement</th><th>Answer</th><th>Actions</th></tr>
                        <c:forEach var="q" items="${tf_basic}">
                            <tr>
                                <td>${q.id}</td>
                                <td>${q.exerciseId}</td>
                                <td>${q.statement}</td>
                                <td>${q.answer}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/listening/tf/edit?id=${q.id}" class="btn edit">Edit</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/listening/tf/delete">
                                        <c:if test="${_csrf != null}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </c:if>
                                        <input type="hidden" name="id" value="${q.id}"/>
                                        <button class="btn danger" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>

        <!-- Listening MCQ -->
        <div class="section">
            <div class="section-header" onclick="toggleSection(this)">Listening (MCQ)</div>
            <div class="section-content">
                <div class="card">
                    <h3>Basic Listening MCQ</h3>
                    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/listening/mcq/save">
                        <c:if test="${_csrf != null}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </c:if>
                        <input type="hidden" name="id" value="${editListeningMCQ.id}" />
                        <input name="exerciseId" placeholder="Exercise ID" value="${editListeningMCQ.exerciseId}" required />
                        <textarea name="questionText" placeholder="Question" required>${editListeningMCQ.questionText}</textarea>
                        <textarea name="choices" placeholder="Choices (A; B; C; D)" required>${editListeningMCQ.choices}</textarea>
                        <input name="correctAnswer" placeholder="Correct Answer" value="${editListeningMCQ.correctAnswer}" required />
                        <button class="btn primary" type="submit">Save</button>
                    </form>
                    <table>
                        <tr><th>ID</th><th>Exercise</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                        <c:forEach var="q" items="${mcq_basic}">
                            <tr>
                                <td>${q.id}</td>
                                <td>${q.exerciseId}</td>
                                <td>${q.questionText}</td>
                                <td>${q.correctAnswer}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/listening/mcq/edit?id=${q.id}" class="btn edit">Edit</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/listening/mcq/delete">
                                        <c:if test="${_csrf != null}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </c:if>
                                        <input type="hidden" name="id" value="${q.id}"/>
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
        <div class="section">
            <div class="section-header" onclick="toggleSection(this)">Vocabulary</div>
            <div class="section-content">
                <div class="card">
                    <h3>Basic Vocabulary Quizzes</h3>
                    <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/vocab/save">
                        <c:if test="${_csrf != null}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </c:if>
                        <input type="hidden" name="id" value="${editVocab.id}" />
                        <input name="category" placeholder="Category" value="${editVocab.category}" required />
                        <select name="questionType">
                            <option value="DEFINITION" ${editVocab.questionType == 'DEFINITION' ? 'selected' : ''}>DEFINITION</option>
                            <option value="FILL_IN_BLANK" ${editVocab.questionType == 'FILL_IN_BLANK' ? 'selected' : ''}>FILL_IN_BLANK</option>
                        </select>
                        <textarea name="questionText" placeholder="Question" required>${editVocab.questionText}</textarea>
                        <textarea name="optionA" placeholder="Option A" required>${editVocab.optionA}</textarea>
                        <textarea name="optionB" placeholder="Option B" required>${editVocab.optionB}</textarea>
                        <textarea name="optionC" placeholder="Option C" required>${editVocab.optionC}</textarea>
                        <textarea name="optionD" placeholder="Option D" required>${editVocab.optionD}</textarea>
                        <input name="correctAnswer" placeholder="Correct (A/B/C/D)" value="${editVocab.correctAnswer}" required />
                        <input name="relatedWord" placeholder="Related Word" value="${editVocab.relatedWord}" />
                        <button class="btn primary" type="submit">Save</button>
                    </form>
                    <table>
                        <tr><th>ID</th><th>Category</th><th>Question</th><th>Correct</th><th>Actions</th></tr>
                        <c:forEach var="q" items="${vq_basic}">
                            <tr>
                                <td>${q.id}</td>
                                <td>${q.category}</td>
                                <td>${q.questionText}</td>
                                <td>${q.correctAnswer}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/vocab/edit?id=${q.id}" class="btn edit">Edit</a>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/basic/vocab/delete">
                                        <c:if test="${_csrf != null}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </c:if>
                                        <input type="hidden" name="id" value="${q.id}"/>
                                        <button class="btn danger" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- =============== PRE-INTERMEDIATE PANEL =============== -->
    <div id="panel-preintermediate" class="panel">
    <!-- Grammar Quiz -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Grammar Quiz</div>
        <div class="section-content">
            <div class="card">
                <h3>Add / Edit Pre-Intermediate Grammar Quiz</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editQuiz.id}" />
                    <select name="lessonSlug" required>
                        <option value="">Select Lesson</option>
                        <c:forEach var="slug" items="${preIntermediateLessons}">
                            <option value="${slug}" ${editQuiz.lessonSlug == slug ? 'selected' : ''}>${slug}</option>
                        </c:forEach>
                    </select>
                    <textarea name="question" placeholder="Question" required>${editQuiz.question}</textarea>
                    <textarea name="options" placeholder="Options (A; B; C; D)" required>${editQuiz.options}</textarea>
                    <input name="answer" placeholder="Answer" value="${editQuiz.answer}" required />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Pre-Intermediate Grammar Quizzes</h3>
                <table>
                    <tr><th>ID</th><th>Lesson</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${preintermediate}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.lessonSlug}</td>
                            <td>${q.question}</td>
                            <td>${q.answer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Reading Questions -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Reading Questions</div>
        <div class="section-content">
            <div class="card">
                <h3>Pre-Intermediate Reading Questions</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/reading/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editReading.id}" />
                    <input name="readingId" placeholder="Reading ID" value="${editReading.readingId}" required />
                    <textarea name="questionText" placeholder="Question" required>${editReading.questionText}</textarea>
                    <textarea name="choices" placeholder="Choices (A; B; C; D)">${editReading.choices}</textarea>
                    <input name="correctAnswer" placeholder="Correct Answer" value="${editReading.correctAnswer}" />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Pre-Intermediate Reading Questions</h3>
                <table>
                    <tr><th>ID</th><th>Reading</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${rq_pre}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.readingId}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/reading/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/reading/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Listening True/False -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Listening (True/False)</div>
        <div class="section-content">
            <div class="card">
                <h3>Pre-Intermediate Listening True/False</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/listening/tf/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editListeningTF.id}" />
                    <input name="exerciseId" placeholder="Exercise ID" value="${editListeningTF.exerciseId}" required />
                    <textarea name="statement" placeholder="Statement" required>${editListeningTF.statement}</textarea>
                    <select name="answer">
                        <option value="True" ${editListeningTF.answer == 'True' ? 'selected' : ''}>True</option>
                        <option value="False" ${editListeningTF.answer == 'False' ? 'selected' : ''}>False</option>
                    </select>
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Pre-Intermediate Listening True/False</h3>
                <table>
                    <tr><th>ID</th><th>Exercise</th><th>Statement</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${tf_pre}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.exerciseId}</td>
                            <td>${q.statement}</td>
                            <td>${q.answer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/listening/tf/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/listening/tf/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Listening MCQ -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Listening (MCQ)</div>
        <div class="section-content">
            <div class="card">
                <h3>Pre-Intermediate Listening MCQ</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/listening/mcq/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editListeningMCQ.id}" />
                    <input name="exerciseId" placeholder="Exercise ID" value="${editListeningMCQ.exerciseId}" required />
                    <textarea name="questionText" placeholder="Question" required>${editListeningMCQ.questionText}</textarea>
                    <textarea name="choices" placeholder="Choices (A; B; C; D)" required>${editListeningMCQ.choices}</textarea>
                    <input name="correctAnswer" placeholder="Correct Answer" value="${editListeningMCQ.correctAnswer}" required />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Pre-Intermediate Listening MCQ</h3>
                <table>
                    <tr><th>ID</th><th>Exercise</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${mcq_pre}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.exerciseId}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/listening/mcq/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/listening/mcq/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
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
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Vocabulary</div>
        <div class="section-content">
            <div class="card">
                <h3>Pre-Intermediate Vocabulary Quizzes</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/vocab/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editVocab.id}" />
                    <input name="category" placeholder="Category" value="${editVocab.category}" required />
                    <select name="questionType">
                        <option value="DEFINITION" ${editVocab.questionType == 'DEFINITION' ? 'selected' : ''}>DEFINITION</option>
                        <option value="FILL_IN_BLANK" ${editVocab.questionType == 'FILL_IN_BLANK' ? 'selected' : ''}>FILL_IN_BLANK</option>
                    </select>
                    <textarea name="questionText" placeholder="Question" required>${editVocab.questionText}</textarea>
                    <textarea name="optionA" placeholder="Option A" required>${editVocab.optionA}</textarea>
                    <textarea name="optionB" placeholder="Option B" required>${editVocab.optionB}</textarea>
                    <textarea name="optionC" placeholder="Option C" required>${editVocab.optionC}</textarea>
                    <textarea name="optionD" placeholder="Option D" required>${editVocab.optionD}</textarea>
                    <input name="correctAnswer" placeholder="Correct (A/B/C/D)" value="${editVocab.correctAnswer}" required />
                    <input name="relatedWord" placeholder="Related Word" value="${editVocab.relatedWord}" />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Pre-Intermediate Vocabulary Quizzes</h3>
                <table>
                    <tr><th>ID</th><th>Category</th><th>Question</th><th>Correct</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${vq_pre}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.category}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/vocab/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/preintermediate/vocab/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

    <!-- =============== INTERMEDIATE PANEL =============== -->
    <div id="panel-intermediate" class="panel">
    <!-- Grammar Quiz -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Grammar Quiz</div>
        <div class="section-content">
            <div class="card">
                <h3>Add / Edit Intermediate Grammar Quiz</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editQuiz.id}" />
                    <select name="lessonSlug" required>
                        <option value="">Select Lesson</option>
                        <c:forEach var="slug" items="${intermediateLessons}">
                            <option value="${slug}" ${editQuiz.lessonSlug == slug ? 'selected' : ''}>${slug}</option>
                        </c:forEach>
                    </select>
                    <textarea name="question" placeholder="Question" required>${editQuiz.question}</textarea>
                    <textarea name="options" placeholder="Options (A; B; C; D)" required>${editQuiz.options}</textarea>
                    <input name="answer" placeholder="Answer" value="${editQuiz.answer}" required />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Intermediate Grammar Quizzes</h3>
                <table>
                    <tr><th>ID</th><th>Lesson</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${intermediate}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.lessonSlug}</td>
                            <td>${q.question}</td>
                            <td>${q.answer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Reading Questions -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Reading Questions</div>
        <div class="section-content">
            <div class="card">
                <h3>Intermediate Reading Questions</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/reading/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editReading.id}" />
                    <input name="readingId" placeholder="Reading ID" value="${editReading.readingId}" required />
                    <textarea name="questionText" placeholder="Question" required>${editReading.questionText}</textarea>
                    <textarea name="choices" placeholder="Choices (A; B; C; D)">${editReading.choices}</textarea>
                    <input name="correctAnswer" placeholder="Correct Answer" value="${editReading.correctAnswer}" />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Intermediate Reading Questions</h3>
                <table>
                    <tr><th>ID</th><th>Reading</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${rq_int}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.readingId}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/reading/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/reading/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Listening True/False -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Listening (True/False)</div>
        <div class="section-content">
            <div class="card">
                <h3>Intermediate Listening True/False</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/listening/tf/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editListeningTF.id}" />
                    <input name="exerciseId" placeholder="Exercise ID" value="${editListeningTF.exerciseId}" required />
                    <textarea name="statement" placeholder="Statement" required>${editListeningTF.statement}</textarea>
                    <select name="answer">
                        <option value="True" ${editListeningTF.answer == 'True' ? 'selected' : ''}>True</option>
                        <option value="False" ${editListeningTF.answer == 'False' ? 'selected' : ''}>False</option>
                    </select>
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Intermediate Listening True/False</h3>
                <table>
                    <tr><th>ID</th><th>Exercise</th><th>Statement</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${tf_int}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.exerciseId}</td>
                            <td>${q.statement}</td>
                            <td>${q.answer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/listening/tf/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/listening/tf/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Listening MCQ -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Listening (MCQ)</div>
        <div class="section-content">
            <div class="card">
                <h3>Intermediate Listening MCQ</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/listening/mcq/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editListeningMCQ.id}" />
                    <input name="exerciseId" placeholder="Exercise ID" value="${editListeningMCQ.exerciseId}" required />
                    <textarea name="questionText" placeholder="Question" required>${editListeningMCQ.questionText}</textarea>
                    <textarea name="choices" placeholder="Choices (A; B; C; D)" required>${editListeningMCQ.choices}</textarea>
                    <input name="correctAnswer" placeholder="Correct Answer" value="${editListeningMCQ.correctAnswer}" required />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Intermediate Listening MCQ</h3>
                <table>
                    <tr><th>ID</th><th>Exercise</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${mcq_int}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.exerciseId}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/listening/mcq/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/listening/mcq/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
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
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Vocabulary</div>
        <div class="section-content">
            <div class="card">
                <h3>Intermediate Vocabulary Quizzes</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/vocab/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editVocab.id}" />
                    <input name="category" placeholder="Category" value="${editVocab.category}" required />
                    <select name="questionType">
                        <option value="DEFINITION" ${editVocab.questionType == 'DEFINITION' ? 'selected' : ''}>DEFINITION</option>
                        <option value="FILL_IN_BLANK" ${editVocab.questionType == 'FILL_IN_BLANK' ? 'selected' : ''}>FILL_IN_BLANK</option>
                    </select>
                    <textarea name="questionText" placeholder="Question" required>${editVocab.questionText}</textarea>
                    <textarea name="optionA" placeholder="Option A" required>${editVocab.optionA}</textarea>
                    <textarea name="optionB" placeholder="Option B" required>${editVocab.optionB}</textarea>
                    <textarea name="optionC" placeholder="Option C" required>${editVocab.optionC}</textarea>
                    <textarea name="optionD" placeholder="Option D" required>${editVocab.optionD}</textarea>
                    <input name="correctAnswer" placeholder="Correct (A/B/C/D)" value="${editVocab.correctAnswer}" required />
                    <input name="relatedWord" placeholder="Related Word" value="${editVocab.relatedWord}" />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Intermediate Vocabulary Quizzes</h3>
                <table>
                    <tr><th>ID</th><th>Category</th><th>Question</th><th>Correct</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${vq_int}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.category}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/vocab/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/intermediate/vocab/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</div>

    <!-- =============== ADVANCED PANEL =============== -->
    <div id="panel-advanced" class="panel">
    <!-- Grammar Quiz -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Grammar Quiz</div>
        <div class="section-content">
            <div class="card">
                <h3>Add / Edit Advanced Grammar Quiz</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editQuiz.id}" />
                    <select name="lessonSlug" required>
                        <option value="">Select Lesson</option>
                        <c:forEach var="slug" items="${advancedLessons}">
                            <option value="${slug}" ${editQuiz.lessonSlug == slug ? 'selected' : ''}>${slug}</option>
                        </c:forEach>
                    </select>
                    <textarea name="question" placeholder="Question" required>${editQuiz.question}</textarea>
                    <textarea name="options" placeholder="Options (A; B; C; D)" required>${editQuiz.options}</textarea>
                    <input name="answer" placeholder="Answer" value="${editQuiz.answer}" required />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Advanced Grammar Quizzes</h3>
                <table>
                    <tr><th>ID</th><th>Lesson</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${advanced}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.lessonSlug}</td>
                            <td>${q.question}</td>
                            <td>${q.answer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Reading Questions -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Reading Questions</div>
        <div class="section-content">
            <div class="card">
                <h3>Advanced Reading Questions</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/reading/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editReading.id}" />
                    <input name="readingId" placeholder="Reading ID" value="${editReading.readingId}" required />
                    <textarea name="questionText" placeholder="Question" required>${editReading.questionText}</textarea>
                    <textarea name="choices" placeholder="Choices (A; B; C; D)">${editReading.choices}</textarea>
                    <input name="correctAnswer" placeholder="Correct Answer" value="${editReading.correctAnswer}" />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Advanced Reading Questions</h3>
                <table>
                    <tr><th>ID</th><th>Reading</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${rq_adv}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.readingId}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/reading/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/reading/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Listening True/False -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Listening (True/False)</div>
        <div class="section-content">
            <div class="card">
                <h3>Advanced Listening True/False</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/listening/tf/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editListeningTF.id}" />
                    <input name="exerciseId" placeholder="Exercise ID" value="${editListeningTF.exerciseId}" required />
                    <textarea name="statement" placeholder="Statement" required>${editListeningTF.statement}</textarea>
                    <select name="answer">
                        <option value="True" ${editListeningTF.answer == 'True' ? 'selected' : ''}>True</option>
                        <option value="False" ${editListeningTF.answer == 'False' ? 'selected' : ''}>False</option>
                    </select>
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Advanced Listening True/False</h3>
                <table>
                    <tr><th>ID</th><th>Exercise</th><th>Statement</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${tf_adv}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.exerciseId}</td>
                            <td>${q.statement}</td>
                            <td>${q.answer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/listening/tf/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/listening/tf/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>

    <!-- Listening MCQ -->
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Listening (MCQ)</div>
        <div class="section-content">
            <div class="card">
                <h3>Advanced Listening MCQ</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/listening/mcq/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editListeningMCQ.id}" />
                    <input name="exerciseId" placeholder="Exercise ID" value="${editListeningMCQ.exerciseId}" required />
                    <textarea name="questionText" placeholder="Question" required>${editListeningMCQ.questionText}</textarea>
                    <textarea name="choices" placeholder="Choices (A; B; C; D)" required>${editListeningMCQ.choices}</textarea>
                    <input name="correctAnswer" placeholder="Correct Answer" value="${editListeningMCQ.correctAnswer}" required />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Advanced Listening MCQ</h3>
                <table>
                    <tr><th>ID</th><th>Exercise</th><th>Question</th><th>Answer</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${mcq_adv}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.exerciseId}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/listening/mcq/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/listening/mcq/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
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
    <div class="section">
        <div class="section-header" onclick="toggleSection(this)">Vocabulary</div>
        <div class="section-content">
            <div class="card">
                <h3>Advanced Vocabulary Quizzes</h3>
                <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/vocab/save">
                    <c:if test="${_csrf != null}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </c:if>
                    <input type="hidden" name="id" value="${editVocab.id}" />
                    <input name="category" placeholder="Category" value="${editVocab.category}" required />
                    <select name="questionType">
                        <option value="DEFINITION" ${editVocab.questionType == 'DEFINITION' ? 'selected' : ''}>DEFINITION</option>
                        <option value="FILL_IN_BLANK" ${editVocab.questionType == 'FILL_IN_BLANK' ? 'selected' : ''}>FILL_IN_BLANK</option>
                    </select>
                    <textarea name="questionText" placeholder="Question" required>${editVocab.questionText}</textarea>
                    <textarea name="optionA" placeholder="Option A" required>${editVocab.optionA}</textarea>
                    <textarea name="optionB" placeholder="Option B" required>${editVocab.optionB}</textarea>
                    <textarea name="optionC" placeholder="Option C" required>${editVocab.optionC}</textarea>
                    <textarea name="optionD" placeholder="Option D" required>${editVocab.optionD}</textarea>
                    <input name="correctAnswer" placeholder="Correct (A/B/C/D)" value="${editVocab.correctAnswer}" required />
                    <input name="relatedWord" placeholder="Related Word" value="${editVocab.relatedWord}" />
                    <button class="btn primary" type="submit">Save</button>
                </form>
            </div>
            <div class="card">
                <h3>Advanced Vocabulary Quizzes</h3>
                <table>
                    <tr><th>ID</th><th>Category</th><th>Question</th><th>Correct</th><th>Actions</th></tr>
                    <c:forEach var="q" items="${vq_adv}">
                        <tr>
                            <td>${q.id}</td>
                            <td>${q.category}</td>
                            <td>${q.questionText}</td>
                            <td>${q.correctAnswer}</td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/vocab/edit?id=${q.id}" class="btn edit">Edit</a>
                                <form method="post" action="${pageContext.request.contextPath}/admin/lesson-quizzes/advanced/vocab/delete">
                                    <c:if test="${_csrf != null}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    </c:if>
                                    <input type="hidden" name="id" value="${q.id}"/>
                                    <button class="btn danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
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