package com.lingua.services;

import com.lingua.DAOS.ReadingPassageDAO;
import com.lingua.models.ReadingPassage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReadingPassageServiceImpl implements ReadingPassageService {

    @Autowired
    private ReadingPassageDAO dao;

    @Override
    public List<ReadingPassage> findAll() { return dao.findAll(); }

    @Override
    public ReadingPassage findById(int id) { return dao.findById(id); }

    @Override
    public void save(ReadingPassage p) { if (p.getId() == 0) dao.insert(p); else dao.update(p); }

    @Override
    public void delete(int id) { dao.deleteById(id); }
}


