<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vocabulary Quiz: ${category}</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8e3f4, #e0eaff);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
        }
        .container {
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: transparent;
            background-clip: text;
            background-image: linear-gradient(to right, #a436f1, #d41e78);
            margin-bottom: 1rem;
            font-size: 2.5rem;
            font-weight: 700;
        }
        .score-box {
            text-align: center;
            font-size: 1.6rem;
            font-weight: 600;
            margin-bottom: 2rem;
            color: #2e7d32;
        }
        .result-item {
            margin-bottom: 1.8rem;
            padding: 1.4rem;
            background: #f9faff;
            border-radius: 12px;
            border-left: 5px solid #2196F3;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .result-question {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0.8rem;
            color: #1a1a1a;
        }
        .result-options {
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
            margin: 0.8rem 0;
        }
        .option {
            padding: 0.8rem 1.2rem;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.2s;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .option.correct {
            background: #e8f5e9;
            border-color: #4caf50;
            font-weight: 600;
        }
        .option.submitted {
            background: #fff3e0;
            border-color: #ff9800;
            font-weight: 600;
        }
        .feedback {
            margin-top: 0.8rem;
            padding: 0.8rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1rem;
        }
        .feedback.correct {
            background: #e8f5e9;
            color: #2e7d32;
        }
        .feedback.incorrect {
            background: #ffebee;
            color: #c62828;
        }
        .quiz-question {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #1a1a1a;
        }
        .quiz-options {
            display: flex;
            flex-direction: column; /* ← Vertical layout */
            gap: 0.6rem;
            margin: 0.8rem 0;
        }
        .quiz-option {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.8rem 1.2rem;
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s;
            white-space: nowrap;
        }
        .quiz-option:hover {
            background: #e9ecef;
            transform: translateY(-1px);
        }
        .submit-btn {
            display: block;
            width: 100%;
            padding: 14px;
            margin-top: 1.5rem;
            font-size: 1.15rem;
            font-weight: 500;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }
        .submit-btn:hover {
            background: #388E3C;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(76, 175, 80, 0.2);
        }
        .actions {
            text-align: center;
            margin-top: 2.5rem;
        }
        .btn-action {
            display: inline-block;
            background: #c800ff;
            color: white;
            border: none;
            padding: 14px 28px;
            margin: 0 10px;
            font-size: 1.1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-decoration: none;
        }
        .btn-action:hover {
            background: #c800ff;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Vocabulary Quiz: ${category}</h1>

        <!-- Show Results if score is present -->
        <c:if test="${not empty score}">
            <div class="results-section">
                <div class="score-box">
                    You scored ${score} out of ${total}
                </div>

                <c:forEach var="quiz" items="${quizzes}">
                    <div class="result-item">
                        <div class="result-question">${quiz.questionText}</div>
                        <div class="result-options">
                            <div class="option ${param['answer_' += quiz.id] == 'A' ? 'submitted' : ''} ${quiz.correctAnswer == 'A' ? 'correct' : ''}">
                                A: ${quiz.optionA}
                            </div>
                            <div class="option ${param['answer_' += quiz.id] == 'B' ? 'submitted' : ''} ${quiz.correctAnswer == 'B' ? 'correct' : ''}">
                                B: ${quiz.optionB}
                            </div>
                            <div class="option ${param['answer_' += quiz.id] == 'C' ? 'submitted' : ''} ${quiz.correctAnswer == 'C' ? 'correct' : ''}">
                                C: ${quiz.optionC}
                            </div>
                            <div class="option ${param['answer_' += quiz.id] == 'D' ? 'submitted' : ''} ${quiz.correctAnswer == 'D' ? 'correct' : ''}">
                                D: ${quiz.optionD}
                            </div>
                        </div>
                        <div class="feedback ${param['answer_' += quiz.id] == quiz.correctAnswer ? 'correct' : 'incorrect'}">
                            <c:choose>
                                <c:when test="${param['answer_' += quiz.id] == quiz.correctAnswer}">
                                    ✅ Correct! Well done!
                                </c:when>
                                <c:otherwise>
                                    ❌ Incorrect. Correct answer: ${quiz.correctAnswer}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>

                <div class="actions">
                    <a href="/student/${level}/vocabulary-quiz?category=${category}" class="btn-action">Try Again</a>
                    <a href="/student/${level}/vocabulary?category=${category}" class="btn-action">Back to Vocabulary</a>
                </div>
            </div>
        </c:if>

        <!-- Show Quiz Form if no score -->
        <c:if test="${empty score}">
            <form action="/student/${level}/vocabulary-quiz/submit" method="post">
                <c:forEach var="quiz" items="${quizzes}" varStatus="status">
                    <div style="margin-bottom: 2rem;">
                        <p class="quiz-question">
                            ${status.index + 1}. ${quiz.questionText}
                        </p>
                        <div class="quiz-options">
                            <label class="quiz-option">
                                <input type="radio" name="answer_${quiz.id}" value="A" required> A: ${quiz.optionA}
                            </label>
                            <label class="quiz-option">
                                <input type="radio" name="answer_${quiz.id}" value="B" required> B: ${quiz.optionB}
                            </label>
                            <label class="quiz-option">
                                <input type="radio" name="answer_${quiz.id}" value="C" required> C: ${quiz.optionC}
                            </label>
                            <label class="quiz-option">
                                <input type="radio" name="answer_${quiz.id}" value="D" required> D: ${quiz.optionD}
                            </label>
                        </div>
                    </div>
                </c:forEach>

                <input type="hidden" name="category" value="${category}">
                <button type="submit" class="submit-btn">Submit Quiz</button>
            </form>

            <!-- Only show one Back link when taking quiz -->
            <div class="actions">
                <a href="/student/${level}/vocabulary?category=${category}" class="btn-action">← Back to Vocabulary</a>
            </div>
        </c:if>
    </div>
</body>
</html>