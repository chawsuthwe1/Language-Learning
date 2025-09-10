-- Final Test Database Schema
-- Execute this script in your MySQL database to create the necessary tables

-- Create final_tests table
CREATE TABLE IF NOT EXISTS final_tests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    total_questions INT NOT NULL DEFAULT 20,
    passing_score INT NOT NULL DEFAULT 40,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create final_test_questions table
CREATE TABLE IF NOT EXISTS final_test_questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    final_test_id BIGINT NOT NULL,
    question TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_answer ENUM('A', 'B', 'C', 'D') NOT NULL,
    session_number INT NOT NULL CHECK (session_number BETWEEN 1 AND 4),
    difficulty ENUM('Easy', 'Medium', 'Hard') DEFAULT 'Medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (final_test_id) REFERENCES final_tests(id) ON DELETE CASCADE,
    INDEX idx_final_test_session (final_test_id, session_number)
);

-- Create final_test_results table
CREATE TABLE IF NOT EXISTS final_test_results (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    final_test_id BIGINT NOT NULL,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    passed BOOLEAN NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    answers TEXT, -- JSON string storing student answers
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (final_test_id) REFERENCES final_tests(id) ON DELETE CASCADE,
    INDEX idx_student_test (student_id, final_test_id),
    INDEX idx_test_results (final_test_id, passed)
);

-- Insert sample final test
INSERT INTO final_tests (title, description, total_questions, passing_score, is_active) VALUES 
('English Proficiency Final Test', 'Comprehensive final assessment covering all language skills including grammar, vocabulary, reading comprehension, and language usage. This test consists of 4 sessions with multiple-choice questions.', 20, 40, TRUE);

-- Get the ID of the inserted test (assuming it's 1 for sample questions)
SET @test_id = LAST_INSERT_ID();

-- Insert sample questions for Session 1 (Grammar & Vocabulary)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(@test_id, 'Choose the correct form of the verb: "She _____ to the store every day."', 'go', 'goes', 'going', 'gone', 'B', 1, 'Easy'),
(@test_id, 'What is the synonym of "happy"?', 'sad', 'angry', 'joyful', 'tired', 'C', 1, 'Easy'),
(@test_id, 'Choose the correct article: "I saw _____ elephant at the zoo."', 'a', 'an', 'the', 'no article', 'B', 1, 'Medium'),
(@test_id, 'Which sentence is grammatically correct?', 'He don''t like pizza.', 'He doesn''t likes pizza.', 'He doesn''t like pizza.', 'He not like pizza.', 'C', 1, 'Medium'),
(@test_id, 'What is the past tense of "run"?', 'runned', 'ran', 'running', 'runs', 'B', 1, 'Easy');

-- Insert sample questions for Session 2 (Reading Comprehension)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(@test_id, 'Based on the context: "The weather was terrible, so we decided to stay indoors." What does "terrible" mean?', 'very good', 'very bad', 'very cold', 'very hot', 'B', 2, 'Medium'),
(@test_id, 'Choose the best title for a story about friendship:', 'The Lonely Mountain', 'Friends Forever', 'Cooking Recipes', 'Space Adventure', 'B', 2, 'Easy'),
(@test_id, 'What is the main idea of this sentence: "Regular exercise improves both physical and mental health"?', 'Exercise is difficult', 'Exercise has multiple benefits', 'Exercise is only for athletes', 'Exercise is expensive', 'B', 2, 'Medium'),
(@test_id, 'In the sentence "Although it was raining, they went for a walk," what does "although" indicate?', 'time', 'contrast', 'cause', 'result', 'B', 2, 'Hard'),
(@test_id, 'Choose the correct inference: "The library was completely silent." This suggests:', 'people were sleeping', 'people were studying quietly', 'the library was closed', 'there were no books', 'B', 2, 'Medium');

-- Insert sample questions for Session 3 (Advanced Grammar)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(@test_id, 'Choose the correct conditional: "If I _____ rich, I would travel the world."', 'am', 'was', 'were', 'will be', 'C', 3, 'Hard'),
(@test_id, 'Select the passive voice: "The teacher explained the lesson."', 'The lesson explained by the teacher.', 'The lesson was explained by the teacher.', 'The lesson is explaining by the teacher.', 'The teacher was explained the lesson.', 'B', 3, 'Hard'),
(@test_id, 'Choose the correct relative pronoun: "The book _____ I read was interesting."', 'who', 'which', 'that', 'whom', 'C', 3, 'Medium'),
(@test_id, 'What is the correct reported speech: He said, "I am tired."', 'He said that he was tired.', 'He said that he is tired.', 'He said that I am tired.', 'He said that he will be tired.', 'A', 3, 'Hard'),
(@test_id, 'Choose the correct form: "I wish I _____ speak French fluently."', 'can', 'could', 'will', 'would', 'B', 3, 'Hard');

-- Insert sample questions for Session 4 (Practical Usage)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(@test_id, 'What is the most polite way to ask for help?', 'Give me help now!', 'Help me!', 'Could you please help me?', 'You must help me.', 'C', 4, 'Medium'),
(@test_id, 'Choose the appropriate response to "Thank you very much."', 'Yes', 'No problem', 'You''re welcome', 'Okay', 'C', 4, 'Easy'),
(@test_id, 'In a formal email, which greeting is most appropriate?', 'Hey there!', 'Hi!', 'Dear Sir/Madam,', 'What''s up?', 'C', 4, 'Medium'),
(@test_id, 'What does "break a leg" mean in English?', 'hurt yourself', 'good luck', 'run fast', 'sit down', 'B', 4, 'Hard'),
(@test_id, 'Choose the best way to express disagreement politely:', 'You are wrong!', 'That''s stupid!', 'I respectfully disagree.', 'No way!', 'C', 4, 'Medium');
