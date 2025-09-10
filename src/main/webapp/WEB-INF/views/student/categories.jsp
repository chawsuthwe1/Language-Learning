<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${level} Level • Skills Overview</title>
    <style>
        :root {
            --radius: 16px;
            --shadow: 0 12px 32px rgba(0,0,0,0.1);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f8e3f4, #e0eaff);
            color: #1f2d3a;
        }
        h1 {
            color: transparent;
            background-clip: text;
            background-image: linear-gradient(to right, #a436f1, #d41e78);
            font-size: 3rem;
            font-weight: 700;
            text-align: left;
            margin-bottom: 1.5rem;
            margin-top: 1rem;
        }
        .container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 3rem;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
        }
        .breadcrumbs {
            font-size: 1rem;
            margin-bottom: 1rem;
            color: #555;
        }
        .level-switch {
            margin-top: 0.5rem;
            text-align: right;
        }
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }
        .skill-card {
            background: white;
            border-radius: var(--radius);
            padding: 1.5rem 1.75rem;
            box-shadow: var(--shadow);
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            transition: transform 0.2s ease-in-out;
        }
        .skill-card:hover {
            transform: translateY(-5px);
        }
        .skill-card h3 {
            margin: 0;
            font-size: 1.5rem;
            color: #333;
        }
        .skill-desc {
            flex: 1;
            font-size: 1.1rem;
            line-height: 1.5;
            color: #555;
        }
        .action {
            margin-top: auto;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: background-color 0.2s, transform 0.2s;
        }
        .btn-primary {
            background: #c800ff;
            color: white;
            font-size: 1.1rem;
        }
        .btn-primary:hover {
            background: #a613cf;
            transform: scale(1.02);
        }
        .small-note {
            font-size: .9rem;
            color: #333;
            margin-top: .75rem;
        }
        h2 {
            font-size: 2rem;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div>
                <div class="breadcrumbs">
                    <span><a href="/student-dashboard">Home</a> > <span>${level} Level</span></span>
                </div>
                <h1>${level} Level</h1>
                <div class="small-note">Choose a skill to start learning. Each category includes lessons, exercises, and quizzes.</div>
            </div>
            <div class="level-switch">
                <span>Current Level:</span>
                <strong>${level}</strong>
                <div style="margin-top:7px;">
                    <a href="/student/levels" class="btn btn-primary" style="padding: 0.75rem 1.5rem; font-size: 0.9rem;">Change Level</a>
                </div>
            </div>
        </header>

        <div class="skills-grid">
            <!-- Vocabulary -->
            <div class="skill-card">
                <h3>Vocabulary</h3>
                <div class="skill-desc">
                    Learn and review core words, their meanings, and usage in context. Build your language foundation.
                </div>
                <div class="action">
                    <a href="/student/${level}/vocabulary" class="btn btn-primary">Start Learning</a>
                </div>
            </div>

            <!-- Grammar -->
            <div class="skill-card">
                <h3>Grammar</h3>
                <div class="skill-desc">
                    Understand sentence structure, verb tenses, and basic rules to build correct and meaningful sentences.
                </div>
                <div class="action">
                    <a href="/student/${level}/grammar" class="btn btn-primary">Start Learning</a>
                </div>
            </div>

            <!-- Reading -->
            <div class="skill-card">
                <h3>Reading</h3>
                <div class="skill-desc">
                    Improve comprehension with engaging texts. Focus on vocabulary, main ideas, and details.
                </div>
                <div class="action">
                    <a href="/student/${level}/reading" class="btn btn-primary">Start Learning</a>
                </div>
            </div>

            <!-- Listening -->
            <div class="skill-card">
                <h3>Listening</h3>
                <div class="skill-desc">
                    Train your ear with real-life conversations and audio clips. Identify key words and phrases.
                </div>
                <div class="action">
                    <a href="/student/${level}/listening" class="btn btn-primary">Start Learning</a>
                </div>
            </div>
        </div>

        <section style="margin-top:5rem;">
            <h2>Recommended Next Steps</h2>
            <p>Practice one skill per day, then combine them: read a passage and summarize it aloud or in writing.</p>
        </section>
    </div>
</body>
</html>