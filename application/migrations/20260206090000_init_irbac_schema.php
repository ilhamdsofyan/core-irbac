<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Migration_Init_irbac_schema extends CI_Migration
{
    /** @var array<int, string> */
    private $createStatements = [
        'CREATE TABLE `sys_allowed`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `allowed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `sys_audit_trails`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event` enum(\'insert\',\'update\',\'delete\') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `table_name` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `old_values` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `new_values` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `sys_auth_assignment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `auth_item_id` int NULL DEFAULT NULL,
  `group_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_auth_assignment_1`(`auth_item_id` ASC) USING BTREE,
  INDEX `fk_auth_assignment_2`(`group_id` ASC) USING BTREE,
  CONSTRAINT `sys_auth_assignment_ibfk_1` FOREIGN KEY (`auth_item_id`) REFERENCES `sys_auth_item` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `sys_auth_assignment_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `tbl_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `sys_auth_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL COMMENT \'1 = routes; 2 = permission\',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `updated_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 286 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `sys_auth_item_child`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `child` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 318 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `label` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `parent_id` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `url` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_group_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `tbl_group_user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `tbl_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `tbl_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4257 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_menu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `menu_custom` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menu_parent` int NULL DEFAULT NULL,
  `menu_order` int NULL DEFAULT NULL,
  `menu_url` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_type`(`menu_type` ASC) USING BTREE,
  CONSTRAINT `tbl_menu_ibfk_1` FOREIGN KEY (`menu_type`) REFERENCES `tbl_menu_type` (`menu_type`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_menu_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NULL DEFAULT NULL,
  `group_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_id`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `tbl_menu_group_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `tbl_menu` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6320 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_menu_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `menu_type`(`menu_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_notifikasi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `to` int NULL DEFAULT NULL,
  `is_read` int NULL DEFAULT 0 COMMENT \'0 = Belum; 1 = Dibaca\',
  `redirect_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT \'Url yg akan me-redirect jika notifikasi di-klik\',
  `priority` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT \'Simpan class untuk ubah warna berdasarkan prioritas\',
  `created_at` datetime NULL DEFAULT NULL,
  `triggered_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT \'Kalau boleh username menggunakan NIP\',
  `password` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `auth_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT \'Untuk kebutuhan kode unik aktivasi akun via email atau bisa juga untuk simpan API Key\',
  `reset_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT \'Untuk kebutuhan kode unik ketika reset password\',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0 COMMENT \'0=inactive; 1=active\',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `updated_by` int NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE,
  INDEX `updated_by`(`updated_by` ASC) USING BTREE,
  INDEX `deleted_by`(`deleted_by` ASC) USING BTREE,
  CONSTRAINT `tbl_user_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_user_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_user_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1714 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;',
        'CREATE TABLE `tbl_user_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nik` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_depan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_tengah` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_belakang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tempat_lahir` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_gabung` date NULL DEFAULT NULL,
  `tanggal_selesai` date NULL DEFAULT NULL,
  `job_title` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_lahir` date NULL DEFAULT NULL,
  `agama` enum(\'islam\',\'kristen_protestan\',\'hindu\',\'buddha\',\'katolik\',\'kong_hu_cu\') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT \'Kalau ada kemungkinan ditambah, bisa dibuatkan table sendiri\',
  `jenis_kelamin` enum(\'p\',\'w\') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status_perkawinan` enum(\'0\',\'1\',\'2\') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT \'0\' COMMENT \'0 = single; 1 = married; 2 = divorce\',
  `pddk_terakhir` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT \'Nantinya akan dibuat data json {jalan:,kota:}\',
  `kota` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `provinsi` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_pos` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `telepon` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `profile_pic` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `updated_by` int NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  `deleted_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `created_by`(`created_by` ASC) USING BTREE,
  INDEX `updated_by`(`updated_by` ASC) USING BTREE,
  INDEX `deleted_by`(`deleted_by` ASC) USING BTREE,
  CONSTRAINT `tbl_user_detail_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tbl_user_detail_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `tbl_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tbl_user_detail_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `tbl_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tbl_user_detail_ibfk_6` FOREIGN KEY (`deleted_by`) REFERENCES `tbl_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1592 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;',
    ];

    /** @var array<int, string> */
    private $tables = [
        'sys_allowed',
        'sys_audit_trails',
        'sys_auth_assignment',
        'sys_auth_item',
        'sys_auth_item_child',
        'tbl_group',
        'tbl_group_user',
        'tbl_menu',
        'tbl_menu_group',
        'tbl_menu_type',
        'tbl_notifikasi',
        'tbl_user',
        'tbl_user_detail',
    ];

    public function up()
    {
        $this->db->query('SET FOREIGN_KEY_CHECKS = 0');

        foreach ($this->createStatements as $statement) {
            $this->db->query($statement);
        }

        $this->db->query('SET FOREIGN_KEY_CHECKS = 1');
    }

    public function down()
    {
        $this->db->query('SET FOREIGN_KEY_CHECKS = 0');

        foreach (array_reverse($this->tables) as $table) {
            $this->dbforge->drop_table($table, true);
        }

        $this->db->query('SET FOREIGN_KEY_CHECKS = 1');
    }
}
