<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Word Scramble - LinguaFem</title>
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
        
        .game-board {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .scrambled-word {
            font-size: 3rem;
            font-weight: 700;
            color: #a436f1;
            letter-spacing: 10px;
            margin: 30px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
            border: 3px dashed #a436f1;
        }
        
        .word-length {
            color: #666;
            margin-bottom: 20px;
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
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(164, 54, 241, 0.4);
        }
        
        .result-message {
            margin: 20px 0;
            padding: 15px;
            border-radius: 10px;
            font-weight: 600;
        }
        
        .correct {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .incorrect {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
            <h1><i class="fas fa-random"></i> Word Scramble</h1>
            <p>Unscramble the letters to form the correct English word!</p>
        </div>
        
        <div class="instructions">
            <h3>How to Play:</h3>
            <p>Look at the scrambled letters below and rearrange them to form a valid English word. Type your answer in the input field and click Submit!</p>
        </div>
        
        <div class="game-board">
            <h3>Unscramble this word:</h3>
            <div class="scrambled-word">${scrambledWord}</div>
            <p class="word-length">Word Length: ${wordLength} letters</p>
            
            <form action="/puzzles/word-scramble/check" method="post">
                <input type="hidden" name="originalWord" value="${originalWord}">
                <input type="text" name="userAnswer" class="answer-input" placeholder="Enter your answer..." required>
                <br>
                <button type="submit" class="submit-btn">Submit Answer</button>
            </form>
            
            <% if (request.getAttribute("isCorrect") != null) { %>
                <% Boolean isCorrect = (Boolean) request.getAttribute("isCorrect"); %>
                <% if (isCorrect) { %>
                    <div class="result-message correct">
                        <i class="fas fa-check-circle"></i> Correct! Well done!
                        <br>The word was: <strong>${correctAnswer}</strong>
                    </div>
                <% } else { %>
                    <div class="result-message incorrect">
                        <i class="fas fa-times-circle"></i> Not quite right. Try again!
                        <br>Your answer: <strong>${userAnswer}</strong>
                        <br>Correct answer: <strong>${correctAnswer}</strong>
                    </div>
                <% } %>
            <% } %>
            
            <div style="margin-top: 30px;">
                <a href="/puzzles/word-scramble" class="new-game-btn">
                    <i class="fas fa-redo"></i> New Word
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
</body>
</html>
