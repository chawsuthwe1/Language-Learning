package com.lingua.services;

import com.lingua.models.Admin;
import java.util.List;

public interface AdminService {
    int countAll();
    List<Admin> getAllAdmins();
    void saveAdmin(Admin admin);
    Admin getAdminById(int id);
    void updateAdmin(Admin admin);
    void deleteAdmin(int id);
}
