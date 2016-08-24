/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : test_db

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-08-24 12:35:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_excel_sheet_colume
-- ----------------------------
DROP TABLE IF EXISTS `t_excel_sheet_colume`;
CREATE TABLE `t_excel_sheet_colume` (
  `iautoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `iexcelId` int(11) NOT NULL COMMENT 'excelconfig表外键ID',
  `icolumeNum` int(11) NOT NULL COMMENT 'Excel中第几列',
  `scolume` varchar(50) NOT NULL COMMENT '列对应的字段名称',
  `iCreateTime` int(11) NOT NULL COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL COMMENT '更新时间',
  `iStatus` int(1) NOT NULL COMMENT '逻辑删除状态[0：逻辑删除，1：有效]',
  `iDeleteTime` int(11) NOT NULL COMMENT '逻辑删除时间',
  PRIMARY KEY (`iautoId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of t_excel_sheet_colume
-- ----------------------------
INSERT INTO `t_excel_sheet_colume` VALUES ('1', '1', '0', 'iAutoId', '0', '0', '0', '0');
INSERT INTO `t_excel_sheet_colume` VALUES ('2', '1', '1', 'iAmount', '0', '0', '0', '0');
INSERT INTO `t_excel_sheet_colume` VALUES ('3', '1', '2', 'iDataTime', '0', '0', '0', '0');
INSERT INTO `t_excel_sheet_colume` VALUES ('4', '1', '3', 'iAuditStatus', '0', '0', '0', '0');
