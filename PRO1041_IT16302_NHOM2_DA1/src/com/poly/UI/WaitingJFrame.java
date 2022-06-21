/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.poly.UI;

import com.poly.Helper.XImage;
import java.awt.Color;
import javax.swing.JButton;

/**
 *
 * @author phong
 */
public class WaitingJFrame extends javax.swing.JFrame {

    /**
     * Creates new form WellcomJFrame
     */
    public WaitingJFrame() {
        initComponents();
        init();
    }
    
    private void init() {
        setLocationRelativeTo(null);
         this.setIconImage(XImage.getAppIcon());
        
        new LoadingJDialog(this, true).setVisible(true);
    }
    
    private void dangNhap() {
        this.dispose();
        new DangNhapJDialog(this, true).setVisible(true);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel_Wall = new javax.swing.JPanel();
        lblTitle = new javax.swing.JLabel();
        btnDangNhap = new javax.swing.JButton();
        btnInfo = new javax.swing.JButton();
        btnExit = new javax.swing.JButton();
        lblNenCheckLogin = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Waiting");
        setMinimumSize(new java.awt.Dimension(1280, 720));
        setUndecorated(true);
        setResizable(false);

        jPanel_Wall.setBackground(new java.awt.Color(255, 255, 255));
        jPanel_Wall.setMinimumSize(new java.awt.Dimension(1280, 720));
        jPanel_Wall.setLayout(null);

        lblTitle.setFont(new java.awt.Font("Tahoma", 1, 40)); // NOI18N
        lblTitle.setForeground(new java.awt.Color(255, 255, 255));
        lblTitle.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblTitle.setText("VUI LÒNG ĐĂNG NHẬP");
        lblTitle.setMaximumSize(new java.awt.Dimension(1240, 80));
        lblTitle.setPreferredSize(new java.awt.Dimension(1240, 80));
        jPanel_Wall.add(lblTitle);
        lblTitle.setBounds(20, 80, 1240, 80);

        btnDangNhap.setBackground(new java.awt.Color(255, 255, 255));
        btnDangNhap.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        btnDangNhap.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/wating_icon_button_login1_x24.png"))); // NOI18N
        btnDangNhap.setText("ĐĂNG NHẬP ");
        btnDangNhap.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED, null, null, new java.awt.Color(0, 0, 0), new java.awt.Color(0, 0, 0)));
        btnDangNhap.setFocusable(false);
        btnDangNhap.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);
        btnDangNhap.setRolloverIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/wating_icon_button_login2_x24.png"))); // NOI18N
        btnDangNhap.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnDangNhapMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnDangNhapMouseExited(evt);
            }
        });
        btnDangNhap.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnDangNhapActionPerformed(evt);
            }
        });
        jPanel_Wall.add(btnDangNhap);
        btnDangNhap.setBounds(460, 220, 360, 60);

        btnInfo.setBackground(new java.awt.Color(255, 255, 255));
        btnInfo.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        btnInfo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/wating_icon_button_info1_x24.png"))); // NOI18N
        btnInfo.setText("THÔNG TIN ");
        btnInfo.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED, null, null, new java.awt.Color(0, 0, 0), new java.awt.Color(0, 0, 0)));
        btnInfo.setFocusable(false);
        btnInfo.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);
        btnInfo.setRolloverIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/wating_icon_button_info2_x24.png"))); // NOI18N
        btnInfo.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnInfoMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnInfoMouseExited(evt);
            }
        });
        btnInfo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnInfoActionPerformed(evt);
            }
        });
        jPanel_Wall.add(btnInfo);
        btnInfo.setBounds(460, 320, 360, 60);

        btnExit.setBackground(new java.awt.Color(255, 255, 255));
        btnExit.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        btnExit.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/wating_icon_button_exit1_x24.png"))); // NOI18N
        btnExit.setText("THOÁT! ");
        btnExit.setBorder(javax.swing.BorderFactory.createBevelBorder(javax.swing.border.BevelBorder.RAISED, null, null, new java.awt.Color(0, 0, 0), new java.awt.Color(0, 0, 0)));
        btnExit.setFocusable(false);
        btnExit.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);
        btnExit.setRolloverIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/wating_icon_button_exit2_x24.png"))); // NOI18N
        btnExit.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                btnExitMouseEntered(evt);
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                btnExitMouseExited(evt);
            }
        });
        btnExit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnExitActionPerformed(evt);
            }
        });
        jPanel_Wall.add(btnExit);
        btnExit.setBounds(460, 420, 360, 60);

        lblNenCheckLogin.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/poly/Icons/background_waiting_1280x720.png"))); // NOI18N
        jPanel_Wall.add(lblNenCheckLogin);
        lblNenCheckLogin.setBounds(0, 0, 1280, 720);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel_Wall, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel_Wall, javax.swing.GroupLayout.DEFAULT_SIZE, 720, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnDangNhapActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnDangNhapActionPerformed
        this.dangNhap();
    }//GEN-LAST:event_btnDangNhapActionPerformed

    private void btnInfoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnInfoActionPerformed
        new AboutJDialog(this, true).setVisible(true);
    }//GEN-LAST:event_btnInfoActionPerformed

    private void btnExitActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnExitActionPerformed
        System.exit(0);
    }//GEN-LAST:event_btnExitActionPerformed

    //HOVER
    private void setDefaultButton(JButton btn) {
        btn.setBackground(Color.WHITE);
        btn.setForeground(Color.BLACK);
    }
    
    private void setEntered(JButton btn) {
        // btn.setBackground(new Color(89, 209, 89));
        //btn.setBackground(new Color(0, 190, 0));
        btn.setBackground(new Color(0, 158, 0));
        btn.setForeground(Color.WHITE);
    }

    private void btnDangNhapMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnDangNhapMouseEntered
        this.setEntered(btnDangNhap);
    }//GEN-LAST:event_btnDangNhapMouseEntered

    private void btnInfoMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnInfoMouseEntered
        this.setEntered(btnInfo);
    }//GEN-LAST:event_btnInfoMouseEntered

    private void btnExitMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnExitMouseEntered
        btnExit.setBackground(new Color(255, 102, 102));
        btnExit.setForeground(Color.WHITE);
    }//GEN-LAST:event_btnExitMouseEntered

    private void btnDangNhapMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnDangNhapMouseExited
        this.setDefaultButton(btnDangNhap);
    }//GEN-LAST:event_btnDangNhapMouseExited

    private void btnInfoMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnInfoMouseExited
        this.setDefaultButton(btnInfo);
    }//GEN-LAST:event_btnInfoMouseExited

    private void btnExitMouseExited(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnExitMouseExited
        this.setDefaultButton(btnExit);
    }//GEN-LAST:event_btnExitMouseExited

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
            java.util.logging.Logger.getLogger(WaitingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(WaitingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(WaitingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(WaitingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new WaitingJFrame().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnDangNhap;
    private javax.swing.JButton btnExit;
    private javax.swing.JButton btnInfo;
    private javax.swing.JPanel jPanel_Wall;
    private javax.swing.JLabel lblNenCheckLogin;
    private javax.swing.JLabel lblTitle;
    // End of variables declaration//GEN-END:variables
}
