<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url var="dashboardUrl" value="/admin/dashboard"/>
<c:url var="postUrl"      value="/admin/settings"/>

<html>
<head>
  <title>Settings • Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    /* Reuse your dashboard tokens if present; provide fallbacks */
    :root{
      --text:#0f172a; --muted:#64748b; --ok:#10b981; --danger:#ef4444; --primary:#6366f1;
      --glass-border:rgba(255,255,255,.28);
      --surface:rgba(255,255,255,.85); --blur:14px;
    }
    body{
      margin:0; font-family:Inter,system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif; color:var(--text);
      background: linear-gradient(135deg,#d8b4fe,#c084fc,#f9a8d4);
      background-size: 400% 400%; animation: g 16s ease infinite;
    }
    @keyframes g{0%{background-position:0% 50%}50%{background-position:100% 50%}100%{background-position:0% 50%}}

    .wrap{max-width:1100px;margin:28px auto;padding:0 18px}
    .topbar{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px}
    .title{font-size:22px;font-weight:800;margin:0;color:#111827}
    .back{color:#111827;text-decoration:none;font-weight:700;border:1px solid rgba(255,255,255,.5);
          padding:10px 12px;border-radius:12px;background:rgba(255,255,255,.75);backdrop-filter:blur(8px)}
    .grid{display:grid;grid-template-columns:1fr;gap:16px}
    .card{background:var(--surface);backdrop-filter:blur(var(--blur));border:1px solid var(--glass-border);
          border-radius:16px;box-shadow:0 6px 24px rgba(0,0,0,.1);padding:18px}
    .card h3{margin:0 0 10px;font-size:16px}
    .row{display:grid;grid-template-columns:repeat(2,minmax(200px,1fr));gap:12px}
    .field{display:flex;flex-direction:column;gap:6px}
    label{font-size:12px;color:var(--muted)}
    input[type="text"], input[type="email"], input[type="number"], input[type="password"], input[type="url"], select{
      padding:10px 12px;border-radius:10px;border:1px solid #e5e7eb;background:#fff;outline:none
    }
    .switch{position:relative;width:46px;height:26px}
    .switch input{opacity:0;width:0;height:0}
    .slider{position:absolute;cursor:pointer;inset:0;background:#e5e7eb;border-radius:999px;transition:.2s}
    .slider:before{content:"";position:absolute;height:20px;width:20px;left:3px;top:3px;background:#fff;border-radius:50%;transition:.2s}
    .switch input:checked + .slider{background:#10b981}
    .switch input:checked + .slider:before{transform:translateX(20px)}
    .note{font-size:12px;color:var(--muted)}
    .actions{position:sticky;bottom:14px;display:flex;gap:10px;justify-content:flex-end;margin-top:16px}
    .btn{padding:11px 14px;border-radius:12px;border:1px solid #e5e7eb;background:#fff;cursor:pointer;font-weight:800}
    .btn-primary{background:var(--ok);border-color:var(--ok);color:#fff}
    .btn-light{background:rgba(255,255,255,.75)}
    @media (max-width:840px){ .row{grid-template-columns:1fr} }
    /* Consistent form rows */
.form-row{
  margin-bottom:18px;
  display:flex;
  flex-direction:column;
}

/* Labels above inputs/buttons */
.form-row > label{
  font-weight:600;
  margin-bottom:6px;
}

/* Fix: put buttons on a row with spacing under label */
.export-buttons{
  display:flex;
  flex-wrap:wrap;
  gap:12px;
  margin-top:6px;        /* ← prevents overlap with label */
}

/* CSV pill buttons */
.btn-csv{
  display:inline-flex;
  align-items:center;
  gap:8px;
  padding:10px 16px;
  border-radius:10px;
  text-decoration:none;
  background:#ffffff;
  border:1px solid rgba(0,0,0,.08);
  color:#1f2937;
  font-weight:700;
  box-shadow:0 4px 12px rgba(0,0,0,.04);
  transition:transform .12s ease, background .2s ease, box-shadow .2s ease;
}
.btn-csv:hover{
  background:#f3f4f6;
  transform:translateY(-1px);
  box-shadow:0 10px 24px rgba(0,0,0,.06);
}

/* Secondary action button look (backup) */
.btn-secondary{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  padding:10px 16px;
  border-radius:10px;
  background:linear-gradient(180deg,#ffffff,rgba(255,255,255,.9));
  border:1px solid rgba(0,0,0,.08);
  color:#111827;
  font-weight:700;
  text-decoration:none;
  box-shadow:0 6px 18px rgba(0,0,0,.05);
}
.btn-secondary:hover{ background:#f8fafc; }

/* Small responsive helper for the backup button */
@media (max-width: 640px){
  .w-full-md{ width:100%; }
}
    
  </style>
</head>
<body>
  <div class="wrap">
    <div class="topbar">
      <h1 class="title">Settings</h1>
      <a href="${dashboardUrl}" class="back"><i class="fa-solid fa-arrow-left"></i> Back</a>
    </div>

	<c:url var="postUrl" value="/admin/settings/save"/>
	<form method="post" action="${postUrl}">
	  <!-- If you use Spring Security, include CSRF: -->
	  <c:if test="${_csrf != null}">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  </c:if>      
	  <!-- GENERAL -->
      <div class="card">
        <h3><i class="fa-solid fa-gear"></i> General</h3>
        <div class="row">
          <div class="field">
            <label>Platform name</label>
            <input type="text" name="platformName" value="${platformName}">
          </div>
          <div class="field">
            <label>Support email</label>
            <input type="email" name="supportEmail" value="${supportEmail}">
          </div>
          <div class="field">
            <label>Default language</label>
            <select name="defaultLang">
              <option value="en" ${platformName == null || defaultLang == 'en' ? 'selected' : ''}>English</option>
              <option value="mm" ${defaultLang == 'mm' ? 'selected' : ''}>Myanmar</option>
              <option value="es" ${defaultLang == 'es' ? 'selected' : ''}>Spanish</option>
            </select>
          </div>
          <div class="field">
            <label>Timezone</label>
            <select name="timezone">
              <option ${timezone=='UTC'?'selected':''}>UTC</option>
              <option ${timezone=='Asia/Yangon'?'selected':''}>Asia/Yangon</option>
              <option ${timezone=='Asia/Bangkok'?'selected':''}>Asia/Bangkok</option>
              <option ${timezone=='America/New_York'?'selected':''}>America/New_York</option>
            </select>
          </div>
          <div class="field">
            <label>Maintenance mode</label>
            <label class="switch">
              <input type="checkbox" name="maintenance">
              <span class="slider"></span>
            </label>
            <span class="note">Temporarily hide the site from students.</span>
          </div>
        </div>
      </div>

      <!-- APPEARANCE -->
      <div class="card">
        <h3><i class="fa-solid fa-palette"></i> Appearance</h3>
        <div class="row">
          <div class="field">
            <label>Theme</label>
            <select name="theme">
			  <option value="system" ${themePref == 'system' ? 'selected' : ''}>System</option>
			  <option value="light"  ${themePref == 'light'  ? 'selected' : ''}>Light</option>
			  <option value="dark"   ${themePref == 'dark'   ? 'selected' : ''}>Dark</option>
			</select>

          </div>
          <div class="field">
            <label>Brand color (hex)</label>
            <input type="text" name="brandColor" placeholder="#6366F1">
          </div>
          <div class="field">
            <label>Compact layout</label>
            <label class="switch">
              <input type="checkbox" name="compact">
              <span class="slider"></span>
            </label>
          </div>
        </div>
      </div>

      <!-- USERS & ROLES -->
      <div class="card">
        <h3><i class="fa-solid fa-user-shield"></i> Users & Roles</h3>
        <div class="row">
          <div class="field">
            <label>Allow self-signup</label>
            <label class="switch">
              <input type="checkbox" name="selfSignup">
              <span class="slider"></span>
            </label>
          </div>
          <div class="field">
            <label>Default role for invites</label>
            <select name="defaultRole">
              <option>Student</option>
              <option>Admin</option>
            </select>
          </div>
          <div class="field">
            <label>Password min length</label>
            <input type="number" min="6" max="64" name="pwdMin" value="8">
          </div>
          <div class="field">
            <label>Require number & symbol</label>
            <label class="switch">
              <input type="checkbox" name="pwdStrong" checked>
              <span class="slider"></span>
            </label>
          </div>
          <div class="field">
            <label>Session timeout (minutes)</label>
            <input type="number" min="5" max="720" name="sessionMins" value="60">
          </div>
        </div>
      </div>

      <!-- NOTIFICATIONS -->
      <div class="card">
        <h3><i class="fa-solid fa-bell"></i> Notifications</h3>
        <div class="row">
          <div class="field">
            <label>Admin alerts (payments, refunds)</label>
            <label class="switch">
              <input type="checkbox" name="adminAlerts" checked>
              <span class="slider"></span>
            </label>
          </div>
          <div class="field">
            <label>Student notifications (new lessons, quiz results)</label>
            <label class="switch">
              <input type="checkbox" name="studentNoti" checked>
              <span class="slider"></span>
            </label>
          </div>
          <div class="field">
            <label>Email sender name</label>
            <input type="text" name="emailSender" placeholder="LinguaFem">
          </div>
          <div class="field">
            <label>Email from address</label>
            <input type="email" name="emailFrom" placeholder="no-reply@linguafem.io">
          </div>
        </div>
      </div>

      <!-- PAYMENTS -->
      <div class="card">
        <h3><i class="fa-solid fa-credit-card"></i> Payments</h3>
        <div class="row">
          <div class="field">
            <label>Currency</label>
            <select name="currency">
              <option value="USD" ${currency=='USD'?'selected':''}>USD</option>
              <option value="EUR" ${currency=='EUR'?'selected':''}>EUR</option>
              <option value="MMK" ${currency=='MMK'?'selected':''}>MMK</option>
            </select>
          </div>
          <div class="field">
            <label>Tax / VAT %</label>
            <input type="number" min="0" max="40" step="0.1" name="tax" value="0">
          </div>
          <div class="field">
            <label>Stripe publishable key</label>
            <input type="text" name="stripePub" placeholder="pk_live_******">
          </div>
          <div class="field">
            <label>Stripe secret key (hidden)</label>
            <input type="password" name="stripeSec" placeholder="sk_live_******">
          </div>
          <div class="field">
            <label>Payments webhook URL</label>
            <input type="url" name="webhook" placeholder="https://yourapp.com/webhooks/stripe" readonly>
          </div>
        </div>
      </div>

      <!-- SECURITY -->
      <div class="card">
        <h3><i class="fa-solid fa-lock"></i> Security</h3>
        <div class="row">
          <div class="field">
            <label>Require 2FA for admins</label>
            <label class="switch">
              <input type="checkbox" name="require2fa">
              <span class="slider"></span>
            </label>
          </div>
          <div class="field">
            <label>IP allowlist (comma separated)</label>
            <input type="text" name="ipAllow" placeholder="127.0.0.1, 203.0.113.4">
          </div>
          <div class="field">
            <label>reCAPTCHA site key</label>
            <input type="text" name="recaptchaSite">
          </div>
          <div class="field">
            <label>reCAPTCHA secret key</label>
            <input type="password" name="recaptchaSecret">
          </div>
        </div>
      </div>

      <!-- INTEGRATIONS -->
      <div class="card">
        <h3><i class="fa-solid fa-plug"></i> Integrations</h3>
        <div class="row">
          <div class="field">
            <label>SMTP host</label>
            <input type="text" name="smtpHost" placeholder="smtp.sendgrid.net">
          </div>
          <div class="field">
            <label>SMTP port</label>
            <input type="number" name="smtpPort" value="587">
          </div>
          <div class="field">
            <label>SMTP username</label>
            <input type="text" name="smtpUser">
          </div>
          <div class="field">
            <label>SMTP password</label>
            <input type="password" name="smtpPass">
          </div>
          <div class="field">
            <label>GA4 Measurement ID</label>
            <input type="text" name="gaId" placeholder="G-XXXXXXX">
          </div>
          <div class="field">
            <label>Webhook signing secret</label>
            <input type="password" name="webhookSecret">
          </div>
        </div>
      </div>

      <!-- Data & Backups -->
	<div class="section">
	  <h3><i class="fas fa-database"></i> Data &amp; Backups</h3>
	
	  <div class="form-row">
	    <label for="retentionDays">Data retention (days)</label>
	    <input id="retentionDays" type="number" name="retention" value="365"/>
	  </div>
	
	  <div class="form-row">
	    <label>Manual backup</label>
	    <button type="button" class="btn-secondary w-full-md">Run backup</button>
	  </div>
	
	  <div class="form-row">
	    <label>Export data</label>
	
	    <!-- ✅ button row fixed -->
	    <div class="export-buttons">
	      <a class="btn-csv"
	         href="${pageContext.request.contextPath}/admin/settings/export/students">
	        Students CSV
	      </a>
	
	      <a class="btn-csv"
	         href="${pageContext.request.contextPath}/admin/settings/export/activity">
	        Activity CSV
	      </a>
	    </div>
	  </div>
	</div>


      <!-- Save Bar -->
      <div class="actions">
        <button class="btn btn-light" type="reset">Reset</button>
        <button class="btn btn-primary" type="submit"><i class="fa-solid fa-floppy-disk"></i> Save Changes</button>
      </div>
    </form>
  </div>
</body>
</html>