<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Placement Result - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="LinGua Logo">
        <a href="${pageContext.request.contextPath}/" class="site-title">Lingua<span class="highlight">Fem</span></a>
    </div>
    <nav class="nav-links">
        <span>Placement Result</span>
        <a href="${pageContext.request.contextPath}/" class="outline-btn">
            <i class="fas fa-home"></i> Home
        </a>
        <!-- Simple Login link in nav -->
        <a href="${pageContext.request.contextPath}/login" class="outline-btn">
            <i class="fas fa-sign-in-alt"></i> Login
        </a>
    </nav>
</header>

<main style="padding: 2rem; max-width: 800px; margin: 140px auto 0;">
    <div style="background: white; border-radius: 15px; padding: 2rem; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align:center;">
        <h1>Your Level: <span class="gradient-text">${level}</span></h1>
        <p style="color:#666;">Score: ${score} / ${total}</p>

        <!-- Decide the next page: if not logged in => /register, else => /login -->
        <c:choose>
            <c:when test="${empty sessionScope.student and empty sessionScope.admin}">
                <c:set var="nextUrl" value='${pageContext.request.contextPath}/register' />
                <c:set var="buttonIcon" value='fa-user-plus' />
                <c:set var="buttonText" value='Register to save progress' />
            </c:when>
            <c:otherwise>
                <c:set var="nextUrl" value='${pageContext.request.contextPath}/login' />
                <c:set var="buttonIcon" value='fa-sign-in-alt' />
                <c:set var="buttonText" value='Login to save progress' />
            </c:otherwise>
        </c:choose>

        <form action="${pageContext.request.contextPath}/placement/save-intent" method="post" style="margin-top:1.5rem; text-align:left; display:inline-block;">
            <%-- If you use Spring Security, include CSRF:
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            --%>

            <!-- Persist these values via session on the server -->
            <input type="hidden" name="score" value="${score}">
            <input type="hidden" name="total" value="${total}">
            <input type="hidden" name="level" value="${level}">

            <!-- Tell the controller where to go next -->
            <input type="hidden" name="next" value="${nextUrl}"/>

            <label style="display:flex; gap:.5rem; align-items:center; margin-bottom:1rem;">
                <input type="checkbox" name="save" value="1">
                <span>Save my score and set my level to my account</span>
            </label>

            <button type="submit" class="primary-btn">
                <i class="fas ${buttonIcon}"></i> ${buttonText}
            </button>
        </form>
    </div>
</main>

<footer style="background: white; padding: 2rem; text-align: center; margin-top: 3rem; box-shadow: 0 -2px 5px rgba(0,0,0,0.1);">
    <p style="color: #666;">&copy; 2025 LinGua. All rights reserved.</p>
</footer>
</body>
</html>
