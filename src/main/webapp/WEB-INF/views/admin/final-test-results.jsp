<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Test Results - ${finalTest.title}</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid #3498db;
        }
        .stat-card.passed {
            border-left-color: #27ae60;
        }
        .stat-card.failed {
            border-left-color: #e74c3c;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .result-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .result-card.passed {
            border-left: 4px solid #27ae60;
        }
        .result-card.failed {
            border-left: 4px solid #e74c3c;
        }
        .student-info {
            flex: 1;
        }
        .score-info {
            text-align: right;
        }
        .percentage {
            font-size: 1.5em;
            font-weight: bold;
        }
        .percentage.passed {
            color: #27ae60;
        }
        .percentage.failed {
            color: #e74c3c;
        }
        .badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .badge-success {
            background: #d4edda;
            color: #155724;
        }
        .badge-danger {
            background: #f8d7da;
            color: #721c24;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .btn-secondary { background: #6c757d; color: white; }
        .btn:hover { transform: translateY(-2px); }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div>
                <h1><i class="fas fa-chart-bar"></i> ${finalTest.title} - Results</h1>
                <p style="margin: 5px 0; color: #666;">${finalTest.description}</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/final-tests" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Tests
                </a>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">${results.size()}</div>
                <div>Total Attempts</div>
            </div>
            <div class="stat-card passed">
                <div class="stat-number">${passedCount}</div>
                <div>Passed (≥40%)</div>
            </div>
            <div class="stat-card failed">
                <div class="stat-number">${failedCount}</div>
                <div>Failed (<40%)</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${results.size() > 0}">
                            ${Math.round((passedCount * 100.0) / results.size())}%
                        </c:when>
                        <c:otherwise>0%</c:otherwise>
                    </c:choose>
                </div>
                <div>Pass Rate</div>
            </div>
        </div>

        <h3>Individual Results</h3>
        <div class="results-list">
            <c:forEach var="result" items="${results}">
                <div class="result-card ${result.passed ? 'passed' : 'failed'}">
                    <div class="student-info">
                        <h4>Student ID: ${result.studentId}</h4>
                        <p style="margin: 5px 0; color: #666;">
                            Completed: ${result.completedAt}
                        </p>
                        <span class="badge ${result.passed ? 'badge-success' : 'badge-danger'}">
                            ${result.passed ? 'PASSED' : 'FAILED'}
                        </span>
                    </div>
                    <div class="score-info">
                        <div class="percentage ${result.passed ? 'passed' : 'failed'}">
                            ${Math.round(result.percentage)}%
                        </div>
                        <div style="color: #666; font-size: 14px;">
                            ${result.score}/${result.totalQuestions} correct
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty results}">
                <div style="text-align: center; padding: 50px;">
                    <i class="fas fa-chart-line" style="font-size: 48px; color: #bbb; margin-bottom: 20px;"></i>
                    <h3>No Results Yet</h3>
                    <p>No students have taken this test yet.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
