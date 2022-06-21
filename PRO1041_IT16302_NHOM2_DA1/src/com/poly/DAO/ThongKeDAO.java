/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.poly.DAO;

import com.poly.Helper.JdbcHelper;
import com.poly.Model.HoaDon;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
public class ThongKeDAO {

    public List<HoaDon> selectAll(int ngay, int thang, int nam) {
        String SELECT_HD_HOMNAY = "SELECT * FROM HOADON WHERE TONGTIEN != 0 AND DAY(NGAYHD)='" + ngay + "' AND MONTH(NGAYHD)='" + thang + "' AND YEAR(NGAYHD)= '" + nam + "'";
        return selectBySql(SELECT_HD_HOMNAY);
    }

    public List<HoaDon> selectLichSuHD() {
        String SELECT_LICHSU_HD = "SELECT * FROM HOADON WHERE Trangthai = 1 AND Tongtien != 0";
        return selectBySql(SELECT_LICHSU_HD);
    }

    public List<HoaDon> selectListByTenNV(String TenNV) {
        String SELECT_LIST_HD_BY_TENNV = "select * from hoadon hd WHERE hd.Trangthai = 1 AND Tongtien != 0 AND hd.TenNV =N'" + TenNV + "'";
        return selectBySql1(SELECT_LIST_HD_BY_TENNV);
    }

    public List<HoaDon> selectByTenNV() {
        String SELECT_TENNV = "select hd.TenNV from hoadon hd WHERE hd.Trangthai = 1 Group By hd.TenNV";
        return selectBySql2(SELECT_TENNV);
    }

    public List<HoaDon> findNgayThangNam(String dt1, String dt2) {
        String SELECT_NGAYTHANGNAM_HD = "Select * from HoaDon where TongTien != 0 AND NgayHD between '" + dt1 + "' AND '" + dt2 + "'";
        return selectBySql(SELECT_NGAYTHANGNAM_HD);
    }

   public List<HoaDon> selectByKhoangTien(String money1, String money2) {
        String SELECT_NGAYTHANGNAM_HD = "select * from hoadon where tongtien != 0 and trangthai = 1 and Tongtien between '"+money1+"' AND '"+money2+"'";
        return selectBySql(SELECT_NGAYTHANGNAM_HD);
    }

    protected List<HoaDon> selectBySql(String sql, Object... args) {
        List<HoaDon> list = new ArrayList<HoaDon>();
        try {
            ResultSet rs = JdbcHelper.query(sql, args);
            while (rs.next()) {
                HoaDon entity = new HoaDon();
                entity.setMaHD(rs.getInt("MaHD"));
                entity.setMaNV(rs.getString("MaNV"));
                entity.setNgayHD(rs.getDate("NgayHD"));
                entity.setTongTien(rs.getFloat("TongTien"));
                entity.setTenNV(rs.getString("TenNV"));
                list.add(entity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    protected List<HoaDon> selectBySql1(String sql, Object... args) {
        List<HoaDon> list = new ArrayList<HoaDon>();
        try {
            ResultSet rs = JdbcHelper.query(sql, args);
            while (rs.next()) {
                HoaDon entity = new HoaDon();
                entity.setMaHD(rs.getInt("MaHD"));
                entity.setNgayHD(rs.getDate("NgayHD"));
                entity.setTongTien(rs.getFloat("TongTien"));
                entity.setTenNV(rs.getString("TenNV"));
                list.add(entity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected List<HoaDon> selectBySql2(String sql, Object... args) {
        List<HoaDon> list = new ArrayList<HoaDon>();
        try {
            ResultSet rs = JdbcHelper.query(sql, args);
            while (rs.next()) {
                HoaDon entity = new HoaDon();
                entity.setTenNV(rs.getString("TenNV"));
                list.add(entity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    //Chart
    public List<HoaDon> selectDoanhThu(int thang, int nam) {
        String SELECT_TONG_DOANHTHU = "SELECT SUM(Tongtien) as TongTien FROM HOADON WHERE TONGTIEN != 0 AND MONTH(NGAYHD)='" + thang + "' AND YEAR(NGAYHD)= '" + nam + "'";
        return selectDoanhThuSQL(SELECT_TONG_DOANHTHU);
    }

    private List<HoaDon> selectDoanhThuSQL(String sql, Object... args) {
        List<HoaDon> list = new ArrayList<>();
        try {
            ResultSet rs = JdbcHelper.query(sql, args);
            while (rs.next()) {
                HoaDon entity = new HoaDon();
                entity.setTongTien(rs.getFloat("TongTien"));
                list.add(entity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
