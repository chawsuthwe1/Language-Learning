<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crossword - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        .game-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .game-header {
            text-align: center;
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
        
        .game-content {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
        }
        
        .crossword-grid {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .grid-container {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 2px;
            max-width: 300px;
            margin: 0 auto;
        }
        
        .grid-cell {
            width: 50px;
            height: 50px;
            border: 2px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1.2rem;
            background: white;
        }
        
        .grid-cell.active {
            background: #f8f9fa;
        }
        
        .grid-cell.blocked {
            background: #333;
        }
        
        .grid-cell input {
            width: 100%;
            height: 100%;
            border: none;
            text-align: center;
            font-size: 1.2rem;
            font-weight: 600;
            background: transparent;
        }
        
        .grid-cell input:focus {
            outline: 2px solid #a436f1;
        }
        
        .clues-panel {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .clues-section h3 {
            color: #333;
            margin-bottom: 15px;
            border-bottom: 2px solid #a436f1;
            padding-bottom: 10px;
        }
        
        .clue-item {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            font-size: 0.95rem;
        }
        
        .instructions {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
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
            margin: 10px 5px;
        }
        
        .check-btn {
            background: linear-gradient(135deg, #a436f1, #d41e78);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            margin: 20px 5px;
        }
        
        @media (max-width: 768px) {
            .game-content {
                grid-template-columns: 1fr;
            }
            
            .grid-cell {
                width: 40px;
                height: 40px;
            }
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
            <h1><i class="fas fa-th"></i> Crossword Puzzle</h1>
            <p>Fill in the grid using the clues provided!</p>
        </div>
        
        <div class="instructions">
            <h3>How to Play:</h3>
            <p>Click on a cell and type your answer. Use the clues on the right to help you. Words can go across or down!</p>
        </div>
        
        <div class="game-content">
            <div class="crossword-grid">
                <h3 style="text-align: center; margin-bottom: 20px;">Crossword Grid</h3>
                <div class="grid-container">
                    <!-- Row 1 -->
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="day" data-pos="0"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="day" data-pos="1"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="day" data-pos="2"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    
                    <!-- Row 2 -->
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="dog" data-pos="0"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    
                    <!-- Row 3 -->
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="dog" data-pos="1"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    
                    <!-- Row 4 -->
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="green" data-pos="0"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="green" data-pos="1"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="green" data-pos="2"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="green" data-pos="3"></div>
                    <div class="grid-cell active"><input type="text" maxlength="1" data-word="green" data-pos="4"></div>
                    
                    <!-- Row 5 -->
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                    <div class="grid-cell blocked"></div>
                </div>
                
                <div style="text-align: center; margin-top: 30px;">
                    <button onclick="checkAnswers()" class="check-btn">Check Answers</button>
                    <br>
                    <a href="/puzzles/crossword" class="new-game-btn">
                        <i class="fas fa-redo"></i> New Puzzle
                    </a>
                    <a href="/english-puzzles" class="new-game-btn" style="background: #6c757d;">
                        <i class="fas fa-home"></i> Back to Puzzles
                    </a>
                </div>
            </div>
            
            <div class="clues-panel">
                <div class="clues-section">
                    <h3>Across</h3>
                    <div class="clue-item">1. Opposite of night (3 letters)</div>
                    <div class="clue-item">3. Color of grass (5 letters)</div>
                </div>
                
                <div class="clues-section" style="margin-top: 30px;">
                    <h3>Down</h3>
                    <div class="clue-item">2. Animal that barks (3 letters)</div>
                </div>
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
        const answers = {
            'day': 'DAY',
            'dog': 'DOG',
            'green': 'GREEN'
        };

        function checkAnswers() {
            let correct = 0;
            let total = Object.keys(answers).length;
            
            for (let word in answers) {
                let inputs = document.querySelectorAll(`[data-word="${word}"]`);
                let userAnswer = '';
                
                inputs.forEach(input => {
                    userAnswer += input.value.toUpperCase();
                });
                
                if (userAnswer === answers[word]) {
                    correct++;
                    inputs.forEach(input => {
                        input.style.background = '#d4edda';
                        input.style.color = '#155724';
                    });
                } else {
                    inputs.forEach(input => {
                        input.style.background = '#f8d7da';
                        input.style.color = '#721c24';
                    });
                }
            }
            
            setTimeout(() => {
                if (correct === total) {
                    alert(`Congratulations! You got all ${total} words correct!`);
                } else {
                    alert(`You got ${correct} out of ${total} words correct. Keep trying!`);
                }
            }, 500);
        }

        // Auto-advance to next input
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('input', function() {
                if (this.value.length === 1) {
                    let nextInput = this.parentElement.nextElementSibling?.querySelector('input');
                    if (nextInput) {
                        nextInput.focus();
                    }
                }
            });
        });
    </script>
</body>
</html>
