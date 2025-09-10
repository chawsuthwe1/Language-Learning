package com.lingua.DAOS;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lingua.models.Admin;



@Repository
public class AdminImple implements AdminDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	 @Override
	    public void saveAdmin(Admin admin) {
	        String sql = "INSERT INTO admin (name, email, password) VALUES (?, ?, ?)";
	        jdbcTemplate.update(sql,
	                admin.getName(),
	                admin.getEmail(),
	                admin.getPassword());
	    }

	    // 📋 Read All
	    @Override
	    public List<Admin> getAllAdmins() {
	        String sql = "SELECT * FROM admin";
	        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Admin.class));
	    }

	    // 🔍 Read One
	    @Override
	    public Admin getAdminById(int id) {
	        String sql = "SELECT * FROM admin WHERE id = ?";
	        List<Admin> list = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Admin.class), id);
	        return list.isEmpty() ? null : list.get(0);
	    }

	    // ✏️ Update
	    @Override
	    public void updateAdmin(Admin admin) {
	        String sql = "UPDATE admin SET name = ?, email = ?, password = ? WHERE id = ?";
	        jdbcTemplate.update(sql,
	                admin.getName(),
	                admin.getEmail(),
	                admin.getPassword(),
	                admin.getId());
	    }

	    // ❌ Delete
	    @Override
	    public void deleteAdmin(int id) {
	        String sql = "DELETE FROM admin WHERE id = ?";
	        jdbcTemplate.update(sql, id);
	    }

	@Override
	public Admin findbyEmailandPassword(String email, String password) {
		String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
        List<Admin> list = jdbcTemplate.query(sql, (rs, rowNum) -> {
            Admin a = new Admin();
            a.setId(rs.getInt("id"));
            a.setName(rs.getString("name"));
            a.setEmail(rs.getString("email"));
            a.setPassword(rs.getString("password"));
            return a;
        }, email, password);
        return list.isEmpty() ? null : list.get(0);
    }
	@Override
    public Admin findByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
        List<Admin> list = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Admin.class), email, password);
        return list.isEmpty() ? null : list.get(0);
    }
	

	 @Override
	    public int countAll() {
	        String sql = "SELECT COUNT(*) FROM admin";
	        return jdbcTemplate.queryForObject(sql, Integer.class);
	    }

}
