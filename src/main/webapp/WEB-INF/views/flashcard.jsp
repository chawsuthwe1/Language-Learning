<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vocabulary Flashcards</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8e3f4, #e0eaff);
            min-height: 100vh;
            padding: 2rem;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h1 {
            text-align: center;
            color: transparent;
            background-clip: text;
            background-image: linear-gradient(to right, #a436f1, #d41e78);
            margin-bottom: 2rem;
            font-size: 2.8rem;
            font-weight: 700;
        }

        .subtitle {
            text-align: center;
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 2.5rem;
        }

        .flashcard-area {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 300px;
            margin: 2rem 0;
        }

        .flashcard {
            width: 320px;
            height: 220px;
            perspective: 1200px;
            cursor: pointer;
        }

        .flashcard-inner {
            position: relative;
            width: 100%;
            height: 100%;
            transition: transform 0.8s cubic-bezier(0.2, 0.8, 0.7, 0.3);
            transform-style: preserve-3d;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .flashcard:hover .flashcard-inner {
            transform: rotateY(180deg);
        }

        .flashcard-front, .flashcard-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            border-radius: 12px;
            font-size: 1.4rem;
            line-height: 1.5;
            text-align: center;
        }

        .flashcard-front {
            background-color: white;
            color: #333;
            font-weight: 600;
        }

        .flashcard-back {
            background-color: #c800ff;
            color: white;
            transform: rotateY(180deg);
            font-weight: 500;
        }

        .controls {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        button {
            padding: 12px 24px;
            font-size: 1.1rem;
            border: none;
            border-radius: 8px;
            background-color: #2196F3;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 120px;
        }

        button:hover {
            background-color: #1976D2;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(33, 150, 243, 0.3);
        }

        button:active {
            transform: translateY(0);
        }

        .instructions {
            text-align: center;
            margin: 1.5rem 0;
            color: #555;
            font-style: italic;
            font-size: 1rem;
        }

        .back-to-home {
            display: block;
            margin: 3rem auto 0;
            padding: 12px 28px;
            background-color: #c800ff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            width: fit-content;
            box-shadow: 0 4px 12px rgba(196, 0, 255, 0.3);
            transition: all 0.3s ease;
        }

        .back-to-home:hover {
            background-color: #a613cf;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(196, 0, 255, 0.4);
        }

        .back-to-home:active {
            transform: translateY(0);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            h1 {
                font-size: 2.2rem;
            }
            .subtitle {
                font-size: 1rem;
            }
            .flashcard {
                width: 280px;
                height: 200px;
            }
            .flashcard-front, .flashcard-back {
                font-size: 1.2rem;
                padding: 1rem;
            }
            button {
                font-size: 1rem;
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Vocabulary Flashcards</h1>
        <p class="subtitle">Click or hover to flip. Learn one word at a time.</p>

        <div class="flashcard-area">
            <div class="flashcard" id="flashcard">
                <div class="flashcard-inner">
                    <div class="flashcard-front">
                        <p id="word">Loading...</p>
                    </div>
                    <div class="flashcard-back">
                        <p id="definition">Loading...</p>
                    </div>
                </div>
            </div>
        </div>

        <p class="instructions">💡 Hover or click the card to see the definition</p>

        <div class="controls">
            <button onclick="previousCard()">← Previous</button>
            <button onclick="nextCard()">Next →</button>
            <button onclick="shuffleCards()">🔄 Shuffle</button>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/" class="back-to-home">← Back to Home</a>

    <script>
        const vocabularyData = [
            { word: 'Curious', definition: 'Eager to learn or know something' },
            { word: 'Diligent', definition: 'Hard-working, industrious' },
            { word: 'Punctual', definition: 'Always on time' },
            { word: 'Generous', definition: 'Willing to give or share' },
            { word: 'Reliable', definition: 'Can be trusted' },
            { word: 'Conscientious', definition: 'Careful to do things correctly' },
            { word: 'Creative', definition: 'Good at thinking of new ideas' },
            { word: 'Honest', definition: 'Telling the truth' },
            { word: 'Obfuscate', definition: 'Making it confusing or unclear' },
            { word: 'Subtle', definition: 'Not obvious; delicate' },
            { word: 'Resilient', definition: 'Able to recover quickly from difficulty' },
            { word: 'Ambitious', definition: 'Having a strong desire to succeed' }
        ];

        let currentIndex = 0;

        function updateCard() {
            const wordEl = document.getElementById('word');
            const definitionEl = document.getElementById('definition');
            wordEl.textContent = vocabularyData[currentIndex].word;
            definitionEl.textContent = vocabularyData[currentIndex].definition;
        }

        function nextCard() {
            currentIndex = (currentIndex + 1) % vocabularyData.length;
            updateCard();
        }

        function previousCard() {
            currentIndex = (currentIndex - 1 + vocabularyData.length) % vocabularyData.length;
            updateCard();
        }

        function shuffleCards() {
            for (let i = vocabularyData.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [vocabularyData[i], vocabularyData[j]] = [vocabularyData[j], vocabularyData[i]];
            }
            currentIndex = 0;
            updateCard();
        }

        // Initialize
        updateCard();
    </script>
</body>
</html>