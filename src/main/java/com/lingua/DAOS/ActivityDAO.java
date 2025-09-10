package com.lingua.DAOS;

import com.lingua.models.Activity;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ActivityDAO {

    private static final String JDBC_URL  = "jdbc:mysql://localhost:3306/lingua?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";
    private static final String TABLE     = "recent_activity";

    static {
        try {
            // Ensure driver is registered once
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL driver not found", e);
        }
    }

    // ---------- Low-level helpers ----------

    private Connection getConn() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
    }

    private Activity mapRow(ResultSet rs) throws SQLException {
        Activity a = new Activity();
        a.setId(rs.getInt("id"));
        a.setDescription(rs.getString("activity"));
        a.setActor(rs.getString("username"));
        a.setType(rs.getString("type"));
        Timestamp ts = rs.getTimestamp("timestamp");
        a.setTimestamp(ts != null ? ts.toLocalDateTime() : LocalDateTime.now());
        return a;
    }

    // ---------- Simple service-friendly methods ----------

    /** For dashboard panel: last N activities (no filters). */
    public List<Activity> findRecent(int limit) {
        String sql = "SELECT id, activity, username, `type`, `timestamp` " +
                     "FROM " + TABLE + " ORDER BY `timestamp` DESC LIMIT ?";
        List<Activity> list = new ArrayList<>();
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, Math.max(1, limit));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Full list (careful for big tables; useful for exports). */
    public List<Activity> findAll() {
        String sql = "SELECT id, activity, username, `type`, `timestamp` " +
                     "FROM " + TABLE + " ORDER BY `timestamp` DESC";
        List<Activity> list = new ArrayList<>();
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Insert a new activity row. */
    public int save(Activity a) {
        String sql = "INSERT INTO " + TABLE + " (activity, username, `type`, `timestamp`) " +
                     "VALUES (?, ?, ?, ?)";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, a.getDescription());
            ps.setString(2, a.getActor());
            ps.setString(3, a.getType());
            ps.setTimestamp(4, Timestamp.valueOf(
                    a.getTimestamp() != null ? a.getTimestamp() : LocalDateTime.now()
            ));
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) a.setId(keys.getInt(1));
                }
            }
            return rows;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /** Optional housekeeping (e.g., from Settings → retention days). */
    public int deleteOlderThanDays(int days) {
        String sql = "DELETE FROM " + TABLE + " WHERE `timestamp` < NOW() - INTERVAL ? DAY";
        try (Connection c = getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, Math.max(0, days));
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // ---------- Your existing filtered/paged endpoints (kept & polished) ----------

    public List<Activity> getRecentActivities(String type, String q, String from, String to,
                                              int page, int pageSize) {
        List<Activity> activities = new ArrayList<>();
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (type != null && !"All".equalsIgnoreCase(type)) {
            where.append(" AND `type` = ? ");
            params.add(type);
        }
        if (q != null && !q.isEmpty()) {
            where.append(" AND (activity LIKE ? OR username LIKE ?) ");
            params.add("%" + q + "%");
            params.add("%" + q + "%");
        }
        if (from != null && !from.isEmpty()) {
            where.append(" AND DATE(`timestamp`) >= ? ");
            params.add(from);
        }
        if (to != null && !to.isEmpty()) {
            where.append(" AND DATE(`timestamp`) <= ? ");
            params.add(to);
        }

        int offset = Math.max(0, (Math.max(1, page) - 1) * Math.max(1, pageSize));

        String sql = "SELECT id, activity, username, `type`, `timestamp` " +
                     "FROM " + TABLE + where +
                     " ORDER BY `timestamp` DESC LIMIT ? OFFSET ?";

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            for (Object param : params) ps.setObject(idx++, param);
            ps.setInt(idx++, Math.max(1, pageSize));
            ps.setInt(idx, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) activities.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }

    public int countActivities(String type, String q, String from, String to) {
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (type != null && !"All".equalsIgnoreCase(type)) {
            where.append(" AND `type` = ? ");
            params.add(type);
        }
        if (q != null && !q.isEmpty()) {
            where.append(" AND (activity LIKE ? OR username LIKE ?) ");
            params.add("%" + q + "%");
            params.add("%" + q + "%");
        }
        if (from != null && !from.isEmpty()) {
            where.append(" AND DATE(`timestamp`) >= ? ");
            params.add(from);
        }
        if (to != null && !to.isEmpty()) {
            where.append(" AND DATE(`timestamp`) <= ? ");
            params.add(to);
        }

        String sql = "SELECT COUNT(*) FROM " + TABLE + where;

        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            for (Object param : params) ps.setObject(idx++, param);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}