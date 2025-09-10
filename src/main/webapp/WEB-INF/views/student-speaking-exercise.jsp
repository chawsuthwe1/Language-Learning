<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>${exercise.title}</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body{font-family:'Inter',system-ui,Segoe UI,Roboto,Arial,sans-serif;background:#faf9ff;margin:0;padding:36px;display:flex;justify-content:center;}
    .wrap{max-width:920px;width:100%;background:#fff;border-radius:20px;box-shadow:0 10px 28px rgba(0,0,0,.06);padding:28px;}
    h2{margin:0 0 14px;font-size:24px;font-weight:900;}
    .subtitle{color:#6b7280;margin:0 0 10px;}
    .target{font-size:20px;line-height:1.7;margin:18px 0 6px;padding:24px;border-radius:14px;background:#f8fafc;text-align:center;}
    #target span{padding:2px 2px;border-radius:5px}
    .ok{color:#16a34a;font-weight:700}
    .bad{color:#dc2626;font-weight:700}
    .btnMain{display:block;margin:20px auto 8px;padding:16px 42px;border-radius:16px;border:0;color:#fff;cursor:pointer;font-size:16px;font-weight:800;background:linear-gradient(100deg,#8b5cf6,#ec4899);box-shadow:0 10px 24px rgba(139,92,246,.28)}
    .btnGhost{display:block;margin:8px auto 18px;padding:12px 26px;border-radius:14px;border:1px solid #d1d5db;background:#fff;font-weight:700;cursor:pointer}
    .center{text-align:center;color:#6b7280}
    #status{ text-align:center; margin:6px 0 0; font-weight:700; color:#6b7280;}
    .listening{ color:#7c3aed; }
    #score{text-align:center;margin-top:14px;font-weight:800}
    .tips{margin-top:20px;padding:18px;border-radius:16px;background:linear-gradient(90deg,#faf5ff,#fafaff)}
    .tips h4{margin:0 0 10px;font-size:16px;font-weight:900;display:flex;gap:8px;align-items:center}
    .tips ul{margin:0;padding:0;list-style:none;display:grid;grid-template-columns:1fr 1fr;gap:8px;color:#6b7280}
    .tips li::before{content:"•";margin-right:6px;color:#a855f7}
    .sr-warning{background:#fff1f2;color:#b91c1c;border:1px solid #fecaca;padding:10px 12px;border-radius:12px;margin:8px 0 12px;font-weight:600;display:none}
    .btnMain[disabled]{opacity:.5;cursor:not-allowed;box-shadow:none}
    .btnGhost[disabled]{opacity:.6;cursor:not-allowed}
    .pass{ color:#16a34a; }
    .fail{ color:#dc2626; }
  </style>
</head>
<body>
  <div class="wrap">
    <h2>${exercise.title}</h2>
    <p id="srWarning" class="sr-warning"></p>

    <p class="subtitle">Read the sentence aloud, then click “Speak It Out”.</p>

    <div id="target" class="target"></div>

    <button id="speakBtn" class="btnMain"><i class="fa-solid fa-microphone"></i> Speak It Out</button>
    <p id="status" class="center"></p>

    <button id="completeBtn" class="btnGhost" type="button" disabled>✔ Mark as Complete</button>
    <p id="score"></p>

    <div class="tips">
      <h4><i class="fa-solid fa-sparkles"></i> Speaking Tips</h4>
      <ul>
        <li>Read slowly and clearly, focusing on each word</li>
        <li>Practice pronunciation of difficult words</li>
        <li>Pay attention to rhythm and natural pauses</li>
        <li>Record yourself to track improvement</li>
      </ul>
    </div>
    <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/student-dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
  </div>

<script>
// ---------- Render target text ----------
var rawTarget = '${exercise.content}'.replace(/\s+/g,' ').trim();
var targetWords = rawTarget.split(/\s+/).map(function(w){return norm(w);});
var targetEl = document.getElementById('target');
var scoreEl  = document.getElementById('score');
var statusEl = document.getElementById('status');

targetEl.innerHTML = rawTarget.split(/\s+/)
  .map(function(w){ return '<span>' + escapeHtml(w) + '</span>'; })
  .join(' ');

// ---------- SpeechRecognition (reliable detection) ----------
var SR = window.SpeechRecognition || window.webkitSpeechRecognition;
var speakBtn = document.getElementById('speakBtn');
var completeBtn = document.getElementById('completeBtn');
var srWarning = document.getElementById('srWarning');
var rec = null;
var lastAccuracy = 0;
var PASS = 80; // pass threshold in percent
var markedComplete = false;

function showSRWarning(msg){
  srWarning.textContent = msg;
  srWarning.style.display = 'block';
  speakBtn.setAttribute('disabled','disabled');
}

function setCompleteUI(done){
  if (done){
    markedComplete = true;
    completeBtn.textContent = '✓ Completed';
    completeBtn.setAttribute('disabled','disabled');
    completeBtn.classList.add('pass');
  } else {
    completeBtn.textContent = '✔ Mark as Complete';
    completeBtn.removeAttribute('disabled');
    completeBtn.classList.remove('pass');
  }
}

// only check the real API + secure origin
var isSecure = (location.protocol === 'https:') ||
               (location.hostname === 'localhost') ||
               (location.hostname === '127.0.0.1');

if (!SR) {
  showSRWarning('Speech recognition isn’t available in this browser.');
} else if (!isSecure) {
  showSRWarning('For security, speech recognition needs HTTPS (or http://localhost).');
} else {
  rec = new SR();
  rec.lang = 'en-US';
  rec.interimResults = false;
  rec.maxAlternatives = 1;

  speakBtn.addEventListener('click', function(){
    statusEl.textContent = '🎙️ Listening… speak now';
    statusEl.classList.add('listening');
    scoreEl.textContent = '';
    try { rec.start(); }
    catch(e){
      try { rec.abort(); } catch(_){}
      setTimeout(function(){ try{ rec.start(); }catch(_){ statusEl.textContent='Microphone busy. Try again.'; statusEl.classList.remove('listening'); } },150);
    }
  });

  rec.onstart = function(){
    speakBtn.setAttribute('disabled','disabled');
  };
  rec.onend = function(){
    speakBtn.removeAttribute('disabled');
    statusEl.classList.remove('listening');
  };

  rec.onresult = function(evt){
    var spokenRaw = evt.results[0][0].transcript.trim();
    var spokenWords = spokenRaw.split(/\s+/).map(function(w){return norm(w);});

    var aligned = align(targetWords, spokenWords);
    var A = aligned.alignmentA, B = aligned.alignmentB;

    Array.prototype.forEach.call(targetEl.querySelectorAll('span'), function(s){ s.className=''; });

    var correct=0, shown=0;
    for (var i=0;i<A.length;i++){
      var span = targetEl.children[shown++];
      var ok = (A[i]!==null && B[i]!==null && A[i]===B[i]);
      if (ok){ correct++; span.classList.add('ok'); }
      else    { span.classList.add('bad'); }
    }

    var acc = Math.round((correct/targetWords.length)*100);
    lastAccuracy = acc;

    var cls = acc >= PASS ? 'pass' : 'fail';
    scoreEl.innerHTML = '<span class="'+cls+'">Accuracy: '+acc+'%</span> — You said: "'+escapeHtml(spokenRaw)+'"';

    // enable "Mark as Complete" when passing
    if (acc >= PASS && !markedComplete){
      setCompleteUI(false); // enable button
      // Auto-mark complete (optional). Comment the next line if you want manual click instead.
      autoMarkComplete(acc);
    } else if (!markedComplete){
      // keep button disabled if not passed
      completeBtn.setAttribute('disabled','disabled');
      completeBtn.textContent = '✔ Mark as Complete';
    }

    // Persist the attempt accuracy
    postAccuracy(acc, /*complete*/ false);
  };

  rec.onerror = function(e){
    var map={
      'not-allowed':'Mic permission denied. Please allow access.',
      'no-speech':'No speech detected. Try again closer to the mic.',
      'audio-capture':'No microphone found.',
      'aborted':'Listening aborted. Click again.'
    };
    statusEl.textContent = map[e.error] || ('Speech error: ' + e.error);
    statusEl.classList.remove('listening');
  };

  // Manual "Mark as Complete" click (requires PASS)
  completeBtn.addEventListener('click', function(){
    if (markedComplete) return;
    if (lastAccuracy < PASS){
      // Soft feedback if the user tries to mark with low score
      scoreEl.innerHTML = '<span class="fail">Score below '+PASS+'%. Try again to unlock completion.</span>';
      return;
    }
    autoMarkComplete(lastAccuracy);
  });
}

// ---- Network helpers ----
function postAccuracy(acc, complete){
  var base='${pageContext.request.contextPath}';
  var exerciseId=${exercise.id};
  var body='accuracy='+encodeURIComponent(acc)+(complete?'&complete=1':'');
  fetch(base+'/student/speaking/'+exerciseId+'/submit', {
    method:'POST',
    headers:{'Content-Type':'application/x-www-form-urlencoded'},
    body: body
  }).catch(function(){});
}

function autoMarkComplete(acc){
  setCompleteUI(false); // show enabled state immediately
  postAccuracy(acc, /*complete*/ true);
  // After posting, lock the UI as completed
  setCompleteUI(true);
}

// ---------- Helpers ----------
function norm(w){ return w.toLowerCase().replace(/^[^\w']+|[^\w']+$/g,''); }
function escapeHtml(s){
  return s.replace(/[&<>"']/g,function(m){return({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'})[m];});
}
// Word-level alignment (Levenshtein backtrace)
function align(a,b){
  var n=a.length,m=b.length,dp=Array(n+1),bt=Array(n+1);
  for(var i=0;i<=n;i++){dp[i]=Array(m+1).fill(0);bt[i]=Array(m+1).fill(0);}
  for(i=0;i<=n;i++){dp[i][0]=i;bt[i][0]=1;}
  for(var j=0;j<=m;j++){dp[0][j]=j;bt[0][j]=2;}
  for(i=1;i<=n;i++)for(j=1;j<=m;j++){
    var cost=(a[i-1]===b[j-1])?0:1;
    var d=dp[i-1][j]+1,l=dp[i][j-1]+1,x=dp[i-1][j-1]+cost,best=x,op=0;
    if(d<best){best=d;op=1;} if(l<best){best=l;op=2;}
    dp[i][j]=best;bt[i][j]=op;
  }
  var A=[],B=[],ii=n,jj=m;
  while(ii>0||jj>0){
    var op=bt[ii][jj];
    if(op===0){A.push(a[ii-1]);B.push(b[jj-1]);ii--;jj--;}
    else if(op===1){A.push(a[ii-1]);B.push(null);ii--;}
    else{A.push(null);B.push(b[jj-1]);jj--;}
  }
  A.reverse();B.reverse();
  var outA=[],outB=[];
  for(var k=0;k<A.length;k++){ if(A[k]!==null){ outA.push(A[k]); outB.push(B[k]); } }
  return {alignmentA:outA,alignmentB:outB};
}
</script>
</body>
</html>
