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
    <title>Edit Profile - LinguaFem</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .profile-form {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #a436f1;
        }
        
        .profile-picture-section {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .current-picture {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #a436f1;
            margin-bottom: 1rem;
        }
        
        .file-input-wrapper {
            position: relative;
            display: inline-block;
        }
        
        .file-input {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .file-input-label {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: linear-gradient(to right, #a436f1, #d41e78);
            color: white;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s ease;
        }
        
        .file-input-label:hover {
            transform: translateY(-2px);
        }
        
        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }
        
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/assets/imgs/logo.jpg" alt="LinGua Logo">
            <span>Lingua<span class="highlight">Fem</span></span>
        </div>
        <nav class="nav-links">
            <span>Edit Profile</span>
            <a href="${pageContext.request.contextPath}/student-dashboard" class="outline-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </nav>
    </header>

    <!-- Main Content -->
    <main style="padding: 2rem; max-width: 800px; margin: 0 auto;">
        <div class="profile-form">
            <h1 style="text-align: center; margin-bottom: 2rem; color: #ffffff;">
                <i class="fas fa-user-edit"></i> Edit Profile
            </h1>
            
            <!-- Flash Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <!-- Profile Picture Section -->
            <div class="profile-picture-section">
                <img src="${pageContext.request.contextPath}/assets/imgs/${student.image != null ? student.image : 'blank-profile.webp'}" 
                     alt="Current Profile Picture" 
                     class="current-picture"
                     id="currentPicture">
                
                <div class="file-input-wrapper">
                    <input type="file" 
                           id="profileImage" 
                           name="profileImage" 
                           class="file-input" 
                           accept="image/*"
                           onchange="previewImage(this)" form="updateProfileForm">
                    <label for="profileImage" class="file-input-label">
                        <i class="fas fa-camera"></i> Change Profile Picture
                    </label>
                </div>
                
                <c:if test="${student.image != null}">
                    <form action="${pageContext.request.contextPath}/student-dashboard/remove-profile-picture" 
                          method="POST" 
                          style="margin-top: 1rem;"
                          onsubmit="return confirm('Are you sure you want to remove your profile picture?')">
                        <button type="submit" class="btn-secondary" style="background: #dc3545; border: none;">
                            <i class="fas fa-trash"></i> Remove Profile Picture
                        </button>
                    </form>
                </c:if>
                
                <p style="color: #666; font-size: 0.9rem; margin-top: 0.5rem;">
                    Supported formats: JPG, PNG, GIF (Max size: 5MB)
                </p>
            </div>
            
            <!-- Profile Form -->
            <form action="${pageContext.request.contextPath}/student-dashboard/update-profile" 
                  method="POST" 
                  enctype="multipart/form-data"
                  onsubmit="return validateForm()" id="updateProfileForm">
                
                <div class="form-group">
                    <label for="name">
                        <i class="fas fa-user"></i> Full Name
                    </label>
                    <input type="text" 
                           id="name" 
                           name="name" 
                           value="${student.name}" 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="email">
                        <i class="fas fa-envelope"></i> Email Address
                    </label>
                    <input type="email" 
                           id="email" 
                           name="email" 
                           value="${student.email}" 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="password">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <input type="password" 
                           id="password" 
                           name="password" 
                           value="${student.password}" 
                           required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">
                        <i class="fas fa-lock"></i> Confirm Password
                    </label>
                    <input type="password" 
                           id="confirmPassword" 
                           name="confirmPassword" 
                           placeholder="Please type your password "
                           required>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="primary-btn">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/student-dashboard" class="btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </main>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    document.getElementById('currentPicture').src = e.target.result;
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 6) {
                alert('Password must be at least 6 characters long!');
                return false;
            }
            
            return true;
        }
        
        // File size validation
        document.getElementById('profileImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const maxSize = 5 * 1024 * 1024; // 5MB
                if (file.size > maxSize) {
                    alert('File size must be less than 5MB!');
                    this.value = '';
                    return;
                }
                
                // Validate file type
                const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if (!allowedTypes.includes(file.type)) {
                    alert('Please select a valid image file (JPG, PNG, or GIF)!');
                    this.value = '';
                    return;
                }
            }
        });
    </script>
</body>
</html>
