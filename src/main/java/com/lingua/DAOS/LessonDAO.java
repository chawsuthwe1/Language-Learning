package com.lingua.DAOS;

import com.lingua.models.Lesson;
import java.util.List;

public interface LessonDAO {
    int countAll();

    void addLesson(Lesson lesson); // Optional if save() handles both insert/update
    void save(Lesson lesson);      // Handles both insert and update

    List<Lesson> findAll();        // Unified method for listing lessons
    Lesson findById(int id);       // For update logic

    void deleteById(int id);       // Clean delete method
}
