<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${level} Vocabulary</title>
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
        h1 {
            text-align: center;
            color: transparent; 
            background-clip: text; 
            background-image: linear-gradient(to right, #a436f1, #d41e78);
            margin-bottom: 2.5rem;
            font-size: 3rem;
            font-weight: 700;
        }
        .container {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
        }
        .category-tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 2rem;
            justify-content: center;
        }
        .category-tab {
            padding: 0.8rem 1.5rem;
            background-color: #f5f5f5;
            border-radius: 999px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
            font-weight: 500;
        }
        .category-tab:hover {
            background-color: #e0e0e0;
        }
        .category-tab.active {
            background-color: #2196F3;
            color: white;
        }
        .vocabulary-category {
            background-color: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }
        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.5rem;
        }
        .category-title {
            font-size: 1.5rem;
            color: #333;
        }
        .word-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1rem;
        }
        .word-card {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 1.5rem;
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        .word-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .word-image {
            width: 120px;
            height: 120px;
            margin-bottom: 1rem;
            object-fit: contain;
        }
        .word {
            font-weight: bold;
            font-size: 1.2rem;
            color: #2196F3;
            margin-bottom: 0.5rem;
        }
        .definition {
            color: #555;
            font-size: 0.95rem;
            line-height: 1.4;
        }
        .example {
            margin-top: 0.5rem;
            font-style: italic;
            color: #777;
            font-size: 0.9rem;
        }
        .take-quiz-button {
            display: block;
            margin: 2rem auto;
            padding: 1rem 2rem;
            font-size: 1.2rem;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }
        .take-quiz-button:hover {
            background-color: #388E3C;
            transform: translateY(-2px);
        }
        .back-to-categories {
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
        .back-to-categories:hover {
            background-color: #c800ff;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Choose A Vocabulary Lesson</h1>

        <!-- Category Tabs -->
        <div class="category-tabs">
            <c:forEach var="entry" items="${wordsByCategory}">
                <c:set var="catId" value="${fn:toLowerCase(entry.key)}" />
                <div class="category-tab ${param.category == catId ? 'active' : ''}"
                     onclick="filterCategory('${catId}')">
                    ${entry.key}
                </div>
            </c:forEach>
        </div>

        <!-- Vocabulary Cards -->
        <c:forEach var="entry" items="${wordsByCategory}">
            <c:set var="catId" value="${fn:toLowerCase(entry.key)}" />
            <c:if test="${param.category == catId || (empty param.category and entry.key == 'Emotions')}">
                <div class="vocabulary-category">
                    <div class="category-header">
                        <h2 class="category-title">${entry.key}</h2>
                        <span>${fn:length(entry.value)} words</span>
                    </div>
                    <div class="word-list">
                        <c:forEach var="word" items="${entry.value}">
                            <div class="word-card">
                                <c:if test="${not empty word.image}">
                                    <img src="${word.image}" alt="${word.word}" class="word-image">
                                </c:if>
                                <div class="word">${word.word}</div>
                                <div class="definition">${word.definition}</div>
                                <div class="example">${word.example}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <!-- Take Quiz Button -->
        <button class="take-quiz-button"
                onclick="window.location.href='/student/${level}/vocabulary-quiz?category=${empty param.category ? 'emotions' : param.category}'">
            Take Quiz
        </button>
    </div>

    <!-- Back to Categories -->
    <a href="/student/${level}/categories" class="back-to-categories">← Back to Categories</a>

    <script>
        function filterCategory(category) {
            const url = new URL(window.location);
            url.searchParams.set('category', category);
            window.location.href = url;
        }
    </script>
</body>
</html>