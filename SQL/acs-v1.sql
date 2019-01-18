/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : acs

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 18/01/2019 15:58:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ac_right
-- ----------------------------
DROP TABLE IF EXISTS `ac_right`;
CREATE TABLE `ac_right`  (
  `ar_id` int(10) NOT NULL AUTO_INCREMENT,
  `right_id` bigint(20) NOT NULL,
  `ac_id` int(10) NOT NULL,
  `starttime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '开始时间',
  `endtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '结束时间',
  PRIMARY KEY (`ar_id`) USING BTREE,
  INDEX `fk_ar_right`(`right_id`) USING BTREE,
  INDEX `fk_ar_ac`(`ac_id`) USING BTREE,
  CONSTRAINT `fk_ar_ac` FOREIGN KEY (`ac_id`) REFERENCES `tb_ac` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_ar_right` FOREIGN KEY (`right_id`) REFERENCES `tb_right` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门禁权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ac_right
-- ----------------------------
INSERT INTO `ac_right` VALUES (1, 1, 1, '2019-01-18 15:08:53', '2019-01-18 15:08:53');

-- ----------------------------
-- Table structure for group_right
-- ----------------------------
DROP TABLE IF EXISTS `group_right`;
CREATE TABLE `group_right`  (
  `gr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `g_id` bigint(20) NOT NULL COMMENT '组id',
  `r_id` bigint(20) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`gr_id`) USING BTREE,
  INDEX `fk_gr_group`(`g_id`) USING BTREE,
  INDEX `fk_gr_right`(`r_id`) USING BTREE,
  CONSTRAINT `fk_gr_group` FOREIGN KEY (`g_id`) REFERENCES `tb_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_gr_right` FOREIGN KEY (`r_id`) REFERENCES `tb_right` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_right
-- ----------------------------
INSERT INTO `group_right` VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for role_right
-- ----------------------------
DROP TABLE IF EXISTS `role_right`;
CREATE TABLE `role_right`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `right_id` bigint(20) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_rr_role`(`role_id`) USING BTREE,
  INDEX `fk_rr_right`(`right_id`) USING BTREE,
  CONSTRAINT `fk_rr_role` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rr_right` FOREIGN KEY (`right_id`) REFERENCES `tb_right` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_right
-- ----------------------------
INSERT INTO `role_right` VALUES (1, 1, 1);
INSERT INTO `role_right` VALUES (2, 1, 2);

-- ----------------------------
-- Table structure for tb_ac
-- ----------------------------
DROP TABLE IF EXISTS `tb_ac`;
CREATE TABLE `tb_ac`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '门禁编号',
  `status` tinyint(4) NOT NULL COMMENT '1开启状态，0关闭状态',
  `pos_id` int(10) NOT NULL COMMENT '位置id,用于确定门禁所在位置',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_ac_pos`(`pos_id`) USING BTREE,
  CONSTRAINT `fk_ac_pos` FOREIGN KEY (`pos_id`) REFERENCES `tb_position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门禁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_ac
-- ----------------------------
INSERT INTO `tb_ac` VALUES (1, 1, 1, '信息楼215');

