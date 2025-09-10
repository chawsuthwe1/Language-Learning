<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Manage Final Tests</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f8d7eb, #caa8f5, #eaefff);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .btn-primary { background: #3498db; color: white; }
        .btn-success { background: #27ae60; color: white; }
        .btn-danger { background: #e74c3c; color: white; }
        .btn-warning { background: #f39c12; color: white; }
        .btn:hover { transform: translateY(-2px); }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .test-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #3498db;
        }
        .test-card.inactive {
            border-left-color: #e74c3c;
            opacity: 0.7;
        }
        .test-actions {
            margin-top: 15px;
        }
        .test-actions a {
            margin-right: 10px;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }
        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 30px;
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
            position: relative;
        }
        .close {
            position: absolute;
            right: 15px;
            top: 15px;
            font-size: 24px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-clipboard-check"></i> Final Tests Management</h1>
            <div>
                <button class="btn btn-primary" onclick="openAddModal()">
                    <i class="fas fa-plus"></i> Add New Test
                </button>
                <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <div class="tests-list">
            <c:forEach var="test" items="${finalTests}">
                <div class="test-card ${test.active ? '' : 'inactive'}">
                    <h3>${test.title}</h3>
                    <p><strong>Description:</strong> ${test.description}</p>
                    <p><strong>Total Questions:</strong> ${test.totalQuestions}</p>
                    <p><strong>Passing Score:</strong> ${test.passingScore}%</p>
                    <p><strong>Status:</strong> 
                        <span class="badge ${test.active ? 'badge-success' : 'badge-danger'}">
                            ${test.active ? 'Active' : 'Inactive'}
                        </span>
                    </p>
                    
                    <div class="test-actions">
                        <a href="${pageContext.request.contextPath}/admin/final-tests/${test.id}/questions" class="btn btn-primary">
                            <i class="fas fa-question-circle"></i> Manage Questions
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/final-tests/${test.id}/results" class="btn btn-success">
                            <i class="fas fa-chart-bar"></i> View Results
                        </a>
                        <button class="btn btn-warning" onclick="openEditModal(${test.id}, '${test.title}', '${test.description}', ${test.totalQuestions}, ${test.passingScore}, ${test.active})">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/final-tests/delete/${test.id}" 
                           class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this test and all its questions?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty finalTests}">
                <div class="text-center" style="padding: 50px;">
                    <i class="fas fa-clipboard-list" style="font-size: 48px; color: #bbb; margin-bottom: 20px;"></i>
                    <h3>No Final Tests Created Yet</h3>
                    <p>Create your first final test to get started.</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Add Test Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeAddModal()">&times;</span>
            <h2>Add New Final Test</h2>
            <form action="${pageContext.request.contextPath}/admin/final-tests/add" method="post">
                <div class="form-group">
                    <label for="title">Test Title:</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label for="totalQuestions">Total Questions:</label>
                    <input type="number" id="totalQuestions" name="totalQuestions" min="1" value="20" required>
                </div>
                <div class="form-group">
                    <label for="passingScore">Passing Score (%):</label>
                    <input type="number" id="passingScore" name="passingScore" min="1" max="100" value="40" required>
                </div>
                <div class="form-group">
                    <label for="active">Status:</label>
                    <select id="active" name="active">
                        <option value="true">Active</option>
                        <option value="false">Inactive</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Create Test</button>
                <button type="button" class="btn btn-secondary" onclick="closeAddModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Edit Test Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Edit Final Test</h2>
            <form id="editForm" method="post">
                <div class="form-group">
                    <label for="editTitle">Test Title:</label>
                    <input type="text" id="editTitle" name="title" required>
                </div>
                <div class="form-group">
                    <label for="editDescription">Description:</label>
                    <textarea id="editDescription" name="description" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label for="editTotalQuestions">Total Questions:</label>
                    <input type="number" id="editTotalQuestions" name="totalQuestions" min="1" required>
                </div>
                <div class="form-group">
                    <label for="editPassingScore">Passing Score (%):</label>
                    <input type="number" id="editPassingScore" name="passingScore" min="1" max="100" required>
                </div>
                <div class="form-group">
                    <label for="editActive">Status:</label>
                    <select id="editActive" name="active">
                        <option value="true">Active</option>
                        <option value="false">Inactive</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Update Test</button>
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function openAddModal() {
            document.getElementById('addModal').style.display = 'block';
        }
        
        function closeAddModal() {
            document.getElementById('addModal').style.display = 'none';
        }
        
        function openEditModal(id, title, description, totalQuestions, passingScore, active) {
            document.getElementById('editTitle').value = title;
            document.getElementById('editDescription').value = description;
            document.getElementById('editTotalQuestions').value = totalQuestions;
            document.getElementById('editPassingScore').value = passingScore;
            document.getElementById('editActive').value = active;
            document.getElementById('editForm').action = '${pageContext.request.contextPath}/admin/final-tests/update/' + id;
            document.getElementById('editModal').style.display = 'block';
        }
        
        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            var addModal = document.getElementById('addModal');
            var editModal = document.getElementById('editModal');
            if (event.target == addModal) {
                addModal.style.display = 'none';
            }
            if (event.target == editModal) {
                editModal.style.display = 'none';
            }
        }
    </script>
</body>
</html>
