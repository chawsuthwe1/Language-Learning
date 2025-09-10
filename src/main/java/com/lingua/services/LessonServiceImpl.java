package com.lingua.services;

import com.lingua.DAOS.LessonDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LessonServiceImpl implements LessonService {

    @Autowired
    private LessonDAO lessonDAO;

    @Override
    public int countAll() {
        return lessonDAO.countAll();
    }
}
