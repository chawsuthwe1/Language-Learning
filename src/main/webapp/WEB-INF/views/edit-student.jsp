<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Student</title>
     <!-- Font Awesome for eye icon -->
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
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .edit-form {
            max-width: 600px;
            margin: 0 auto;
            background-color: var(--card);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }

        .edit-form label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .edit-form input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .edit-form button {
            background-color: var(--accent);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .edit-form button:hover {
            background-color: #2980b9;
        }

        .cancel-link {
            text-decoration: none;
            color: var(--danger);
            font-weight: bold;
            padding: 12px 24px;
            border-radius: 6px;
            transition: color 0.3s ease;
        }

        .cancel-link:hover {
            color: #c0392b;
        }
        
	    .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #27ae60;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .btn-secondary {
            background-color: #ecf0f1;
            color: #2c3e50;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #bdc3c7;
        }

        .top-left-nav {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        .password-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .password-wrapper input {
            width: 100%;
            padding-right: 40px; /* space for eye icon */
        }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-52%);
            cursor: pointer;
            font-size: 18px;
            color: #bbb;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .toggle-password:hover {
            color: var(--accent);
        }
	        
    </style>
</head>
<body>
    <h2>Edit Student</h2>

    <div class="edit-form">
        <form action="${pageContext.request.contextPath}/admin/students/edit/${student.student_id}" method="post">
            <label for="student_id">Student ID</label>
			<p style="margin-bottom: 20px; font-weight: bold;">${student.student_id}</p>
			<input type="hidden" name="student_id" value="${student.student_id}" />


            <label for="name">Name</label>
            <input type="text" name="name" value="${student.name}" required />

            <label for="email">Email</label>
            <input type="email" name="email" value="${student.email}" required />

             <div class="password-wrapper">
                <input type="password" name="password" id="studentPassword" value="${student.password}" required />
                <i class="fas fa-eye toggle-password" onclick="togglePassword('studentPassword', this)"></i>
            </div>
            <div class="form-actions">
			     <button type="submit" class="btn btn-success">
                    <span style="margin-right: 8px;">✔</span> Update
                </button>
                <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-danger">
                    <span style="margin-right: 8px;">✖</span> Cancel
                </a>
            </div>

        </form>
        </div>
         <div class="top-left-nav">
        <a href="${pageContext.request.contextPath}/admin/students" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back
        </a>

        
    </div>
     <script>
        function togglePassword(inputId, icon) {
            const input = document.getElementById(inputId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>
</body>
</html>
