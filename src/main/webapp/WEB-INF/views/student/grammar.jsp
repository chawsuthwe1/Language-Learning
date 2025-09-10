<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${lesson.title} - ${level} Grammar</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f4f8;
            line-height: 1.6;
        }
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
        }
        .header {
            background-color: #0ea5e9;
            color: white;
            padding: 2rem;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        .header h1 { font-size: 2.5rem; font-weight: 700; margin-bottom: 0.5rem; }
        .header p { font-size: 1.2rem; opacity: 0.9; margin-bottom: 1rem; }
        .level-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: #7c3aed;
            color: white;
            font-weight: 600;
            border-radius: 999px;
            font-size: 0.9rem;
        }
        .content {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            line-height: 1.8;
            font-size: 1.1rem;
        }
        .content h3 { color: #1e40af; margin: 1.5rem 0 1rem; }
        .content ul { margin-left: 1.5rem; margin-bottom: 1rem; }
        .content li { margin: 0.5rem 0; }
        .content pre {
            background: #f1f5f9;
            padding: 1rem;
            border-radius: 8px;
            overflow-x: auto;
            margin: 1rem 0;
            font-family: monospace;
        }
        .quiz-container {
            display: none;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }
        .quiz-container.active { display: block; }
        .quiz-scroll {
            max-height: 50vh;
            overflow-y: auto;
            padding-right: 0.5rem;
        }
        .quiz-scroll::-webkit-scrollbar {
            width: 6px;
        }
        .quiz-scroll::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 3px;
        }
        .question {
            background: #f8fafc;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            border-left: 4px solid #0ea5e9;
        }
        .question p { margin-bottom: 0.5rem; }
        .options {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }
        .options label {
            display: flex;
            align-items: center;
            background: #f1f3f5;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .options label:hover { background: #e2e8f0; }
        .options input[type="radio"] { margin-right: 0.5rem; }
        .feedback { margin-top: 0.5rem; font-weight: 600; }
        .correct { color: #059669; }
        .incorrect { color: #dc2626; }
        .results {
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
            margin: 1.5rem 0;
            padding: 1rem;
            background: #f1f5f9;
            border-radius: 8px;
            display: none;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            margin: 0 0.5rem;
        }
        .btn-primary { background: #0ea5e9; color: white; }
        .btn-primary:hover { background: #0284c7; transform: translateY(-2px); }
        .btn-success { background: #10b981; color: white; }
        .btn-success:hover { background: #059669; transform: translateY(-2px); }
        .btn-danger { background: #ef4444; color: white; }
        .btn-danger:hover { background: #dc2626; transform: translateY(-2px); }
        .cta-section {
            text-align: center;
            background: #f1f5f9;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        .back-link {
            display: inline-block;
            margin-top: 1rem;
            color: #0ea5e9;
            font-weight: 600;
            text-decoration: none;
        }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${lesson.title}</h1>
            <p>${lesson.description}</p>
            <span class="level-badge">${lesson.level}</span>
        </div>

        <div class="content">
            ${lesson.contentHtml}
        </div>

        <div id="quiz-container" class="quiz-container">
            <h2 class="quiz-title">Interactive Quiz</h2>
            <div id="quiz-content" class="quiz-scroll">
                <c:forEach var="q" items="${quizzes}" varStatus="status">
                    <div class="question" data-answer="${q.answer}">
                        <p><strong>${status.index + 1}.</strong> ${q.question}</p>
                        <div class="options">
                            <c:set var="options" value="${q.options.split(',')}" />
                            <c:forEach var="opt" items="${options}">
                                <label>
                                    <input type="radio" name="question-${status.index}" value="${opt}" />
                                    ${opt}
                                </label>
                            </c:forEach>
                        </div>
                        <div class="feedback" id="feedback-${status.index}"></div>
                    </div>
                </c:forEach>
            </div>
            <div id="quiz-results" class="results"></div>
            <div class="quiz-actions" style="margin-top: 1.5rem; text-align: center;">
                <button id="submit-quiz" type="button" class="btn btn-primary">Submit Answers</button>
                <button id="retry-quiz" type="button" class="btn btn-success" style="display: none;">Retry Quiz</button>
                <button id="close-quiz" type="button" class="btn btn-danger">Close Quiz</button>
            </div>
        </div>

        <div id="cta-section" class="cta-section">
            <h3>Test Your Grammar!</h3>
            <p>Ready to practice? Click the button below to start the quiz.</p>
            <button id="start-exercise" type="button" class="btn btn-primary">Start Exercise</button>
            <div>
                <a href="/student/${level}/grammar" class="back-link">← Back to All Grammar Lessons</a>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const startButton = document.getElementById('start-exercise');
            const closeButton = document.getElementById('close-quiz');
            const submitButton = document.getElementById('submit-quiz');
            const retryButton = document.getElementById('retry-quiz');
            const quizContainer = document.getElementById('quiz-container');
            const quizContent = document.getElementById('quiz-content');
            const quizResults = document.getElementById('quiz-results');
            const ctaSection = document.getElementById('cta-section');

            function resetQuiz() {
                document.querySelectorAll('input[type="radio"]').forEach(radio => {
                    radio.checked = false;
                    radio.disabled = false;
                    radio.closest('.question').querySelector('.feedback').innerHTML = '';
                });
                quizResults.style.display = 'none';
                submitButton.style.display = 'inline-block';
                retryButton.style.display = 'none';
            }

            function submitAnswers() {
                let score = 0;
                let allAnswered = true;

                const questions = quizContent.querySelectorAll('.question');
                questions.forEach((q, index) => {
                    const selected = q.querySelector('input[name="question-' + index + '"]:checked');
                    const feedback = q.querySelector('.feedback');
                    const correctAnswer = q.dataset.answer.trim();
                    feedback.className = 'feedback';

                    if (!selected) {
                        allAnswered = false;
                        feedback.textContent = 'Please answer this question.';
                        feedback.classList.add('incorrect');
                    } else {
                        if (selected.value.trim() === correctAnswer) {
                            score++;
                            feedback.textContent = '✅ Correct!';
                            feedback.classList.add('correct');
                        } else {
                            feedback.textContent = '❌ Incorrect. Correct answer: ' + correctAnswer;
                            feedback.classList.add('incorrect');
                        }
                    }
                });

                if (!allAnswered) {
                    alert("Please answer all questions before submitting.");
                    return;
                }

                // Disable inputs after submission
                document.querySelectorAll('input[type="radio"]').forEach(radio => radio.disabled = true);

                quizResults.textContent = 'You scored ' + score + ' out of ' + questions.length + '!';
                quizResults.style.display = 'block';
                submitButton.style.display = 'none';
                retryButton.style.display = 'inline-block';
            }

            function showQuiz() {
                quizContainer.classList.add('active');
                ctaSection.style.display = 'none';
                resetQuiz();
            }

            function hideQuiz() {
                quizContainer.classList.remove('active');
                ctaSection.style.display = 'block';
                quizResults.style.display = 'none';
            }

            // Event Listeners are now attached once to existing elements
            startButton.addEventListener('click', showQuiz);
            closeButton.addEventListener('click', hideQuiz);
            submitButton.addEventListener('click', submitAnswers);
            retryButton.addEventListener('click', () => {
                resetQuiz();
            });
        });
    </script>
</body>
</html>