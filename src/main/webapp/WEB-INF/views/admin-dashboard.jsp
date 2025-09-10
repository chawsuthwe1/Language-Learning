<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url var="lessonsUrl"    value="/admin/lessons"/>
<c:url var="quizzesUrl"    value="/admin/quizzes"/>
<c:url var="assignUrl"     value="/admin/assignments"/>
<c:url var="certsUrl"      value="/admin/certificates"/>
<c:url var="paymentsUrl"   value="/admin/payments"/>
<c:url var="studentsUrl"   value="/admin/students"/>
<c:url var="adminsUrl"     value="/admin/admins"/>
<c:url var="settingsUrl"   value="/admin/settings"/>
<c:url var="activityUrl"   value="/admin/activity"/>
<c:url var="logoutUrl"     value="/logout"/>
<html>
<head>
    <title>Admin Dashboard</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
  :root{
    /* layout */
    --sidebar-w: 180px;
    --sidebar-w-collapsed: 72px;

    /* light theme tokens */
    --bg-grad-1: #d8b4fe;
    --bg-grad-2: #c084fc;
    --bg-grad-3: #f9a8d4;
    --surface: rgba(255,255,255,.82);
    --surface-strong: rgba(255,255,255,.9);
    --glass-border: rgba(255,255,255,.28);
    --text: #0f172a;
    --muted: #64748b;
    --primary: #6366f1;
    --ok: #10b981;
    --danger: #ef4444;
    --shadow: 0 10px 30px rgba(2,6,23,.12);
    --blur: 14px;
  }

  /* DARK THEME */
  :root[data-theme="dark"]{
    --bg-grad-1: #0f172a;
    --bg-grad-2: #1f2937;
    --bg-grad-3: #4338ca;
    --surface: rgba(17,24,39,.58);
    --surface-strong: rgba(17,24,39,.66);
    --glass-border: rgba(255,255,255,.12);
    --text: #e5e7eb;
    --muted: #a3a3a3;
    --primary: #8b5cf6;
    --ok: #22c55e;
    --danger: #f87171;
    --shadow: 0 12px 36px rgba(0,0,0,.45);
    --blur: 18px;
  }

  /* base + animated gradient */
  *{box-sizing:border-box}
  html,body{height:100%}
  body{
    margin:0; font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
    color: var(--text);
    background: radial-gradient(1200px 800px at 10% 10%, var(--bg-grad-3) 0%, transparent 40%),
                radial-gradient(1000px 700px at 90% 20%, var(--bg-grad-2) 0%, transparent 45%),
                radial-gradient(1200px 900px at 50% 100%, var(--bg-grad-1) 0%, transparent 55%),
                linear-gradient(135deg, var(--bg-grad-1), var(--bg-grad-2), var(--bg-grad-3));
    background-size: 140% 140%;
    animation: gradientShift 18s ease infinite;
  }
  @keyframes gradientShift{
    0%{background-position:0% 50%}
    50%{background-position:100% 50%}
    100%{background-position:0% 50%}
  }
  @media (prefers-reduced-motion: reduce){ body{animation:none} }

  /* GLASS surfaces */
  .card, .kpi, .panel, .header{
    background: var(--surface);
    backdrop-filter: blur(var(--blur));
    -webkit-backdrop-filter: blur(var(--blur));
    border: 1px solid var(--glass-border);
    box-shadow: var(--shadow);
  }

  /* ===== Sidebar (glass) ===== */
  .sidebar{
    position:fixed; inset:0 auto 0 0; height:100vh;
    width:var(--sidebar-w);
    background: linear-gradient(180deg, rgba(99,102,241,.28), rgba(168,85,247,.22));
    backdrop-filter: blur(calc(var(--blur) + 4px));
    -webkit-backdrop-filter: blur(calc(var(--blur) + 4px));
    color:#fff; padding:20px 12px;
    border-right: 1px solid var(--glass-border);
    box-shadow: 8px 0 30px rgba(0,0,0,.18);
    transition: width .2s ease;
    overflow:hidden;
  }
  .sidebar .brand{display:flex;align-items:center;gap:10px;justify-content:center;margin:6px 0 18px;font-weight:800;letter-spacing:.3px}
  .nav{list-style:none;margin:0;padding:0}
  .nav a{
    display:flex;align-items:center;gap:12px;
    padding:11px 12px;margin:4px 6px;border-radius:12px;
    color:#fff;text-decoration:none;font-weight:700;font-size:14px;
    transition:background .15s ease, transform .15s ease;
    white-space:nowrap;
  }
  .nav a:hover,.nav a.active{background:rgba(255,255,255,.15); transform: translateX(2px);}
  .nav i{min-width:24px;text-align:center;font-size:16px}
  .nav .label{opacity:1;transition:opacity .15s}

  /* ===== Collapsed via BODY CLASS (robust) ===== */
  .sidebar { width: var(--sidebar-w); }
  body.sidebar-collapsed .sidebar { width: var(--sidebar-w-collapsed); }
  body.sidebar-collapsed .sidebar .brand .text { display:none; }
  body.sidebar-collapsed .sidebar .nav .label { opacity:0; pointer-events:none; }

  /* header + main shift */
  .header,.main{margin-left:var(--sidebar-w); transition:margin-left .2s ease}
  body.sidebar-collapsed .header,
  body.sidebar-collapsed .main{margin-left:var(--sidebar-w-collapsed)}

  /* ===== Header ===== */
  .header{
    padding:14px 20px;
    display:flex;align-items:center;justify-content:space-between;gap:12px;
    position:sticky;top:0;z-index:10;
  }
  .left-head{display:flex;align-items:center;gap:10px}
  .title{font-size:20px;font-weight:900;margin:0}
  .icon-btn{
    width:38px;height:38px;border-radius:12px;border:1px solid var(--glass-border);
    display:flex;align-items:center;justify-content:center;
    background: var(--surface-strong); cursor:pointer; font-size:16px; transition:all .15s ease;
  }
  .icon-btn:hover{transform: translateY(-1px)}
  .actions{display:flex;gap:6px;align-items:center} /* smaller gap so toggle sits close to logout */
  .logout{color:var(--danger);font-weight:800;text-decoration:none}

  /* ===== Main ===== */
  .main{padding:22px}

  /* ===== Welcome banner ===== */
  .welcome{
    background: linear-gradient(135deg, rgba(255,255,255,.16), rgba(255,255,255,.10));
    backdrop-filter: blur(calc(var(--blur) + 6px));
    -webkit-backdrop-filter: blur(calc(var(--blur) + 6px));
    border: 1px solid var(--glass-border);
    color: #fff;
    border-radius: 22px; padding: 28px 30px; margin-bottom: 26px;
    display:flex;align-items:center;justify-content:space-between;gap:18px;
    box-shadow: var(--shadow);
  }
  .welcome .title{font-size:24px;font-weight:900;margin:0 0 6px;letter-spacing:.2px}
  .welcome .subtitle{margin:0;font-size:14px;opacity:.92}
  .cta{display:flex;gap:10px}
  .btn{
    padding:12px 16px;border-radius:12px;text-decoration:none;font-weight:800;
    border:1px solid rgba(255,255,255,.6);color:#fff;transition:all .15s ease;
  }
  .btn:hover{background:rgba(255,255,255,.18)}
  .btn-solid{background:var(--ok);border-color:var(--ok)}
  .btn-solid:hover{background:#059669}

  /* ===== KPIs ===== */
  .kpis{display:grid;grid-template-columns:repeat(auto-fit,minmax(190px,1fr));gap:16px;margin-bottom:24px}
  .kpi{border-radius:14px;padding:16px;display:flex;align-items:center;gap:12px}
  .kpi .icon{width:42px;height:42px;border-radius:12px;display:flex;align-items:center;justify-content:center}
  .kpi .icon.blue {background:rgba(99,102,241,.18);color:#818cf8}
  .kpi .icon.teal {background:rgba(16,185,129,.18);color:#34d399}
  .kpi .icon.amber{background:rgba(245,158,11,.18);color:#fbbf24}
  .kpi .icon.rose {background:rgba(244,63,94,.18); color:#fb7185}
  .kpi .label{font-size:12px;color:var(--muted)}
  .kpi .value{font-size:22px;font-weight:900}

  /* ===== Cards ===== */
  .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:18px}
  .card{border-radius:16px;padding:22px;text-align:center;transition:transform .15s ease, box-shadow .15s ease}
  .card:hover{transform:translateY(-4px)}
  .card i{font-size:28px;color:var(--primary);margin-bottom:10px}
  .card a{font-size:16px;font-weight:800;text-decoration:none;color:var(--text)}
  .count{margin-top:6px;font-size:13px;color:var(--muted)}

  /* ===== Activity panel ===== */
  .panel{border-radius:16px;padding:18px;margin-top:24px}
  .panel h3{margin:0 0 12px;font-size:18px;font-weight:900}
  .activity-item{padding:10px 0;border-bottom:1px solid var(--glass-border)}
  .activity-item:last-child{border-bottom:none}
  .meta{font-size:12px;color:var(--muted)}
  .view-all{display:inline-block;margin-top:10px;color:var(--primary);font-weight:800;text-decoration:none}

  /* ===== Responsive: auto collapse ===== */
  @media (max-width:1024px){
    body.sidebar-collapsed .sidebar{width:var(--sidebar-w-collapsed)}
    body.sidebar-collapsed .header,
    body.sidebar-collapsed .main{margin-left:var(--sidebar-w-collapsed)}
    .sidebar{width:var(--sidebar-w-collapsed)}
    .header,.main{margin-left:var(--sidebar-w-collapsed)}
    .sidebar .brand .text,.nav .label{display:none}
  }
  </style>
</head>
<body>

    <!-- Sidebar -->
  <div id="sidebar" class="sidebar">
    <div class="brand">
      <i class="fas fa-graduation-cap"></i>
      <span class="text">LinguaFem Admin</span>
    </div>
       <ul class="nav">
            <li> <a href="${pageContext.request.contextPath}/admin/manage-lessons"><i class="fas fa-book"></i>Manage Lessons</a></li>
            <li> <a href="<c:url value='/admin/lesson-quizzes' />"><i class="fas fa-question-circle"></i> Lesson Quizzes</a></li>
            <li> <a href="<c:url value='/admin/placement-questions' />"><i class="fas fa-clipboard-list"></i>Manage Placement Questions</a></li>
           
            <li> <a href="<c:url value='/admin/placement-questions' />"><i class="fas fa-tasks"></i> Manage Speaking</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/certificates"><i class="fas fa-certificate"></i> Approve Certificates</a></li>
       
            <li><a href="${pageContext.request.contextPath}/admin/students"><i class="fas fa-users"></i>Manage Students</a></li>
            <li> <a href="${pageContext.request.contextPath}/admin/admins"><i class="fas fa-users"></i>Manage Admins</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/final-tests"><i class="fas fa-clipboard-check"></i>Manage Final Tests</a></li>
            
            <li><a href="${pageContext.request.contextPath}/admin/settings"><i class="fas fa-clipboard-check"></i>Setting</a></li>
            <li><a href="${activityUrl}">Recent Activity<i class="fas fa-clipboard-check"></i>View logs & updates</a></li>
        </ul>
    </div>

     <!-- Header -->
  <div class="header">
    <div class="left-head">
      <button id="sidebarToggle" class="icon-btn" type="button" aria-label="Toggle sidebar" title="Toggle sidebar">
        <i class="fas fa-bars"></i>
      </button>
      <h1 class="title">Admin Dashboard</h1>
    </div>
    <div class="actions">
      <a class="logout" href="${logoutUrl}"><i class="fas fa-sign-out-alt"></i> Logout</a>
      <button id="themeToggle" class="icon-btn" type="button" title="Toggle theme" aria-label="Toggle theme">
        <i id="themeIcon" class="fas fa-moon"></i>
      </button>
    </div>
  </div>
    

    <div class="main">
    <!-- Welcome -->
      <div class="welcome">
        <div>
          <p class="title">Welcome back, Admin 👋</p>
          <p class="subtitle">Today is <span id="todayStr"></span>. Review activity, track payments, and manage content below.</p>
        </div>
      </div>
        <div class="card-grid">
            <div class="card">
                <i class="fas fa-book"></i>
                <a href="${pageContext.request.contextPath}/admin/manage-lessons">Manage Lessons</a>
                <div class="count">Reading, Vocabulary, Listening, Grammar</div>
            </div>

            <div class="card">
                <i class="fas fa-question-circle"></i>
                <a href="<c:url value='/admin/lesson-quizzes' />">Lesson Quizzes</a>
                <div class="count">Manage by level</div>
            </div>

            <div class="card">
                <i class="fas fa-clipboard-list"></i>
                <a href="<c:url value='/admin/placement-questions' />">Manage Placement Questions</a>
                <div class="count">Add/edit/delete test items</div>
            </div>

           
<!-- Manage Speaking -->
<div class="card">
  <i class="fas fa-microphone"></i>
  <a href="${pageContext.request.contextPath}/admin/speaking">Manage Speaking</a>
  <div class="count">speaking exercises</div>
</div>



            <div class="card">
                <i class="fas fa-users"></i>
		<a href="${pageContext.request.contextPath}/admin/students">
		  <i class="fas fa-user-graduate"></i> Manage Students
		</a>
                <div class="count">${studentCount} students</div>
            </div>
<div class="card">
			    <i class="fas fa-user-shield"></i>
			    <a href="${pageContext.request.contextPath}/admin/admins">Manage Admins</a>
			    <div class="count">${adminCount} admins</div>
			</div>
            <div class="card">
                <i class="fas fa-certificate"></i>
                <a href="${pageContext.request.contextPath}/admin/certificates">Approve Certificates</a>
                <div class="count">Track issued certificates</div>
            </div>

           
<div class="card">
                <i class="fas fa-clipboard-check"></i>
                <a href="${pageContext.request.contextPath}/admin/final-tests">Manage Final Tests</a>
                <div class="count">${finalTestCount} tests</div>
            </div>

            <div class="card">
                <i class="fas fa-cogs"></i>
				<a href="${pageContext.request.contextPath}/admin/settings">Settings</a>
                <div class="count">Customize dashboard</div>
            </div>
<div class="card"><i class="fas fa-history"></i><a href="${activityUrl}">Recent Activity</a><div class="count">View logs & updates</div></div>
    </div>

           <!-- Recent 5 Activity -->
    <div class="panel">
      <h3>Recent Activity</h3>
      <c:choose>
        <c:when test="${empty recentActivities}">
          <div class="meta">No recent activity yet.</div>
        </c:when>
        <c:otherwise>
          <c:forEach var="a" items="${recentActivities}">
            <div class="activity-item">
              <div><strong><c:out value="${a.type}"/></strong> — <c:out value="${a.description}"/></div>
              <div class="meta">by <c:out value="${a.actor}"/> • <c:out value="${a.timestamp}"/></div>
</div>
 </c:forEach>
        </c:otherwise>
      </c:choose>
      <a class="view-all" href="${activityUrl}">View all activity →</a>
            
        </div>
    </div>

   <script>
    // Friendly date in banner
    (function(){
      const el=document.getElementById('todayStr');
      if(el){
        const d=new Date();
        el.textContent=d.toLocaleDateString(undefined,{weekday:'long',year:'numeric',month:'long',day:'numeric'});
      }
    })();

    // Sidebar collapse using BODY CLASS (robust) + persistence
    (function(){
      const KEY = 'lf_sidebar_collapsed';
      // Restore saved state
      if(localStorage.getItem(KEY)==='1'){
        document.body.classList.add('sidebar-collapsed');
      }
      const btn = document.getElementById('sidebarToggle');
      if(btn){
        btn.addEventListener('click', function(e){
          e.preventDefault();
          document.body.classList.toggle('sidebar-collapsed');
          localStorage.setItem(KEY, document.body.classList.contains('sidebar-collapsed') ? '1' : '0');
        });
      }
    })();

    // Dark mode toggle + persistence
    (function(){
      const key = 'lf_theme';
      const root = document.documentElement;
      const icon = document.getElementById('themeIcon');
      const btn  = document.getElementById('themeToggle');

      const saved = localStorage.getItem(key);
      if(saved === 'dark' || (!saved && window.matchMedia('(prefers-color-scheme: dark)').matches)){
        root.setAttribute('data-theme','dark');
        if(icon){ icon.classList.remove('fa-moon'); icon.classList.add('fa-sun'); }
      }

      if(btn){
        btn.addEventListener('click', () => {
          const isDark = root.getAttribute('data-theme') === 'dark';
          root.setAttribute('data-theme', isDark ? '' : 'dark');
          localStorage.setItem(key, isDark ? 'light' : 'dark');
          if(icon){
            icon.classList.toggle('fa-moon', isDark);
            icon.classList.toggle('fa-sun', !isDark);
          }
        });
      }
    })();
  </script>
  
  <script>
  (function(){
    // If server stored a preference in session, write it to localStorage so your existing toggle code uses it.
    var serverPref = '<%= (session.getAttribute("themePref") != null) ? session.getAttribute("themePref") : "system" %>';
    if (serverPref && serverPref !== 'system') {
      localStorage.setItem('lf_theme', serverPref);
      if (serverPref === 'dark') {
        document.documentElement.setAttribute('data-theme', 'dark');
      } else {
        document.documentElement.setAttribute('data-theme', '');
      }
    }
  })();
</script>
</body>
</html>
