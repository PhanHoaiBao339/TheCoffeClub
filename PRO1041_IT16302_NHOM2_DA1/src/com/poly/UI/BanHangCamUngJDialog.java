/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.poly.UI;

import com.poly.DAO.BanDAO;
import com.poly.DAO.HoaDonCTDAO;
import com.poly.DAO.HoaDonDAO;
import com.poly.DAO.KhuVucDAO;
import com.poly.DAO.LoaiMonDAO;
import com.poly.DAO.MenuDAO;
import com.poly.DAO.NhanVienDAO;
import com.poly.Helper.Auth;
import com.poly.Helper.JdbcHelper;
import com.poly.Helper.XImage;
import com.poly.Model.Ban;
import com.poly.Model.HoaDon;
import com.poly.Model.HoaDonCT;
import com.poly.Model.KhuVuc;
import com.poly.Model.LoaiMon;
import com.poly.Model.Menu;
import com.poly.Model.NhanVien;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.File;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.border.BevelBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author phong
 */
public class BanHangCamUngJDialog extends javax.swing.JDialog {

    /**
     * Creates new form paymentJDialog
     */
    public BanHangCamUngJDialog(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
        init();
    }

    private int rowsp, vtT;
    private float TTHD = 0;
    private String keyWorld, getMaBan = "";
    private boolean ktgb;
    BanDAO daoB = new BanDAO();
    MenuDAO daomn = new MenuDAO();
    HoaDonDAO daohd = new HoaDonDAO();
    KhuVucDAO daokv = new KhuVucDAO();
    LoaiMonDAO daolm = new LoaiMonDAO();
    HoaDonCTDAO daohdct = new HoaDonCTDAO();
    NhanVienDAO daonv = new NhanVienDAO();
    private Locale localeVN = new Locale("vi", "VN");
    private NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);

    private void init() {
        this.setIconImage(XImage.getAppIcon());
        setLocationRelativeTo(null);
        this.setHeaderTable(tblHoaDon.getTableHeader());
        this.setHeaderTable(tblSanPham.getTableHeader());
        this.HeaderRendererDHCT(tblHoaDon);
        this.HeaderRendererMenu(tblSanPham);
        keyWorld = txtTiemKiemTenMon.getText();
        fillTableSP();
        fillTTB();
        fillComBoBox();

        if (Auth.user != null) {
            String vt = Auth.isManager() ? "Quản lý" : "Thu Ngân";
            setTitle("BÁN HÀNG CẢM ỨNG - " + Auth.nameNV() + " - " + vt);
        }
    }

    private void setHeaderTable(JTableHeader a) {
        JTableHeader header = a;
        header.setFont(new Font("Dialog", Font.BOLD, 14));
    }

    private void HeaderRendererDHCT(JTable table) {
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        DefaultTableCellRenderer rightRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(JLabel.CENTER);
        rightRenderer.setHorizontalAlignment(JLabel.RIGHT);
        table.getColumnModel().getColumn(0).setCellRenderer(centerRenderer);
        table.getColumnModel().getColumn(1).setCellRenderer(centerRenderer);
        table.getColumnModel().getColumn(4).setCellRenderer(centerRenderer);
        table.getColumnModel().getColumn(3).setCellRenderer(rightRenderer);
        table.getColumnModel().getColumn(5).setCellRenderer(rightRenderer);
    }

    private void HeaderRendererMenu(JTable table) {
        DefaultTableCellRenderer centerRenderer = new DefaultTableCellRenderer();
        DefaultTableCellRenderer rightRenderer = new DefaultTableCellRenderer();
        centerRenderer.setHorizontalAlignment(JLabel.CENTER);
        rightRenderer.setHorizontalAlignment(JLabel.RIGHT);
        table.getColumnModel().getColumn(0).setCellRenderer(centerRenderer);
        table.getColumnModel().getColumn(1).setCellRenderer(centerRenderer);
        table.getColumnModel().getColumn(3).setCellRenderer(rightRenderer);
    }

    private void fillTableSP() {
        DefaultTableModel model = (DefaultTableModel) tblSanPham.getModel();
        model.setRowCount(0);
        int i = 1;
        try {
            List<Menu> list = daomn.selectByKeyword(keyWorld);
            for (Menu mon : list) {
                Object[] row = {
                    i,
                    mon.getMaMon(),
                    mon.getTenMon(),
                    currencyVN.format(mon.getGia())
                };
                model.addRow(row);
                i++;
            }
        } catch (Exception e) {

        }
    }

    private void timKiemSP() {
        keyWorld = txtTiemKiemTenMon.getText();
        if (keyWorld.equals("")) {
            fillTableSP();
            cboLoaiSP.setSelectedIndex(0);
        } else {
            fillTableSP();
        }
    }

    private void editSP() {
        String maMon = (String) tblSanPham.getValueAt(this.rowsp, 1);
        Menu mon = daomn.selectById(maMon);
        if (mon != null) {
            this.setFormSP(mon);
        }
    }

    private void setFormSP(Menu mon) {
        txtTenMon.setText(mon.getTenMon());
        txtGia.setText(currencyVN.format(mon.getGia()));
        txtLoaiMon.setText(mon.getMaLoai());
        lblAnhMon.setText("");
        lblAnhMon.setIcon(XImage.readmon(mon.getHinhAnh(), lblAnhMon.getWidth(), lblAnhMon.getHeight()));
    }

    private void clickTableSP() {
        if (!txtMaHoaDon.getText().isEmpty()) {
            this.rowsp = tblSanPham.getSelectedRow();
            this.editSP();
            spnSoLuong.setValue(1);
            btnOrder.setEnabled(ktgb);
            spnSoLuong.setEnabled(ktgb);

        }
    }

    private void fillTTB() {
        tabBan.removeAll();
        try {
            List<KhuVuc> list = daokv.selectAll();
            for (KhuVuc kv : list) {
                tabBan.add(kv.getTenKV(), taoPanel(taoListButton(kv)));
            }
            tabBan.setBackground(Color.WHITE);
        } catch (Exception e) {
        }
        tabBan.setAutoscrolls(true);
    }

    private JPanel taoPanel(List<JButton> btn) {
        JPanel kv = new JPanel();
        kv.setPreferredSize(new Dimension(320, 722));
        kv.setMaximumSize(new Dimension(320, 900));
        kv.setAutoscrolls(true);
        kv.setLayout(new GridLayout(6, 0, 20, 20));
        kv.setBackground(Color.WHITE);
        for (JButton btn1 : btn) {
            kv.add(btn1);
        }
        return kv;
    }

    private List<JButton> taoListButton(KhuVuc kv) {
        List<JButton> listban = new ArrayList<>();
        List<Ban> list1 = daoB.findByIdKhuVuc(kv.getMaKV());
        List<HoaDon> list = daohd.selectAll();
        for (Ban b : list1) {
            JButton btn = new JButton();
            btn.setText(b.getTenBan());
            btn.setIcon(XImage.read("coffee-cup.png"));
            btn.setPreferredSize(new Dimension(120, 120));
            btn.setBorder(new BevelBorder(1, Color.black, Color.gray));
            btn.setBackground(Color.GREEN);
            btn.setForeground(Color.BLACK);
            btn.setFont(new Font("Tahoma", 1, 14));
            btn.setFocusable(false);
            btn.setToolTipText(b.getMaBan());

            for (HoaDon hd : list) {
                if (b.getMaBan().equals(hd.getMaBan()) && !hd.isTrangThai()) {
                    try {
                        String maBG = b.getGhepBan();
                        if (!"".equals(maBG)) {
                            btn.setText(b.getTenBan() + "-" + daoB.selectTenBan(b.getGhepBan()));
                            if (ktHdBanGhep(b.getMaBan())) {
                                btn.setBackground(Color.orange);
                            } else {
                                btn.setBackground(Color.red);
                            }
                        } else {
                            btn.setBackground(Color.red);
                        }
                    } catch (Exception e) {

                    }
                    break;
                }
            }
            btn.addMouseListener(new MouseListener() {

                @Override
                public void mouseClicked(MouseEvent e) {

                }

                @Override
                public void mousePressed(MouseEvent e) {
                    List<KhuVuc> listkv = daokv.selectAll();
                    int i = 0;
                    for (KhuVuc kv1 : listkv) {
                        if (kv1.getMaKV().equals(b.getMaKV())) {
                            vtT = i;
                        } else {
                            i++;
                        }
                    }
                    getMaBan = b.getMaBan();
                    HoaDon hd = daohd.selectByMahd(b.getMaBan());
                    if (hd != null) {
                        List<HoaDonCT> list = daohdct.selectHDCTByHD(hd.getMaHD());
                        String maBG = b.getGhepBan();
                        if (!"".equals(maBG) && list.isEmpty()) {
                            if (!hd.isTrangThai()) {
                                editHD(hd);
                                fillTbHD();
                                tabBan.setSelectedIndex(vtT);
                                btnThanhToan.setEnabled(false);
                                btnXemBill.setEnabled(false);
                                btnGopBanGhepBan.setEnabled(false);
                                btnDatBan.setEnabled(false);
                                btnOrder.setEnabled(false);
                                spnSoLuong.setEnabled(false);
                                ktgb = false;
                            }
                        } else {
                            if (!hd.isTrangThai()) {
                                editHD(hd);
                                fillTbHD();
                                tabBan.setSelectedIndex(vtT);
                                btnThanhToan.setEnabled(true);
                                btnXemBill.setEnabled(true);
                                btnGopBanGhepBan.setEnabled(true);
                                btnDatBan.setEnabled(false);
                                ktgb = true;
                            }
                        }
                    } else {
                        resetHD();
                        tabBan.setSelectedIndex(vtT);
                        btnOrder.setEnabled(false);
                        btnThanhToan.setEnabled(false);
                        btnXemBill.setEnabled(false);
                        btnDatBan.setEnabled(true);
                        btnGopBanGhepBan.setEnabled(false);
                        spnSoLuong.setEnabled(false);
                        ktgb = true;
                    }

                }

                @Override
                public void mouseReleased(MouseEvent e) {

                }

                @Override
                public void mouseEntered(MouseEvent e) {

                }

                @Override
                public void mouseExited(MouseEvent e) {

                }
            });
            listban.add(btn);
        }
        return listban;
    }

    private boolean ktHdBanGhep(String maBan) {
        HoaDon hd = daohd.selectByMahd(maBan);
        List<HoaDonCT> list = daohdct.selectHDCTByHD(hd.getMaHD());
        return list.isEmpty();
    }

    private void datBan() {
        String maBan = getMaBan;
        NhanVien nv = daonv.selectById(Auth.user.getMaNV());
        if (!maBan.equals("")) {
            try {
                daohd.insert(new HoaDon(maBan, nv.getMaNV(), new Date(), 0, false, nv.getTenNV()));
                HoaDon hd = daohd.selectByMahd(maBan);
                this.editHD(hd);
            } catch (Exception e) {
                new ThongBaoJDialog(null, true).alert(2, "Lỗi truy vấn!");
            }
        } else {
            new ThongBaoJDialog(null, true).alert(2, "Chưa chọn bàn!!!");
        }
        getMaBan = "";
        this.fillTTB();
        tabBan.setSelectedIndex(vtT);
        btnThanhToan.setEnabled(true);
        btnXemBill.setEnabled(true);
        btnGopBanGhepBan.setEnabled(true);
        btnDatBan.setEnabled(false);
    }

    private void editHD(HoaDon hd) {
        txtMaHoaDon.setText(String.valueOf(hd.getMaHD()));
        txtBanDangChon.setText(daoB.selectTenBan(hd.getMaBan()));
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        txtNgay.setText(formatter.format(hd.getNgayHD()));
    }

    private void fillComBoBox() {
        DefaultComboBoxModel model = (DefaultComboBoxModel) cboLoaiSP.getModel();
        model.removeAllElements();
        List<LoaiMon> list = daolm.selectAll();
        model.addElement("Chọn loại món");
        for (LoaiMon lm : list) {
            model.addElement(lm.toString());
        }
    }

    private void chonLoaiMon() {
        String loaiMon = (String) cboLoaiSP.getSelectedItem();
        if (loaiMon != null) {
            String[] key = loaiMon.split("-");
            if (key.length == 2) {
                keyWorld = key[1];
                fillTableSP();
            } else {
                keyWorld = "";
                fillTableSP();
            }
        }
    }

    private void fillTbHD() {
        DefaultTableModel model = (DefaultTableModel) tblHoaDon.getModel();
        model.setRowCount(0);
        float TT = 0;
        float ttmon;
        int i = 1;
        try {
            List<HoaDonCT> list = daohdct.selectHDCTByHD(Integer.valueOf(txtMaHoaDon.getText()));
            for (HoaDonCT hdct : list) {
                ttmon = hdct.getDonGia() * hdct.getSoLuong();
                Object[] row = {
                    i,
                    hdct.getMaHDCT(),
                    hdct.getTenMon(),
                    currencyVN.format(hdct.getDonGia()),
                    hdct.getSoLuong(),
                    currencyVN.format(ttmon)
                };
                model.addRow(row);
                TT = TT + ttmon;
                i++;
            }
            txtThanhTien.setText(currencyVN.format(TT));
            TTHD = TT;

        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    public void fillTbHDdc(Integer Mahd) {
        DefaultTableModel model = (DefaultTableModel) tblHoaDon.getModel();
        model.setRowCount(0);
        int i = 1;
        float TT = 0;
        float ttmon;
        try {
            List<HoaDonCT> list = daohdct.selectHDCTByHD(Mahd);
            for (HoaDonCT hdct : list) {
                ttmon = hdct.getDonGia() * hdct.getSoLuong();
                Object[] row = {
                    i,
                    hdct.getMaHDCT(),
                    hdct.getTenMon(),
                    currencyVN.format(hdct.getDonGia()),
                    hdct.getSoLuong(),
                    currencyVN.format(ttmon)
                };
                model.addRow(row);
                TT = TT + ttmon;
                i++;
            }
            txtThanhTien.setText(currencyVN.format(TT));
            TTHD = TT;
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private void oderMon() {
        if (txtMaHoaDon.getText() != null) {
            String maMon = (String) tblSanPham.getValueAt(this.rowsp, 1);
            Menu mon = daomn.selectById(maMon);
            int sl = (int) spnSoLuong.getValue();
            daohdct.insert(new HoaDonCT(Integer.valueOf(txtMaHoaDon.getText()), mon.getMaMon(), sl, mon.getGia(), mon.getTenMon()));
            this.fillTbHD();
        } else {
            new ThongBaoJDialog(null, true).alert(2, "Chưa đặt bàn không thể Order");
        }
    }

    private void updateTT() {
        HoaDon hd = daohd.selectById(Integer.valueOf(txtMaHoaDon.getText()));
        daohd.updateTT(TTHD, hd.getMaHD(), true);
        this.xuatBill(hd.getMaHD());

        Ban ban = daoB.selectById(hd.getMaBan());
        if (!ban.getGhepBan().equals("")) {
            String[] BanGheps = ban.getGhepBan().split("-");
            for (int i = 0; i < BanGheps.length; i++) {
                if (!BanGheps[i].equals("")) {
                    HoaDon hdgb = daohd.selectByMahd(BanGheps[i]);
                    daohd.delete(hdgb.getMaHD());
                    daoB.updateGB("", BanGheps[i]);
                }
            }
            daoB.updateGB("", ban.getMaBan());
        }

    }

    private void xembill() {
        daohd.updateTT(TTHD, Integer.valueOf(txtMaHoaDon.getText()), false);
        String sourceFileName = "report\\reportHoaDon.jasper";
        Map map = new HashMap();
        map.put("MaHD", Integer.valueOf(txtMaHoaDon.getText()));
        JdbcHelper jdbc = new JdbcHelper();
        JasperViewer jasperViewer = null;
        try {
            JasperPrint rp = JasperFillManager.fillReport(sourceFileName, map, jdbc.connection);
            jasperViewer = new JasperViewer(rp, false);
            JDialog jdl = new JDialog(this);
            jdl.setContentPane(jasperViewer.getContentPane());
            jdl.setSize(jasperViewer.getSize());
            jdl.setTitle("Xem Hóa Đơn");
            jdl.setLocationRelativeTo(null);
            jdl.setVisible(true);
        } catch (JRException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void xuatBill(int mahd) {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd_MM_yyyy_hh_mm_ss");
        String sourceFileName = "report\\reportHoaDon.jasper";
        File file = new File("C:\\Users\\" + System.getProperty("user.name") + "\\Desktop\\Bill");
        if (!file.exists()) {
            file.mkdir();
        }
        String tenfile = "C:\\Users\\" + System.getProperty("user.name") + "\\Desktop\\Bill\\Bill " + now.format(formatter) + ".pdf";
        Map map = new HashMap();
        map.put("MaHD", mahd);
        JdbcHelper jdbc = new JdbcHelper();
        JasperViewer jasperViewer = null;
        try {
            String rp = JasperFillManager.fillReportToFile(sourceFileName, map, jdbc.connection);
            JasperExportManager.exportReportToPdfFile(rp, tenfile);
            jasperViewer = new JasperViewer(rp, false);
            JDialog jdl = new JDialog(this);
            jdl.setContentPane(jasperViewer.getContentPane());
            jdl.setSize(jasperViewer.getSize());
            jdl.setTitle("Xem Hóa Đơn");
            jdl.setLocationRelativeTo(null);
            jdl.setVisible(true);
            new ThongBaoJDialog(null, true).alert(1, "Bill đã được lưu trong thư mục Bill trên Màn Hình Chính ");
        } catch (JRException ex) {
            System.out.println(ex.getMessage());
        }

    }

    private void resetHD() {
        try {
            txtMaHoaDon.setText(null);
            txtBanDangChon.setText(null);
            txtNgay.setText(null);
            DefaultTableModel model = (DefaultTableModel) tblHoaDon.getModel();
            model.setRowCount(0);
            txtThanhTien.setText(null);
            btnOrder.setEnabled(false);
            btnThanhToan.setEnabled(false);
            btnXemBill.setEnabled(false);
            btnGopBanGhepBan.setEnabled(false);
            btnDatBan.setEnabled(true);
            spnSoLuong.setEnabled(false);
            this.fillTTB();
        } catch (Exception e) {
        }
    }

    private void thanhToan() {
        this.updateTT();
        this.resetHD();
        TTHD = 0;
        btnDatBan.setEnabled(false);
    }

    private void chuyenGhepBan() {

        new CGBCamUngJDialog(null, true, Integer.valueOf(txtMaHoaDon.getText()), this).setVisible(true);
    }

    private void capNhatSoLuong(MouseEvent evt) {
        if (evt.getClickCount() == 2) {
            int rowsl = tblHoaDon.getSelectedRow();
            HoaDonCT hdct = daohdct.selectById((Integer) tblHoaDon.getValueAt(rowsl, 1));
            new CNSPCamUngJDialog(null, true, this, hdct).setVisible(true);
        }

    }

    public void resetForm() {
        this.fillTTB();
        this.resetHD();
        btnDatBan.setEnabled(false);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        pnlHeader = new javax.swing.JPanel();
        lblTitle = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        lblHeader = new javax.swing.JLabel();
        pnlWall = new javax.swing.JPanel();
        pnlThongTinBan = new javax.swing.JPanel();
        btnDatBan = new javax.swing.JButton();
        btnLamMoi = new javax.swing.JButton();
        tabBan = new javax.swing.JTabbedPane();
        pnlThucDon = new javax.swing.JPanel();
        lblTenMon = new javax.swing.JLabel();
        txtTiemKiemTenMon = new javax.swing.JTextField();
        pnlMoTa = new javax.swing.JPanel();
        lblTenMonMota = new javax.swing.JLabel();
        lblGiaMota = new javax.swing.JLabel();
        lblAnhMon = new javax.swing.JLabel();
        lblLoaiMota = new javax.swing.JLabel();
        btnOrder = new javax.swing.JButton();
        txtTenMon = new javax.swing.JTextField();
        txtGia = new javax.swing.JTextField();
        txtLoaiMon = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        spnSoLuong = new javax.swing.JSpinner();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblSanPham = new javax.swing.JTable();
        lblLoaiSP = new javax.swing.JLabel();
        cboLoaiSP = new javax.swing.JComboBox();
        pnlHoaDon = new javax.swing.JPanel();
        lblMaHoaDon = new javax.swing.JLabel();
        lblBanDangChon = new javax.swing.JLabel();
        lblNgay = new javax.swing.JLabel();
        lblOderList = new javax.swing.JLabel();
        lblThanhTien = new javax.swing.JLabel();
        txtMaHoaDon = new javax.swing.JTextField();
        txtBanDangChon = new javax.swing.JTextField();
        txtNgay = new javax.swing.JTextField();
        txtThanhTien = new javax.swing.JTextField();
        jScrollPane2 = new javax.swing.JScrollPane();
        tblHoaDon = new javax.swing.JTable();
        jPanel1 = new javax.swing.JPanel();
        btnXemBill = new javax.swing.JButton();
        btnThanhToan = new javax.swing.JButton();
        btnGopBanGhepBan = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("BÁN HÀNG");
        setFocusable(false);
        setUndecorated(true);
        setSize(new java.awt.Dimension(1920, 1080));

        pnlHeader.setPreferredSize(new java.awt.Dimension(1920, 50));
        pnlHeader.setLayout(null);

        lblTitle.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        lblTitle.setForeground(new java.awt.Color(255, 255, 255));
        lblTitle.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTitle.setText("QUẢN LÝ BÁN HÀNG");
        pnlHeader.add(lblTitle);
        lblTitle.setBounds(170, 10, 1590, 30);

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(255, 255, 255));
        jLabel2.setText("<< Trở về Trang chủ");
        jLabel2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                jLabel2MousePressed(evt);
            }
        });
        pnlHeader.add(jLabel2);
        jLabel2.setBounds(10, 10, 210, 30);

        lblHeader.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/header_black_1920x100.png"))); // NOI18N
        lblHeader.setPreferredSize(new java.awt.Dimension(1900, 100));
        pnlHeader.add(lblHeader);
        lblHeader.setBounds(0, 0, 1920, 50);

        pnlWall.setBackground(new java.awt.Color(51, 51, 51));
        pnlWall.setPreferredSize(new java.awt.Dimension(1920, 850));

        pnlThongTinBan.setBackground(new java.awt.Color(255, 255, 255));
        pnlThongTinBan.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "THÔNG TIN BÀN", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 18))); // NOI18N
        pnlThongTinBan.setFocusable(false);

        btnDatBan.setBackground(new java.awt.Color(255, 255, 255));
        btnDatBan.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        btnDatBan.setText("ĐẶT BÀN");
        btnDatBan.setEnabled(false);
        btnDatBan.setFocusable(false);
        btnDatBan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDatBanActionPerformed(evt);
            }
        });

        btnLamMoi.setBackground(new java.awt.Color(255, 255, 255));
        btnLamMoi.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        btnLamMoi.setText("LÀM MỚI");
        btnLamMoi.setFocusable(false);
        btnLamMoi.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnLamMoiActionPerformed(evt);
            }
        });

        tabBan.setBackground(new java.awt.Color(204, 204, 204));
        tabBan.setTabLayoutPolicy(javax.swing.JTabbedPane.SCROLL_TAB_LAYOUT);
        tabBan.setFocusable(false);
        tabBan.setMaximumSize(new java.awt.Dimension(321, 900));
        tabBan.setPreferredSize(new java.awt.Dimension(321, 722));

        javax.swing.GroupLayout pnlThongTinBanLayout = new javax.swing.GroupLayout(pnlThongTinBan);
        pnlThongTinBan.setLayout(pnlThongTinBanLayout);
        pnlThongTinBanLayout.setHorizontalGroup(
            pnlThongTinBanLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlThongTinBanLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlThongTinBanLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(tabBan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(pnlThongTinBanLayout.createSequentialGroup()
                        .addComponent(btnDatBan, javax.swing.GroupLayout.PREFERRED_SIZE, 156, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnLamMoi, javax.swing.GroupLayout.PREFERRED_SIZE, 156, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        pnlThongTinBanLayout.setVerticalGroup(
            pnlThongTinBanLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlThongTinBanLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlThongTinBanLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnDatBan, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnLamMoi, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(tabBan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );

        pnlThucDon.setBackground(new java.awt.Color(255, 255, 255));
        pnlThucDon.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "THỰC ĐƠN", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 18))); // NOI18N
        pnlThucDon.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        lblTenMon.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        lblTenMon.setText("Tên món:");

        txtTiemKiemTenMon.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));
        txtTiemKiemTenMon.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtTiemKiemTenMonKeyReleased(evt);
            }
        });

        pnlMoTa.setBackground(new java.awt.Color(255, 255, 255));
        pnlMoTa.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Mô tả", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 14))); // NOI18N

        lblTenMonMota.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblTenMonMota.setText("Tên món:");

        lblGiaMota.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblGiaMota.setText("Giá:");

        lblAnhMon.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblAnhMon.setText("ảnh");
        lblAnhMon.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        lblLoaiMota.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblLoaiMota.setText("Loại:");

        btnOrder.setBackground(new java.awt.Color(255, 255, 255));
        btnOrder.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        btnOrder.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/order_icon_x32.png"))); // NOI18N
        btnOrder.setText("ORDER");
        btnOrder.setEnabled(false);
        btnOrder.setFocusable(false);
        btnOrder.setIconTextGap(6);
        btnOrder.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnOrderActionPerformed(evt);
            }
        });

        txtTenMon.setEditable(false);
        txtTenMon.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        txtTenMon.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));

        txtGia.setEditable(false);
        txtGia.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        txtGia.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));

        txtLoaiMon.setEditable(false);
        txtLoaiMon.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        txtLoaiMon.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));

        jLabel1.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        jLabel1.setText("Số lượng:");

        spnSoLuong.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        spnSoLuong.setModel(new javax.swing.SpinnerNumberModel(1, 1, null, 1));
        spnSoLuong.setEnabled(false);
        spnSoLuong.setFocusable(false);

        javax.swing.GroupLayout pnlMoTaLayout = new javax.swing.GroupLayout(pnlMoTa);
        pnlMoTa.setLayout(pnlMoTaLayout);
        pnlMoTaLayout.setHorizontalGroup(
            pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlMoTaLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lblAnhMon, javax.swing.GroupLayout.PREFERRED_SIZE, 240, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(33, 33, 33)
                .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(lblTenMonMota)
                    .addComponent(lblGiaMota)
                    .addComponent(lblLoaiMota)
                    .addComponent(jLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 13, Short.MAX_VALUE)
                .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(spnSoLuong, javax.swing.GroupLayout.PREFERRED_SIZE, 370, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(txtTenMon, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 370, Short.MAX_VALUE)
                        .addComponent(txtGia, javax.swing.GroupLayout.Alignment.TRAILING)
                        .addComponent(txtLoaiMon, javax.swing.GroupLayout.Alignment.TRAILING))
                    .addComponent(btnOrder, javax.swing.GroupLayout.PREFERRED_SIZE, 370, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(29, 29, 29))
        );
        pnlMoTaLayout.setVerticalGroup(
            pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlMoTaLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(pnlMoTaLayout.createSequentialGroup()
                        .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblTenMonMota, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtTenMon, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(27, 27, 27)
                        .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblGiaMota, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtGia, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(27, 27, 27)
                        .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblLoaiMota, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtLoaiMon, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(27, 27, 27)
                        .addGroup(pnlMoTaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(spnSoLuong, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(34, 34, 34)
                        .addComponent(btnOrder, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(lblAnhMon, javax.swing.GroupLayout.PREFERRED_SIZE, 330, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        tblSanPham.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        tblSanPham.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Stt", "Mã món", "Tên món", "Giá tiền"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tblSanPham.setToolTipText("");
        tblSanPham.setRowHeight(60);
        tblSanPham.getTableHeader().setReorderingAllowed(false);
        tblSanPham.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                tblSanPhamMousePressed(evt);
            }
        });
        jScrollPane1.setViewportView(tblSanPham);
        if (tblSanPham.getColumnModel().getColumnCount() > 0) {
            tblSanPham.getColumnModel().getColumn(0).setMinWidth(50);
            tblSanPham.getColumnModel().getColumn(0).setPreferredWidth(50);
            tblSanPham.getColumnModel().getColumn(0).setMaxWidth(50);
        }

        lblLoaiSP.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        lblLoaiSP.setText("Loại sản phẩm:");

        cboLoaiSP.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        cboLoaiSP.setFocusable(false);
        cboLoaiSP.setPreferredSize(new java.awt.Dimension(40, 23));
        cboLoaiSP.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cboLoaiSPActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout pnlThucDonLayout = new javax.swing.GroupLayout(pnlThucDon);
        pnlThucDon.setLayout(pnlThucDonLayout);
        pnlThucDonLayout.setHorizontalGroup(
            pnlThucDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlThucDonLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlThucDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, pnlThucDonLayout.createSequentialGroup()
                        .addComponent(lblTenMon, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(txtTiemKiemTenMon, javax.swing.GroupLayout.PREFERRED_SIZE, 320, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(26, 26, 26)
                        .addComponent(lblLoaiSP)
                        .addGap(18, 18, 18)
                        .addComponent(cboLoaiSP, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addComponent(pnlMoTa, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING)
        );
        pnlThucDonLayout.setVerticalGroup(
            pnlThucDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlThucDonLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlThucDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(pnlThucDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(lblLoaiSP, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(cboLoaiSP, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(txtTiemKiemTenMon, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblTenMon, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 496, Short.MAX_VALUE)
                .addGap(18, 18, 18)
                .addComponent(pnlMoTa, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pnlThucDonLayout.linkSize(javax.swing.SwingConstants.VERTICAL, new java.awt.Component[] {cboLoaiSP, lblLoaiSP});

        pnlHoaDon.setBackground(new java.awt.Color(255, 255, 255));
        pnlHoaDon.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "HÓA ĐƠN", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Tahoma", 1, 18))); // NOI18N

        lblMaHoaDon.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        lblMaHoaDon.setText("Mã hóa đơn:");

        lblBanDangChon.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        lblBanDangChon.setText("Bàn đang chọn:");

        lblNgay.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        lblNgay.setText("Ngày:");

        lblOderList.setFont(new java.awt.Font("Tahoma", 0, 18)); // NOI18N
        lblOderList.setText("Danh sách sản phẩm đã order:");
        lblOderList.setToolTipText("");

        lblThanhTien.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        lblThanhTien.setText("Thành tiền:");

        txtMaHoaDon.setEditable(false);
        txtMaHoaDon.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        txtMaHoaDon.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));

        txtBanDangChon.setEditable(false);
        txtBanDangChon.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        txtBanDangChon.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));

        txtNgay.setEditable(false);
        txtNgay.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        txtNgay.setBorder(javax.swing.BorderFactory.createMatteBorder(0, 0, 1, 0, new java.awt.Color(0, 0, 0)));

        txtThanhTien.setEditable(false);
        txtThanhTien.setBackground(new java.awt.Color(244, 244, 244));
        txtThanhTien.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        txtThanhTien.setForeground(new java.awt.Color(0, 153, 51));
        txtThanhTien.setHorizontalAlignment(javax.swing.JTextField.TRAILING);
        txtThanhTien.setBorder(null);

        tblHoaDon.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        tblHoaDon.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "STT", "Mã HDCT", "Tên món", "Giá tiền", "Số lượng", "Thành tiền"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        tblHoaDon.setRowHeight(50);
        tblHoaDon.getTableHeader().setReorderingAllowed(false);
        tblHoaDon.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                tblHoaDonMousePressed(evt);
            }
        });
        jScrollPane2.setViewportView(tblHoaDon);
        if (tblHoaDon.getColumnModel().getColumnCount() > 0) {
            tblHoaDon.getColumnModel().getColumn(0).setMinWidth(50);
            tblHoaDon.getColumnModel().getColumn(0).setPreferredWidth(50);
            tblHoaDon.getColumnModel().getColumn(0).setMaxWidth(50);
        }

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));

        btnXemBill.setBackground(new java.awt.Color(255, 255, 255));
        btnXemBill.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        btnXemBill.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/bill_view_x32.png"))); // NOI18N
        btnXemBill.setText("XEM BILL");
        btnXemBill.setEnabled(false);
        btnXemBill.setFocusable(false);
        btnXemBill.setIconTextGap(6);
        btnXemBill.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnXemBillActionPerformed(evt);
            }
        });

        btnThanhToan.setBackground(new java.awt.Color(255, 255, 255));
        btnThanhToan.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        btnThanhToan.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/bill_pos_x32.png"))); // NOI18N
        btnThanhToan.setText("THANH TOÁN");
        btnThanhToan.setEnabled(false);
        btnThanhToan.setFocusable(false);
        btnThanhToan.setIconTextGap(6);
        btnThanhToan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnThanhToanActionPerformed(evt);
            }
        });

        btnGopBanGhepBan.setBackground(new java.awt.Color(255, 255, 255));
        btnGopBanGhepBan.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        btnGopBanGhepBan.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/move_table_x32.png"))); // NOI18N
        btnGopBanGhepBan.setText("CHUYỂN BÀN - GHÉP BÀN");
        btnGopBanGhepBan.setEnabled(false);
        btnGopBanGhepBan.setFocusable(false);
        btnGopBanGhepBan.setIconTextGap(6);
        btnGopBanGhepBan.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGopBanGhepBanActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(btnXemBill, javax.swing.GroupLayout.PREFERRED_SIZE, 290, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnThanhToan, javax.swing.GroupLayout.PREFERRED_SIZE, 290, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(btnGopBanGhepBan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnXemBill, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnThanhToan, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 24, Short.MAX_VALUE)
                .addComponent(btnGopBanGhepBan, javax.swing.GroupLayout.PREFERRED_SIZE, 55, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        javax.swing.GroupLayout pnlHoaDonLayout = new javax.swing.GroupLayout(pnlHoaDon);
        pnlHoaDon.setLayout(pnlHoaDonLayout);
        pnlHoaDonLayout.setHorizontalGroup(
            pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlHoaDonLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jScrollPane2)
                    .addGroup(pnlHoaDonLayout.createSequentialGroup()
                        .addComponent(lblThanhTien)
                        .addGap(18, 18, 18)
                        .addComponent(txtThanhTien))
                    .addGroup(pnlHoaDonLayout.createSequentialGroup()
                        .addGroup(pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblMaHoaDon)
                            .addComponent(lblNgay))
                        .addGap(18, 18, 18)
                        .addGroup(pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtNgay)
                            .addGroup(pnlHoaDonLayout.createSequentialGroup()
                                .addComponent(txtMaHoaDon, javax.swing.GroupLayout.PREFERRED_SIZE, 190, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 46, Short.MAX_VALUE)
                                .addComponent(lblBanDangChon)
                                .addGap(18, 18, 18)
                                .addComponent(txtBanDangChon, javax.swing.GroupLayout.PREFERRED_SIZE, 190, javax.swing.GroupLayout.PREFERRED_SIZE))))
                    .addComponent(lblOderList))
                .addContainerGap())
        );

        pnlHoaDonLayout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {lblBanDangChon, lblMaHoaDon, lblNgay});

        pnlHoaDonLayout.setVerticalGroup(
            pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlHoaDonLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblMaHoaDon)
                    .addComponent(txtMaHoaDon, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblBanDangChon)
                    .addComponent(txtBanDangChon, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblNgay)
                    .addComponent(txtNgay, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(lblOderList)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane2)
                .addGap(18, 18, 18)
                .addGroup(pnlHoaDonLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblThanhTien, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtThanhTien, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(48, 48, 48))
        );

        pnlHoaDonLayout.linkSize(javax.swing.SwingConstants.VERTICAL, new java.awt.Component[] {lblBanDangChon, lblMaHoaDon, lblNgay, txtBanDangChon, txtMaHoaDon});

        javax.swing.GroupLayout pnlWallLayout = new javax.swing.GroupLayout(pnlWall);
        pnlWall.setLayout(pnlWallLayout);
        pnlWallLayout.setHorizontalGroup(
            pnlWallLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlWallLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(pnlThongTinBan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(pnlThucDon, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(pnlHoaDon, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
        pnlWallLayout.setVerticalGroup(
            pnlWallLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(pnlWallLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(pnlWallLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(pnlHoaDon, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(pnlThucDon, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(pnlThongTinBan, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(15, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(pnlWall, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addComponent(pnlHeader, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(pnlHeader, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, 0)
                .addComponent(pnlWall, javax.swing.GroupLayout.DEFAULT_SIZE, 1030, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void txtTiemKiemTenMonKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtTiemKiemTenMonKeyReleased
        this.timKiemSP();
    }//GEN-LAST:event_txtTiemKiemTenMonKeyReleased

    private void btnDatBanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDatBanActionPerformed
        this.datBan();
    }//GEN-LAST:event_btnDatBanActionPerformed

    private void cboLoaiSPActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cboLoaiSPActionPerformed
        this.chonLoaiMon();
    }//GEN-LAST:event_cboLoaiSPActionPerformed

    private void btnOrderActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnOrderActionPerformed
        this.oderMon();
    }//GEN-LAST:event_btnOrderActionPerformed

    private void btnThanhToanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnThanhToanActionPerformed
        this.thanhToan();
    }//GEN-LAST:event_btnThanhToanActionPerformed

    private void btnLamMoiActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnLamMoiActionPerformed
        this.resetForm();
    }//GEN-LAST:event_btnLamMoiActionPerformed

    private void btnXemBillActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnXemBillActionPerformed
        this.xembill();
    }//GEN-LAST:event_btnXemBillActionPerformed

    private void btnGopBanGhepBanActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGopBanGhepBanActionPerformed
        this.chuyenGhepBan();
    }//GEN-LAST:event_btnGopBanGhepBanActionPerformed

    private void tblSanPhamMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tblSanPhamMousePressed
        this.clickTableSP();
    }//GEN-LAST:event_tblSanPhamMousePressed

    private void tblHoaDonMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tblHoaDonMousePressed
        this.capNhatSoLuong(evt);
    }//GEN-LAST:event_tblHoaDonMousePressed

    private void jLabel2MousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jLabel2MousePressed
        this.dispose();
    }//GEN-LAST:event_jLabel2MousePressed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(BanHangCamUngJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(BanHangCamUngJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(BanHangCamUngJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(BanHangCamUngJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                BanHangCamUngJDialog dialog = new BanHangCamUngJDialog(new javax.swing.JFrame(), true);
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnDatBan;
    private javax.swing.JButton btnGopBanGhepBan;
    private javax.swing.JButton btnLamMoi;
    private javax.swing.JButton btnOrder;
    private javax.swing.JButton btnThanhToan;
    private javax.swing.JButton btnXemBill;
    private javax.swing.JComboBox cboLoaiSP;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JLabel lblAnhMon;
    private javax.swing.JLabel lblBanDangChon;
    private javax.swing.JLabel lblGiaMota;
    private javax.swing.JLabel lblHeader;
    private javax.swing.JLabel lblLoaiMota;
    private javax.swing.JLabel lblLoaiSP;
    private javax.swing.JLabel lblMaHoaDon;
    private javax.swing.JLabel lblNgay;
    private javax.swing.JLabel lblOderList;
    private javax.swing.JLabel lblTenMon;
    private javax.swing.JLabel lblTenMonMota;
    private javax.swing.JLabel lblThanhTien;
    private javax.swing.JLabel lblTitle;
    private javax.swing.JPanel pnlHeader;
    private javax.swing.JPanel pnlHoaDon;
    private javax.swing.JPanel pnlMoTa;
    private javax.swing.JPanel pnlThongTinBan;
    private javax.swing.JPanel pnlThucDon;
    private javax.swing.JPanel pnlWall;
    private javax.swing.JSpinner spnSoLuong;
    private javax.swing.JTabbedPane tabBan;
    private javax.swing.JTable tblHoaDon;
    private javax.swing.JTable tblSanPham;
    private javax.swing.JTextField txtBanDangChon;
    private javax.swing.JTextField txtGia;
    private javax.swing.JTextField txtLoaiMon;
    private javax.swing.JTextField txtMaHoaDon;
    private javax.swing.JTextField txtNgay;
    private javax.swing.JTextField txtTenMon;
    private javax.swing.JTextField txtThanhTien;
    private javax.swing.JTextField txtTiemKiemTenMon;
    // End of variables declaration//GEN-END:variables
}
