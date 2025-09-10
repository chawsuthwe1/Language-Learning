package com.lingua.services;

import com.lingua.models.Admin;
import com.lingua.DAOS.AdminDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDAO adminDAO;

    @Override
    public int countAll() {
        return adminDAO.countAll();
    }

    @Override
    public List<Admin> getAllAdmins() {
        List<Admin> admins = adminDAO.getAllAdmins();
        for (Admin admin : admins) {
            System.out.println("ID: " + admin.getId());
            System.out.println("Name: " + admin.getName());
            System.out.println("Email: " + admin.getEmail());
            System.out.println("Password: " + admin.getPassword());
            System.out.println("Image: " + admin.getImage());
            System.out.println("-----------------------------");
        }
        return admins;
    }

    @Override
    public void saveAdmin(Admin admin) {
        adminDAO.saveAdmin(admin);
    }

    @Override
    public Admin getAdminById(int id) {
        Admin admin = adminDAO.getAdminById(id);
        if (admin != null) {
            System.out.println("Admin exists: " + admin.getName());
        } else {
            System.out.println("No admin found with ID: " + id);
        }
        return admin;
    }

    @Override
    public void updateAdmin(Admin admin) {
        adminDAO.updateAdmin(admin);
    }

    @Override
    public void deleteAdmin(int id) {
        adminDAO.deleteAdmin(id);
    }
}
