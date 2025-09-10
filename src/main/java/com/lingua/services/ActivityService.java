package com.lingua.services;

import com.lingua.models.Activity;
import java.util.List;

public interface ActivityService {
    List<Activity> getRecent(int limit);
    List<Activity> getAll();              // optional: for full page
    void log(Activity activity);          // optional: log a new activity
}