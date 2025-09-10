<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Manage Lessons</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --bg: #f4f7fc;
            --card: #ffffff;
            --text: #2c3e50;
            --accent: #3498db;
            --danger: #e74c3c;
            --success: #2ecc71;
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

        h2 {
            margin-bottom: 30px;
            font-size: 28px;
            text-align: center;
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

        .action-btn {
            margin-right: 10px;
            text-decoration: none;
            font-weight: bold;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 14px;
        }

        .edit-btn {
            background-color: var(--success);
            color: white;
        }

        .delete-btn {
            background-color: var(--danger);
            color: white;
        }

        .edit-btn:hover, .delete-btn:hover {
            opacity: 0.8;
        }

        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            font-size: 20px;
            cursor: pointer;
            color: var(--accent);
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: var(--card);
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .modal-content input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .modal-content button {
            background-color: var(--accent);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .close-btn {
            float: right;
            font-size: 18px;
            cursor: pointer;
            color: var(--danger);
        }

        body.dark-mode .modal-content {
            background-color: #2c3e50;
            color: #ecf0f1;
        }
    </style>
</head>
<body>

    <span class="theme-toggle" onclick="toggleTheme()" title="Toggle Theme"><i class="fas fa-adjust"></i></span>

    <h2>📚 Manage Lessons</h2>

    <!-- Insert Form -->
    <div class="form-card">
        <form action="${pageContext.request.contextPath}/admin/lessons/add" method="post">
            <input name="title" placeholder="Lesson Title" required />
            <input name="description" placeholder="Short Description" required />
            <input name="videoUrl" placeholder="Video URL (optional)" />
            <input name="materialPath" placeholder="Material Path (optional)" />
            <button type="submit"><i class="fas fa-plus-circle"></i> Add Lesson</button>
        </form>
    </div>

    <!-- Lessons Table -->
    <div class="table-container">
        <table>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="lesson" items="${lessons}">
                <tr>
                    <td>${lesson.title}</td>
                    <td>${lesson.description}</td>
                    <td>
                        <a class="action-btn edit-btn" onclick="openEditModal('${lesson.id}', '${lesson.title}', '${lesson.description}')">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a class="action-btn delete-btn" href="${pageContext.request.contextPath}/admin/lessons/delete/${lesson.id}" onclick="return confirm('Are you sure you want to delete this lesson?')">
                            <i class="fas fa-trash-alt"></i> Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!-- Update Modal -->
    <div class="modal" id="editModal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeEditModal()">&times;</span>
            <form id="editForm" method="post">
                <input type="hidden" name="id" id="editId" />
                <input type="text" name="title" id="editTitle" placeholder="Lesson Title" required />
                <input type="text" name="description" id="editDescription" placeholder="Short Description" required />
                <button type="submit"><i class="fas fa-save"></i> Update Lesson</button>
            </form>
        </div>
    </div>

    <script>
        function toggleTheme() {
            document.body.classList.toggle("dark-mode");
        }

        function openEditModal(id, title, description) {
            document.getElementById("editId").value = id;
            document.getElementById("editTitle").value = title;
            document.getElementById("editDescription").value = description;
            document.getElementById("editForm").action = "${pageContext.request.contextPath}/admin/lessons/update/" + id;
            document.getElementById("editModal").style.display = "flex";
        }

        function closeEditModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>
</body>
</html>