-- ----------------------------
-- Table structure for tb_group
-- ----------------------------
DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `group_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组名称',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组信息描述',
  `created` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用于用户分组，便于权限管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES (1, '管理员', '可以在后台添加用户', '2019-01-18 14:22:35');
INSERT INTO `tb_group` VALUES (2, '超级管理员', '可以在后台添加管理员', '2019-01-18 14:22:56');
INSERT INTO `tb_group` VALUES (3, '学生', '无权访问后台', '2019-01-18 14:23:06');
INSERT INTO `tb_group` VALUES (4, '教师', '无权访问后台', '2019-01-18 14:23:12');
INSERT INTO `tb_group` VALUES (5, '员工', '无权访问后台', '2019-01-18 14:23:49');
INSERT INTO `tb_group` VALUES (6, '访客', '无权访问后台，并且有时间限制', '2019-01-18 14:51:10');

-- ----------------------------
-- Table structure for tb_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_log`;
CREATE TABLE `tb_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `u_id` bigint(20) NOT NULL COMMENT '操作人',
  `ac_id` int(10) NOT NULL COMMENT '门禁编号',
  `op_type` tinyint(4) NOT NULL COMMENT '操作类型：1刷卡，0扫码',
  `door_status` tinyint(4) NOT NULL COMMENT '1进入，0离开',
  `op_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `fk_log_user`(`u_id`) USING BTREE,
  INDEX `fk_log_ac`(`ac_id`) USING BTREE,
  CONSTRAINT `fk_log_user` FOREIGN KEY (`u_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_log_ac` FOREIGN KEY (`ac_id`) REFERENCES `tb_ac` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_position
-- ----------------------------
DROP TABLE IF EXISTS `tb_position`;
CREATE TABLE `tb_position`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `house` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '哪栋楼,如信息楼',
  `floor` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '楼层,如2楼',
  `locate` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '具体门牌号,如215',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '学校位置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_position
-- ----------------------------
INSERT INTO `tb_position` VALUES (1, '信息楼', '2楼', '215');
INSERT INTO `tb_position` VALUES (2, '信息楼', '2楼', '211');

-- ----------------------------
-- Table structure for tb_right
-- ----------------------------
DROP TABLE IF EXISTS `tb_right`;
CREATE TABLE `tb_right`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `right_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限具体描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `right_name`(`right_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_right
-- ----------------------------
INSERT INTO `tb_right` VALUES (1, '超级权限', '可访问所有门禁');
INSERT INTO `tb_right` VALUES (2, '管理权限', '可访问某一部分');
INSERT INTO `tb_right` VALUES (3, '普通权限', '非连续性，可拥有多个');
INSERT INTO `tb_right` VALUES (4, '访客权限', '相比普通权限，时间会精确到时分');

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `created` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色信息,无权登录后台的普通用户，可以登录后台的管理员和超级管理员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES (1, '超级管理员', '2019-01-18 14:56:25', '拥有最高权限');
INSERT INTO `tb_role` VALUES (2, '普通管理员', '2019-01-18 14:57:17', '拥有某一区域的全部权限');
INSERT INTO `tb_role` VALUES (3, '普通职工', '2019-01-18 14:58:17', '拥有某一区域的个别门禁权限');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `u_id` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '工号/登录名',
  `u_pwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码，加密储存',
  `fullname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级',
  `college` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二级学院',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系手机,默认为空',
  `count` int(10) NULL DEFAULT 0 COMMENT '刷卡次数',
  `created` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `u_id`(`u_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, '51730301', NULL, '张三', '软件1733', '信息工程学院', '1234567891', 0, '2019-01-18 14:11:17');
INSERT INTO `tb_user` VALUES (2, '51730302', NULL, '李四', '软件1733', '信息工程学院', '1111111111', 0, '2019-01-18 14:14:00');
INSERT INTO `tb_user` VALUES (3, '51739303', NULL, '王五', '软件1733', '信息工程学院', '1111111111', 0, '2019-01-18 14:14:36');

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`  (
  `ug_id` int(10) NOT NULL AUTO_INCREMENT,
  `u_id` bigint(20) NOT NULL,
  `g_id` bigint(20) NOT NULL COMMENT '组id',
  PRIMARY KEY (`ug_id`) USING BTREE,
  INDEX `fk_ug_user`(`u_id`) USING BTREE,
  INDEX `fk_ug_group`(`g_id`) USING BTREE,
  CONSTRAINT `fk_ug_user` FOREIGN KEY (`u_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_ug_group` FOREIGN KEY (`g_id`) REFERENCES `tb_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户分组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_group
-- ----------------------------
INSERT INTO `user_group` VALUES (1, 1, 1);
INSERT INTO `user_group` VALUES (2, 2, 2);
INSERT INTO `user_group` VALUES (3, 3, 1);

-- ----------------------------
-- Table structure for user_right
-- ----------------------------
DROP TABLE IF EXISTS `user_right`;
CREATE TABLE `user_right`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  `u_id` bigint(20) NOT NULL COMMENT '操作人',
  `ac_id` int(10) NOT NULL COMMENT '门禁编号',
  `right_type` tinyint(4) NOT NULL COMMENT '1,允许,0,不允许',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_ur_user`(`u_id`) USING BTREE,
  INDEX `fk_ur_ac`(`ac_id`) USING BTREE,
  CONSTRAINT `fk_ur_user` FOREIGN KEY (`u_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_ur_ac` FOREIGN KEY (`ac_id`) REFERENCES `tb_ac` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_right
-- ----------------------------
INSERT INTO `user_right` VALUES (1, 1, 1, 1);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标识ID',
  `u_id` bigint(20) NOT NULL COMMENT '操作人',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_u_role_user`(`u_id`) USING BTREE,
  INDEX `fk_u_role_role`(`role_id`) USING BTREE,
  CONSTRAINT `fk_u_role_role` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_u_role_user` FOREIGN KEY (`u_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, 1);

SET FOREIGN_KEY_CHECKS = 1;
