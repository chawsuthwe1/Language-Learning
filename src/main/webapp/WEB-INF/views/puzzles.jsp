<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>English Puzzles - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        .puzzles-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .puzzles-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .puzzles-header h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .puzzles-header p {
            color: #666;
            font-size: 1.1rem;
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
        
        .puzzles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .puzzle-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .puzzle-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .puzzle-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #a436f1, #d41e78);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }
        
        .puzzle-icon i {
            color: white;
            font-size: 24px;
        }
        
        .puzzle-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        
        .puzzle-description {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .puzzle-difficulty {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 20px;
        }
        
        .difficulty-easy { background: #e8f5e8; color: #2e7d32; }
        .difficulty-medium { background: #fff3e0; color: #f57c00; }
        .difficulty-hard { background: #fce4ec; color: #c2185b; }
        
        .play-btn {
            background: linear-gradient(135deg, #a436f1, #d41e78);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .play-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(164, 54, 241, 0.4);
        }
        
        .coming-soon {
            background: #f5f5f5;
            color: #999;
            cursor: not-allowed;
        }
        
        .coming-soon:hover {
            transform: none;
            box-shadow: none;
        }
        
        .footer {
            margin-top: 60px;
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

    <div class="puzzles-container">
        <a href="/" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>
        
        <div class="puzzles-header">
            <h1>English Puzzles</h1>
            <p>Challenge your mind with fun word games and brain teasers</p>
        </div>
        
        <div class="puzzles-grid">
            <!-- Word Scramble -->
            <div class="puzzle-card">
                <div class="puzzle-icon">
                    <i class="fas fa-random"></i>
                </div>
                <h3 class="puzzle-title">Word Scramble</h3>
                <p class="puzzle-description">Unscramble jumbled letters to form English words. Perfect for vocabulary building and spelling practice.</p>
                <span class="puzzle-difficulty difficulty-easy">Easy</span>
                <br>
                <a href="#" class="play-btn" onclick="playWordScramble()">Play Now</a>
            </div>
            
            <!-- Riddles -->
            <div class="puzzle-card">
                <div class="puzzle-icon">
                    <i class="fas fa-lightbulb"></i>
                </div>
                <h3 class="puzzle-title">English Riddles</h3>
                <p class="puzzle-description">Solve clever word puzzles and brain teasers. Improves critical thinking and language comprehension.</p>
                <span class="puzzle-difficulty difficulty-hard">Hard</span>
                <br>
                <a href="#" class="play-btn" onclick="playRiddles()">Play Now</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <div class="footer-col">
                <h2>LinguaFem</h2>
                <p>Empowering language learners worldwide with innovative, accessible education built by passionate female developers.</p>
                <div class="social-icons">
                    <i class="fas fa-calculator"></i>
                    <i class="fas fa-comment-dots"></i>
                    <i class="fas fa-camera"></i>
                </div>
            </div>
            
            <div class="footer-col">
                <h3>Learning</h3>
                <ul>
                    <li>All Levels</li>
                    <li>Speaking Practice</li>
                    <li>English Puzzles</li>
                    <li>Vocabulary Builder</li>
                    <li>Progress Tracking</li>
                </ul>
            </div>
            
            <div class="footer-col">
                <h3>Support</h3>
                <ul>
                    <li>Help Center</li>
                    <li>Community</li>
                    <li>Contact Us</li>
                    <li>Feedback</li>
                    <li>Bug Reports</li>
                </ul>
            </div>
            
            <div class="footer-col">
                <h3>About</h3>
                <ul>
                    <li>Our Story</li>
                    <li>Team</li>
                    <li>Careers</li>
                    <li>Privacy Policy</li>
                    <li>Terms of Service</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p> 2024 LinguaFem. Made with  by an all-girls developer team.</p>
            <p> Available in 12 languages  4.9/5 rating  Female-founded</p>
        </div>
    </footer>

    <script>
        function playWordScramble() {
            window.location.href = '/puzzles/word-scramble';
        }
        
        function playRiddles() {
            window.location.href = '/puzzles/riddles';
        }
    </script>
</body>
</html>
