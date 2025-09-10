package com.lingua.DAOS;

import com.lingua.models.ReadingPassage;
import java.util.List;

public interface ReadingPassageDAO {
    void insert(ReadingPassage p);
    void update(ReadingPassage p);
    void deleteById(int id);
    ReadingPassage findById(int id);
    List<ReadingPassage> findAll();
}


