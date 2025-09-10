<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customize Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            padding: 40px;
        }

        .settings-container {
            max-width: 800px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        .settings-container h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .settings-form .form-group {
            margin-bottom: 20px;
        }

        .settings-form label {
            font-weight: bold;
        }

        .settings-form select,
        .settings-form input[type="checkbox"] {
            margin-top: 10px;
        }

        .btn-save {
            display: block;
            margin: 30px auto 0;
            padding: 10px 25px;
            font-weight: bold;
        }

        .btn-secondary {
            background-color: #ecf0f1;
            color: #2c3e50;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #bdc3c7;
        }

        .top-left-nav {
            position: absolute;
            top: 20px;
            left: 20px;
        }
    </style>
</head>
<body>

<div class="top-left-nav">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
    </a>
</div>

<div class="settings-container">
    <h2><i class="fas fa-sliders-h"></i> Customize Dashboard</h2>

    <form action="${pageContext.request.contextPath}/admin/settings" method="post" class="settings-form">
        <div class="form-group">
            <label for="dashboardTitle">Dashboard Title</label>
            <input type="text" id="dashboardTitle" name="dashboardTitle" class="form-control" placeholder="Enter title" required />
        </div>

        <div class="form-group">
            <label for="theme">Theme</label>
            <select id="theme" name="theme" class="form-select">
                <option value="light">🌞 Light</option>
                <option value="dark">🌙 Dark</option>
                <option value="modern">🧊 Modern</option>
            </select>
        </div>

        <div class="form-group">
            <label for="layout">Layout Style</label>
            <select id="layout" name="layout" class="form-select">
                <option value="grid">🔲 Grid</option>
                <option value="list">📋 List</option>
            </select>
        </div>

        <div class="form-group">
            <label>Show Widgets</label><br>
            <input type="checkbox" name="widgetsEnabled" checked> Enable widgets
        </div>

        <div class="form-group">
            <label for="language">Language</label>
            <select id="language" name="language" class="form-select">
                <option value="en">English</option>
                <option value="my">မြန်မာ</option>
            </select>
        </div>

        <button type="submit" class="btn btn-success btn-save">
            <i class="fas fa-save"></i> Save Settings
        </button>
    </form>
</div>
</body>
</html>
