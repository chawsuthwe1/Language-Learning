<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listening Exercise</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            padding: 2rem;
            background: linear-gradient(135deg, #f8e3f4, #e0eaff);
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
        }

        .main-content {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .card {
            border: none;
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            background-color: #ffffff;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 3rem;
            text-align: center;
            color: transparent;
            background-clip: text;
            background-image: linear-gradient(to right, #a436f1, #d41e78);
            font-weight: 700;
            margin-bottom: 2.5rem;
        }

        h2 {
            margin-top: 0;
            color: #333;
            font-size: 2rem;
            font-weight: 700;
        }

        h3 {
            font-size: 1.8rem;
            color: #444;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }

        /* Collapsible */
        .collapsible-container {
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            overflow: hidden;
        }

        .collapsible-header {
            cursor: pointer;
            padding: 18px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            background-color: #f1f1f1;
            transition: background-color 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .collapsible-header:hover {
            background-color: #e2e2e2;
        }

        .collapsible-header.active .arrow {
            transform: rotate(90deg);
        }

        .arrow {
            width: 24px;
            height: 24px;
            transition: transform 0.3s ease;
        }

        .collapsible-content {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
            background-color: #ffffff;
        }

        .content-inner {
            padding: 1rem;
        }

        .level {
            font-style: italic;
            color: #666;
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
        }

        .audio-container {
            text-align: center;
            margin-bottom: 2rem;
        }

        .audio-container audio {
            width: 100%;
            max-width: 600px;
            border-radius: 8px;
            outline: none;
        }

        .transcript {
            line-height: 1.8;
            font-size: 1.25rem;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 8px;
            max-height: 300px;
            overflow-y: auto;
        }

        /* Scrollable quiz area */
        .quiz-scroll {
            max-height: 50vh;
            overflow-y: auto;
            padding-right: 0.5rem;
            margin-bottom: 1.5rem;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 1rem;
        }

        .quiz-scroll::-webkit-scrollbar {
            width: 6px;
        }

        .quiz-scroll::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 3px;
        }

        .task {
            padding: 1.5rem;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .question-container {
            margin-bottom: 1rem;
            padding: 1rem;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            background-color: white;
        }

        .question {
            font-weight: bold;
            color: #444;
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
        }

        .choices {
            margin-bottom: 1rem;
        }

        .choices label {
            display: block;
            margin-bottom: 12px;
            cursor: pointer;
            font-size: 1.2rem;
            padding: 8px;
            border-radius: 6px;
            transition: background-color 0.2s;
        }

        .choices label:hover {
            background-color: #f0f0f0;
        }

        .choices input[type="radio"] {
            margin-right: 12px;
            transform: scale(1.2);
        }

        .result-message {
            font-weight: bold;
            margin-top: 8px;
            display: block;
            padding: 10px;
            border-radius: 6px;
        }

        .correct {
            color: #28a745;
            background-color: #f0fff4;
        }

        .wrong {
            color: #dc3545;
            background-color: #fff5f5;
        }

        .correct-answer-display {
            font-weight: bold;
            color: #007bff;
            margin-top: 6px;
            font-size: 1.1em;
            display: none;
            padding: 8px;
            background-color: #f0f8ff;
            border-radius: 6px;
        }

        .question-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 0.5rem;
            padding-top: 1rem;
            border-top: 2px solid #eee;
            position: sticky;
            bottom: 0;
            background-color: white;
            z-index: 10;
        }

        .submit-btn, .retry-btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .submit-btn {
            background-color: #28a745;
            color: white;
        }

        .submit-btn:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .retry-btn {
            background-color: #ffc107;
            color: #333;
        }

        .retry-btn:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
        }

        .score-display {
            text-align: center;
            font-size: 1.3rem;
            font-weight: bold;
            margin-top: 20px;
            padding: 15px;
            background-color: #e6f7ff;
            border-radius: 8px;
            display: none;
        }

        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
        }

        .nav-button {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            text-decoration: none;
            font-size: 1.1em;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .nav-button.disabled {
            background-color: #cccccc;
            cursor: not-allowed;
            pointer-events: none;
            opacity: 0.6;
        }

        .back-to-home {
            display: block;
            text-align: center;
            margin-top: 3rem;
            font-size: 1.2em;
            padding: 12px 25px;
            background-color: #c800ff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            max-width: 250px;
            margin-left: auto;
            margin-right: auto;
        }

        .back-to-home:hover {
            background-color: #a613cf;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="main-content">
        <h1>Listening Exercise</h1>

        <c:if test="${not empty error}">
            <p style="color: red; text-align: center;">${error}</p>
        </c:if>

        <c:if test="${not empty listening}">
            <div class="card">
                <h2>${listening.title}</h2>
                <p class="level"><strong>Level:</strong> ${listening.level}</p>

                <div class="audio-container">
                    <audio controls>
                        <source src="${pageContext.request.contextPath}/assets/audio/${listening.audioFile}"
                                type="${listening.audioFile.endsWith('.mp3') ? 'audio/mpeg' : 'audio/mp4'}">
                        Your browser does not support the audio element.
                    </audio>
                </div>

                <!-- Transcript -->
                <div class="collapsible-container">
                    <button class="collapsible-header">
                        Transcript
                        <svg class="arrow" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10l-3.293-3.293a1 1 0 111.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                        </svg>
                    </button>
                    <div class="collapsible-content">
                        <div class="content-inner">
                            <div class="transcript">
                                <p>${listening.transcript}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Task 1: True or False -->
                <div class="collapsible-container">
                    <button class="collapsible-header">
                        Task 1: True or False
                        <svg class="arrow" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10l-3.293-3.293a1 1 0 111.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                        </svg>
                    </button>
                    <div class="collapsible-content">
                        <div class="content-inner">
                            <div class="task" id="task1">
                                <h3>Decide if these statements are True or False.</h3>
                                <div class="quiz-scroll">
                                    <c:forEach var="q" items="${tf}" varStatus="status">
                                        <div class="question-container" data-correct-answer="${q.answer}">
                                            <p class="question">${status.index + 1}. ${q.statement}</p>
                                            <div class="choices">
                                                <label><input type="radio" name="tf_${q.id}" value="true"> True</label>
                                                <label><input type="radio" name="tf_${q.id}" value="false"> False</label>
                                            </div>
                                            <div class="result-message" id="result_tf_${q.id}"></div>
                                            <div class="correct-answer-display"></div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="question-actions">
                                    <button type="button" class="submit-btn" onclick="checkAnswers('task1')">Check Answers</button>
                                    <button type="button" class="retry-btn" onclick="resetTask('task1')">Retry</button>
                                </div>
                                <div class="score-display" id="score-task1"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Task 2: Multiple Choice -->
                <div class="collapsible-container">
                    <button class="collapsible-header">
                        Task 2: Multiple Choice
                        <svg class="arrow" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10l-3.293-3.293a1 1 0 111.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                        </svg>
                    </button>
                    <div class="collapsible-content">
                        <div class="content-inner">
                            <div class="task" id="task2">
                                <h3>Choose the correct answer for each question.</h3>
                                <div class="quiz-scroll">
                                    <c:forEach var="q" items="${mcq}" varStatus="status">
                                        <div class="question-container" data-correct-answer="${q.correctAnswer}">
                                            <p class="question">${status.index + 1}. ${q.questionText}</p>
                                            <div class="choices">
                                                <c:forTokens items="${q.choices}" delims=";" var="choice" varStatus="choiceStatus">
                                                    <label>
                                                        <input type="radio" name="mc_${q.id}" value="${choice}"> 
                                                        ${choice}
                                                    </label>
                                                </c:forTokens>
                                            </div>
                                            <div class="result-message" id="result_mc_${q.id}"></div>
                                            <div class="correct-answer-display"></div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="question-actions">
                                    <button type="button" class="submit-btn" onclick="checkAnswers('task2')">Check Answers</button>
                                    <button type="button" class="retry-btn" onclick="resetTask('task2')">Retry</button>
                                </div>
                                <div class="score-display" id="score-task2"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation -->
                <div class="navigation-buttons">
                    <a href="${pageContext.request.contextPath}/student/${level}/listening?page=${currentPage - 1}"
                       class="nav-button ${currentPage == 0 ? 'disabled' : ''}"
                       ${currentPage == 0 ? 'style="pointer-events: none; opacity: 0.6;"' : ''}>
                        ← Previous
                    </a>
                    <span>Page ${currentPage + 1} of ${totalPages}</span>
                    <a href="${pageContext.request.contextPath}/student/${level}/listening?page=${currentPage + 1}"
                       class="nav-button ${currentPage == totalPages - 1 ? 'disabled' : ''}"
                       ${currentPage == totalPages - 1 ? 'style="pointer-events: none; opacity: 0.6;"' : ''}>
                        Next →
                    </a>
                </div>

                <a href="${pageContext.request.contextPath}/student/${level}/categories" class="back-to-home">
                    ← Back to Categories
                </a>
            </div>
        </c:if>

        <c:if test="${empty listening}">
            <div class="card">
                <h2>Sample Listening Exercise</h2>
                <p class="level"><strong>Level:</strong> Intermediate</p>
                <div class="audio-container">
                    <audio controls>
                        <source src="#" type="audio/mpeg">
                        Your browser does not support the audio element.
                    </audio>
                </div>
                <div class="navigation-buttons">
                    <a href="#" class="nav-button disabled">← Previous</a>
                    <span>Page 1 of 1</span>
                    <a href="#" class="nav-button disabled">Next →</a>
                </div>
                <a href="#" class="back-to-home">← Back to Categories</a>
            </div>
        </c:if>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Handle collapsible sections
            document.querySelectorAll('.collapsible-header').forEach(header => {
                const content = header.nextElementSibling;

                header.addEventListener('click', function () {
                    const isActive = this.classList.toggle('active');
                    if (isActive) {
                        setTimeout(() => {
                            content.style.maxHeight = content.scrollHeight + 'px';
                        }, 10);
                    } else {
                        content.style.maxHeight = null;
                    }
                });
            });
        });

        // ✅ Fixed: Use task ID to get the task container
        function checkAnswers(taskId) {
            const task = document.getElementById(taskId);
            const questions = task.querySelectorAll('.question-container');
            let correctCount = 0;
            let totalQuestions = questions.length;
            let allAnswered = true;

            questions.forEach(q => {
                const selected = q.querySelector('input[type="radio"]:checked');
                const resultEl = q.querySelector('.result-message');
                const correctDisplay = q.querySelector('.correct-answer-display');
                const correctAnswer = q.getAttribute('data-correct-answer')?.trim();

                // Reset
                resultEl.textContent = '';
                resultEl.className = 'result-message';
                correctDisplay.style.display = 'none';

                if (!selected) {
                    allAnswered = false;
                    resultEl.textContent = 'Please select an answer.';
                    resultEl.className = 'result-message wrong';
                } else {
                    const userAnswer = selected.value.trim();
                    if (userAnswer === correctAnswer) {
                        resultEl.textContent = '✅ Correct!';
                        resultEl.className = 'result-message correct';
                        correctCount++;
                    } else {
                        resultEl.textContent = '❌ Incorrect.';
                        resultEl.className = 'result-message wrong';
                        correctDisplay.textContent = 'Correct answer: ' + correctAnswer;
                        correctDisplay.style.display = 'block';
                    }
                }
            });

            if (!allAnswered) {
                alert("Please answer all questions before checking.");
                return;
            }

            const scoreDisplay = document.getElementById(`score-${taskId}`);
            scoreDisplay.textContent = `You scored ${correctCount} out of ${totalQuestions}`;
            scoreDisplay.style.display = 'block';
        }

        function resetTask(taskId) {
            const task = document.getElementById(taskId);
            const questions = task.querySelectorAll('.question-container');

            questions.forEach(q => {
                q.querySelectorAll('input[type="radio"]').forEach(r => r.checked = false);
                q.querySelector('.result-message').textContent = '';
                q.querySelector('.result-message').className = 'result-message';
                const correctDisplay = q.querySelector('.correct-answer-display');
                correctDisplay.textContent = '';
                correctDisplay.style.display = 'none';
            });

            const scoreDisplay = document.getElementById(`score-${taskId}`);
            if (scoreDisplay) {
                scoreDisplay.style.display = 'none';
            }
        }
    </script>
</body>
</html>