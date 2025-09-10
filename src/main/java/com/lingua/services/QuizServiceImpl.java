package com.lingua.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lingua.DAOS.QuizDAO;

@Service
public class QuizServiceImpl implements QuizService {

    @Autowired
    private QuizDAO quizDAO;

    @Override
    public int countAll() {
        return quizDAO.countAll();
    }
}

