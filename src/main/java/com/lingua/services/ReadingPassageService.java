package com.lingua.services;

import com.lingua.models.ReadingPassage;
import java.util.List;

public interface ReadingPassageService {
    List<ReadingPassage> findAll();
    ReadingPassage findById(int id);
    void save(ReadingPassage p);
    void delete(int id);
}


