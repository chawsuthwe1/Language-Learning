package com.lingua.DAOS;

public interface StudentSpeakingResultDAO {
	void save(int studentId, int exerciseId, int accuracy);
	// inserts a row into speaking_attempts (student_id, exercise_id, accuracy, created_at)

	void markComplete(int studentId, int exerciseId);
	// sets completed=1 in a progress table, or upserts a row for (studentId, exerciseId)
}
