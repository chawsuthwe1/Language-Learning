<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lesson Quizzes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminstyle.css" />
    <style>
        .tabs{display:flex;gap:10px;margin:10px 0}
        .tab{padding:10px 16px;border-radius:8px;background:#f0f3f6;cursor:pointer}
        .tab.active{background:#111827;color:#fff}
        .panel{display:none}
        .panel.active{display:block}
        .grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
        .card{background:#fff;border:1px solid #e5e7eb;border-radius:10px;padding:16px}
        table{width:100%;border-collapse:collapse}
        th,td{padding:10px;border-bottom:1px solid #eee;text-align:left}
        form.inline{display:flex;gap:8px;flex-wrap:wrap}
        input,textarea,select{width:100%;padding:8px;border:1px solid #d1d5db;border-radius:8px}
        .actions{display:flex;gap:8px}
        .btn{padding:8px 12px;border-radius:8px;border:0;cursor:pointer}
        .btn.primary{background:#2563eb;color:#fff}
        .btn.danger{background:#ef4444;color:#fff}
        .btn.edit{background:#f59e0b;color:#fff}
        body{background:#f8fafc;font-family:Inter,system-ui,-apple-system}
    </style>
</head>
<body>

<h2>Lesson Quizzes</h2>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
    <div style="background:#d1fae5;color:#065f46;padding:12px;border-radius:8px;margin:20px 0;">
        ${message}
    </div>
</c:if>
<c:if test="${not empty error}">
    <div style="background:#fee2e2;color:#b91c1c;padding:12px;border-radius:8px;margin:20px 0;">
        ${error}
    </div>
</c:if>

<!-- Tabs with onclick -->
<div class="tabs">
    <div id="tab-basic" class="tab" onclick="showTab('basic')">Basic</div>
    <div id="tab-preintermediate" class="tab" onclick="showTab('preintermediate')">Pre-Intermediate</div>
    <div id="tab-intermediate" class="tab" onclick="showTab('intermediate')">Intermediate</div>
    <div id="tab-advanced" class="tab" onclick="showTab('advanced')">Advanced</div>
</div>

<!-- =============== BASIC PANEL =============== -->
<div id="panel-basic" class="panel">
    <div class="grid">
        <!-- Grammar Quiz -->
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

        <!-- Reading Questions -->
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

        <!-- Listening True/False -->
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

        <!-- Listening MCQ -->
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

        <!-- Vocabulary -->
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

<!-- =============== PRE-INTERMEDIATE PANEL =============== -->
<div id="panel-preintermediate" class="panel">
    <div class="grid">
        <!-- Grammar -->
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

        <!-- Reading -->
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

        <!-- Listening True/False -->
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

        <!-- Listening MCQ -->
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

        <!-- Vocabulary -->
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

<!-- =============== INTERMEDIATE PANEL =============== -->
<div id="panel-intermediate" class="panel">
    <div class="grid">
        <!-- Grammar -->
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

        <!-- Reading -->
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

        <!-- Listening True/False -->
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

        <!-- Listening MCQ -->
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

        <!-- Vocabulary -->
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

<!-- =============== ADVANCED PANEL =============== -->
<div id="panel-advanced" class="panel">
    <div class="grid">
        <!-- Grammar -->
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

        <!-- Reading -->
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

        <!-- Listening True/False -->
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

        <!-- Listening MCQ -->
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

        <!-- Vocabulary -->
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

<script>
// Tab switching
function showTab(id) {
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
    }
}

// Restore tab after edit
window.addEventListener('DOMContentLoaded', () => {
    const editLevel = '${editLevel}';
    showTab(editLevel || 'basic');
});
</script>

</body>
</html>