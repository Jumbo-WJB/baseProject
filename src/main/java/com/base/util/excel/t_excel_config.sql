/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : test_db

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-08-24 12:35:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_excel_config
-- ----------------------------
DROP TABLE IF EXISTS `t_excel_config`;
CREATE TABLE `t_excel_config` (
  `iautoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `sfileName` varchar(50) NOT NULL COMMENT '文件名称',
  `ssheetName` varchar(50) NOT NULL COMMENT 'sheet页名称',
  `istartRowNum` int(11) NOT NULL COMMENT '起始行',
  `iCreateTime` int(11) NOT NULL COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL COMMENT '更新时间',
  `iStatus` int(1) NOT NULL COMMENT '逻辑删除状态[0：逻辑删除，1：有效]',
  `iDeleteTime` int(11) NOT NULL COMMENT '逻辑删除时间',
  PRIMARY KEY (`iautoId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_excel_config
-- ----------------------------
INSERT INTO `t_excel_config` VALUES ('1', 'sss好的', '小额提现申请记录', '1', '0', '0', '0', '0');
