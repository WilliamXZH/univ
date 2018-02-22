/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50518
Source Host           : localhost:3306
Source Database       : fresho2o

Target Server Type    : MYSQL
Target Server Version : 50518
File Encoding         : 65001

Date: 2016-03-29 21:08:26
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `area`
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `areaname` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `xypoint` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('9', '龙岗区政府', 'aaaaaaa', '114.254581,22.725132');
INSERT INTO `area` VALUES ('10', '东晖花园', '广州市天河区东晖花园', '113.368097,23.135325');

-- ----------------------------
-- Table structure for `cookbook`
-- ----------------------------
DROP TABLE IF EXISTS `cookbook`;
CREATE TABLE `cookbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) DEFAULT NULL,
  `cmethod` varchar(255) DEFAULT NULL,
  `csource` varchar(64) DEFAULT NULL,
  `cpic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cookbook
-- ----------------------------
INSERT INTO `cookbook` VALUES ('7', '菜肴1', '做法。。。     ', 'ere 苹果 萝卜 ', '/upload/20160327233531.png');

-- ----------------------------
-- Table structure for `deduction`
-- ----------------------------
DROP TABLE IF EXISTS `deduction`;
CREATE TABLE `deduction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deduction` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of deduction
-- ----------------------------
INSERT INTO `deduction` VALUES ('3', '100');

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `g_id` int(11) NOT NULL AUTO_INCREMENT,
  `g_name` varchar(255) DEFAULT NULL,
  `g_pic` varchar(255) DEFAULT NULL,
  `g_desc` varchar(255) DEFAULT NULL,
  `g_price` double(255,0) DEFAULT NULL,
  `g_dis` double(255,0) DEFAULT NULL,
  `g_type` varchar(255) DEFAULT NULL,
  `category_id` int(4) DEFAULT NULL,
  `g_reco` varchar(25) DEFAULT NULL,
  `g_count` int(11) DEFAULT NULL,
  `g_integration` int(4) DEFAULT NULL,
  `g_discount` int(4) DEFAULT NULL,
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('7', 'ere', '/upload/20160327232949.png', '2', '2', null, null, '1', '1', '22', '11', '0');
INSERT INTO `goods` VALUES ('8', '猪肉', '/upload/20160327233002.png', '猪肉', '23', null, null, '3', '0', '2', '0', '0');
INSERT INTO `goods` VALUES ('9', '苹果', '/upload/20160327233018.png', '未22 ', '34', null, null, '4', '1', '3', '0', '0');
INSERT INTO `goods` VALUES ('10', '大米', '/upload/20160327233027.png', '333', '12', null, null, '2', '0', '22', '0', '0');
INSERT INTO `goods` VALUES ('11', '萝卜', '/upload/20160327233037.png', '白萝卜', '3', null, null, '1', '0', '4', '0', '0');
INSERT INTO `goods` VALUES ('12', '杏', '/upload/20160327233047.png', '杏123', '12', null, null, '5', '0', '12', '0', '0');
INSERT INTO `goods` VALUES ('13', '西红柿', '/upload/20160327234541.png', '西红柿', '22', null, null, '1', '1', '2', '10', '0');

-- ----------------------------
-- Table structure for `indent`
-- ----------------------------
DROP TABLE IF EXISTS `indent`;
CREATE TABLE `indent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  `g_name` varchar(255) DEFAULT NULL,
  `g_price` double DEFAULT NULL,
  `g_num` int(4) DEFAULT NULL,
  `g_amount` double DEFAULT NULL,
  `o_state` varchar(25) DEFAULT NULL,
  `o_time` date DEFAULT NULL,
  `o_addr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of indent
-- ----------------------------
INSERT INTO `indent` VALUES ('4', 'admin', '10', '大米', '12', '1', '12', '已发货', '2016-03-20', '广州市天河区');
INSERT INTO `indent` VALUES ('6', 'admin', '10', '大米', '12', '4', '48', '订单已完成', '2016-03-22', '广州市天河区');

-- ----------------------------
-- Table structure for `receiveaddr`
-- ----------------------------
DROP TABLE IF EXISTS `receiveaddr`;
CREATE TABLE `receiveaddr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `defaultaddr` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of receiveaddr
-- ----------------------------
INSERT INTO `receiveaddr` VALUES ('1', 'dfgh', '123', 'dghj', 'admin', null);
INSERT INTO `receiveaddr` VALUES ('4', 'etu', 'rtu', 'etuuyyyuuiiii', 'adimin', null);
INSERT INTO `receiveaddr` VALUES ('5', 'etuo', 'rtyi', 'dgjk', null, null);
INSERT INTO `receiveaddr` VALUES ('13', 'rtyuuu', 'rrttttrrrr1', 'rrtty', 'admin', null);

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `registertime` date DEFAULT NULL,
  `integrate` int(11) DEFAULT '0',
  `nickname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `recvaddr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('13', 'zhangsan', 'zhangsan', '2016-03-24', '1', 'zhangsan2', '123@qq.com', '13333333333', '2016-03-12', '广州市天河区', null);
INSERT INTO `user` VALUES ('14', 'admin', 'admin', '2016-03-25', '2000', 'admin', 'admin@qq.com', '12131', '2016-03-09', 'hanliu', 'dghj');
INSERT INTO `user` VALUES ('15', 'lisi', 'lisi', '2016-03-27', '20000', 'lisi', '123@qq.com', '123456', '2016-03-11', '广州市，，，，', null);
