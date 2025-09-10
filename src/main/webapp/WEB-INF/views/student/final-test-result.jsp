<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Final Test Result - ${finalTest.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: linear-gradient(135deg, #f8d7eb, #caa8f5, #eaefff); margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 40px; }
        .result-header { text-align: center; margin-bottom: 40px; }
        .result-icon { font-size: 4em; margin-bottom: 20px; }
        .result-icon.passed { color: #27ae60; }
        .result-icon.failed { color: #e74c3c; }
        .result-title { font-size: 2.5em; font-weight: bold; margin-bottom: 10px; }
        .result-title.passed { color: #27ae60; }
        .result-title.failed { color: #e74c3c; }
        .score-display { background: #f8f9fa; border-radius: 10px; padding: 30px; margin: 30px 0; text-align: center; }
        .score-circle { width: 150px; height: 150px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; font-size: 2.5em; font-weight: bold; color: white; }
        .score-circle.passed { background: linear-gradient(135deg, #27ae60, #229954); }
        .score-circle.failed { background: linear-gradient(135deg, #e74c3c, #c0392b); }
        .score-details { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 20px; margin: 30px 0; }
        .score-item { text-align: center; padding: 20px; background: white; border-radius: 8px; border: 1px solid #e9ecef; }
        .score-number { font-size: 1.8em; font-weight: bold; color: #3498db; }
        .score-label { color: #666; margin-top: 5px; }
        .message-box { padding: 20px; border-radius: 8px; margin: 30px 0; text-align: center; }
        .message-box.passed { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .message-box.failed { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
        .btn { padding: 12px 25px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: bold; transition: all 0.3s ease; margin: 10px; }
        .btn-primary { background: linear-gradient(135deg, #3498db, #2980b9); color: white; }
        .btn-success { background: linear-gradient(135deg, #27ae60, #229954); color: white; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-danger { background: #e74c3c; color: white; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.2); }
        .actions { text-align: center; margin-top: 40px; }
        .test-info { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px; }
        /* Modal Styles */
        #certConfirmModal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); justify-content:center; align-items:center; }
        #certConfirmModal div { background:white; padding:20px; border-radius:10px; max-width:400px; text-align:center; }
    </style>
</head>
<body>
<div class="container">
    <div class="result-header">
        <div class="result-icon ${result.passed ? 'passed' : 'failed'}">
            <i class="fas ${result.passed ? 'fa-check-circle' : 'fa-times-circle'}"></i>
        </div>
        <div class="result-title ${result.passed ? 'passed' : 'failed'}">
            ${result.passed ? 'CONGRATULATIONS!' : 'TEST NOT PASSED'}
        </div>
        <p style="color: #666; font-size: 1.1em;">
            ${finalTest.title} - Final Assessment
        </p>
    </div>

    <div class="test-info">
        <h3>${finalTest.title}</h3>
        <p>${finalTest.description}</p>
        <p><strong>Completed on:</strong> ${result.completedAt}</p>
    </div>

    <div class="score-display">
        <div class="score-circle ${result.passed ? 'passed' : 'failed'}">
            ${Math.round(result.percentage)}%
        </div>
        <h3>Your Final Score</h3>
    </div>

    <div class="score-details">
        <div class="score-item">
            <div class="score-number">${result.score}</div>
            <div class="score-label">Correct Answers</div>
        </div>
        <div class="score-item">
            <div class="score-number">${result.totalQuestions}</div>
            <div class="score-label">Total Questions</div>
        </div>
        <div class="score-item">
            <div class="score-number">${finalTest.passingScore}%</div>
            <div class="score-label">Required to Pass</div>
        </div>
        <div class="score-item">
            <div class="score-number ${result.passed ? 'passed' : 'failed'}" style="color: ${result.passed ? '#27ae60' : '#e74c3c'};">
                ${result.passed ? 'PASS' : 'FAIL'}
            </div>
            <div class="score-label">Result</div>
        </div>
    </div>

    <div class="message-box ${result.passed ? 'passed' : 'failed'}">
        <c:choose>
            <c:when test="${result.passed}">
                <h4><i class="fas fa-trophy"></i> Excellent Work!</h4>
                <p>You have successfully passed the final test with a score of ${Math.round(result.percentage)}%. 
                This demonstrates your strong understanding of the material. You can now proceed to request your certificate!</p>
            </c:when>
            <c:otherwise>
                <h4><i class="fas fa-info-circle"></i> Keep Learning!</h4>
                <p>You scored ${Math.round(result.percentage)}%, below the required ${finalTest.passingScore}% passing score. 
                Review the material and try again.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="actions">
        <c:choose>
            <c:when test="${result.passed}">
                <button type="button" id="requestCertBtn" class="btn btn-success">
                    <i class="fas fa-certificate"></i> Get Certificate
                </button>
                <a href="${pageContext.request.contextPath}/student-dashboard" class="btn btn-secondary">
                    <i class="fas fa-home"></i> Back to Dashboard
                </a>
            </c:when>
            <c:otherwise>
               <a href="${pageContext.request.contextPath}/student/levels" class="primary-btn" style="display: inline-block;">
                    <i class="fas fa-book"></i> Review Lessons
                </a>
               <a href="${pageContext.request.contextPath}/student-dashboard" class="back-to-dashboard">
            ← Back to Dashboard
        </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Confirmation Modal -->
<div id="certConfirmModal">
    <div>
        <p>✅ You are about to request your certificate for this course.<br>
           Certificates require admin approval. Once approved, a payment of ${certificateFee} will be required before you can download it.</p>
        <button id="confirmRequest" class="btn btn-success">Confirm Request</button>
        <button id="cancelRequest" class="btn btn-danger">Cancel</button>
    </div>
</div>

<script>
const modal = document.getElementById('certConfirmModal');
const requestBtn = document.getElementById('requestCertBtn');
const cancelBtn = document.getElementById('cancelRequest');
const confirmBtn = document.getElementById('confirmRequest');

if(requestBtn) requestBtn.onclick = () => modal.style.display = 'flex';
if(cancelBtn) cancelBtn.onclick = () => modal.style.display = 'none';
if(confirmBtn) confirmBtn.onclick = async () => {
    const resp = await fetch('${pageContext.request.contextPath}/cert/request/from-final/${finalTest.id}', {
        method:'POST',
        credentials:'same-origin'
    });
    if(resp.ok){
        const data = await resp.json();
        window.location.href = '${pageContext.request.contextPath}/cert/status?cid=' + data.certificateId;
    } else {
        alert('Failed to request certificate.');
    }
};
</script>
</body>
</html>
