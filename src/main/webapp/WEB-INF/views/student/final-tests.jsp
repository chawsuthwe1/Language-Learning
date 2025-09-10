<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Final Tests - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f8d7eb, #caa8f5, #eaefff);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .test-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            border-left: 4px solid #3498db;
            transition: transform 0.2s ease;
        }
        .test-card:hover {
            transform: translateY(-2px);
        }
        .test-info {
            margin-bottom: 20px;
        }
        .test-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .stat-item {
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: 5px;
            border: 1px solid #e9ecef;
        }
        .stat-number {
            font-size: 1.5em;
            font-weight: bold;
            color: #3498db;
        }
        .stat-label {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: all 0.3s ease;
            text-align: center;
        }
        .btn-primary { 
            background: linear-gradient(135deg, #3498db, #2980b9); 
            color: white; 
        }
        .btn-success { 
            background: linear-gradient(135deg, #27ae60, #229954); 
            color: white; 
        }
        .btn-secondary { 
            background: #6c757d; 
            color: white; 
        }
        .btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        .warning-box {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 15px;
            margin: 20px 0;
            color: #856404;
        }
        .info-box {
            background: #d1ecf1;
            border: 1px solid #bee5eb;
            border-radius: 5px;
            padding: 15px;
            margin: 20px 0;
            color: #0c5460;
        }
        .test-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-graduation-cap"></i> Final Tests</h1>
            <p>Complete your final assessment to demonstrate your language proficiency</p>
        </div>

        <div class="info-box">
            <h4><i class="fas fa-info-circle"></i> Important Information</h4>
            <ul>
                <li>Each final test consists of 4 sessions with multiple-choice questions</li>
                <li>You need to score at least <strong>40%</strong> to pass</li>
                <li>Once you start a test, you must complete all sessions</li>
                <li>You can only take each test once</li>
            </ul>
        </div>

        <div class="tests-list">
            <c:forEach var="test" items="${finalTests}">
                <div class="test-card">
                    <div class="test-info">
                        <h3>${test.title}</h3>
                        <p>${test.description}</p>
                    </div>
                    
                    <div class="test-stats">
                        <div class="stat-item">
                            <div class="stat-number">${test.totalQuestions}</div>
                            <div class="stat-label">Total Questions</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">4</div>
                            <div class="stat-label">Sessions</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">${test.passingScore}%</div>
                            <div class="stat-label">Passing Score</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">~${Math.ceil(test.totalQuestions * 2)}min</div>
                            <div class="stat-label">Est. Time</div>
                        </div>
                    </div>

                    <div class="warning-box">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>Warning:</strong> Make sure you have a stable internet connection and enough time to complete all sessions before starting.
                    </div>

                    <div class="test-actions">
                        <a href="${pageContext.request.contextPath}/student/final-test/${test.id}/start" 
                           class="btn btn-primary"
                           onclick="return confirm('Are you ready to start the final test? You cannot pause or restart once you begin.')">
                            <i class="fas fa-play"></i> Start Test
                        </a>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty finalTests}">
                <div style="text-align: center; padding: 50px;">
                    <i class="fas fa-clipboard-list" style="font-size: 48px; color: #bbb; margin-bottom: 20px;"></i>
                    <h3>No Final Tests Available</h3>
                    <p>There are currently no active final tests. Please check back later.</p>
                </div>
            </c:if>
        </div>

        <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/student-dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>
