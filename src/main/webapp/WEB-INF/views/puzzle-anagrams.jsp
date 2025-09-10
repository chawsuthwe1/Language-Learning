<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anagrams - LinguaFem</title>
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
        
        .word-display {
            font-size: 2.5rem;
            font-weight: 700;
            color: #a436f1;
            margin: 30px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 15px;
            border: 3px solid #a436f1;
        }
        
        .letters-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 30px 0;
            flex-wrap: wrap;
        }
        
        .letter-tile {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #a436f1, #d41e78);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.5rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .letter-tile:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(164, 54, 241, 0.4);
        }
        
        .letter-tile.used {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }
        
        .answer-area {
            min-height: 80px;
            border: 3px dashed #a436f1;
            border-radius: 15px;
            padding: 20px;
            margin: 30px 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
            background: #f8f9fa;
        }
        
        .answer-letter {
            width: 50px;
            height: 50px;
            background: #28a745;
            color: white;
            border-radius: 8px;
            font-size: 1.3rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .answer-letter:hover {
            background: #dc3545;
        }
        
        .game-controls {
            margin: 30px 0;
        }
        
        .control-btn {
            background: linear-gradient(135deg, #a436f1, #d41e78);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            margin: 0 10px;
            transition: all 0.3s ease;
        }
        
        .control-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(164, 54, 241, 0.4);
        }
        
        .clear-btn {
            background: #ffc107;
            color: #333;
        }
        
        .result-message {
            margin: 20px 0;
            padding: 15px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.2rem;
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
        
        .score-display {
            font-size: 1.1rem;
            font-weight: 600;
            margin: 20px 0;
            color: #333;
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
            <h1><i class="fas fa-exchange-alt"></i> Anagrams</h1>
            <p>Rearrange the letters to form new words!</p>
        </div>
        
        <div class="instructions">
            <h3>How to Play:</h3>
            <p>Click on the letter tiles to add them to your answer. Try to form as many different words as possible using the given letters!</p>
        </div>
        
        <div class="game-board">
            <h3>Use these letters:</h3>
            <div class="word-display">${word}</div>
            
            <div class="letters-container" id="lettersContainer">
                <!-- Letters will be populated by JavaScript -->
            </div>
            
            <div class="answer-area" id="answerArea">
                <span style="color: #666; font-style: italic;">Click letters above to build your word</span>
            </div>
            
            <div class="game-controls">
                <button onclick="checkAnswer()" class="control-btn">Check Word</button>
                <button onclick="clearAnswer()" class="control-btn clear-btn">Clear</button>
            </div>
            
            <div id="resultMessage" style="display: none;"></div>
            
            <div class="score-display">
                Words Found: <span id="wordsFound">0</span>
            </div>
            
            <div id="foundWordsList" style="margin: 20px 0; font-weight: 600;"></div>
            
            <div style="margin-top: 30px;">
                <a href="/puzzles/anagrams" class="new-game-btn">
                    <i class="fas fa-redo"></i> New Letters
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
        const originalWord = '${word}';
        const letters = originalWord.split('');
        let currentAnswer = [];
        let foundWords = [];
        
        // Common English words that can be formed from various letter combinations
        const validWords = {
            'LISTEN': ['LISTEN', 'SILENT', 'ENLIST', 'TINSEL'],
            'SILENT': ['LISTEN', 'SILENT', 'ENLIST', 'TINSEL'],
            'EARTH': ['EARTH', 'HEART', 'HATER'],
            'HEART': ['EARTH', 'HEART', 'HATER'],
            'ANGEL': ['ANGEL', 'GLEAN', 'LANGE'],
            'GLEAN': ['ANGEL', 'GLEAN', 'LANGE']
        };

        function initializeGame() {
            const container = document.getElementById('lettersContainer');
            container.innerHTML = '';
            
            letters.forEach((letter, index) => {
                const tile = document.createElement('button');
                tile.className = 'letter-tile';
                tile.textContent = letter;
                tile.onclick = () => addLetter(letter, index);
                tile.id = `letter-${index}`;
                container.appendChild(tile);
            });
        }

        function addLetter(letter, index) {
            const tile = document.getElementById(`letter-${index}`);
            if (tile.classList.contains('used')) return;
            
            currentAnswer.push({letter, index});
            tile.classList.add('used');
            updateAnswerDisplay();
        }

        function removeLetter(answerIndex) {
            const removed = currentAnswer.splice(answerIndex, 1)[0];
            const tile = document.getElementById(`letter-${removed.index}`);
            tile.classList.remove('used');
            updateAnswerDisplay();
        }

        function updateAnswerDisplay() {
            const answerArea = document.getElementById('answerArea');
            
            if (currentAnswer.length === 0) {
                answerArea.innerHTML = '<span style="color: #666; font-style: italic;">Click letters above to build your word</span>';
                return;
            }
            
            answerArea.innerHTML = '';
            currentAnswer.forEach((item, index) => {
                const letterDiv = document.createElement('div');
                letterDiv.className = 'answer-letter';
                letterDiv.textContent = item.letter;
                letterDiv.onclick = () => removeLetter(index);
                answerArea.appendChild(letterDiv);
            });
        }

        function checkAnswer() {
            if (currentAnswer.length === 0) {
                alert('Please form a word first!');
                return;
            }
            
            const word = currentAnswer.map(item => item.letter).join('');
            const possibleWords = validWords[originalWord] || [];
            
            const resultDiv = document.getElementById('resultMessage');
            
            if (possibleWords.includes(word) && !foundWords.includes(word)) {
                foundWords.push(word);
                resultDiv.innerHTML = `<div class="result-message correct"><i class="fas fa-check-circle"></i> Great! "${word}" is correct!</div>`;
                updateScore();
                clearAnswer();
            } else if (foundWords.includes(word)) {
                resultDiv.innerHTML = `<div class="result-message incorrect"><i class="fas fa-info-circle"></i> You already found "${word}"!</div>`;
            } else {
                resultDiv.innerHTML = `<div class="result-message incorrect"><i class="fas fa-times-circle"></i> "${word}" is not a valid word for these letters.</div>`;
            }
            
            resultDiv.style.display = 'block';
            
            setTimeout(() => {
                resultDiv.style.display = 'none';
            }, 3000);
        }

        function clearAnswer() {
            currentAnswer.forEach(item => {
                const tile = document.getElementById(`letter-${item.index}`);
                tile.classList.remove('used');
            });
            currentAnswer = [];
            updateAnswerDisplay();
        }

        function updateScore() {
            document.getElementById('wordsFound').textContent = foundWords.length;
            
            const listDiv = document.getElementById('foundWordsList');
            if (foundWords.length > 0) {
                listDiv.innerHTML = '<strong>Found Words:</strong> ' + foundWords.join(', ');
            }
            
            const possibleWords = validWords[originalWord] || [];
            if (foundWords.length === possibleWords.length) {
                setTimeout(() => {
                    alert(`Congratulations! You found all ${possibleWords.length} possible words!`);
                }, 500);
            }
        }

        // Initialize the game when page loads
        document.addEventListener('DOMContentLoaded', initializeGame);
    </script>
</body>
</html>
