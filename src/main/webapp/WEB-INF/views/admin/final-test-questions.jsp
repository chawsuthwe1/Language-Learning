<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Manage Questions - ${finalTest.title}</title>
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
            max-width: 1400px;
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
        .session-tabs {
            display: flex;
            margin-bottom: 30px;
            border-bottom: 1px solid #ddd;
        }
        .session-tab {
            padding: 15px 25px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
            font-weight: bold;
        }
        .session-tab.active {
            border-bottom-color: #3498db;
            color: #3498db;
        }
        .session-content {
            display: none;
        }
        .session-content.active {
            display: block;
        }
        .question-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid #3498db;
        }
        .question-options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin: 15px 0;
        }
        .option {
            padding: 8px 12px;
            background: #e9ecef;
            border-radius: 5px;
            font-size: 14px;
        }
        .option.correct {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            font-weight: bold;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: all 0.3s ease;
            margin-right: 10px;
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
            margin: 2% auto;
            padding: 30px;
            width: 90%;
            max-width: 800px;
            border-radius: 10px;
            position: relative;
            max-height: 90vh;
            overflow-y: auto;
        }
        .close {
            position: absolute;
            right: 15px;
            top: 15px;
            font-size: 24px;
            cursor: pointer;
        }
        .add-question-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #27ae60;
            color: white;
            border: none;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }
        .add-question-btn:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div>
                <h1><i class="fas fa-question-circle"></i> ${finalTest.title} - Questions</h1>
                <p style="margin: 5px 0; color: #666;">${finalTest.description}</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/final-tests" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Tests
                </a>
            </div>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <div class="session-tabs" style="flex: 1;">
                <div class="session-tab active" onclick="showSession(1)">
                    <i class="fas fa-play-circle"></i> Session 1 (${session1Questions.size()} questions)
                </div>
                <div class="session-tab" onclick="showSession(2)">
                    <i class="fas fa-play-circle"></i> Session 2 (${session2Questions.size()} questions)
                </div>
                <div class="session-tab" onclick="showSession(3)">
                    <i class="fas fa-play-circle"></i> Session 3 (${session3Questions.size()} questions)
                </div>
                <div class="session-tab" onclick="showSession(4)">
                    <i class="fas fa-play-circle"></i> Session 4 (${session4Questions.size()} questions)
                </div>
            </div>
            <button class="btn btn-success" onclick="openAddModal()" style="margin-left: 20px;">
                <i class="fas fa-plus"></i> Add Question
            </button>
        </div>

        <!-- Session 1 -->
        <div id="session1" class="session-content active">
            <h3>Session 1 Questions</h3>
            <c:forEach var="question" items="${session1Questions}">
                <div class="question-card">
                    <h4>Q: ${question.question}</h4>
                    <div class="question-options">
                        <div class="option ${question.correctAnswer == 'A' ? 'correct' : ''}">A) ${question.optionA}</div>
                        <div class="option ${question.correctAnswer == 'B' ? 'correct' : ''}">B) ${question.optionB}</div>
                        <div class="option ${question.correctAnswer == 'C' ? 'correct' : ''}">C) ${question.optionC}</div>
                        <div class="option ${question.correctAnswer == 'D' ? 'correct' : ''}">D) ${question.optionD}</div>
                    </div>
                    <div style="margin-top: 15px;">
                        <span class="badge">Difficulty: ${question.difficulty}</span>
                        <span class="badge">Correct Answer: ${question.correctAnswer}</span>
                    </div>
                    <div style="margin-top: 15px;">
                        <button class="btn btn-warning edit-btn" 
                                data-id="${question.id}"
                                data-question="${question.question}"
                                data-option-a="${question.optionA}"
                                data-option-b="${question.optionB}"
                                data-option-c="${question.optionC}"
                                data-option-d="${question.optionD}"
                                data-correct="${question.correctAnswer}"
                                data-session="${question.sessionNumber}"
                                data-difficulty="${question.difficulty}">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/final-tests/questions/delete/${question.id}" 
                           class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this question?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty session1Questions}">
                <p style="text-align: center; color: #666; padding: 50px;">No questions added for Session 1 yet.</p>
            </c:if>
        </div>

        <!-- Session 2 -->
        <div id="session2" class="session-content">
            <h3>Session 2 Questions</h3>
            <c:forEach var="question" items="${session2Questions}">
                <div class="question-card">
                    <h4>Q: ${question.question}</h4>
                    <div class="question-options">
                        <div class="option ${question.correctAnswer == 'A' ? 'correct' : ''}">A) ${question.optionA}</div>
                        <div class="option ${question.correctAnswer == 'B' ? 'correct' : ''}">B) ${question.optionB}</div>
                        <div class="option ${question.correctAnswer == 'C' ? 'correct' : ''}">C) ${question.optionC}</div>
                        <div class="option ${question.correctAnswer == 'D' ? 'correct' : ''}">D) ${question.optionD}</div>
                    </div>
                    <div style="margin-top: 15px;">
                        <span class="badge">Difficulty: ${question.difficulty}</span>
                        <span class="badge">Correct Answer: ${question.correctAnswer}</span>
                    </div>
                    <div style="margin-top: 15px;">
                        <button class="btn btn-warning edit-btn" 
                                data-id="${question.id}"
                                data-question="${question.question}"
                                data-option-a="${question.optionA}"
                                data-option-b="${question.optionB}"
                                data-option-c="${question.optionC}"
                                data-option-d="${question.optionD}"
                                data-correct="${question.correctAnswer}"
                                data-session="${question.sessionNumber}"
                                data-difficulty="${question.difficulty}">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/final-tests/questions/delete/${question.id}" 
                           class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this question?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty session2Questions}">
                <p style="text-align: center; color: #666; padding: 50px;">No questions added for Session 2 yet.</p>
            </c:if>
        </div>

        <!-- Session 3 -->
        <div id="session3" class="session-content">
            <h3>Session 3 Questions</h3>
            <c:forEach var="question" items="${session3Questions}">
                <div class="question-card">
                    <h4>Q: ${question.question}</h4>
                    <div class="question-options">
                        <div class="option ${question.correctAnswer == 'A' ? 'correct' : ''}">A) ${question.optionA}</div>
                        <div class="option ${question.correctAnswer == 'B' ? 'correct' : ''}">B) ${question.optionB}</div>
                        <div class="option ${question.correctAnswer == 'C' ? 'correct' : ''}">C) ${question.optionC}</div>
                        <div class="option ${question.correctAnswer == 'D' ? 'correct' : ''}">D) ${question.optionD}</div>
                    </div>
                    <div style="margin-top: 15px;">
                        <span class="badge">Difficulty: ${question.difficulty}</span>
                        <span class="badge">Correct Answer: ${question.correctAnswer}</span>
                    </div>
                    <div style="margin-top: 15px;">
                        <button class="btn btn-warning edit-btn" 
                                data-id="${question.id}"
                                data-question="${question.question}"
                                data-option-a="${question.optionA}"
                                data-option-b="${question.optionB}"
                                data-option-c="${question.optionC}"
                                data-option-d="${question.optionD}"
                                data-correct="${question.correctAnswer}"
                                data-session="${question.sessionNumber}"
                                data-difficulty="${question.difficulty}">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/final-tests/questions/delete/${question.id}" 
                           class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this question?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty session3Questions}">
                <p style="text-align: center; color: #666; padding: 50px;">No questions added for Session 3 yet.</p>
            </c:if>
        </div>

        <!-- Session 4 -->
        <div id="session4" class="session-content">
            <h3>Session 4 Questions</h3>
            <c:forEach var="question" items="${session4Questions}">
                <div class="question-card">
                    <h4>Q: ${question.question}</h4>
                    <div class="question-options">
                        <div class="option ${question.correctAnswer == 'A' ? 'correct' : ''}">A) ${question.optionA}</div>
                        <div class="option ${question.correctAnswer == 'B' ? 'correct' : ''}">B) ${question.optionB}</div>
                        <div class="option ${question.correctAnswer == 'C' ? 'correct' : ''}">C) ${question.optionC}</div>
                        <div class="option ${question.correctAnswer == 'D' ? 'correct' : ''}">D) ${question.optionD}</div>
                    </div>
                    <div style="margin-top: 15px;">
                        <span class="badge">Difficulty: ${question.difficulty}</span>
                        <span class="badge">Correct Answer: ${question.correctAnswer}</span>
                    </div>
                    <div style="margin-top: 15px;">
                        <button class="btn btn-warning edit-btn" 
                                data-id="${question.id}"
                                data-question="${question.question}"
                                data-option-a="${question.optionA}"
                                data-option-b="${question.optionB}"
                                data-option-c="${question.optionC}"
                                data-option-d="${question.optionD}"
                                data-correct="${question.correctAnswer}"
                                data-session="${question.sessionNumber}"
                                data-difficulty="${question.difficulty}">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/final-tests/questions/delete/${question.id}" 
                           class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this question?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty session4Questions}">
                <p style="text-align: center; color: #666; padding: 50px;">No questions added for Session 4 yet.</p>
            </c:if>
        </div>
    </div>

    <!-- Floating Add Button -->
    <button class="add-question-btn" onclick="openAddModal()" title="Add New Question">
        <i class="fas fa-plus"></i>
    </button>

    <!-- Add Question Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeAddModal()">&times;</span>
            <h2>Add New Question</h2>
            <form action="${pageContext.request.contextPath}/admin/final-tests/${finalTest.id}/questions/add" method="post">
                <div class="form-group">
                    <label for="question">Question:</label>
                    <textarea id="question" name="question" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="optionA">Option A:</label>
                    <input type="text" id="optionA" name="optionA" required>
                </div>
                <div class="form-group">
                    <label for="optionB">Option B:</label>
                    <input type="text" id="optionB" name="optionB" required>
                </div>
                <div class="form-group">
                    <label for="optionC">Option C:</label>
                    <input type="text" id="optionC" name="optionC" required>
                </div>
                <div class="form-group">
                    <label for="optionD">Option D:</label>
                    <input type="text" id="optionD" name="optionD" required>
                </div>
                <div class="form-group">
                    <label for="correctAnswer">Correct Answer:</label>
                    <select id="correctAnswer" name="correctAnswer" required>
                        <option value="">Select correct answer</option>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="sessionNumber">Session Number:</label>
                    <select id="sessionNumber" name="sessionNumber" required>
                        <option value="1">Session 1</option>
                        <option value="2">Session 2</option>
                        <option value="3">Session 3</option>
                        <option value="4">Session 4</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="difficulty">Difficulty:</label>
                    <select id="difficulty" name="difficulty">
                        <option value="Easy">Easy</option>
                        <option value="Medium" selected>Medium</option>
                        <option value="Hard">Hard</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Add Question</button>
                <button type="button" class="btn btn-secondary" onclick="closeAddModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Edit Question Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeEditModal()">&times;</span>
            <h2>Edit Question</h2>
            <form id="editForm" method="post">
                <div class="form-group">
                    <label for="editQuestion">Question:</label>
                    <textarea id="editQuestion" name="question" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="editOptionA">Option A:</label>
                    <input type="text" id="editOptionA" name="optionA" required>
                </div>
                <div class="form-group">
                    <label for="editOptionB">Option B:</label>
                    <input type="text" id="editOptionB" name="optionB" required>
                </div>
                <div class="form-group">
                    <label for="editOptionC">Option C:</label>
                    <input type="text" id="editOptionC" name="optionC" required>
                </div>
                <div class="form-group">
                    <label for="editOptionD">Option D:</label>
                    <input type="text" id="editOptionD" name="optionD" required>
                </div>
                <div class="form-group">
                    <label for="editCorrectAnswer">Correct Answer:</label>
                    <select id="editCorrectAnswer" name="correctAnswer" required>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editSessionNumber">Session Number:</label>
                    <select id="editSessionNumber" name="sessionNumber" required>
                        <option value="1">Session 1</option>
                        <option value="2">Session 2</option>
                        <option value="3">Session 3</option>
                        <option value="4">Session 4</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editDifficulty">Difficulty:</label>
                    <select id="editDifficulty" name="difficulty">
                        <option value="Easy">Easy</option>
                        <option value="Medium">Medium</option>
                        <option value="Hard">Hard</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Update Question</button>
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
            </form>
        </div>
    </div>

    <script>
        function showSession(sessionNum) {
            // Hide all sessions
            document.querySelectorAll('.session-content').forEach(content => {
                content.classList.remove('active');
            });
            document.querySelectorAll('.session-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Show selected session
            document.getElementById('session' + sessionNum).classList.add('active');
            document.querySelectorAll('.session-tab')[sessionNum - 1].classList.add('active');
        }

        function openAddModal() {
            document.getElementById('addModal').style.display = 'block';
        }
        
        function closeAddModal() {
            document.getElementById('addModal').style.display = 'none';
        }
        
        // Add event listeners for edit buttons
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.edit-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const id = this.getAttribute('data-id');
                    const question = this.getAttribute('data-question');
                    const optionA = this.getAttribute('data-option-a');
                    const optionB = this.getAttribute('data-option-b');
                    const optionC = this.getAttribute('data-option-c');
                    const optionD = this.getAttribute('data-option-d');
                    const correctAnswer = this.getAttribute('data-correct');
                    const sessionNumber = this.getAttribute('data-session');
                    const difficulty = this.getAttribute('data-difficulty');
                    
                    openEditModal(id, question, optionA, optionB, optionC, optionD, correctAnswer, sessionNumber, difficulty);
                });
            });
        });
        
        function openEditModal(id, question, optionA, optionB, optionC, optionD, correctAnswer, sessionNumber, difficulty) {
            document.getElementById('editQuestion').value = question;
            document.getElementById('editOptionA').value = optionA;
            document.getElementById('editOptionB').value = optionB;
            document.getElementById('editOptionC').value = optionC;
            document.getElementById('editOptionD').value = optionD;
            document.getElementById('editCorrectAnswer').value = correctAnswer;
            document.getElementById('editSessionNumber').value = sessionNumber;
            document.getElementById('editDifficulty').value = difficulty;
            document.getElementById('editForm').action = '${pageContext.request.contextPath}/admin/final-tests/questions/update/' + id;
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
