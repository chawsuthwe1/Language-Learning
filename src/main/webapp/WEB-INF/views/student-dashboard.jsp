<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
 <!-- Certificate Notifications -->
    <div id="certificate-notifications" style="position: fixed; top: 80px; right: 20px; width: 300px; z-index: 999;">
        <!-- Notifications will appear here -->
    </div>

    <!-- Header -->
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="LinGua Logo">
            <span>Lingua<span class="highlight">Fem</span></span>
        </div>
        <nav class="nav-links">
            <span>Welcome, ${student.name}!</span>
            <a href="${pageContext.request.contextPath}/" class="outline-btn" style="margin-right: 10px;">
                <i class="fas fa-home"></i> Back to Homepage
            </a>
            <a href="${pageContext.request.contextPath}/student-dashboard/logout" class="outline-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </header>

    <!-- Main Content -->
    <main style="padding: 2rem; max-width: 1200px; margin: 0 auto;">
        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div style="background: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; text-align: center;">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; text-align: center;">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <!-- Welcome Section -->
        <section class="welcome-section" style="text-align: center; margin-bottom: 3rem; margin-top: 140px;">
            <h1 style="font-size: 2.5rem; margin-bottom: 1rem; color: #333;">
                Welcome back, <span class="gradient-text">${student.name}</span>!
            </h1>
            <p style="font-size: 1.1rem; color: #666; margin-bottom: 2rem;">
                Continue your language learning journey with LinguaFem
            </p>
        </section>

        <!-- Profile Card -->
        <section class="profile-section" style="margin-bottom: 3rem;">
            <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                <div style="display: flex; align-items: center; gap: 2rem; justify-content: space-between;">
                    <div style="display: flex; align-items: center; gap: 2rem;">
                        <div style="width: 80px; height: 80px; border-radius: 50%; overflow: hidden; border: 3px solid #a436f1;">
                            <img src="${pageContext.request.contextPath}/assets/imgs/${student.image != null ? student.image : 'blank-profile.webp'}" 
                                 alt="Profile Picture" 
                                 style="width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <div>
                            <h2 style="font-size: 1.5rem; margin-bottom: 0.5rem; color: #333;">${student.name}</h2>
                            <p style="color: #666; margin-bottom: 0.5rem;"><i class="fas fa-envelope"></i> ${student.email}</p>
                            <p style="color: #666;"><i class="fas fa-user-graduate"></i> Student ID: ${student.user_id}</p>
                             <p style="color: #666;"><i class="fas fa-user-graduate"></i> Level: ${empty student.level ? 'Not assessed' : student.level}</p>
                        </div>
                    </div>
                    <div>
                        <a href="<c:url value='/student-dashboard/edit-profile'/>" class="outline-btn">
                            <i class="fas fa-user-edit"></i> Edit Profile
                        </a>
                    </div>
                </div>
            </div>
        </section>

       <!-- Dashboard Cards -->
        <section class="dashboard-cards">
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; margin-bottom: 3rem;">
                
                <!-- Lessons Card -->
                <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease;">
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #a436f1, #d41e78); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
                            <i class="fas fa-book-open" style="color: white; font-size: 1.5rem;"></i>
                        </div>
                        <h3 style="font-size: 1.3rem; margin-bottom: 0.5rem; color: #333;">Interactive Lessons</h3>
                        <p style="color: #666; margin-bottom: 1.5rem;">Master new concepts with our interactive learning modules</p>
                        <a href="${pageContext.request.contextPath}/student/levels" class="primary-btn" style="display: inline-block;">
                            <i class="fas fa-play"></i> Start Learning
                        </a>
                    </div>
                </div>


                <!-- Quiz Card -->
                <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease;">
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #ff6b6b, #feca57); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
                            <i class="fas fa-question-circle" style="color: white; font-size: 1.5rem;"></i>
                        </div>
                        <h3 style="font-size: 1.3rem; margin-bottom: 0.5rem; color: #333;">Certificate</h3>
                        <p style="color: #666; margin-bottom: 1.5rem;">Get your Certificates</p>
                    <c:choose>
  <c:when test="${not empty cert and not empty cert.id}">
    <a href="${pageContext.request.contextPath}/cert/download/${cert.id}" class="outline-btn">
      <i class="fas fa-clipboard-check"></i> View My Certificate
    </a>
  </c:when>
  <c:otherwise>
    <a href="${pageContext.request.contextPath}/cert/status" class="outline-btn">
      <i class="fas fa-clipboard-check"></i> View My Certificate
    </a>
  </c:otherwise>
</c:choose>
                    </div>
                </div>

               
                <!-- Communication Card -->
                <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease;">
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #1dd1a1, #10ac84); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
                            <i class="fas fa-comments" style="color: white; font-size: 1.5rem;"></i>
                        </div>
                        <h3 style="font-size: 1.3rem; margin-bottom: 0.5rem; color: #333;">Conversation Practice</h3>
                        <p style="color: #666; margin-bottom: 1.5rem;">Practice pronunciation</p>
                        <a href="${pageContext.request.contextPath}/student/speaking" class="outline-btn" style="display: inline-block;">
                            <i class="fas fa-microphone"></i> Start Practicing
                        </a>
                    </div>
                </div>


                <!-- Final Test Card -->
                <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease;">
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #6c5ce7, #a29bfe); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
                            <i class="fas fa-clipboard-check" style="color: white; font-size: 1.5rem;"></i>
                        </div>
                        <h3 style="font-size: 1.3rem; margin-bottom: 0.5rem; color: #333;">Final Test</h3>
                        <p style="color: #666; margin-bottom: 1.5rem;">Take your final assessment to demonstrate proficiency</p>
                        <a href="${pageContext.request.contextPath}/student/final-test" class="primary-btn" style="display: inline-block;">
                            <i class="fas fa-graduation-cap"></i> Take Final Test
                        </a>
                    </div>
                </div>

               
                </div>
        
        </section>

       
    </main>

    <!-- Footer -->
    <footer style="background: white; padding: 2rem; text-align: center; margin-top: 3rem; box-shadow: 0 -2px 5px rgba(0,0,0,0.1);">
        <p style="color: #666;">&copy; 2025 LinguaFem. All rights reserved.</p>
    </footer>

    <script>
        // Add hover effects to dashboard cards
        document.querySelectorAll('.dashboard-cards > div > div').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Add click effects to buttons
        document.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', function(e) {
                if (this.getAttribute('href') === '#') {
                    e.preventDefault();
                    alert('This feature is coming soon!');
                }
            });
        });
    </script>
  <script>
  const ctx = '${pageContext.request.contextPath}';

  function fetchCertificateNotifications() {
    fetch(ctx + '/cert/check-notifications')
      .then(res => res.json())
      .then(data => {
        const container = document.getElementById('certificate-notifications');
        container.innerHTML = '';
        data.forEach(cert => {
          const div = document.createElement('div');
          div.style.background = '#fffae6';
          div.style.border = '1px solid #ffe58f';
          div.style.borderRadius = '8px';
          div.style.padding = '12px';
          div.style.marginBottom = '10px';

          div.innerHTML =
            '<strong>Certificate Ready:</strong> ' + (cert.courseName || '') + '<br/>' +
            '<a href="' + ctx + '/cert/pay?cid=' + cert.id + '" ' +
            'style="color:#d48806;font-weight:bold;">Pay Now</a>';

          container.appendChild(div);
        });
      })
      .catch(err => console.error('Error fetching notifications:', err));
  }

  fetchCertificateNotifications(); // initial load
  setInterval(fetchCertificateNotifications, 30000); // poll every 30s
</script>

</body>
</html>