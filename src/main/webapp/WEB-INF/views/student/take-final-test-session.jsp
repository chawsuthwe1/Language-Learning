<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Final Test - Session ${currentSession} - ${finalTest.title}</title>
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
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .test-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e9ecef;
            border-radius: 4px;
            margin: 20px 0;
            overflow: hidden;
        }
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #3498db, #2980b9);
            transition: width 0.3s ease;
        }
        .session-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8f9fa;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .question-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 25px;
            border-left: 4px solid #3498db;
        }
        .question-number {
            background: #3498db;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .question-text {
            font-size: 1.1em;
            font-weight: 500;
            margin-bottom: 20px;
            line-height: 1.5;
        }
        .options {
            display: grid;
            gap: 12px;
        }
        .option {
            display: flex;
            align-items: center;
            padding: 15px;
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .option:hover {
            border-color: #3498db;
            background: #f8f9fa;
        }
        .option.selected {
            border-color: #3498db;
            background: #e3f2fd;
        }
        .option input[type="radio"] {
            margin-right: 12px;
            transform: scale(1.2);
        }
        .option-label {
            font-weight: bold;
            margin-right: 10px;
            color: #3498db;
        }
        .navigation {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .btn-primary { 
            background: linear-gradient(135deg, #3498db, #2980b9); 
            color: white; 
        }
        .btn-success { 
            background: linear-gradient(135deg, #27ae60, #229954); 
            color: white; 
        }
        .btn-secondary { 
            background: #6c757d; 
            color: white; 
        }
        .btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .timer {
            position: fixed;
            top: 20px;
            right: 20px;
            background: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            font-weight: bold;
            color: #3498db;
        }
        .warning-box {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 15px;
            margin: 20px 0;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="timer">
        <i class="fas fa-clock"></i> Session ${currentSession} of ${totalSessions}
    </div>

    <div class="container">
        <div class="test-header">
            <h1>${finalTest.title}</h1>
            <h2>Session ${currentSession}</h2>
        </div>

        <div class="session-info">
            <div>
                <strong>Questions in this session:</strong> ${questions.size()}
            </div>
            <div>
                <strong>Passing Score:</strong> ${finalTest.passingScore}%
            </div>
        </div>

        <div class="progress-bar">
            <div class="progress-fill" style="width: ${(currentSession * 100) / totalSessions}%"></div>
        </div>

        <form id="sessionForm" action="${pageContext.request.contextPath}/student/final-test/${finalTest.id}/submit" method="post">
            <c:forEach var="question" items="${questions}" varStatus="status">
                <div class="question-card">
                    <div class="question-number">${status.index + 1}</div>
                    <div class="question-text">${question.question}</div>
                    
                    <div class="options">
                        <label class="option" onclick="selectOption(this)">
                            <input type="radio" name="question_${question.id}" value="A" required>
                            <span class="option-label">A)</span>
                            <span>${question.optionA}</span>
                        </label>
                        <label class="option" onclick="selectOption(this)">
                            <input type="radio" name="question_${question.id}" value="B" required>
                            <span class="option-label">B)</span>
                            <span>${question.optionB}</span>
                        </label>
                        <label class="option" onclick="selectOption(this)">
                            <input type="radio" name="question_${question.id}" value="C" required>
                            <span class="option-label">C)</span>
                            <span>${question.optionC}</span>
                        </label>
                        <label class="option" onclick="selectOption(this)">
                            <input type="radio" name="question_${question.id}" value="D" required>
                            <span class="option-label">D)</span>
                            <span>${question.optionD}</span>
                        </label>
                    </div>
                </div>
            </c:forEach>

            <div class="warning-box">
                <i class="fas fa-exclamation-triangle"></i>
                <strong>Important:</strong> Please review all your answers before proceeding. You cannot go back to previous sessions.
            </div>

            <div class="navigation">
                <div>
                    <c:if test="${currentSession > 1}">
                        <span style="color: #666;">Previous sessions completed</span>
                    </c:if>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${currentSession < totalSessions}">
                            <button type="button" class="btn btn-primary" onclick="proceedToNextSession()">
                                <i class="fas fa-arrow-right"></i> Next Session
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-success" onclick="submitFinalTest()">
                                <i class="fas fa-check"></i> Submit Final Test
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </form>
    </div>

    <script>
        function selectOption(optionElement) {
            // Remove selected class from all options in the same question
            const questionCard = optionElement.closest('.question-card');
            const allOptions = questionCard.querySelectorAll('.option');
            allOptions.forEach(option => option.classList.remove('selected'));
            
            // Add selected class to clicked option
            optionElement.classList.add('selected');
        }

        function proceedToNextSession() {
            if (validateCurrentSession()) {
                // Store current session answers in sessionStorage
                const formData = new FormData(document.getElementById('sessionForm'));
                const answers = {};
                for (let [key, value] of formData.entries()) {
                    answers[key] = value;
                }
                
                // Get existing answers or create new object
                let allAnswers = JSON.parse(sessionStorage.getItem('finalTestAnswers') || '{}');
                Object.assign(allAnswers, answers);
                sessionStorage.setItem('finalTestAnswers', JSON.stringify(allAnswers));
                
                // Navigate to next session
                const nextSession = ${currentSession} + 1;
                window.location.href = '${pageContext.request.contextPath}/student/final-test/${finalTest.id}/session/' + nextSession;
            }
        }

        function submitFinalTest() {
            if (validateCurrentSession()) {
                if (confirm('Are you sure you want to submit your final test? This action cannot be undone.')) {
                    // Get all stored answers
                    const currentFormData = new FormData(document.getElementById('sessionForm'));
                    let allAnswers = JSON.parse(sessionStorage.getItem('finalTestAnswers') || '{}');
                    
                    // Add current session answers
                    for (let [key, value] of currentFormData.entries()) {
                        allAnswers[key] = value;
                    }
                    
                    // Create form with all answers
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/student/final-test/${finalTest.id}/submit';
                    
                    for (let [key, value] of Object.entries(allAnswers)) {
                        const input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = key;
                        input.value = value;
                        form.appendChild(input);
                    }
                    
                    document.body.appendChild(form);
                    form.submit();
                    
                    // Clear stored answers
                    sessionStorage.removeItem('finalTestAnswers');
                }
            }
        }

        function validateCurrentSession() {
            const form = document.getElementById('sessionForm');
            const questions = form.querySelectorAll('.question-card');
            let allAnswered = true;
            
            questions.forEach(question => {
                const radios = question.querySelectorAll('input[type="radio"]');
                const answered = Array.from(radios).some(radio => radio.checked);
                if (!answered) {
                    allAnswered = false;
                    question.style.border = '2px solid #e74c3c';
                    setTimeout(() => {
                        question.style.border = '';
                    }, 3000);
                }
            });
            
            if (!allAnswered) {
                alert('Please answer all questions before proceeding.');
                return false;
            }
            
            return true;
        }

        // Prevent accidental page refresh
        window.addEventListener('beforeunload', function(e) {
            e.preventDefault();
            e.returnValue = 'Are you sure you want to leave? Your progress will be lost.';
        });

        // Auto-save answers periodically
        setInterval(function() {
            const formData = new FormData(document.getElementById('sessionForm'));
            const answers = {};
            for (let [key, value] of formData.entries()) {
                answers[key] = value;
            }
            
            let allAnswers = JSON.parse(sessionStorage.getItem('finalTestAnswers') || '{}');
            Object.assign(allAnswers, answers);
            sessionStorage.setItem('finalTestAnswers', JSON.stringify(allAnswers));
        }, 30000); // Save every 30 seconds
    </script>
</body>
</html>
