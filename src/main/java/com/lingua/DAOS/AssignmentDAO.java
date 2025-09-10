package com.lingua.DAOS;

import com.lingua.models.Assignment;
import java.util.List;

public interface AssignmentDAO {
    void addAssignment(Assignment assignment);
    List<Assignment> getAllAssignments();
    void deleteAssignment(Long id);

    // ✅ Fix these return types
    List<Assignment> findAll();              // Returns list of assignments
    Assignment findById(int id);             // Returns a single assignment
    void save(Assignment assignment);        // Saves or updates assignment
}
