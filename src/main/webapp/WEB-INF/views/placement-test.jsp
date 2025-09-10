<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Placement Test - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .pt-header { padding: 1.5rem 2rem; border-bottom: 1px solid #eee; position: sticky; top: 96px; background: white; z-index: 5; }
        .back-btn { border: 2px solid #d0d5dd; padding: 0.55rem 1.1rem; border-radius: 10px; font-weight: 600; color: #344054; background: #fff; cursor: pointer; }
        .back-btn:hover { background: #f8fafc; }
        .q-card { background: #fff; border: 1px solid #eceff3; border-radius: 12px; padding: 1rem 1.25rem; box-shadow: 0 6px 16px rgba(0,0,0,.06); margin-bottom: 1rem; }
        header { transition: transform .25s ease; }
        header.hidden { transform: translateY(-100%); }
                 .pill { display:inline-block; padding: .3rem .7rem; border-radius: 999px; background:#efe9ff; color:#5b2bd9; font-weight: 700; font-size: .9rem; }

    </style>
</head>
<body>
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="LinGua Logo">
            <a href="${pageContext.request.contextPath}/" class="site-title">Lingua<span class="highlight">Fem</span></a>
        </div>
        <nav class="nav-links">
            <span>Placement Test</span>
            <a href="${pageContext.request.contextPath}/" class="outline-btn">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
        </nav>
    </header>

    <main style="padding: 2rem; max-width: 900px; margin: 0 auto; margin-top: 90px;">
        <div style="background: white; border-radius: 15px; padding: 0; box-shadow: 0 4px 15px rgba(0,0,0,0.1); overflow: hidden;">
                <div class="pt-header">
                    <h1 style="margin: 0 0 0.5rem 0;">Placement Test</h1>
                    <div style="height: 8px; background: #f1f3f5; border-radius: 999px; overflow: hidden;">
                        <div id="progressBar" style="height: 8px; width: 50%; background: linear-gradient(90deg,#a436f1,#d41e78);"></div>
                    </div>
                  
                </div>

                <form id="placementForm" action="${pageContext.request.contextPath}/placement-test" method="POST">
                    <div id="sections" style="padding: 2rem; margin-top: 90px;">
                        <!-- Vocabulary Section -->
                        <section class="pt-section" data-index="0" style="display:block;">
                            <h2>Vocabulary</h2>
                            <p style="color:#666;">Answer the questions below.</p>
                            <c:forEach var="q" items="${questions}">
                                <c:if test="${q.section == 'Vocabulary'}">
                                    <div class="form-group q-card">
                                        <label><c:out value="${q.questionText}"/></label>
                                        <div>
                                            <c:if test="${not empty q.optionA}">
                                                <label><input type="radio" name="q${q.id}" value="A" required> <c:out value="${q.optionA}"/></label><br/>
                                            </c:if>
                                            <c:if test="${not empty q.optionB}">
                                                <label><input type="radio" name="q${q.id}" value="B" required> <c:out value="${q.optionB}"/></label><br/>
                                            </c:if>
                                            <c:if test="${not empty q.optionC}">
                                                <label><input type="radio" name="q${q.id}" value="C" required> <c:out value="${q.optionC}"/></label><br/>
                                            </c:if>
                                            <c:if test="${not empty q.optionD}">
                                                <label><input type="radio" name="q${q.id}" value="D" required> <c:out value="${q.optionD}"/></label>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </section>


                        <!-- Grammar Section -->
                        <section class="pt-section" data-index="3" style="display:none;">
                            <h2>Grammar</h2>
                            <c:forEach var="q" items="${questions}">
                                <c:if test="${q.section == 'Grammar'}">
                                    <div class="form-group q-card">
                                        <label><c:out value="${q.questionText}"/></label>
                                        <div>
                                            <c:if test="${not empty q.optionA}">
                                                <label><input type="radio" name="q${q.id}" value="A" required> <c:out value="${q.optionA}"/></label><br/>
                                            </c:if>
                                            <c:if test="${not empty q.optionB}">
                                                <label><input type="radio" name="q${q.id}" value="B" required> <c:out value="${q.optionB}"/></label><br/>
                                            </c:if>
                                            <c:if test="${not empty q.optionC}">
                                                <label><input type="radio" name="q${q.id}" value="C" required> <c:out value="${q.optionC}"/></label><br/>
                                            </c:if>
                                            <c:if test="${not empty q.optionD}">
                                                <label><input type="radio" name="q${q.id}" value="D" required> <c:out value="${q.optionD}"/></label>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </section>
                    </div>

                    <div style="display:flex; justify-content: space-between; padding: 1rem 2rem; border-top: 1px solid #eee; background: #fafafa;">
                        <button type="button" id="backBtn" class="back-btn" disabled><i class="fas fa-arrow-left"></i> Back</button>
                        <div>
                            <button type="button" id="nextBtn" class="outline-btn">Next <i class="fas fa-arrow-right"></i></button>
                            <button type="submit" id="submitBtn" class="primary-btn" style="display:none;"><i class="fas fa-check"></i> Submit</button>
                        </div>
                    </div>
                </form>
        </div>
    </main>

    <footer style="background: white; padding: 2rem; text-align: center; margin-top: 3rem; box-shadow: 0 -2px 5px rgba(0,0,0,0.1);">
        <p style="color: #666;">&copy; 2025 LinguaFem. All rights reserved.</p>
    </footer>
    <script>
        (function(){
            const sections = Array.from(document.querySelectorAll('.pt-section'));
            const nextBtn = document.getElementById('nextBtn');
            const backBtn = document.getElementById('backBtn');
            const submitBtn = document.getElementById('submitBtn');
            const progressBar = document.getElementById('progressBar');
            const nav = document.getElementById('ptNav');
            let index = 0;

            function updateView() {
                sections.forEach((s, i) => s.style.display = (i === index ? 'block' : 'none'));
                // Toggle required only on visible section to avoid blocking submission
                sections.forEach((s, i) => {
                    s.querySelectorAll('input[required]').forEach(inp => {
                        inp.required = (i === index);
                    });
                });
                backBtn.disabled = index === 0;
                nextBtn.style.display = index === sections.length - 1 ? 'none' : 'inline-block';
                submitBtn.style.display = index === sections.length - 1 ? 'inline-block' : 'none';
                const pct = Math.round(((index+1) / sections.length) * 100);
                progressBar.style.width = pct + '%';
                window.scrollTo({top: 0, behavior: 'smooth'});
                if (nav) {
                    Array.from(nav.children).forEach((li, i) => {
                        li.classList.toggle('active', i === index);
                    });
                }
                const labels = ['Vocabulary','Grammar'];
                const sectionLabel = document.getElementById('sectionLabel');
                if (sectionLabel) sectionLabel.textContent = `${labels[index]} (${index+1}/${sections.length})`;
            }

            nextBtn.addEventListener('click', () => {
                // Validate current section answered
                const currentSection = sections[index];
                const hasInputs = currentSection.querySelectorAll('input[type="radio"]').length > 0;
                const answered = currentSection.querySelector('input[type="radio"]:checked');
                if (hasInputs && !answered) {
                    alert('Please answer the questions in this section before continuing.');
                    return;
                }
                if (index < sections.length - 1) {
                    index++;
                    updateView();
                }
            });
            backBtn.addEventListener('click', () => {
                if (index > 0) {
                    index--;
                    updateView();
                }
            });
            if (nav) {
                Array.from(nav.children).forEach(li => {
                    li.addEventListener('click', () => {
                        const target = parseInt(li.getAttribute('data-index'));
                        if (!isNaN(target)) {
                            index = target;
                            updateView();
                        }
                    });
                });
            }
            document.getElementById('placementForm').addEventListener('change', () => {
                sections.forEach((section, i) => {
                    const answered = section.querySelector('input[type="radio"]:checked');
                    const li = nav.children[i];
                    if (li) li.classList.toggle('completed', !!answered);
                });
            });
            updateView();
            // Auto-hide header on scroll down, show on scroll up
            let lastY = 0;
            const hdr = document.querySelector('header');
            window.addEventListener('scroll', () => {
                const y = window.scrollY || document.documentElement.scrollTop;
                if (y > lastY && y > 120) hdr.classList.add('hidden');
                else hdr.classList.remove('hidden');
                lastY = y;
            });
        })();
    </script>

    
</body>
</html>


