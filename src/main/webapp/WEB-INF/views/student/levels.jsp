<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Learning Path • LinguaFem</title>
    <link rel="preconnect" href="https://fonts.googleapis.com  ">
    <link rel="preconnect" href="https://fonts.gstatic.com  " crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --radius: 20px;
            --shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            --gradient-bg: linear-gradient(145deg, #f0e4ff, #e0f2ff);
            --gradient-text: linear-gradient(90deg, #6c5ce7, #d41e78);
            --card-bg: #ffffff;
            --btn-primary: linear-gradient(90deg, #6c5ce7, #a436f1);
            --btn-locked: #e9ecef;
            --btn-locked-text: #adb5bd;
            --text-color: #2c3e50;
            --secondary-text: #7f8c8d;
        }

        body {
            margin: 0;
            padding: 4rem 2rem;
            background: var(--gradient-bg);
            color: var(--text-color);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            width: 100%;
            margin: 0 auto;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background-image: var(--gradient-text);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .intro-text, .current-level {
            font-size: 1.1rem;
            color: var(--secondary-text);
            margin-bottom: 2.5rem;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }

        .levels-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        }

        .level-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 2.5rem 1.5rem;
            box-shadow: var(--shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .level-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
        }

        .level-card h3 {
            font-size: 1.7rem;
            margin: 0 0 0.5rem 0;
            font-weight: 600;
            background-image: var(--gradient-text);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .level-card .subtitle {
            font-size: 0.95rem;
            color: #888;
            margin-bottom: 1.5rem;
            font-style: italic;
        }

        .level-desc {
            font-size: 1rem;
            color: var(--secondary-text);
            margin: 1rem 0 2rem;
            flex-grow: 1;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            color: white;
            border: none;
            text-align: center;
        }

        .btn-primary {
            background: var(--btn-primary);
            box-shadow: 0 8px 20px rgba(108, 92, 231, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(108, 92, 231, 0.4);
        }

        .btn-locked {
            background: var(--btn-locked);
            color: var(--btn-locked-text);
            cursor: not-allowed;
        }

        .btn-locked:hover {
            transform: none;
        }

        /* ✅ New: Back to Dashboard Button */
        .back-to-dashboard {
            margin-top: 3rem;
            display: inline-block;
            padding: 12px 32px;
            background: #6c5ce7;
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            box-shadow: 0 8px 20px rgba(108, 92, 231, 0.4);
            transition: all 0.3s ease;
            width: fit-content;
        }

        .back-to-dashboard:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(108, 92, 231, 0.5);
            background: #5a4bcf;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Learning Path</h1>
        <p class="intro-text">
            Welcome to your language journey! Below are the levels you can master. Each step builds on the last, so you can learn at your own pace and achieve fluency. Your progress is always saved, so you can pick up right where you left off.
        </p>

        <p class="current-level">You're currently at <strong>${sessionScope.student.level}</strong> level. Complete this level to unlock the next!</p>

        <div class="levels-grid">
            <div class="level-card">
                <div>
                    <h3>Beginner</h3>
                    <p class="subtitle">Take your first step</p>
                    <div class="level-desc">
                        Start with everyday words and simple sentences.
                    </div>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.student.level == 'Beginner'||sessionScope.student.level == 'Pre-Intermediate' || sessionScope.student.level == 'Intermediate' || sessionScope.student.level == 'Advanced'}">
                        <a href="/student/basic/categories" class="btn btn-primary">Start Learning</a>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-locked" disabled>Locked</button>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="level-card">
                <div>
                    <h3>Pre-Intermediate</h3>
                    <p class="subtitle">Build on your foundation</p>
                    <div class="level-desc">
                        Build on basics with real-life conversations.
                    </div>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.student.level == 'Pre-Intermediate' || sessionScope.student.level == 'Intermediate' || sessionScope.student.level == 'Advanced'}">
                        <a href="/student/preintermediate/categories" class="btn btn-primary">Start Learning</a>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-locked" disabled>Locked</button>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="level-card">
                <div>
                    <h3>Intermediate</h3>
                    <p class="subtitle">Master fluent conversation</p>
                    <div class="level-desc">
                        Understand longer texts and express opinions.
                    </div>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.student.level == 'Intermediate' || sessionScope.student.level == 'Advanced'}">
                        <a href="/student/intermediate/categories" class="btn btn-primary">Start Learning</a>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-locked" disabled>Locked</button>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="level-card">
                <div>
                    <h3>Advanced</h3>
                    <p class="subtitle">Express yourself expertly</p>
                    <div class="level-desc">
                        Master idioms and nuanced expressions.
                    </div>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.student.level == 'Advanced'}">
                        <a href="/student/advanced/categories" class="btn btn-primary">Start Learning</a>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-locked" disabled>Locked</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ✅ Back to Dashboard Button -->
        <a href="${pageContext.request.contextPath}/student-dashboard" class="back-to-dashboard">
            ← Back to Dashboard
        </a>
    </div>
</body>
</html>