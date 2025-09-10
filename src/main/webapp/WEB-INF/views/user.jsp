<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../assets/css/user.css" rel="stylesheet" />
<link href="../assets/imgs/logo.jpg" rel="icon" />
<!-- Bootstrap (if you use it) -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>


</head>
<body>
<header>
    <div class="logo">
        <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="Logo">
        <a href="/" class="site-title">Lingua<span class="highlight">Fem</span></a>
    </div>

    </header>


<!-- Sign Up form -->
<div class="container d-flex justify-content-center align-items-center min-vh-100 ">
  <div class="sign-card p-4">

    <!-- ⭐ badge -->
    <div class="badge-circle"><i class="fa-solid fa-star"></i></div>

    <h4 class="text-center fw-bold text-primary mb-4" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Join LinguaFem</h4>
    <h4 class="text-center fw-bold text-primary mb-4" style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Start your personalized language learning adventure</h4>

    <form id="signupForm" method="post" action="../register" onsubmit="return validateForm()">
      <!-- Email -->
      <div class="mb-2">
        <label for="email" class="form-label">Email address</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="your@gmail.com" required>
      </div>

      <!-- Name -->
      <div class="mb-2">
        <label for="name" class="form-label">Fullname</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="yourname" required>
      </div>

      <!-- Password -->
      <div class="mb-2">
        <label for="password" class="form-label">Password</label>

        <div class="input-wrap">
          <input type="password" class="form-control" id="password" name="password" placeholder="RequiresCapitalLetter,SmallLetter,Number,SpecialCharacter" required>
          <button type="button" class="peek" aria-label="Show password"><i class="fa-regular fa-eye"></i></button>
        </div>

        <div id="passwordHelp" class="form-text text-danger d-none">
          Password must be at least 8 characters, include uppercase, lowercase, digit, and symbol.
        </div>
      </div>

      <!-- Retype Password -->
      <div class="mb-3">
        <label for="repassword" class="form-label">Confirm Password</label>

        <div class="input-wrap">
          <input type="password" class="form-control" id="repassword" name="repassword" placeholder="Please type your password exactly" required>
          <button type="button" class="peek" aria-label="Show password"><i class="fa-regular fa-eye"></i></button>
        </div>

        <div id="matchHelp" class="form-text text-danger d-none">Passwords do not match.</div>
      </div>

      <button type="submit" class="btn btn-primary w-100">Sign Up</button>
    </form>
  </div>
</div>


<!-- form validation -->
<script>
function validateForm() {
  const pwd = document.getElementById('password').value;
  const repwd = document.getElementById('repassword').value;
  const pwdHelp = document.getElementById('passwordHelp');
  const matchHelp = document.getElementById('matchHelp');

  // Strong password pattern
  const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$/;

  let isValid = true;

  if (!strongRegex.test(pwd)) {
    pwdHelp.classList.remove('d-none');
    isValid = false;
  } else {
    pwdHelp.classList.add('d-none');
  }

  if (pwd !== repwd) {
    matchHelp.classList.remove('d-none');
    isValid = false;
  } else {
    matchHelp.classList.add('d-none');
  }

  return isValid;
}
document.querySelectorAll('.input-wrap .peek').forEach(function(btn){
    btn.addEventListener('click', function(){
      const input = this.previousElementSibling;
      const icon  = this.querySelector('i');
      const show  = input.type === 'password';
      input.type = show ? 'text' : 'password';
      icon.classList.toggle('fa-eye', !show);
      icon.classList.toggle('fa-eye-slash', show);
    });
  });
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>