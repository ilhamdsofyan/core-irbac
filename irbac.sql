/*
 Navicat Premium Data Transfer

 Source Server         : LOCALHOST
 Source Server Type    : MySQL
 Source Server Version : 100425 (10.4.25-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : irbac

 Target Server Type    : MySQL
 Target Server Version : 100425 (10.4.25-MariaDB)
 File Encoding         : 65001

 Date: 20/02/2024 17:55:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_allowed
-- ----------------------------
DROP TABLE IF EXISTS `sys_allowed`;
CREATE TABLE `sys_allowed`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `allowed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_allowed
-- ----------------------------
INSERT INTO `sys_allowed` VALUES (6, 'site/logout');
INSERT INTO `sys_allowed` VALUES (9, 'site/login');
INSERT INTO `sys_allowed` VALUES (10, 'site/google-auth');
INSERT INTO `sys_allowed` VALUES (11, 'site/not-found');
INSERT INTO `sys_allowed` VALUES (13, 'site/refresh-csrf');

-- ----------------------------
-- Table structure for sys_audit_trails
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit_trails`;
CREATE TABLE `sys_audit_trails`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event` enum('insert','update','delete') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `table_name` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `old_values` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `new_values` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_audit_trails
-- ----------------------------

-- ----------------------------
-- Table structure for sys_auth_assignment
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_assignment`;
CREATE TABLE `sys_auth_assignment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `auth_item_id` int NULL DEFAULT NULL,
  `group_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_auth_assignment_1`(`auth_item_id` ASC) USING BTREE,
  INDEX `fk_auth_assignment_2`(`group_id` ASC) USING BTREE,
  CONSTRAINT `sys_auth_assignment_ibfk_1` FOREIGN KEY (`auth_item_id`) REFERENCES `sys_auth_item` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `sys_auth_assignment_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `tbl_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_auth_assignment
-- ----------------------------
INSERT INTO `sys_auth_assignment` VALUES (3, 32, 1);
INSERT INTO `sys_auth_assignment` VALUES (4, 109, 1);

-- ----------------------------
-- Table structure for sys_auth_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_item`;
CREATE TABLE `sys_auth_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL COMMENT '1 = routes; 2 = permission',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `created_by` int NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `updated_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 286 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_auth_item
-- ----------------------------
INSERT INTO `sys_auth_item` VALUES (32, 'rbac-permission', 2, 'Permission untuk routes Role Base Access Control', '2020-10-21 10:19:48', 1, '2020-10-30 13:31:10', 1);
INSERT INTO `sys_auth_item` VALUES (48, 'rbac/menu/index', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (49, 'rbac/menu/hapus', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (50, 'rbac/menu/list-menu', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (52, 'rbac/user/index', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (53, 'rbac/user/get-data', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (54, 'rbac/user/create', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (55, 'rbac/user/detail', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (56, 'rbac/user/simpan-detail', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (57, 'rbac/user/edit', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (58, 'rbac/user/hapus', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (59, 'rbac/user/get-department', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (61, 'rbac/group/index', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (62, 'rbac/group/detail', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (63, 'rbac/group/get-data', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (64, 'rbac/group/simpan', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (65, 'rbac/group/hapus', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (67, 'rbac/route/index', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (68, 'rbac/route/create', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (69, 'rbac/route/assign', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (70, 'rbac/route/remove', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (71, 'rbac/route/refresh', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (73, 'rbac/allowed/index', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (74, 'rbac/allowed/create', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (75, 'rbac/allowed/assign', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (76, 'rbac/allowed/remove', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (77, 'rbac/allowed/refresh', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (79, 'rbac/permission/index', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (80, 'rbac/permission/detail', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (81, 'rbac/permission/get-data', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (82, 'rbac/permission/simpan', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (83, 'rbac/permission/hapus', 1, NULL, '2020-10-30 13:23:51', 1, '2020-10-30 13:23:51', NULL);
INSERT INTO `sys_auth_item` VALUES (87, 'rbac/menu/index', 1, NULL, '2020-10-31 04:34:33', 1, '2020-10-31 04:34:33', NULL);
INSERT INTO `sys_auth_item` VALUES (88, 'site/index', 1, NULL, '2020-11-15 11:57:23', 1, '2020-11-15 11:57:23', NULL);
INSERT INTO `sys_auth_item` VALUES (89, 'site/lock', 1, NULL, '2020-11-15 11:57:23', 1, '2020-11-15 11:57:23', NULL);
INSERT INTO `sys_auth_item` VALUES (92, 'rbac/menu', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (93, 'rbac/user', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (94, 'rbac/group', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (95, 'rbac/route', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (96, 'rbac/allowed', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (97, 'rbac/permission', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (98, 'rbac/permission/view', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (99, 'rbac/permission/assign', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (100, 'rbac/permission/remove', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (101, 'rbac/permission/refresh', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (102, 'rbac/assignment', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (103, 'rbac/assignment/index', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (104, 'rbac/assignment/get-data', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (105, 'rbac/assignment/view', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (106, 'rbac/assignment/assign', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (107, 'rbac/assignment/remove', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (108, 'rbac/assignment/refresh', 1, NULL, '2020-11-15 11:57:30', 1, '2020-11-15 11:57:30', NULL);
INSERT INTO `sys_auth_item` VALUES (109, 'all-user-permission', 2, 'Permission that accessible by all user', '2020-11-22 08:37:00', 1, '2020-11-22 08:37:00', NULL);
INSERT INTO `sys_auth_item` VALUES (110, 'profil/ubah-password', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (153, 'rbac/user/get-atasan', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (154, 'rbac/user/get-grade', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (155, 'rbac/user/get-designation', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (156, 'rbac/user/get-kelas-jabatan', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (157, 'rbac/user/get-golongan', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (204, 'notifikasi/index', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);
INSERT INTO `sys_auth_item` VALUES (205, 'notifikasi/read', 1, NULL, '2021-06-03 23:39:18', 1, '2021-06-03 23:39:18', NULL);

-- ----------------------------
-- Table structure for sys_auth_item_child
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_item_child`;
CREATE TABLE `sys_auth_item_child`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `child` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 318 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_auth_item_child
-- ----------------------------
INSERT INTO `sys_auth_item_child` VALUES (3, 'rbac-permission', 'rbac/menu/hapus');
INSERT INTO `sys_auth_item_child` VALUES (4, 'rbac-permission', 'rbac/menu/list-menu');
INSERT INTO `sys_auth_item_child` VALUES (5, 'rbac-permission', 'rbac/user/index');
INSERT INTO `sys_auth_item_child` VALUES (6, 'rbac-permission', 'rbac/user/get-data');
INSERT INTO `sys_auth_item_child` VALUES (7, 'rbac-permission', 'rbac/user/create');
INSERT INTO `sys_auth_item_child` VALUES (8, 'rbac-permission', 'rbac/user/detail');
INSERT INTO `sys_auth_item_child` VALUES (9, 'rbac-permission', 'rbac/user/simpan-detail');
INSERT INTO `sys_auth_item_child` VALUES (10, 'rbac-permission', 'rbac/user/edit');
INSERT INTO `sys_auth_item_child` VALUES (11, 'rbac-permission', 'rbac/user/hapus');
INSERT INTO `sys_auth_item_child` VALUES (12, 'rbac-permission', 'rbac/user/get-department');
INSERT INTO `sys_auth_item_child` VALUES (13, 'rbac-permission', 'rbac/menu/index');
INSERT INTO `sys_auth_item_child` VALUES (14, 'rbac-permission', 'rbac/group/index');
INSERT INTO `sys_auth_item_child` VALUES (15, 'rbac-permission', 'rbac/group/detail');
INSERT INTO `sys_auth_item_child` VALUES (16, 'rbac-permission', 'rbac/group/get-data');
INSERT INTO `sys_auth_item_child` VALUES (17, 'rbac-permission', 'rbac/group/simpan');
INSERT INTO `sys_auth_item_child` VALUES (18, 'rbac-permission', 'rbac/group/hapus');
INSERT INTO `sys_auth_item_child` VALUES (19, 'rbac-permission', 'rbac/route/index');
INSERT INTO `sys_auth_item_child` VALUES (20, 'rbac-permission', 'rbac/route/create');
INSERT INTO `sys_auth_item_child` VALUES (21, 'rbac-permission', 'rbac/route/assign');
INSERT INTO `sys_auth_item_child` VALUES (22, 'rbac-permission', 'rbac/route/remove');
INSERT INTO `sys_auth_item_child` VALUES (23, 'rbac-permission', 'rbac/route/refresh');
INSERT INTO `sys_auth_item_child` VALUES (24, 'rbac-permission', 'rbac/allowed/index');
INSERT INTO `sys_auth_item_child` VALUES (25, 'rbac-permission', 'rbac/allowed/create');
INSERT INTO `sys_auth_item_child` VALUES (26, 'rbac-permission', 'rbac/allowed/assign');
INSERT INTO `sys_auth_item_child` VALUES (27, 'rbac-permission', 'rbac/allowed/remove');
INSERT INTO `sys_auth_item_child` VALUES (28, 'rbac-permission', 'rbac/allowed/refresh');
INSERT INTO `sys_auth_item_child` VALUES (29, 'rbac-permission', 'rbac/permission/index');
INSERT INTO `sys_auth_item_child` VALUES (30, 'rbac-permission', 'rbac/permission/detail');
INSERT INTO `sys_auth_item_child` VALUES (31, 'rbac-permission', 'rbac/permission/get-data');
INSERT INTO `sys_auth_item_child` VALUES (32, 'rbac-permission', 'rbac/permission/simpan');
INSERT INTO `sys_auth_item_child` VALUES (33, 'rbac-permission', 'rbac/permission/hapus');
INSERT INTO `sys_auth_item_child` VALUES (34, 'rbac-permission', 'rbac/permission/view');
INSERT INTO `sys_auth_item_child` VALUES (35, 'rbac-permission', 'rbac/permission/assign');
INSERT INTO `sys_auth_item_child` VALUES (36, 'rbac-permission', 'rbac/menu');
INSERT INTO `sys_auth_item_child` VALUES (37, 'rbac-permission', 'rbac/user');
INSERT INTO `sys_auth_item_child` VALUES (38, 'rbac-permission', 'rbac/group');
INSERT INTO `sys_auth_item_child` VALUES (39, 'rbac-permission', 'rbac/route');
INSERT INTO `sys_auth_item_child` VALUES (40, 'rbac-permission', 'rbac/allowed');
INSERT INTO `sys_auth_item_child` VALUES (41, 'rbac-permission', 'rbac/permission');
INSERT INTO `sys_auth_item_child` VALUES (42, 'rbac-permission', 'rbac/permission/assign');
INSERT INTO `sys_auth_item_child` VALUES (43, 'rbac-permission', 'rbac/permission/remove');
INSERT INTO `sys_auth_item_child` VALUES (44, 'rbac-permission', 'rbac/permission/refresh');
INSERT INTO `sys_auth_item_child` VALUES (45, 'rbac-permission', 'rbac/assignment');
INSERT INTO `sys_auth_item_child` VALUES (46, 'rbac-permission', 'rbac/assignment/index');
INSERT INTO `sys_auth_item_child` VALUES (47, 'rbac-permission', 'rbac/assignment/get-data');
INSERT INTO `sys_auth_item_child` VALUES (48, 'rbac-permission', 'rbac/assignment/view');
INSERT INTO `sys_auth_item_child` VALUES (49, 'rbac-permission', 'rbac/assignment/assign');
INSERT INTO `sys_auth_item_child` VALUES (50, 'rbac-permission', 'rbac/assignment/remove');
INSERT INTO `sys_auth_item_child` VALUES (51, 'rbac-permission', 'rbac/assignment/refresh');
INSERT INTO `sys_auth_item_child` VALUES (135, 'rbac-permission', 'rbac/user/get-atasan');
INSERT INTO `sys_auth_item_child` VALUES (136, 'rbac-permission', 'rbac/user/get-grade');
INSERT INTO `sys_auth_item_child` VALUES (137, 'rbac-permission', 'rbac/user/get-designation');
INSERT INTO `sys_auth_item_child` VALUES (138, 'rbac-permission', 'rbac/user/get-kelas-jabatan');
INSERT INTO `sys_auth_item_child` VALUES (139, 'rbac-permission', 'rbac/user/get-golongan');

-- ----------------------------
-- Table structure for tbl_group
-- ----------------------------
DROP TABLE IF EXISTS `tbl_group`;
CREATE TABLE `tbl_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `label` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `parent_id` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `url` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_group
-- ----------------------------
INSERT INTO `tbl_group` VALUES (1, 'administrator', 'Administrator', 'Jenis grup yg memiliki hak akses penuh terhadap sistem', '[1]', '/site/index');

-- ----------------------------
-- Table structure for tbl_group_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_group_user`;
CREATE TABLE `tbl_group_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id` ASC) USING BTREE,
  INDEX `fk_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `tbl_group_user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `tbl_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `tbl_group_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4257 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_group_user
-- ----------------------------
INSERT INTO `tbl_group_user` VALUES (2279, 1, 1);

-- ----------------------------
-- Table structure for tbl_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbl_menu`;
CREATE TABLE `tbl_menu`  (
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
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_menu
-- ----------------------------
INSERT INTO `tbl_menu` VALUES (5, 'Pengaturan', '', '1', 'backend-menu', 0, 1, '#', 'fas fa-cogs', NULL, 1);
INSERT INTO `tbl_menu` VALUES (6, 'Manajemen User', '', '1', 'backend-menu', 5, 1, '#', 'fas fa-users', NULL, 2);
INSERT INTO `tbl_menu` VALUES (7, 'Manajemen Menu', '', '1', 'backend-menu', 5, 2, '/rbac/menu', 'fas fa-sliders-h', NULL, 2);
INSERT INTO `tbl_menu` VALUES (17, 'Dashboard', '', '1', 'backend-menu', 0, 0, '/site', 'fas fa-tachometer-alt', NULL, 1);
INSERT INTO `tbl_menu` VALUES (30, 'Access Control', '', '1', 'backend-menu', 5, 0, '#', 'fas fa-shield-alt', NULL, 2);
INSERT INTO `tbl_menu` VALUES (31, 'Allowed', '', '1', 'backend-menu', 30, 0, '/rbac/allowed', '', NULL, 3);
INSERT INTO `tbl_menu` VALUES (32, 'Route', '', '1', 'backend-menu', 30, 1, '/rbac/route', '', NULL, 3);
INSERT INTO `tbl_menu` VALUES (33, 'Permission', '', '1', 'backend-menu', 30, 2, '/rbac/permission', '', NULL, 3);
INSERT INTO `tbl_menu` VALUES (34, 'Assignment', '', '1', 'backend-menu', 30, 3, '/rbac/assignment', '', NULL, 3);
INSERT INTO `tbl_menu` VALUES (35, 'User', '', '1', 'backend-menu', 6, 0, '/rbac/user', '', NULL, 3);
INSERT INTO `tbl_menu` VALUES (36, 'Group', '', '1', 'backend-menu', 6, 1, '/rbac/group', '', NULL, 3);

-- ----------------------------
-- Table structure for tbl_menu_group
-- ----------------------------
DROP TABLE IF EXISTS `tbl_menu_group`;
CREATE TABLE `tbl_menu_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NULL DEFAULT NULL,
  `group_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_id`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `tbl_menu_group_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `tbl_menu` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6320 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_menu_group
-- ----------------------------
INSERT INTO `tbl_menu_group` VALUES (6297, 17, '1');
INSERT INTO `tbl_menu_group` VALUES (6304, 5, '1');
INSERT INTO `tbl_menu_group` VALUES (6307, 30, '1');
INSERT INTO `tbl_menu_group` VALUES (6308, 31, '1');
INSERT INTO `tbl_menu_group` VALUES (6309, 32, '1');
INSERT INTO `tbl_menu_group` VALUES (6310, 33, '1');
INSERT INTO `tbl_menu_group` VALUES (6311, 34, '1');
INSERT INTO `tbl_menu_group` VALUES (6312, 6, '1');
INSERT INTO `tbl_menu_group` VALUES (6315, 35, '1');
INSERT INTO `tbl_menu_group` VALUES (6318, 36, '1');
INSERT INTO `tbl_menu_group` VALUES (6319, 7, '1');

-- ----------------------------
-- Table structure for tbl_menu_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_menu_type`;
CREATE TABLE `tbl_menu_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `menu_type`(`menu_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_menu_type
-- ----------------------------
INSERT INTO `tbl_menu_type` VALUES (1, 'backend-menu', 'Menu Utama', 'Menu utama aplikasi HRIS');

-- ----------------------------
-- Table structure for tbl_notifikasi
-- ----------------------------
DROP TABLE IF EXISTS `tbl_notifikasi`;
CREATE TABLE `tbl_notifikasi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `to` int NULL DEFAULT NULL,
  `is_read` int NULL DEFAULT 0 COMMENT '0 = Belum; 1 = Dibaca',
  `redirect_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Url yg akan me-redirect jika notifikasi di-klik',
  `priority` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Simpan class untuk ubah warna berdasarkan prioritas',
  `created_at` datetime NULL DEFAULT NULL,
  `triggered_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_notifikasi
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Kalau boleh username menggunakan NIP',
  `password` varchar(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `auth_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Untuk kebutuhan kode unik aktivasi akun via email atau bisa juga untuk simpan API Key',
  `reset_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Untuk kebutuhan kode unik ketika reset password',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0 COMMENT '0=inactive; 1=active',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1714 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES (1, 'admin', '$2y$10$3krJQBrXPlyfVO31dvuf0uAdsJh.0KneiRUlSKzP2jYyDpBaOClbK', NULL, NULL, '', 1, '2024-01-27 20:59:25', NULL, '2024-01-27 20:59:25', 1, NULL, NULL);

-- ----------------------------
-- Table structure for tbl_user_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_detail`;
CREATE TABLE `tbl_user_detail`  (
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
  `agama` enum('islam','kristen_protestan','hindu','buddha','katolik','kong_hu_cu') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Kalau ada kemungkinan ditambah, bisa dibuatkan table sendiri',
  `jenis_kelamin` enum('p','w') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status_perkawinan` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '0 = single; 1 = married; 2 = divorce',
  `pddk_terakhir` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'Nantinya akan dibuat data json {jalan:,kota:}',
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
) ENGINE = InnoDB AUTO_INCREMENT = 1592 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_user_detail
-- ----------------------------
INSERT INTO `tbl_user_detail` VALUES (1, 1, '', 'Administrator', '', 'System', '', '1993-08-15', '0000-00-00', '', '1997-06-19', '', 'p', '0', '1', '', NULL, NULL, NULL, '', './web/uploads/profile/Foto_Profil_1.png', '2024-02-20 15:49:55', 1, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
