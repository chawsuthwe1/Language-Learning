<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${level} Grammar Lessons</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
    body {
        font-family: 'Inter', sans-serif;
        background: #f0f4f8;
        padding: 2rem;
        margin: 0;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
    }
    h1 {
        text-align: center;
        color: #0ea5e9;
        margin-bottom: 2rem;
    }
    .lesson-card {
        background: white;
        padding: 1.5rem;
        margin: 1rem 0;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        transition: transform 0.2s;
    }
    .lesson-card:hover {
        transform: translateY(-3px);
    }
    .lesson-card h3 {
        color: #1e40af;
        margin-bottom: 0.5rem;
    }
    .lesson-card p {
        color: #666;
        margin-bottom: 0.5rem;
    }
    .level-badge {
        background: #7c3aed;
        color: white;
        padding: 0.25rem 0.75rem;
        border-radius: 999px;
        font-size: 0.9rem;
    }
    .btn {
        padding: 0.5rem 1rem;
        background: #0ea5e9;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        margin-top: 1rem;
        display: inline-block;
    }
    /* Updated styles for the back link */
    .back-link {
        display: inline-block; /* Changed to inline-block to allow for padding/margin */
        text-align: center;
        margin-top: 2rem;
        color: #0ea5e9; /* Changed to match primary color */
        text-decoration: none; /* Removed underline by default */
        font-weight: 600; /* Made it bold */
        transition: all 0.3s ease; /* Added a smooth transition for hover effect */
    }
    .back-link:hover {
        text-decoration: underline; /* Underline on hover for user feedback */
        transform: translateY(-2px); /* Slight lift on hover */
    }
</style>
</head>
<body>
    <div class="container">
        <h1> Grammar Lessons</h1>

        <c:choose>
            <c:when test="${not empty lessons}">
                <c:forEach var="lesson" items="${lessons}">
                    <div class="lesson-card">
                        <h3>${lesson.title}</h3>
                        <p>${lesson.description}</p>
                        <span class="level-badge">${lesson.level}</span>
                        <a href="/student/${level}/grammar/${lesson.slug}" class="btn">View Lesson</a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No grammar lessons available for this level.</p>
            </c:otherwise>
        </c:choose>

        <a href="/student/${level}/categories" class="back-link">← Back to Categories</a>
    </div>
</body>
</html>