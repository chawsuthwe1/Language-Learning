<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Choose Level</title>
    <style>
        body{font-family:Arial;margin:40px;background:#f5f7fa}
        .levels{display:flex;gap:20px;flex-wrap:wrap;justify-content:center}
        .level-card{background:white;padding:20px;border-radius:10px;box-shadow:0 2px 10px rgba(0,0,0,0.1);width:200px;text-align:center}
        .level-card h3{margin-top:0}
        .btn{background:#2563eb;color:white;padding:10px 16px;border:none;border-radius:8px;text-decoration:none;display:inline-block;margin-top:10px}
    </style>
</head>
<body>
    <h1>Choose Your Level</h1>
    <div class="levels">
        <div class="level-card">
            <h3>Basic</h3>
            <a href="/student/basic/categories" class="btn">Start Learning</a>
        </div>
        <div class="level-card">
            <h3>Pre-Intermediate</h3>
            <a href="/student/preintermediate/categories" class="btn">Start Learning</a>
        </div>
        <div class="level-card">
            <h3>Intermediate</h3>
            <a href="/student/intermediate/categories" class="btn">Start Learning</a>
        </div>
        <div class="level-card">
            <h3>Advanced</h3>
            <a href="/student/advanced/categories" class="btn">Start Learning</a>
        </div>
    </div>
</body>
</html>