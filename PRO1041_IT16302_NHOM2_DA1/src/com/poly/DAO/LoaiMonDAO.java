/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.poly.DAO;

import com.poly.Helper.JdbcHelper;
import com.poly.Model.LoaiMon;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Patnight
 */
public class LoaiMonDAO extends CoffeShopSysDAO<LoaiMon, String> {

    String INSERT_SQL = "INSERT INTO LOAIMON (MaLoai, TenLoai, DeleteL) VALUES (?, ?, ?)";
    String UPDATE_SQL = "UPDATE LOAIMON SET TenLoai=? WHERE MaLoai=?";
    String DELETE_SQL = "UPDATE LOAIMON SET DeleteL=1 WHERE MaLoai=?";
    String SELECT_ALL_SQL = "SELECT * FROM LOAIMON WHERE DeleteL=0";
    String SELECT_BY_ID_SQL = "SELECT * FROM LOAIMON WHERE MaLoai=? AND DeleteL=0";

    @Override
    public void insert(LoaiMon entity) {
        JdbcHelper.update(INSERT_SQL,
                entity.getMaLoai(),
                entity.getTenLoai(),
                false
        );
    }

    @Override
    public void update(LoaiMon entity) {
        JdbcHelper.update(UPDATE_SQL,
                entity.getTenLoai(),
                entity.getMaLoai()
        );
    }

    @Override
    public void delete(String key) {
        JdbcHelper.update(DELETE_SQL, key);
    }

    @Override
    public List<LoaiMon> selectAll() {
        return this.selectBySql(SELECT_ALL_SQL);
    }

    @Override
    public LoaiMon selectById(String key) {
        List<LoaiMon> list = this.selectBySql(SELECT_BY_ID_SQL, key);
        if (list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    @Override
    protected List<LoaiMon> selectBySql(String sql, Object... args) {
        List<LoaiMon> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcHelper.query(sql, args);
            while (rs.next()) {
                LoaiMon entity = new LoaiMon();
                entity.setMaLoai(rs.getString("MaLoai"));
                entity.setTenLoai(rs.getString("TenLoai"));
                list.add(entity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
