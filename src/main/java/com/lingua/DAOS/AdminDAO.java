package com.lingua.DAOS;

import com.lingua.models.Admin;
import java.util.List;
public interface AdminDAO {
	
	Admin findbyEmailandPassword(String email,String password);
	 Admin findByEmailAndPassword(String email, String password);
	 // 📋 Read
    List<Admin> getAllAdmins();
    Admin getAdminById(int id);
    int countAll();

    // ➕ Create
    void saveAdmin(Admin admin);

    // ✏️ Update
    void updateAdmin(Admin admin);

    // ❌ Delete
    void deleteAdmin(int id);
}
