<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>English Riddles - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        .game-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }
        
        .game-header {
            margin-bottom: 40px;
        }
        
        .game-header h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #a436f1;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        .riddle-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .riddle-text {
            font-size: 1.5rem;
            color: #333;
            margin: 30px 0;
            padding: 30px;
            background: #f8f9fa;
            border-radius: 15px;
            border-left: 5px solid #a436f1;
            font-style: italic;
        }
        
        .answer-section {
            margin: 30px 0;
        }
        
        .answer-input {
            width: 300px;
            padding: 15px;
            font-size: 1.2rem;
            border: 2px solid #ddd;
            border-radius: 10px;
            text-align: center;
            margin: 20px 0;
        }
        
        .answer-input:focus {
            outline: none;
            border-color: #a436f1;
        }
        
        .submit-btn {
            background: linear-gradient(135deg, #a436f1, #d41e78);
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 0 10px;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(164, 54, 241, 0.4);
        }
        
        .hint-btn {
            background: #ffc107;
            color: #333;
            padding: 12px 25px;
            border: none;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            margin: 0 10px;
        }
        
        .answer-display {
            margin: 20px 0;
            padding: 15px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.2rem;
        }
        
        .correct-answer {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .hint-text {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
            margin: 15px 0;
            padding: 15px;
            border-radius: 10px;
            font-style: italic;
        }
        
        .new-game-btn {
            background: #28a745;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 10px;
        }
        
        .instructions {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="Logo">
            <a href="/" class="site-title">Lingua<span class="highlight">Fem</span></a>
        </div>
        
        <div class="auth-buttons">
            <a href="/user/" class="btn btn-outline">Register</a>
            <a href="/login" class="btn btn-filled">Login</a>
        </div>
    </header>

    <div class="game-container">
        <a href="/english-puzzles" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Puzzles
        </a>
        
        <div class="game-header">
            <h1><i class="fas fa-lightbulb"></i> English Riddles</h1>
            <p>Challenge your mind with clever word puzzles!</p>
        </div>
        
        <div class="instructions">
            <h3>How to Play:</h3>
            <p>Read the riddle carefully and think about the answer. Type your guess in the input field. Need help? Click the hint button!</p>
        </div>
        
        <div class="riddle-card">
            <h3>Solve this riddle:</h3>
            <div class="riddle-text">${riddle}</div>
            
            <div class="answer-section">
                <input type="text" id="userAnswer" class="answer-input" placeholder="Enter your answer..." />
                <br>
                <button onclick="checkAnswer()" class="submit-btn">Submit Answer</button>
                <button onclick="showHint()" class="hint-btn">💡 Hint</button>
            </div>
            
            <div id="hintSection" class="hint-text" style="display: none;">
                Think about something you use every day that has the features mentioned in the riddle!
            </div>
            
            <div id="resultSection" style="display: none;">
                <div id="resultMessage" class="answer-display"></div>
            </div>
            
            <div style="margin-top: 30px;">
                <a href="/puzzles/riddles" class="new-game-btn">
                    <i class="fas fa-redo"></i> New Riddle
                </a>
                <a href="/english-puzzles" class="new-game-btn" style="background: #6c757d;">
                    <i class="fas fa-home"></i> Back to Puzzles
                </a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <div class="footer-col">
                <h2>LinguaFem</h2>
                <p>Empowering language learners worldwide with innovative, accessible education built by passionate female developers.</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2024 LinguaFem. Made with 💜 by an all-girls developer team.</p>
        </div>
    </footer>

    <script>
        const correctAnswer = '${answer}';
        let hintShown = false;

        function checkAnswer() {
            const userAnswer = document.getElementById('userAnswer').value.trim().toUpperCase();
            const resultSection = document.getElementById('resultSection');
            const resultMessage = document.getElementById('resultMessage');
            
            if (userAnswer === correctAnswer.toUpperCase()) {
                resultMessage.innerHTML = '<i class="fas fa-check-circle"></i> Correct! Well done!<br>The answer is: <strong>' + correctAnswer + '</strong>';
                resultMessage.className = 'answer-display correct-answer';
            } else if (userAnswer === '') {
                alert('Please enter an answer!');
                return;
            } else {
                resultMessage.innerHTML = '<i class="fas fa-times-circle"></i> Not quite right. Try again!<br>Your answer: <strong>' + userAnswer + '</strong><br>Correct answer: <strong>' + correctAnswer + '</strong>';
                resultMessage.className = 'answer-display';
                resultMessage.style.background = '#f8d7da';
                resultMessage.style.color = '#721c24';
                resultMessage.style.border = '1px solid #f5c6cb';
            }
            
            resultSection.style.display = 'block';
        }

        function showHint() {
            const hintSection = document.getElementById('hintSection');
            if (!hintShown) {
                hintSection.style.display = 'block';
                hintShown = true;
            } else {
                hintSection.style.display = 'none';
                hintShown = false;
            }
        }

        // Allow Enter key to submit answer
        document.getElementById('userAnswer').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                checkAnswer();
            }
        });
    </script>
</body>
</html>
