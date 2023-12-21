/*
 Navicat MySQL Data Transfer

 Source Server         : books
 Source Server Type    : MySQL
 Source Server Version : 80035 (8.0.35)
 Source Host           : localhost:3306
 Source Schema         : books

 Target Server Type    : MySQL
 Target Server Version : 80035 (8.0.35)
 File Encoding         : 65001

 Date: 18/12/2023 13:57:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book`  (
  `bid` int NOT NULL AUTO_INCREMENT COMMENT '图书信息的ID',
  `book_name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图书名称',
  `author` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '作者',
  `num` int NULL DEFAULT NULL COMMENT '库存',
  `press` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `tid` int NULL DEFAULT NULL COMMENT '类型ID',
  `times` int NULL DEFAULT NULL COMMENT '被借阅次数',
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES (9, 'The Great Gatsby', 'F. Scott Fitzgerald', 100, 'Charles Scribner\'s Sons', 7, 1);
INSERT INTO `t_book` VALUES (10, '1984', 'George Orwell', 100, 'New American Library', 3, 0);
INSERT INTO `t_book` VALUES (11, 'the Battle Through the Heavens', 'Tudou Tianchan', 50, 'Penguin Press', 1, 0);
INSERT INTO `t_book` VALUES (12, 'The Plum in the Golden Vase', ' Lanling Xiaoxiao Sheng', 20, 'Ming Dynasty Press', 2, 0);
INSERT INTO `t_book` VALUES (13, 'Diffuse', 'Eason Chen', 20, 'Golden Press', 2, 0);
INSERT INTO `t_book` VALUES (14, 'In the Shadows of Giants', 'Sophia Marquez', 20, 'Mythos and Legends Ltd', 3, 0);
INSERT INTO `t_book` VALUES (15, 'The Clockwork Garden', 'Tobias Fletcher', 20, 'Steampunk Press', 3, 0);
INSERT INTO `t_book` VALUES (16, 'Giggles at the Gala', 'Jasper Quinn', 20, 'Laughing Owl Publications', 4, 0);
INSERT INTO `t_book` VALUES (17, 'The Accidental Spy in Suburbia', 'Fiona Bright', 20, 'Chucklehouse Press', 4, 0);
INSERT INTO `t_book` VALUES (18, 'Moonlit Promises', 'Ethan Montgomery', 20, 'Starlight Literary Press', 2, 0);
INSERT INTO `t_book` VALUES (19, 'Whispers of the Heart', 'Charlotte Sinclair', 20, 'Rosewood Romance Publishing', 2, 0);
INSERT INTO `t_book` VALUES (20, 'All the Light We Cannot See', 'Anthony Doerr', 20, 'Scribner', 5, 0);
INSERT INTO `t_book` VALUES (21, 'The Book Thief', 'Markus Zusak', 20, 'Knopf Doubleday Publishing Group', 5, 0);
INSERT INTO `t_book` VALUES (22, 'The Joy of Cooking', 'Irma S. Rombauer', 20, 'Scribner', 6, 0);
INSERT INTO `t_book` VALUES (23, 'Mastering the Art of French Cooking', 'Julia Child', 20, 'Alfred A. Knopf', 6, 0);

-- ----------------------------
-- Table structure for t_history
-- ----------------------------
DROP TABLE IF EXISTS `t_history`;
CREATE TABLE `t_history`  (
  `hid` int NOT NULL AUTO_INCREMENT COMMENT '记录表ID',
  `uid` int NULL DEFAULT NULL COMMENT '用户ID',
  `name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `account` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `bid` int NULL DEFAULT NULL COMMENT '图书ID',
  `book_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图书名称',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '借书时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '还书时间',
  `status` int NULL DEFAULT NULL COMMENT '借阅状态，1为正在借阅，2 已经还书',
  PRIMARY KEY (`hid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_history
-- ----------------------------
INSERT INTO `t_history` VALUES (1, 3, 'John Smith', '1', 9, 'The Great Gatsby', '2023-12-17 19:22:45', '2023-12-27 19:22:45', 2);

-- ----------------------------
-- Table structure for t_problem
-- ----------------------------
DROP TABLE IF EXISTS `t_problem`;
CREATE TABLE `t_problem`  (
  `pid` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `uid` int NULL DEFAULT NULL COMMENT '反馈人ID',
  `title` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '标题',
  `page` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '页面',
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '内容',
  `link` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '0 未解决  1已解决',
  `time` datetime NULL DEFAULT NULL COMMENT '反馈时间',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_problem
-- ----------------------------

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `tid` int NOT NULL AUTO_INCREMENT COMMENT '类型主键ID',
  `type_name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图书类型名称',
  PRIMARY KEY (`tid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1, 'Adventure');
INSERT INTO `t_type` VALUES (2, 'Love');
INSERT INTO `t_type` VALUES (3, 'Fictional');
INSERT INTO `t_type` VALUES (4, 'Comedy');
INSERT INTO `t_type` VALUES (5, 'History');
INSERT INTO `t_type` VALUES (6, 'cooking');
INSERT INTO `t_type` VALUES (7, 'Literary realism');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `uid` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户表主键ID',
  `account` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '账号',
  `name` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `password` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机',
  `times` int NULL DEFAULT NULL COMMENT '借阅量',
  `lend_num` int NULL DEFAULT NULL COMMENT '可借阅天数',
  `max_num` int NULL DEFAULT NULL COMMENT '最大可借数量',
  `role` int NULL DEFAULT NULL COMMENT '角色 1用户 2管理员',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', 'admin', '4QrcOUm6Wau+VuBX8g+IPg==', '9297728975', 0, 0, 0, 2);
INSERT INTO `t_user` VALUES (2, '007', 'James Bond', '4QrcOUm6Wau+VuBX8g+IPg==', '007007007', 0, 100, 100, 2);
INSERT INTO `t_user` VALUES (3, '1', 'John Smith', '4QrcOUm6Wau+VuBX8g+IPg==', '1860000001', 1, 10, 10, 1);
INSERT INTO `t_user` VALUES (4, '2', 'Emily Johnson', '4QrcOUm6Wau+VuBX8g+IPg==', '1860000002', 0, 15, 15, 1);
INSERT INTO `t_user` VALUES (5, '3', 'David Williams', '4QrcOUm6Wau+VuBX8g+IPg==', '1860000003', 0, 15, 15, 1);
INSERT INTO `t_user` VALUES (6, '4', 'Sophia Brown', '4QrcOUm6Wau+VuBX8g+IPg==', '1860000004', 0, 15, 15, 1);
INSERT INTO `t_user` VALUES (7, '5', 'Michael Davis', '4QrcOUm6Wau+VuBX8g+IPg==', '1860000005', 0, 15, 15, 1);

SET FOREIGN_KEY_CHECKS = 1;
