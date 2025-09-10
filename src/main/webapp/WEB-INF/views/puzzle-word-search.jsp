<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Word Search - LinguaFem</title>
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
            grid-template-columns: 1fr 300px;
            gap: 30px;
        }
        
        .word-grid {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .grid-container {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            gap: 2px;
            max-width: 400px;
            margin: 0 auto;
        }
        
        .grid-cell {
            width: 40px;
            height: 40px;
            border: 2px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.2s ease;
            background: white;
        }
        
        .grid-cell:hover {
            background: #f0f0f0;
        }
        
        .grid-cell.selected {
            background: #a436f1;
            color: white;
        }
        
        .grid-cell.found {
            background: #28a745;
            color: white;
        }
        
        .words-panel {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .words-list h3 {
            color: #333;
            margin-bottom: 20px;
        }
        
        .word-item {
            padding: 10px 15px;
            margin: 5px 0;
            background: #f8f9fa;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .word-item.found {
            background: #d4edda;
            color: #155724;
            text-decoration: line-through;
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
        
        .score-display {
            text-align: center;
            margin: 20px 0;
            font-size: 1.2rem;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .game-content {
                grid-template-columns: 1fr;
            }
            
            .grid-cell {
                width: 35px;
                height: 35px;
                font-size: 1rem;
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
            <h1><i class="fas fa-search"></i> Word Search</h1>
            <p>Find all the hidden words in the grid!</p>
        </div>
        
        <div class="instructions">
            <h3>How to Play:</h3>
            <p>Click and drag to select words in the grid. Words can be horizontal, vertical, or diagonal. Find all the words listed on the right!</p>
        </div>
        
        <div class="game-content">
            <div class="word-grid">
                <h3 style="text-align: center; margin-bottom: 20px;">Word Grid</h3>
                <div class="grid-container" id="wordGrid">
                    <c:forEach var="row" items="${grid}" varStatus="rowStatus">
                        <c:forEach var="cell" items="${row}" varStatus="colStatus">
                            <div class="grid-cell" data-row="${rowStatus.index}" data-col="${colStatus.index}">
                                ${cell}
                            </div>
                        </c:forEach>
                    </c:forEach>
                </div>
                
                <div class="score-display">
                    <span id="foundCount">0</span> / ${wordsToFind.length} words found
                </div>
                
                <div style="text-align: center; margin-top: 30px;">
                    <a href="/puzzles/word-search" class="new-game-btn">
                        <i class="fas fa-redo"></i> New Game
                    </a>
                    <a href="/english-puzzles" class="new-game-btn" style="background: #6c757d;">
                        <i class="fas fa-home"></i> Back to Puzzles
                    </a>
                </div>
            </div>
            
            <div class="words-panel">
                <div class="words-list">
                    <h3>Find These Words:</h3>
                    <c:forEach var="word" items="${wordsToFind}">
                        <div class="word-item" data-word="${word}">${word}</div>
                    </c:forEach>
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
        let isSelecting = false;
        let selectedCells = [];
        let foundWords = [];
        const wordsToFind = [<c:forEach var="word" items="${wordsToFind}" varStatus="status">'${word}'<c:if test="${!status.last}">,</c:if></c:forEach>];

        document.addEventListener('DOMContentLoaded', function() {
            const cells = document.querySelectorAll('.grid-cell');
            
            cells.forEach(cell => {
                cell.addEventListener('mousedown', startSelection);
                cell.addEventListener('mouseenter', continueSelection);
                cell.addEventListener('mouseup', endSelection);
            });
            
            document.addEventListener('mouseup', endSelection);
        });

        function startSelection(e) {
            isSelecting = true;
            selectedCells = [];
            clearSelection();
            selectCell(e.target);
        }

        function continueSelection(e) {
            if (isSelecting) {
                selectCell(e.target);
            }
        }

        function endSelection() {
            if (isSelecting) {
                checkSelectedWord();
                isSelecting = false;
            }
        }

        function selectCell(cell) {
            if (!selectedCells.includes(cell)) {
                selectedCells.push(cell);
                cell.classList.add('selected');
            }
        }

        function clearSelection() {
            selectedCells.forEach(cell => {
                if (!cell.classList.contains('found')) {
                    cell.classList.remove('selected');
                }
            });
            selectedCells = [];
        }

        function checkSelectedWord() {
            const selectedWord = selectedCells.map(cell => cell.textContent).join('');
            const reverseWord = selectedWord.split('').reverse().join('');
            
            let foundWord = null;
            if (wordsToFind.includes(selectedWord)) {
                foundWord = selectedWord;
            } else if (wordsToFind.includes(reverseWord)) {
                foundWord = reverseWord;
            }
            
            if (foundWord && !foundWords.includes(foundWord)) {
                foundWords.push(foundWord);
                selectedCells.forEach(cell => {
                    cell.classList.remove('selected');
                    cell.classList.add('found');
                });
                
                // Mark word as found in the list
                const wordItem = document.querySelector(`[data-word="${foundWord}"]`);
                if (wordItem) {
                    wordItem.classList.add('found');
                }
                
                updateScore();
                
                if (foundWords.length === wordsToFind.length) {
                    setTimeout(() => {
                        alert('Congratulations! You found all the words!');
                    }, 500);
                }
            } else {
                clearSelection();
            }
        }

        function updateScore() {
            document.getElementById('foundCount').textContent = foundWords.length;
        }
    </script>
</body>
</html>
