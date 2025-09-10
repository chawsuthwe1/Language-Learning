<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LinguaFem</title>

    <!-- Your CSS (context-safe path) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
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

<section class="hero">
    <div class="container center">
        <h1><span class="gradient-text">Master English</span><br> with Confidence</h1>
        <p>Join our platform to reach your goals.</p>
        <div class="stats">
            <div><span class="stat-num purple">10+</span><br>Active Learners</div>
            <div><span class="stat-num pink">5</span><br>Core Skills</div>
            <div><span class="stat-num blue">4</span><br>Proficiency Levels</div>
        </div>
        <div class="cta-buttons">
            <a class="btn primary-btn" href="${pageContext.request.contextPath}/placement-test">Take Placement Test</a>
        </div>
    </div>
</section>

<!-- Language Skills Section -->
<section class="skills-section">
  <p class="skills-intro">Comprehensive language learning through interactive exercises to build real-world communication abilities</p>
  <div class="skills-grid">
    <div class="skill-card purple-bg">
      <img src="${pageContext.request.contextPath}/assets/imgs/writing.jpg" alt="English Puzzles Icon" class="skill-icon">
      <h3>English Puzzles</h3>
      <p>Solve fun word games and brain teasers to improve your English</p>
             <a href="/english-puzzles" class="start-link">Start Learning →</a>
    </div>
    <div class="skill-card yellow-bg">
      <img src="${pageContext.request.contextPath}/assets/imgs/feature3.jpg" alt="Stories Icon" class="skill-icon">
      <h3>Stories</h3>
      <p>Learn through engaging stories and narratives</p>
      <a href="/stories" class="start-link">Start Learning →</a>
    </div>
    <div class="skill-card beige-bg">
      <img src="${pageContext.request.contextPath}/assets/imgs/Lesson.jpg" alt="Flashcards Icon" class="skill-icon">
      <h3>Flashcards</h3>
      <p>Memorize vocabulary efficiently with spaced repetition</p>
      <a href="/flashcard" class="start-link">Start Learning →</a>
    </div>
  </div>
</section>

<section class="levels-section" id="levels">
  <h2 class="levels-title">Choose Your Level</h2>
  <p class="levels-description">
    Whether you're just starting out or looking to sharpen your skills, find the level that suits you best.
  </p>
  <div class="levels-container">
    <a href="${pageContext.request.contextPath}/user/" class="level-card basic">
      <h3>Basic</h3>
      <p>Start from the very beginning and build your foundation.</p>
    </a>
    <a href="${pageContext.request.contextPath}/placement-test" class="level-card">
      <h3>Pre-Intermediate</h3>
      <p>For learners with some experience. Continue your journey.</p>
    </a>
    <a href="${pageContext.request.contextPath}/placement-test" class="level-card">
      <h3>Intermediate</h3>
      <p>Solidify your grammar and expand your vocabulary.</p>
    </a>
    <a href="/placement-test" class="level-card">
      <h3>Upper-Intermediate</h3>
      <p>Challenge yourself with advanced content and fluency tasks.</p>
    </a>
  </div>
</section>

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
    <p>© 2025 LinguaFem. </p>
    <p>UIT Project</p>
  </div>
</footer>
</body>
</html>
