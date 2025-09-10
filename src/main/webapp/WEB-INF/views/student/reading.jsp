<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Reading Practice</title>
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
            max-width: 1400px; /* Wider container */
            width: 100%;
            margin: 0 auto;
        }
        h1 {
            text-align: center;
            color: transparent;
            background-clip: text;
            background-image: linear-gradient(to right, #a436f1, #d41e78);
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 2.5rem;
        }
        .card {
            background-color: white;
            border-radius: 12px;
            padding: 2.5rem; /* More padding */
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            max-width: 1000px; /* Wider card */
            margin-left: auto;
            margin-right: auto;
            width: 95%;
        }
        .level {
            font-style: italic;
            color: #666;
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
        }
        .paragraph {
            line-height: 1.8;
            margin-bottom: 2rem;
            font-size: 1.25rem;
            text-align: justify;
        }
        .question {
            margin-top: 2rem;
            font-weight: bold;
            color: #444;
            font-size: 1.3rem;
            margin-bottom: 1rem;
        }
        .choices {
            margin-bottom: 2rem;
        }
        .choices label {
            display: block;
            margin-bottom: 1rem;
            cursor: pointer;
            font-size: 1.2rem;
            padding-left: 2.5rem;
            position: relative;
            line-height: 1.6;
        }
        .choices input[type="radio"] {
            position: absolute;
            left: 0;
            top: 0.3rem;
            width: 1.4rem;
            height: 1.4rem;
            margin-right: 0.5rem;
        }
        .submit-btn {
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            font-size: 1.2em;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .submit-btn:hover {
            background-color: #218838;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }
        .result-message {
            margin-left: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }
        .correct { color: green; }
        .wrong { color: red; }
        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2.5rem;
            max-width: 1000px;
            width: 95%;
            margin-left: auto;
            margin-right: auto;
        }
        .nav-button {
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            text-decoration: none;
            font-size: 1.2em;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .nav-button:hover { 
            background-color: #0056b3; 
            transform: translateY(-2px); 
        }
        .nav-button.disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .back-to-home {
            display: block;
            text-align: center;
            margin-top: 3rem;
            padding: 14px 30px;
            background-color: #c800ff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            max-width: 300px;
            margin-left: auto;
            margin-right: auto;
            font-size: 1.2em;
            transition: all 0.3s ease;
        }
        .back-to-home:hover {
            background-color: #a613cf;
            transform: translateY(-2px);
        }
        .btn.retry {
    background-color: #f59e0b;
    color: white;
    border: none;
    padding: 14px 30px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.2em;
    font-weight: bold;
    transition: all 0.3s ease;
    text-decoration: none;
    display: inline-block;
}

.btn.retry:hover {
    background-color: #d97706;
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(0,0,0,0.15);
}

.btn.retry:active {
    transform: translateY(0);
    box-shadow: none;
}
}
    </style>
</head>
<body>
    <div class="container">
        <h1> Reading Practice</h1>

        <div class="card">
            <!-- Reading Title -->
            <h2>${reading.title}</h2>

            <!-- Level -->
            <p class="level"><strong>Level:</strong> ${reading.level}</p>

            <!-- Paragraph -->
            <p class="paragraph">${reading.paragraph}</p>

            <!-- Questions -->
            <h3>Comprehension Questions:</h3>
            <form method="post" action="/student/${level}/reading/submit">
                <input type="hidden" name="readingId" value="${reading.id}" />
                <input type="hidden" name="page" value="${currentPage}" />

                <c:forEach var="q" items="${questions}">
                    <p class="question">${q.questionText}</p>
                    <div class="choices">
                        <c:forTokens items="${q.choices}" delims=";" var="choice">
                            <label>
                                <input type="radio" 
                                       name="question_${q.id}" 
                                       value="${choice.trim()}" 
                                       required />
                                ${choice.trim()}
                            </label><br/>
                        </c:forTokens>
                    </div>

                    <!-- Show feedback after submission -->
                    <c:if test="${not empty submissionResults and submissionResults[q.id] != null}">
                        <span class="result-message ${submissionResults[q.id].startsWith('✅') ? 'correct' : 'wrong'}">
                            ${submissionResults[q.id]}
                        </span><br/>
                    </c:if>
                </c:forEach>

                <button type="submit" class="submit-btn">Check Answers</button>
				<!-- ✅ Show Retry only after submission -->
                <c:if test="${not empty submissionResults}">
                    <a href="/student/${level}/reading?page=${currentPage}" class="btn retry">Retry</a>
                </c:if>
            </form>
        </div>

        <!-- Navigation -->
        <div class="navigation-buttons">
            <a href="/student/${level}/reading?page=${currentPage - 1}"
               class="nav-button ${currentPage == 0 ? 'disabled' : ''}"
               ${currentPage == 0 ? 'style="pointer-events:none;opacity:0.5"' : ''}>
                ← Previous
            </a>
            <span>Page ${currentPage + 1} of ${totalPages}</span>
            <a href="/student/${level}/reading?page=${currentPage + 1}"
               class="nav-button ${currentPage == totalPages - 1 ? 'disabled' : ''}"
               ${currentPage == totalPages - 1 ? 'style="pointer-events:none;opacity:0.5"' : ''}>
                Next →
            </a>
        </div>

        <!-- Back -->
        <a href="/student/${level}/categories" class="back-to-home">← Back to Categories</a>
    </div>
</body>
</html>