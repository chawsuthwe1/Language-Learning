<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>A Busy Morning - LinguaFem</title>

    <!-- Your CSS (context-safe path) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    
    <style>
        .story-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.8;
        }
        
        .story-header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
        }
        
        .story-header h1 {
            font-size: 2.2rem;
            margin-bottom: 10px;
        }
        
        .story-meta {
            display: flex;
            justify-content: center;
            gap: 20px;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .story-content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .story-text {
            font-size: 1.1rem;
            color: #333;
            margin-bottom: 30px;
        }
        
        .vocabulary-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            margin: 30px 0;
        }
        
        .vocabulary-section h3 {
            color: #1976d2;
            margin-bottom: 15px;
        }
        
        .vocab-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .vocab-item:last-child {
            border-bottom: none;
        }
        
        .vocab-word {
            font-weight: 600;
            color: #333;
        }
        
        .vocab-meaning {
            color: #666;
            text-align: right;
        }
        
        .exercises-section {
            background: #fff3e0;
            padding: 25px;
            border-radius: 10px;
            margin: 30px 0;
        }
        
        .exercises-section h3 {
            color: #f57c00;
            margin-bottom: 15px;
        }
        
        .exercise-question {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin: 15px 0;
            border-left: 4px solid #f57c00;
        }
        
        .exercise-options {
            margin: 15px 0;
        }
        
        .exercise-option {
            padding: 10px 15px;
            margin: 5px 0;
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .exercise-option:hover {
            background: #e3f2fd;
            border-color: #1976d2;
        }
        
        .exercise-option.selected {
            background: #1976d2;
            color: white;
            border-color: #1976d2;
        }
        
        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
        }
        
        .nav-btn {
            padding: 12px 25px;
            background: #f8f9fa;
            color: #333;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .nav-btn:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }
        
        .back-to-stories {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .back-to-stories:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
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

<div class="story-container">
    <div class="story-header">
        <h1>A Busy Morning</h1>
        <div class="story-meta">
            <span><i class="fas fa-clock"></i> 5 min read</span>
            <span><i class="fas fa-signal"></i> Basic Level</span>
            <span><i class="fas fa-book"></i> Everyday Vocabulary</span>
        </div>
    </div>
    
    <div class="story-content">
        <div class="story-text">
            <p>Sarah woke up at 6:30 AM with a start. She had an important job interview at 9:00 AM, and she was already running late. She quickly jumped out of bed and rushed to the bathroom.</p>
            
            <p>"Oh no! I need to take a shower, get dressed, and eat breakfast," she thought to herself. "I don't have much time!"</p>
            
            <p>In the bathroom, Sarah turned on the hot water and stepped into the shower. She washed her hair with shampoo and used soap to clean her body. After five minutes, she turned off the water and grabbed a towel to dry herself.</p>
            
            <p>Next, Sarah went to her bedroom and opened her closet. She chose a blue blouse and black pants for the interview. She also picked out a pair of comfortable black shoes. "Professional but comfortable," she said to herself.</p>
            
            <p>After getting dressed, Sarah went to the kitchen. She made herself a quick breakfast: toast with butter and jam, and a cup of coffee. She ate quickly while checking the time on her phone.</p>
            
            <p>"It's 7:45 AM. I need to leave in 15 minutes to catch the bus," Sarah calculated. She grabbed her purse, put on her coat, and rushed out the door.</p>
            
            <p>At the bus stop, Sarah waited anxiously. The bus arrived at 8:00 AM, and she got on quickly. She found a seat and took out her phone to review her interview notes.</p>
            
            <p>When the bus reached her destination at 8:45 AM, Sarah got off and walked to the office building. She arrived at 8:55 AM, just in time for her 9:00 AM interview.</p>
            
            <p>"Phew! I made it," Sarah said with relief. She took a deep breath and walked confidently into the building, ready for her interview.</p>
        </div>
        
        <div class="vocabulary-section">
            <h3><i class="fas fa-book-open"></i> New Vocabulary</h3>
            <div class="vocab-item">
                <span class="vocab-word">blouse</span>
                <span class="vocab-meaning">a shirt for women</span>
            </div>
            <div class="vocab-item">
                <span class="vocab-word">closet</span>
                <span class="vocab-meaning">a small room for storing clothes</span>
            </div>
            <div class="vocab-item">
                <span class="vocab-word">interview</span>
                <span class="vocab-meaning">a formal meeting to discuss a job</span>
            </div>
            <div class="vocab-item">
                <span class="vocab-word">professional</span>
                <span class="vocab-meaning">suitable for work or business</span>
            </div>
            <div class="vocab-item">
                <span class="vocab-word">anxiously</span>
                <span class="vocab-meaning">with worry or nervousness</span>
            </div>
        </div>
        
        <div class="exercises-section">
            <h3><i class="fas fa-pencil-alt"></i> Comprehension Exercise</h3>
            
            <div class="exercise-question">
                <p><strong>Question 1:</strong> What time did Sarah wake up?</p>
                <div class="exercise-options">
                    <div class="exercise-option" onclick="selectOption(this)">A) 6:00 AM</div>
                    <div class="exercise-option" onclick="selectOption(this)">B) 6:30 AM</div>
                    <div class="exercise-option" onclick="selectOption(this)">C) 7:00 AM</div>
                </div>
            </div>
            
            <div class="exercise-question">
                <p><strong>Question 2:</strong> What did Sarah eat for breakfast?</p>
                <div class="exercise-options">
                    <div class="exercise-option" onclick="selectOption(this)">A) Cereal and milk</div>
                    <div class="exercise-option" onclick="selectOption(this)">B) Toast with butter and jam</div>
                    <div class="exercise-option" onclick="selectOption(this)">C) Eggs and bacon</div>
                </div>
            </div>
            
            <div class="exercise-question">
                <p><strong>Question 3:</strong> What color clothes did Sarah choose for the interview?</p>
                <div class="exercise-options">
                    <div class="exercise-option" onclick="selectOption(this)">A) Red and white</div>
                    <div class="exercise-option" onclick="selectOption(this)">B) Blue and black</div>
                    <div class="exercise-option" onclick="selectOption(this)">C) Green and brown</div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="navigation-buttons">
        <a href="/stories" class="nav-btn back-to-stories">
            <i class="fas fa-arrow-left"></i> Back to Stories
        </a>
        <a href="/stories" class="nav-btn">
            Next Story <i class="fas fa-arrow-right"></i>
        </a>
    </div>
</div>

<script>
function selectOption(element) {
    // Remove selected class from all options in the same question
    const question = element.closest('.exercise-question');
    question.querySelectorAll('.exercise-option').forEach(option => {
        option.classList.remove('selected');
    });
    
    // Add selected class to clicked option
    element.classList.add('selected');
}
</script>

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
                <li>Stories</li>
                <li>Writing Practice</li>
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
        <p>© 2024 LinguaFem. Made with 💜 by an all-girls developer team.</p>
        <p>🌐 Available in 12 languages ⭐ 4.9/5 rating 👩‍💻 Female-founded</p>
    </div>
</footer>
</body>
</html>
