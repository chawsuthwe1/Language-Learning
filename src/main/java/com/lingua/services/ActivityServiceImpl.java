package com.lingua.services;

import com.lingua.DAOS.ActivityDAO;
import com.lingua.models.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityDAO activityDAO;

    @Override
    public List<Activity> getRecent(int limit) {
        return activityDAO.findRecent(limit);
    }

    @Override
    public List<Activity> getAll() {
        return activityDAO.findAll();
    }

    @Override
    public void log(Activity activity) {
        activityDAO.save(activity);
    }
}