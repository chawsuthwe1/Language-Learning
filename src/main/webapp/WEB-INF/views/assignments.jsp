<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Assignments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --bg: #f4f7fc;
            --card: #ffffff;
            --text: #2c3e50;
            --accent: #3498db;
            --danger: #e74c3c;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            padding: 40px;
            transition: background 0.3s ease, color 0.3s ease;
        }

        body.dark-mode {
            background-color: #1e1e2f;
            color: #ecf0f1;
        }

        h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .form-card {
            background-color: var(--card);
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto 40px;
        }

        .form-card input {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-card button {
            background-color: var(--accent);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .form-card button:hover {
            background-color: #2980b9;
        }

        .table-container {
            max-width: 900px;
            margin: 0 auto;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--card);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #ecf0f1;
            font-weight: bold;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .delete-btn {
            color: var(--danger);
            text-decoration: none;
            font-weight: bold;
        }

        .delete-btn:hover {
            text-decoration: underline;
        }

        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            font-size: 20px;
            cursor: pointer;
            color: var(--accent);
        }
    </style>
</head>
<body>

    <span class="theme-toggle" onclick="toggleTheme()" title="Toggle Theme"><i class="fas fa-adjust"></i></span>

    <h1>📂 Manage Assignments</h1>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/assignments/add" method="post">
            <input type="text" name="title" placeholder="Assignment Title" required />
            <input type="text" name="description" placeholder="Short Description" required />
            <input type="number" name="lessonId" placeholder="Linked Lesson ID" required />
            <button type="submit"><i class="fas fa-plus-circle"></i> Add Assignment</button>
        </form>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Lesson ID</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="assignment" items="${assignments}">
                    <tr>
                        <td>${assignment.title}</td>
                        <td>${assignment.description}</td>
                        <td>${assignment.lessonId}</td>
                        <td>
                            <a class="delete-btn" href="${pageContext.request.contextPath}/assignments/delete/${assignment.id}">
                                <i class="fas fa-trash-alt"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        function toggleTheme() {
            document.body.classList.toggle("dark-mode");
        }
    </script>
</body>
</html>
