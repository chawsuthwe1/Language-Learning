<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>


<html>
<head>
    <title>Manage Students</title>
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
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .table-container {
            max-width: 1000px;
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
            text-decoration: none;
            font-weight: bold;
            margin-right: 10px;
            padding: 6px 12px;
            border-radius: 6px;
            transition: background 0.3s ease;
        }

        .edit-btn {
            background-color: var(--accent);
            color: white;
        }

        .edit-btn:hover {
            background-color: #2980b9;
        }

        .delete-btn {
            background-color: var(--danger);
            color: white;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            font-size: 20px;
            cursor: pointer;
            color: var(--accent);
        }

        .add-user-form {
            max-width: 600px;
            margin: 0 auto 40px;
            background-color: var(--card);
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .add-user-form input {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .add-user-form button {
            background-color: var(--success);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .add-user-form button:hover {
            background-color: #27ae60;
        }
        
        .top-left-nav {
		    position: absolute;
		    top: 20px;
		    left: 20px;
		    z-index: 1000;
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
		
		.header-nav {
	    display: flex;
	    justify-content: flex-start;
	    padding: 20px;
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

    <span class="theme-toggle" onclick="toggleTheme()" title="Toggle Theme"><i class="fas fa-adjust"></i></span>

    <h2>👥 Manage Students</h2>

     <!-- Add Student Form -->
	<div class="add-user-form">
	    <form action="${pageContext.request.contextPath}/admin/students/add" method="post" autocomplete="off">
	        <input type="number" name="studentId" placeholder="Student ID" required autocomplete="off" />
	        <input type="text" name="name" placeholder="Name" required autocomplete="off" />
	        <input type="email" name="email" placeholder="Email" required autocomplete="off" />
	
	        <!-- Hidden dummy password field to prevent autofill -->
	        <input type="password" style="display:none" />
	
	        <!-- Password field with show/hide toggle -->
	        <div class="password-wrapper">
	            <input type="password" name="password" placeholder="Password" id="studentPassword" required autocomplete="new-password" />
	        </div>
	
	        <button type="submit"><i class="fas fa-user-graduate"></i> Add Student</button>
	    </form>
	</div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td>${student.student_id}</td>
                        <td>${student.name}</td>
                        <td>${student.email}</td>
                        <td>${student.password}</td>
                        <td>
                            <a class="action-btn edit-btn" href="${pageContext.request.contextPath}/admin/students/edit/${student.student_id}">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a class="action-btn delete-btn" href="${pageContext.request.contextPath}/admin/students/delete/${student.student_id}">
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

<div class="top-left-nav">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
    </a>
</div>

</html>
