<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Stories - LinguaFem</title>

    <!-- Your CSS (context-safe path) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    
    <style>
        .stories-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .stories-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .stories-header h1 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 10px;
        }
        
        .stories-header p {
            font-size: 1.1rem;
            color: #666;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .stories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .story-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .story-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .story-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .story-content {
            padding: 25px;
        }
        
        .story-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        
        .story-level {
            display: inline-block;
            padding: 5px 12px;
            background: #e3f2fd;
            color: #1976d2;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .story-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .story-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 0.9rem;
            color: #888;
        }
        
        .read-story-btn {
            display: inline-block;
            padding: 12px 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-align: center;
            width: 100%;
        }
        
        .read-story-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .back-home {
            display: inline-block;
            padding: 12px 25px;
            background: #f8f9fa;
            color: #333;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-bottom: 30px;
        }
        
        .back-home:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }
        
        .difficulty-basic { background: #e8f5e8; color: #2e7d32; }
        .difficulty-intermediate { background: #fff3e0; color: #f57c00; }
        .difficulty-advanced { background: #fce4ec; color: #c2185b; }
        
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            overflow-y: auto;
        }
        
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 0;
            border-radius: 15px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }
        
        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 15px 15px 0 0;
            position: relative;
        }
        
        .modal-header h2 {
            margin: 0;
            font-size: 2rem;
        }
        
        .modal-meta {
            display: flex;
            gap: 20px;
            margin-top: 15px;
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .close {
            position: absolute;
            right: 25px;
            top: 25px;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            color: white;
        }
        
        .close:hover {
            opacity: 0.7;
        }
        
        .modal-body {
            padding: 30px;
        }
        
        .story-text {
            font-size: 1.1rem;
            line-height: 1.8;
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

<div class="stories-container">
    <a href="/" class="back-home">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>
    
    <div class="stories-header">
        <h1>Learn English Through Stories</h1>
        <p>Immerse yourself in engaging narratives that will improve your vocabulary, comprehension, and language skills. Each story is carefully crafted for different proficiency levels.</p>
    </div>
    
    <div class="stories-grid">
        <div class="story-card">
            <img src="${pageContext.request.contextPath}/assets/imgs/feature1.jpg" alt="A Busy Morning" class="story-image">
            <div class="story-content">
                <h3 class="story-title">A Busy Morning</h3>
                <span class="story-level difficulty-basic">Basic</span>
                <p class="story-description">Follow Sarah's hectic morning routine as she prepares for an important job interview. Learn everyday vocabulary and simple present tense.</p>
                <div class="story-stats">
                    <span><i class="fas fa-clock"></i> 5 min read</span>
                    <span><i class="fas fa-users"></i> 1.2k readers</span>
                </div>
                <a href="#" class="read-story-btn" onclick="openStoryModal('a-busy-morning')">Read Story</a>
            </div>
        </div>
        
        <div class="story-card">
            <img src="${pageContext.request.contextPath}/assets/imgs/feature2.jpg" alt="The Birthday Party" class="story-image">
            <div class="story-content">
                <h3 class="story-title">The Birthday Party</h3>
                <span class="story-level difficulty-basic">Basic</span>
                <p class="story-description">Join Emma and her friends as they plan and celebrate her 25th birthday. Practice social vocabulary and future tense expressions.</p>
                <div class="story-stats">
                    <span><i class="fas fa-clock"></i> 7 min read</span>
                    <span><i class="fas fa-users"></i> 890 readers</span>
                </div>
                <a href="/stories" class="read-story-btn">Coming Soon</a>
            </div>
        </div>
        
        <div class="story-card">
            <img src="${pageContext.request.contextPath}/assets/imgs/feature3.jpg" alt="A Trip to the Park" class="story-image">
            <div class="story-content">
                <h3 class="story-title">A Trip to the Park</h3>
                <span class="story-level difficulty-basic">Basic</span>
                <p class="story-description">Experience a beautiful afternoon in the park with the Johnson family. Learn nature vocabulary and descriptive adjectives.</p>
                <div class="story-stats">
                    <span><i class="fas fa-clock"></i> 6 min read</span>
                    <span><i class="fas fa-users"></i> 1.5k readers</span>
                </div>
                <a href="/stories" class="read-story-btn">Coming Soon</a>
            </div>
        </div>
        
        <div class="story-card">
            <img src="${pageContext.request.contextPath}/assets/imgs/quiz.jpg" alt="Coffee Order" class="story-image">
            <div class="story-content">
                <h3 class="story-title">Coffee Order</h3>
                <span class="story-level difficulty-intermediate">Intermediate</span>
                <p class="story-description">Navigate a coffee shop conversation and learn useful phrases for ordering food and drinks in English-speaking countries.</p>
                <div class="story-stats">
                    <span><i class="fas fa-clock"></i> 8 min read</span>
                    <span><i class="fas fa-users"></i> 2.1k readers</span>
                </div>
                <a href="/stories" class="read-story-btn">Coming Soon</a>
            </div>
        </div>
        
        <div class="story-card">
            <img src="${pageContext.request.contextPath}/assets/imgs/Lesson.jpg" alt="Digital Nomading" class="story-image">
            <div class="story-content">
                <h3 class="story-title">Digital Nomading</h3>
                <span class="story-level difficulty-intermediate">Intermediate</span>
                <p class="story-description">Follow Alex's journey as a digital nomad working remotely from different countries. Learn travel and technology vocabulary.</p>
                <div class="story-stats">
                    <span><i class="fas fa-clock"></i> 10 min read</span>
                    <span><i class="fas fa-users"></i> 1.8k readers</span>
                </div>
                <a href="/stories" class="read-story-btn">Coming Soon</a>
            </div>
        </div>
        
        <div class="story-card">
            <img src="${pageContext.request.contextPath}/assets/imgs/writing.jpg" alt="Sustainable Fashion" class="story-image">
            <div class="story-content">
                <h3 class="story-title">Sustainable Fashion</h3>
                <span class="story-level difficulty-advanced">Advanced</span>
                <p class="story-description">Explore the world of eco-friendly fashion through Maria's sustainable clothing business. Advanced vocabulary and complex sentence structures.</p>
                <div class="story-stats">
                    <span><i class="fas fa-clock"></i> 12 min read</span>
                    <span><i class="fas fa-users"></i> 950 readers</span>
                </div>
                <a href="/stories" class="read-story-btn">Coming Soon</a>
            </div>
        </div>
    </div>
</div>

<!-- Story Modal -->
<div id="storyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <span class="close" onclick="closeStoryModal()">&times;</span>
            <h2 id="modalTitle">Story Title</h2>
            <div class="modal-meta">
                <span><i class="fas fa-clock"></i> <span id="modalTime">5 min read</span></span>
                <span><i class="fas fa-signal"></i> <span id="modalLevel">Basic Level</span></span>
                <span><i class="fas fa-book"></i> <span id="modalType">Everyday Vocabulary</span></span>
            </div>
        </div>
        <div class="modal-body" id="modalBody">
            <!-- Story content will be loaded here -->
        </div>
    </div>
</div>

<script>
// Story data
const stories = {
    'a-busy-morning': {
        title: 'A Busy Morning',
        time: '5 min read',
        level: 'Basic Level',
        type: 'Everyday Vocabulary',
        content: `
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
            
            
        `
    }
};

function openStoryModal(storyId) {
    const story = stories[storyId];
    if (story) {
        document.getElementById('modalTitle').textContent = story.title;
        document.getElementById('modalTime').textContent = story.time;
        document.getElementById('modalLevel').textContent = story.level;
        document.getElementById('modalType').textContent = story.type;
        document.getElementById('modalBody').innerHTML = story.content;
        document.getElementById('storyModal').style.display = 'block';
        document.body.style.overflow = 'hidden'; // Prevent background scrolling
    }
}

function closeStoryModal() {
    document.getElementById('storyModal').style.display = 'none';
    document.body.style.overflow = 'auto'; // Restore scrolling
}



// Close modal when clicking outside of it
window.onclick = function(event) {
    const modal = document.getElementById('storyModal');
    if (event.target === modal) {
        closeStoryModal();
    }
}

// Close modal with Escape key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeStoryModal();
    }
});
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
        <p>© 2025 LinguaFem</p>
        <p>🌐 UIT project</p>
    </div>
</footer>
</body>
</html>
