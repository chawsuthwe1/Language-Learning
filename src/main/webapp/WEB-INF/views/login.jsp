<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/login.css" rel="stylesheet" />
<link href="../assets/imgs/logo.jpg" rel="icon" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">


</head>
<body>

<!--  Navbar -->
<header>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="Logo">
        <a href="/" class="site-title">Lingua<span class="highlight">Fem</span></a>
    </div>

    </header>

<!-- Login Form -->
<main class="login-wrap">
<div class="login-card">
<div class="badge"><i class="fa-solid fa-heart"></i></div>
    <h4 class="welcome" >Welcome Back</h4>
    <p class="subtitle">Continue your language learning journey</p>
    <form method="POST" action="/check">
        <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" name="email" id="email" placeholder="your@gmail.com" required>
        </div>

        <div class="mb-3 password-field">
  <label for="password" class="form-label">Password</label>

  <div class="input-wrap">
    <input type="password" class="form-control" name="password" id="password" placeholder="yourpassword" required>
    <button type="button" class="peek" aria-label="Show password">
      <i class="fa-regular fa-eye"></i>
    </button>
  </div>
</div>


        <div class="mb-5">
            <label for="userType" class="form-label">Choose User :</label>
            <select class="form-select" name="userType" id="userType" required>
                <option value="">Select user</option>
                <option value="student">Student</option>
                <option value="admin">Admin</option>
                
            </select>
        </div>
<div class="row-line">
        <label class="remember"><input type="checkbox"> Remember me</label>
       
      </div>
        <div class="d-grid">
            <button type="submit" class="btn-gradient">Sign In</button>
        </div>
    </form>
</div>
</main>
<script>
  document.querySelector('.password-field .peek')?.addEventListener('click', function () {
    const input = document.getElementById('password');
    const icon  = this.querySelector('i');
    const show  = input.type === 'password';
    input.type = show ? 'text' : 'password';
    icon.classList.toggle('fa-eye', !show);
    icon.classList.toggle('fa-eye-slash', show);
  });
</script>

</body>
</html>
