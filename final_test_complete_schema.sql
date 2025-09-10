-- Complete Final Test Database Schema for Lingua Application
-- Execute this in phpMyAdmin SQL tab

-- Drop tables if they exist (in correct order due to foreign keys)
DROP TABLE IF EXISTS final_test_results;
DROP TABLE IF EXISTS final_test_questions;
DROP TABLE IF EXISTS final_tests;

-- Create final_tests table
CREATE TABLE final_tests (
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
CREATE TABLE final_test_questions (
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
    FOREIGN KEY (final_test_id) REFERENCES final_tests(id) ON DELETE CASCADE
);

-- Create final_test_results table
CREATE TABLE final_test_results (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    final_test_id BIGINT NOT NULL,
    score INT NOT NULL,
    total_questions INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    passed BOOLEAN NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    answers TEXT,
    FOREIGN KEY (final_test_id) REFERENCES final_tests(id) ON DELETE CASCADE
);

-- Insert sample final tests
INSERT INTO final_tests (title, description, total_questions, passing_score, is_active) VALUES
('English Proficiency Assessment', 'Comprehensive test covering grammar, vocabulary, reading, and listening skills across 4 sessions', 20, 40, TRUE),
('Advanced Language Skills Test', 'Advanced level assessment for experienced learners with complex scenarios', 20, 40, TRUE);

-- Insert sample questions for Test 1 - Session 1 (Grammar Focus)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(1, 'Choose the correct form: "She _____ to the store yesterday."', 'go', 'goes', 'went', 'going', 'C', 1, 'Easy'),
(1, 'Which sentence is grammatically correct?', 'He don''t like coffee.', 'He doesn''t like coffee.', 'He not like coffee.', 'He no like coffee.', 'B', 1, 'Easy'),
(1, 'Select the proper article: "I saw _____ elephant at the zoo."', 'a', 'an', 'the', 'no article', 'B', 1, 'Medium'),
(1, 'Choose the correct preposition: "The book is _____ the table."', 'in', 'on', 'at', 'by', 'B', 1, 'Easy'),
(1, 'Which is the past perfect form of "eat"?', 'ate', 'eaten', 'had eaten', 'have eaten', 'C', 1, 'Medium');

-- Insert sample questions for Test 1 - Session 2 (Vocabulary Focus)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(1, 'What does "abundant" mean?', 'scarce', 'plentiful', 'expensive', 'difficult', 'B', 2, 'Medium'),
(1, 'Choose the synonym for "happy":', 'sad', 'angry', 'joyful', 'tired', 'C', 2, 'Easy'),
(1, 'What is the opposite of "ancient"?', 'old', 'modern', 'historic', 'traditional', 'B', 2, 'Medium'),
(1, 'Select the correct meaning of "procrastinate":', 'to hurry', 'to delay', 'to complete', 'to organize', 'B', 2, 'Hard'),
(1, 'Which word means "to make something clear"?', 'confuse', 'clarify', 'complicate', 'hide', 'B', 2, 'Medium');

-- Insert sample questions for Test 1 - Session 3 (Reading Comprehension)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(1, 'Based on the passage: "The weather was perfect for a picnic." What can we infer?', 'It was raining', 'It was sunny and pleasant', 'It was very cold', 'It was windy', 'B', 3, 'Easy'),
(1, 'In the sentence "Despite the challenges, she persevered," what does "despite" indicate?', 'because of', 'in spite of', 'due to', 'thanks to', 'B', 3, 'Medium'),
(1, 'What is the main idea of a paragraph that discusses various benefits of exercise?', 'Exercise is difficult', 'Exercise has many advantages', 'Exercise is expensive', 'Exercise takes time', 'B', 3, 'Medium'),
(1, 'If a text mentions "furthermore" what is the author doing?', 'contradicting', 'adding information', 'concluding', 'questioning', 'B', 3, 'Medium'),
(1, 'What does "chronological order" mean in writing?', 'alphabetical order', 'time sequence', 'importance order', 'random order', 'B', 3, 'Hard');

-- Insert sample questions for Test 1 - Session 4 (Listening & Communication)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(1, 'When someone says "Could you please repeat that?" they are:', 'agreeing', 'asking for clarification', 'disagreeing', 'complaining', 'B', 4, 'Easy'),
(1, 'What is the appropriate response to "How are you doing?"', 'I''m 25 years old', 'I''m doing well, thanks', 'I live in New York', 'I work as a teacher', 'B', 4, 'Easy'),
(1, 'In formal communication, which is most appropriate?', 'Hey, what''s up?', 'Good morning, how may I help you?', 'Yo, need something?', 'What do you want?', 'B', 4, 'Medium'),
(1, 'What does "I beg your pardon" mean?', 'I''m sorry', 'Excuse me, I didn''t hear', 'Thank you', 'You''re welcome', 'B', 4, 'Medium'),
(1, 'Which phrase shows active listening?', 'Whatever', 'I see what you mean', 'That''s boring', 'I don''t care', 'B', 4, 'Hard');

-- Insert sample questions for Test 2 - Session 1 (Advanced Grammar)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(2, 'Choose the correct subjunctive form: "If I _____ you, I would study harder."', 'am', 'was', 'were', 'be', 'C', 1, 'Hard'),
(2, 'Select the proper conditional: "If it _____ tomorrow, we will cancel the trip."', 'rain', 'rains', 'rained', 'raining', 'B', 1, 'Medium'),
(2, 'Which sentence uses the passive voice correctly?', 'The cake was eaten by John.', 'John was eating the cake.', 'The cake ate John.', 'John eats the cake.', 'A', 1, 'Hard'),
(2, 'Choose the correct relative pronoun: "The person _____ called you is my friend."', 'which', 'who', 'whom', 'whose', 'B', 1, 'Medium'),
(2, 'What is the correct form: "Neither John nor Mary _____ coming."', 'are', 'is', 'were', 'be', 'B', 1, 'Hard');

-- Insert sample questions for Test 2 - Session 2 (Advanced Vocabulary)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(2, 'What does "ubiquitous" mean?', 'rare', 'everywhere', 'expensive', 'beautiful', 'B', 2, 'Hard'),
(2, 'Choose the synonym for "meticulous":', 'careless', 'careful', 'quick', 'lazy', 'B', 2, 'Hard'),
(2, 'What is "serendipity"?', 'bad luck', 'hard work', 'pleasant surprise', 'careful planning', 'C', 2, 'Hard'),
(2, 'Select the meaning of "ephemeral":', 'permanent', 'temporary', 'expensive', 'beautiful', 'B', 2, 'Hard'),
(2, 'What does "pragmatic" mean?', 'theoretical', 'practical', 'emotional', 'artistic', 'B', 2, 'Hard');

-- Insert sample questions for Test 2 - Session 3 (Advanced Reading)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(2, 'In academic writing, what is a "thesis statement"?', 'a question', 'main argument', 'conclusion', 'introduction', 'B', 3, 'Hard'),
(2, 'What does "juxtaposition" mean in literature?', 'repetition', 'contrast', 'similarity', 'conclusion', 'B', 3, 'Hard'),
(2, 'What is "irony" in writing?', 'humor', 'sadness', 'opposite of expectation', 'direct statement', 'C', 3, 'Hard'),
(2, 'What does "implicit" mean?', 'clearly stated', 'suggested but not stated', 'incorrect', 'repeated', 'B', 3, 'Hard'),
(2, 'In analysis, what is "synthesis"?', 'breaking down', 'combining ideas', 'memorizing', 'questioning', 'B', 3, 'Hard');

-- Insert sample questions for Test 2 - Session 4 (Advanced Communication)
INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES
(2, 'What is "diplomatic language"?', 'direct and blunt', 'tactful and polite', 'loud and clear', 'fast and efficient', 'B', 4, 'Hard'),
(2, 'In presentations, what is "rapport"?', 'conflict', 'connection with audience', 'confusion', 'competition', 'B', 4, 'Hard'),
(2, 'What does "articulate" mean as a verb?', 'to confuse', 'to express clearly', 'to whisper', 'to argue', 'B', 4, 'Medium'),
(2, 'What is "constructive feedback"?', 'only criticism', 'helpful suggestions', 'praise only', 'no response', 'B', 4, 'Hard'),
(2, 'In negotiation, what is "compromise"?', 'winning everything', 'losing everything', 'mutual agreement', 'avoiding discussion', 'C', 4, 'Hard');

-- Verify the data
SELECT 'Final Tests Created:' as Info, COUNT(*) as Count FROM final_tests;
SELECT 'Questions Created:' as Info, COUNT(*) as Count FROM final_test_questions;
SELECT 'Questions per Session:' as Info, session_number, COUNT(*) as Count 
FROM final_test_questions 
GROUP BY session_number 
ORDER BY session_number;
