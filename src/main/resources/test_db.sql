/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : test_db

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-08-22 16:00:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_account_check_details
-- ----------------------------
DROP TABLE IF EXISTS `t_account_check_details`;
CREATE TABLE `t_account_check_details` (
  `iAutoID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `iDate` int(8) unsigned NOT NULL COMMENT '对账账单日期',
  `sSerialNum` varchar(100) NOT NULL COMMENT '支付中心流水号',
  `iAmount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '支付中心支付金额',
  `sThirdSerialNum` varchar(100) NOT NULL COMMENT '第三方支付流水号',
  `iThirdAmount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '第三方支付金额',
  `iFee` bigint(20) NOT NULL DEFAULT '0' COMMENT '手续费',
  `iChannelID` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '渠道ID(1:快钱2:财付通)',
  `iTransactionType` bigint(20) NOT NULL DEFAULT '1' COMMENT '交易类型，1正常交易，2退款',
  `sAccountID` varchar(100) NOT NULL DEFAULT '' COMMENT '渠道账户ID',
  `iBusinessID` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '业务ID',
  `sBusinessOrderID` varchar(100) NOT NULL DEFAULT '' COMMENT '业务订单号',
  `iAccChkStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '对账状态（1:成功，2:补单成功，3:交易金额异常，4:交易状态异常，5:掉单）',
  `iTradeTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易时间（根据情况取时间）',
  `iVoucherStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '回销状态(1:回销成功）',
  `iVoucherTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回销时间',
  `iCheckStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '异常处理状态（1：系统自动失效   2：人工处理失效  3：平账（已处理））',
  `iCallBackStatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '通知业务方状态（ 1:成功 ）',
  `iStatus` tinyint(1) unsigned DEFAULT '1' COMMENT '状态',
  `iCreateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对账创建时间',
  `iUpdateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`),
  KEY `iDateTime_INDEX` (`iDate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对账详情表';

-- ----------------------------
-- Records of t_account_check_details
-- ----------------------------

-- ----------------------------
-- Table structure for t_account_check_result
-- ----------------------------
DROP TABLE IF EXISTS `t_account_check_result`;
CREATE TABLE `t_account_check_result` (
  `iAutoID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `iDate` int(8) NOT NULL COMMENT '交易日期（唯一）',
  `iChannelID` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '渠道ID(1:快钱2:财付通)',
  `sAccountID` varchar(100) DEFAULT NULL COMMENT '渠道账户ID',
  `iPayTotalNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '支付中心总订单量',
  `iPayTotalAmount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '支付中心总订单金额',
  `iPayFee` bigint(20) NOT NULL DEFAULT '0' COMMENT '支付通道服务费',
  `iThirdTotalNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '第三方总订单量',
  `iThirdTotalAmount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '第三方总订单金额',
  `iRefundTotalNum` int(10) NOT NULL DEFAULT '0' COMMENT '支付通道退款总量',
  `iRefundTotalAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '支付通道退款总额',
  `iRefundFee` bigint(20) NOT NULL DEFAULT '0' COMMENT '支付通道退款服务费',
  `iThirdRefundTotalNum` int(10) NOT NULL DEFAULT '0' COMMENT '业务通道退款总量',
  `iThirdRefundTotalAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '业务通道退款总额',
  `iRefundSuccessNum` int(10) NOT NULL DEFAULT '0' COMMENT '退款成功笔数',
  `iResultStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '对账结果状态（1：对账有异常2：对账成功 3: 未对账）',
  `iSuccessNum` int(10) unsigned DEFAULT '0' COMMENT '成功的数量',
  `iReSuccessNum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '补帐成功的数量',
  `iRefundReSuccessNum` int(10) NOT NULL DEFAULT '0' COMMENT '退款补帐成功的数量',
  `iAbnormalAmount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '交易金额异常数量',
  `iAbnormalStatus` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易状态异常数量',
  `iMissing` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '掉单数量',
  `iRefundAbnormalAmount` int(10) NOT NULL DEFAULT '0' COMMENT '退款金额异常数量',
  `iRefundAbnormalStatus` int(10) NOT NULL DEFAULT '0' COMMENT '退款状态异常数量',
  `iRefundMissing` int(10) NOT NULL DEFAULT '0' COMMENT '退款掉单数量',
  `iStatus` tinyint(1) unsigned DEFAULT '1' COMMENT '状态',
  `iCreateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对账时间',
  `iUpdateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`),
  KEY `iDate_INDEX` (`iDate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对账结果表';

-- ----------------------------
-- Records of t_account_check_result
-- ----------------------------

-- ----------------------------
-- Table structure for t_batch_import_record
-- ----------------------------
DROP TABLE IF EXISTS `t_batch_import_record`;
CREATE TABLE `t_batch_import_record` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '批量导入流水号',
  `iBatchSucceedNum` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成功导入数',
  `iBatchErrorNum` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '失败导入数',
  `sOldFileName` varchar(100) NOT NULL DEFAULT '' COMMENT '原文件名称',
  `sErrorFileName` varchar(100) NOT NULL DEFAULT '' COMMENT '错误文件名称',
  `iBatchLoadTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '批量导入时间',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='批量导入名单记录表';

-- ----------------------------
-- Records of t_batch_import_record
-- ----------------------------

-- ----------------------------
-- Table structure for t_business
-- ----------------------------
DROP TABLE IF EXISTS `t_business`;
CREATE TABLE `t_business` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sBusinessName` varchar(50) NOT NULL DEFAULT '' COMMENT '业务名称',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iCreateTime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_business
-- ----------------------------
INSERT INTO `t_business` VALUES ('1', '新房', '0', '0', '0');
INSERT INTO `t_business` VALUES ('2', '二手房', '0', '0', '0');
INSERT INTO `t_business` VALUES ('3', '租房', '0', '0', '0');
INSERT INTO `t_business` VALUES ('4', '金融', '0', '0', '0');

-- ----------------------------
-- Table structure for t_business_product
-- ----------------------------
DROP TABLE IF EXISTS `t_business_product`;
CREATE TABLE `t_business_product` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `iBusinessID` int(11) NOT NULL DEFAULT '0' COMMENT '业务ID',
  `iProductID` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `iCreateTime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_business_product
-- ----------------------------
INSERT INTO `t_business_product` VALUES ('1', '3', '3', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('2', '3', '4', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('3', '4', '1', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('4', '4', '2', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('5', '4', '5', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('6', '4', '6', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('7', '4', '7', '0', '0', '0');
INSERT INTO `t_business_product` VALUES ('8', '4', '8', '0', '0', '0');

-- ----------------------------
-- Table structure for t_case_information
-- ----------------------------
DROP TABLE IF EXISTS `t_case_information`;
CREATE TABLE `t_case_information` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `sCaseID` varchar(14) NOT NULL DEFAULT '' COMMENT '案件号',
  `sCaseType` varchar(2) NOT NULL DEFAULT '0' COMMENT '案件类型',
  `sCaseSource` varchar(11) NOT NULL DEFAULT '0' COMMENT '案件来源',
  `sCaseBelong` varchar(11) NOT NULL DEFAULT '' COMMENT '案件归属',
  `sRelativePrd` varchar(11) NOT NULL DEFAULT '' COMMENT '涉案产品',
  `iGenerateTime` int(11) NOT NULL DEFAULT '0' COMMENT '案件生成时间',
  `sCaseGenerateCause` varchar(11) NOT NULL DEFAULT '' COMMENT '案件生成原因',
  `sTriggerListSequence` varchar(11) NOT NULL DEFAULT '' COMMENT '触发名单序列',
  `sTriggerRuleSequence` varchar(11) NOT NULL DEFAULT '' COMMENT '触发规则序列',
  `iFirstAssignPersonID` int(11) NOT NULL DEFAULT '0' COMMENT '首次分配人ID',
  `sFirstAssignPersonName` varchar(11) NOT NULL DEFAULT '' COMMENT '首次分配人姓名',
  `iFirstAssignTime` int(11) NOT NULL DEFAULT '0' COMMENT '首次分配时间',
  `iLastDealPersonID` int(11) NOT NULL DEFAULT '0' COMMENT '最后处理人ID',
  `sLastDealPersonName` varchar(11) NOT NULL DEFAULT '' COMMENT '最后处理人姓名',
  `iLastDealTime` int(11) NOT NULL DEFAULT '0' COMMENT '最后处理时间',
  `sTradeID` varchar(11) NOT NULL DEFAULT '' COMMENT '交易ID',
  `iCaseStatus` int(11) NOT NULL DEFAULT '0' COMMENT '案件状态',
  `iCaseLockStatus` int(11) NOT NULL DEFAULT '0' COMMENT '案件锁定状态',
  `sCaseEndType` varchar(11) NOT NULL DEFAULT '' COMMENT '案件结束类型',
  `iUserID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `sUserName` varchar(11) NOT NULL DEFAULT '' COMMENT '姓名',
  `sMobiephone` varchar(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` int(2) NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`),
  UNIQUE KEY `caseIndex` (`sCaseID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='案件信息表';

-- ----------------------------
-- Records of t_case_information
-- ----------------------------
INSERT INTO `t_case_information` VALUES ('11', '16051211000001', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '0', '张三0', '1463023641', '0', '张三0', '1463023641', '0', '0', '0', '', '0', '用户0', '13131541210', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('12', '16051211000002', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '1', '张三1', '1463023641', '1', '张三1', '1463023641', '1', '0', '0', '', '1', '用户1', '13131541211', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('13', '16051211000003', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '2', '张三2', '1463023641', '2', '张三2', '1463023641', '2', '0', '0', '', '2', '用户2', '13131541212', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('14', '16051211000004', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '3', '张三3', '1463023641', '3', '张三3', '1463046401', '3', '1', '1', '', '3', '用户3', '13131541213', '1463023641', '1463046401', '0', '0');
INSERT INTO `t_case_information` VALUES ('15', '16051211000005', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '4', '张三4', '1463023641', '4', '张三4', '1463023641', '4', '0', '0', '', '4', '用户4', '13131541214', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('16', '16051211000006', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '5', '张三5', '1463023641', '5', '张三5', '1463023641', '5', '0', '0', '', '5', '用户5', '13131541215', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('17', '16051211000007', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '6', '张三6', '1463023641', '1', '操作人员', '1463033731', '6', '2', '0', '疑似欺诈', '6', '用户6', '13131541216', '1463023641', '1463033731', '0', '0');
INSERT INTO `t_case_information` VALUES ('18', '16051211000008', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '7', '张三7', '1463023641', '7', '张三7', '1463023641', '7', '0', '0', '', '7', '用户7', '13131541217', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('19', '16051211000009', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '8', '张三8', '1463023641', '8', '张三8', '1463023641', '8', '0', '0', '', '8', '用户8', '13131541218', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('20', '16051211000010', '11', '系统监控', '1', '1', '1463023641', '黑名单命中', '黑-电话', '疑似伪卡、套红包', '9', '张三9', '1463023641', '9', '张三9', '1463023641', '9', '0', '0', '', '9', '用户9', '13131541219', '1463023641', '1463023641', '0', '0');
INSERT INTO `t_case_information` VALUES ('21', '16051201000001', '01', '内部发单', '1', '', '1463023898', '', '', '', '0', '张三0', '1463023898', '0', '张三0', '1463023898', '0', '0', '0', '', '0', '用户0', '13131541210', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('22', '16051201000002', '01', '内部发单', '1', '', '1463023898', '', '', '', '1', '张三1', '1463023898', '1', '张三1', '1463023898', '1', '0', '0', '', '1', '用户1', '13131541211', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('23', '16051201000003', '01', '内部发单', '1', '', '1463023898', '', '', '', '2', '张三2', '1463023898', '2', '张三2', '1463023898', '2', '1', '1', '', '2', '用户2', '13131541212', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('24', '16051201000004', '01', '内部发单', '1', '', '1463023898', '', '', '', '3', '张三3', '1463023898', '3', '张三3', '1463046401', '3', '1', '1', '', '3', '用户3', '13131541213', '1463023898', '1463046401', '0', '0');
INSERT INTO `t_case_information` VALUES ('25', '16051201000005', '01', '内部发单', '1', '', '1463023898', '', '', '', '4', '张三4', '1463023898', '4', '张三4', '1463023898', '4', '1', '1', '', '4', '用户4', '13131541214', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('26', '16051201000006', '01', '内部发单', '1', '', '1463023898', '', '', '', '5', '张三5', '1463023898', '5', '张三5', '1463023898', '5', '0', '0', '', '5', '用户5', '13131541215', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('27', '16051201000007', '01', '内部发单', '1', '', '1463023898', '', '', '', '6', '张三6', '1463023898', '6', '张三6', '1463023898', '6', '0', '0', '', '6', '用户6', '13131541216', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('28', '16051201000008', '01', '内部发单', '1', '', '1463023898', '', '', '', '7', '张三7', '1463023898', '7', '张三7', '1463023898', '7', '0', '0', '', '7', '用户7', '13131541217', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('29', '16051201000009', '01', '内部发单', '1', '', '1463023898', '', '', '', '8', '张三8', '1463023898', '8', '张三8', '1463023898', '8', '0', '0', '', '8', '用户8', '13131541218', '1463023898', '1463023898', '0', '0');
INSERT INTO `t_case_information` VALUES ('30', '16051201000010', '01', '内部发单', '1', '', '1463023898', '', '', '', '9', '张三9', '1463023898', '9', '张三9', '1463023898', '9', '0', '0', '', '9', '用户9', '13131541219', '1463023898', '1463023898', '0', '0');

-- ----------------------------
-- Table structure for t_case_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `t_case_operate_log`;
CREATE TABLE `t_case_operate_log` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `iUserID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `sCaseID` varchar(14) NOT NULL DEFAULT '' COMMENT '案件ID',
  `iOperatorID` int(11) NOT NULL DEFAULT '0' COMMENT '操作员ID',
  `sOperatorName` varchar(20) NOT NULL DEFAULT '' COMMENT '操作员名',
  `iOperateTime` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `sActionClassifyOne` varchar(10) NOT NULL DEFAULT '' COMMENT '动作分类一',
  `sActionClassifyTwo` varchar(10) NOT NULL DEFAULT '' COMMENT '动作分类二',
  `sRecordContent` varchar(600) NOT NULL DEFAULT '' COMMENT '记录内容',
  `iCreateTime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '逻辑删除状态：1有效，0删除',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='案件操作日志表';

-- ----------------------------
-- Records of t_case_operate_log
-- ----------------------------
INSERT INTO `t_case_operate_log` VALUES ('9', '1', '16051211000007', '1', '操作人员', '1463033731', '发起动作', '12', '', '0', '0', '1', '0');
INSERT INTO `t_case_operate_log` VALUES ('12', '3', '16051211000004', '1', '张三1', '1463046401', '异常处理', '', '', '1463046401', '0', '1', '0');
INSERT INTO `t_case_operate_log` VALUES ('13', '3', '16051201000004', '1', '张三1', '1463046401', '异常处理', '', '', '1463046401', '0', '1', '0');

-- ----------------------------
-- Table structure for t_commission_confirm
-- ----------------------------
DROP TABLE IF EXISTS `t_commission_confirm`;
CREATE TABLE `t_commission_confirm` (
  `iAutoID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `iLoupanID` int(11) NOT NULL DEFAULT '0' COMMENT '项目ID',
  `sLoupanName` varchar(50) NOT NULL DEFAULT '' COMMENT '项目名称',
  `iRatio` int(11) NOT NULL DEFAULT '0' COMMENT '分佣比率',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0无效，1有效',
  `iCreateTime` int(11) NOT NULL COMMENT '创建时间',
  `iUpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='佣金结算单收入申请确认表';

-- ----------------------------
-- Records of t_commission_confirm
-- ----------------------------

-- ----------------------------
-- Table structure for t_commission_confirm_item
-- ----------------------------
DROP TABLE IF EXISTS `t_commission_confirm_item`;
CREATE TABLE `t_commission_confirm_item` (
  `iAutoID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `iRelationID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关联申请ID',
  `sBalanceNo` char(50) NOT NULL DEFAULT '' COMMENT '结算单号',
  `iOrderNum` int(11) NOT NULL DEFAULT '0' COMMENT '订单的数量',
  `iBranchCompany` char(50) NOT NULL DEFAULT '' COMMENT '分公司段即业绩归属地',
  `iAmount` varchar(255) NOT NULL DEFAULT '' COMMENT '收入',
  `iOrderOut` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单支出',
  `iCommissionBase` bigint(20) NOT NULL DEFAULT '0',
  `sFileUrl` varchar(255) NOT NULL DEFAULT '' COMMENT '结算单文件地址',
  `iAccountID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作人ID',
  `sUmAccount` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人um账号',
  `bConfirm` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '结算是否确认过： 1 未确认, 2 已确认, 3 驳回',
  `iCallBackStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '通知状态（2 通知成功）',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0无效，1有效',
  `iCreateTime` int(11) NOT NULL COMMENT '创建时间',
  `iUpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='佣金结算单收入清单';

-- ----------------------------
-- Records of t_commission_confirm_item
-- ----------------------------

-- ----------------------------
-- Table structure for t_commission_settlement
-- ----------------------------
DROP TABLE IF EXISTS `t_commission_settlement`;
CREATE TABLE `t_commission_settlement` (
  `iAutoID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sBalanceNo` char(50) NOT NULL DEFAULT '' COMMENT '结算单号',
  `iOrderNum` int(11) NOT NULL DEFAULT '0' COMMENT '订单的数量',
  `iBusinessType` smallint(3) NOT NULL DEFAULT '0' COMMENT '业务类型(601 新房, 602 二手房)',
  `iBranchCompany` char(50) NOT NULL DEFAULT '' COMMENT '分公司即成本中心段',
  `sCompany` varchar(100) NOT NULL DEFAULT '' COMMENT '分公司',
  `iLoupanID` int(11) NOT NULL DEFAULT '0' COMMENT '楼盘项目ID',
  `sLoupanName` char(100) NOT NULL COMMENT '楼盘名称 项目名称',
  `iCommissionMonth` int(11) NOT NULL COMMENT '佣金月份',
  `sRejectDesc` varchar(50) NOT NULL DEFAULT '' COMMENT '驳回理由',
  `iVerifyStatus` tinyint(3) NOT NULL DEFAULT '1' COMMENT '审核状态：1：审核中，2 经办驳回， 3经办通过，4 复核驳回， 5 复核通过即完全通过',
  `bResend` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否重发 0 否， 1是',
  `iPayStatus` tinyint(1) DEFAULT '1' COMMENT '支付状态(1:支付创建，2：支付中，3：支付成功，4：支付失败)',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0无效，1有效',
  `iCreateTime` int(11) NOT NULL COMMENT '创建时间',
  `iUpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COMMENT='佣金支付信息表';

-- ----------------------------
-- Records of t_commission_settlement
-- ----------------------------
INSERT INTO `t_commission_settlement` VALUES ('148', 'hxt001', '3', '601', '1014', '上海', '101288', '瑾润·九仰周庄', '201605', '', '5', '0', '1', '1', '1463387852', '2016-05-16 16:40:31');
INSERT INTO `t_commission_settlement` VALUES ('149', '323232', '3', '601', '1018', '上海', '39052', '金山香港城', '201605', '', '5', '0', '1', '1', '1463399112', '2016-05-16 19:48:18');
INSERT INTO `t_commission_settlement` VALUES ('150', 'zym16051610', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '0', '1', '1', '1463399642', '2016-05-17 15:09:42');
INSERT INTO `t_commission_settlement` VALUES ('151', 'ZYM051612', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '0', '1', '1', '1463401923', '2016-05-17 15:09:42');
INSERT INTO `t_commission_settlement` VALUES ('152', 'zym051702', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '0', '1', '1', '1463469333', '2016-05-17 15:21:35');
INSERT INTO `t_commission_settlement` VALUES ('153', 'zym16051703', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '0', '1', '1', '1463469334', '2016-05-17 16:40:43');
INSERT INTO `t_commission_settlement` VALUES ('154', 'zym051702', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '0', '1', '1', '1463474819', '2016-05-17 16:50:54');
INSERT INTO `t_commission_settlement` VALUES ('155', 'zym051702', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '1', '1', '1', '1463475083', '2016-05-17 16:52:48');
INSERT INTO `t_commission_settlement` VALUES ('156', 'ZYM051612', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '0', '1', '1', '1463477522', '2016-05-17 17:36:18');
INSERT INTO `t_commission_settlement` VALUES ('157', '456456', '3', '601', '1004', '上海', '5', '南山雨果_test', '201605', '', '1', '0', '1', '1', '1463482263', '2016-06-24 15:19:09');
INSERT INTO `t_commission_settlement` VALUES ('158', 'ZYM051612', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '1', '1', '1', '1463483319', '2016-06-13 17:45:55');
INSERT INTO `t_commission_settlement` VALUES ('159', 'hxt797', '3', '601', '1018', '上海', '39052', '金山香港城', '201605', '', '5', '0', '4', '1', '1463485683', '2016-05-17 20:01:02');
INSERT INTO `t_commission_settlement` VALUES ('160', 'hxt797', '3', '601', '1018', '上海', '39052', '金山香港城', '201605', '', '5', '1', '1', '1', '1463486980', '2016-05-17 20:10:09');
INSERT INTO `t_commission_settlement` VALUES ('161', 'zym16051801', '3', '601', '1002', '上海', '45584', '中信广场', '201605', '', '5', '0', '1', '1', '1463549952', '2016-06-20 11:47:13');
INSERT INTO `t_commission_settlement` VALUES ('162', 'zym16051704', '3', '601', '1002', '上海', '45584', '中信广场', '201605', '', '5', '0', '1', '1', '1463552266', '2016-06-20 11:47:13');
INSERT INTO `t_commission_settlement` VALUES ('163', 'zym051709', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '0', '1', '1', '1463561097', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement` VALUES ('164', 'zym16051803', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '2', '0', '1', '1', '1463561968', '2016-05-19 11:16:44');
INSERT INTO `t_commission_settlement` VALUES ('165', 'zym16051804', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '0', '4', '1', '1463566652', '2016-06-13 18:13:58');
INSERT INTO `t_commission_settlement` VALUES ('166', 'zym16051610', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '0', '4', '1', '1463622831', '2016-06-13 18:24:13');
INSERT INTO `t_commission_settlement` VALUES ('167', 'zym16051901', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '0', '1', '1', '1463638378', '2016-05-19 14:34:36');
INSERT INTO `t_commission_settlement` VALUES ('168', 'zym16051902', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '1', '0', '1', '1', '1463640121', '2016-06-17 13:17:55');
INSERT INTO `t_commission_settlement` VALUES ('169', 'zym16051904', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '', '5', '0', '4', '1', '1463642974', '2016-06-13 18:23:49');
INSERT INTO `t_commission_settlement` VALUES ('170', '78944774', '3', '601', '1001', '上海', '14', '绿地百年宅', '201605', '', '5', '0', '1', '1', '1463649352', '2016-05-30 11:08:01');
INSERT INTO `t_commission_settlement` VALUES ('171', '1e298923892', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201605', '', '5', '0', '1', '1', '1463654230', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('172', '12478841', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201605', '', '5', '0', '1', '1', '1463654231', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('173', '44545487', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201605', '', '5', '0', '1', '1', '1463654233', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('174', '11111111111111', '3', '601', '1001', '上海', '348', '黄金年代', '201605', '', '5', '0', '1', '1', '1464256554', '2016-05-26 17:57:19');
INSERT INTO `t_commission_settlement` VALUES ('175', 'A10222', '3', '601', '1001', '上海', '112752', '碧桂园金海湾', '201605', '', '5', '0', '1', '1', '1464576836', '2016-05-30 11:11:17');
INSERT INTO `t_commission_settlement` VALUES ('176', '1872', '3', '601', '1002', '上海', '45584', '中信广场', '201605', '', '5', '0', '1', '1', '1464577273', '2016-06-20 11:47:13');
INSERT INTO `t_commission_settlement` VALUES ('177', 'hxt20160531aa', '3', '601', '1001', '上海', '348', '黄金年代', '201605', '', '5', '0', '1', '1', '1464665794', '2016-05-31 11:49:52');
INSERT INTO `t_commission_settlement` VALUES ('178', 'aaabbb', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201605', '', '5', '0', '1', '1', '1464680811', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('179', 'fdd23423', '3', '601', '1002', '上海', '45584', '中信广场', '201606', '', '5', '0', '1', '1', '1464771764', '2016-06-20 11:47:13');
INSERT INTO `t_commission_settlement` VALUES ('180', 'gg123132', '3', '601', '1001', '上海', '112752', '碧桂园金海湾', '201606', '', '5', '0', '1', '1', '1464772161', '2016-06-01 17:11:08');
INSERT INTO `t_commission_settlement` VALUES ('181', 'A000144', '3', '601', '1001', '上海', '112752', '碧桂园金海湾', '201606', '', '5', '0', '1', '1', '1464835455', '2016-06-02 10:45:23');
INSERT INTO `t_commission_settlement` VALUES ('182', 'dsfasdfdsafasdfsa', '3', '601', '1001', '上海', '348', '黄金年代', '201606', '', '5', '0', '4', '1', '1464949872', '2016-06-07 10:15:15');
INSERT INTO `t_commission_settlement` VALUES ('183', 'gdagffsgsdgfds', '3', '601', '1001', '上海', '348', '黄金年代', '201606', '', '5', '0', '1', '1', '1465443791', '2016-06-09 11:45:23');
INSERT INTO `t_commission_settlement` VALUES ('184', '20160613YJZF', '3', '601', '1001', '上海', '348', '黄金年代', '201606', '', '5', '0', '1', '1', '1465798537', '2016-06-13 14:56:14');
INSERT INTO `t_commission_settlement` VALUES ('185', 'A99323', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201606', '11', '2', '0', '1', '1', '1466140612', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('186', 'zym16051610', '3', '601', '1003', '杭州', '102130', '建发玖珑湾', '201605', '11', '1', '1', '1', '1', '1466140671', '2016-06-20 16:12:24');
INSERT INTO `t_commission_settlement` VALUES ('187', 'A0002223', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201606', '11', '2', '0', '1', '1', '1466146362', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('188', 'A0002223', '3', '601', '1001', '上海', '66766', '申亚书香水岸', '201606', '', '5', '1', '1', '1', '1466146989', '2016-06-20 11:47:24');
INSERT INTO `t_commission_settlement` VALUES ('189', 'dfsafasfasfda', '3', '601', '1001', '上海', '348', '黄金年代', '201606', '', '5', '0', '1', '1', '1466254897', '2016-06-18 21:02:54');
INSERT INTO `t_commission_settlement` VALUES ('190', 'zym16062104', '3', '601', '0', '0', '102130', '建发玖珑湾', '201606', '', '1', '0', '1', '1', '1466502582', '2016-06-21 17:49:42');
INSERT INTO `t_commission_settlement` VALUES ('191', 'zym16062107', '3', '601', '0106', '0', '102130', '建发玖珑湾', '201606', '', '5', '0', '1', '1', '1466561532', '2016-06-22 10:30:09');
INSERT INTO `t_commission_settlement` VALUES ('192', 'rtx789', '3', '601', '0104', '0', '66766', '申亚书香水岸', '201606', '', '5', '0', '1', '1', '1466598563', '2016-06-22 21:01:40');
INSERT INTO `t_commission_settlement` VALUES ('193', 'sb564', '3', '601', '1099', '0', '66766', '申亚书香水岸', '201606', '', '1', '0', '1', '1', '1466601482', '2016-06-22 21:18:02');
INSERT INTO `t_commission_settlement` VALUES ('194', 'ewre123', '3', '601', '0204', '0', '66766', '申亚书香水岸', '201606', '', '3', '0', '1', '1', '1466738349', '2016-06-24 11:34:01');
INSERT INTO `t_commission_settlement` VALUES ('195', 'we8795', '3', '601', '0201', '0', '66766', '申亚书香水岸', '201606', '', '1', '0', '1', '1', '1466751471', '2016-06-24 14:57:51');
INSERT INTO `t_commission_settlement` VALUES ('196', 'zym16062402', '3', '601', '0106', '0', '102130', '建发玖珑湾', '201606', '', '1', '0', '1', '1', '1466754593', '2016-06-24 15:49:53');
INSERT INTO `t_commission_settlement` VALUES ('197', 'A0555', '3', '601', '', '0', '112752', '碧桂园金海湾', '201606', '', '1', '0', '1', '1', '1466754593', '2016-06-24 15:49:53');
INSERT INTO `t_commission_settlement` VALUES ('198', 'iwe879', '3', '601', '0199', '0', '66766', '申亚书香水岸', '201606', '', '1', '0', '1', '1', '1466758494', '2016-06-24 16:54:54');

-- ----------------------------
-- Table structure for t_commission_settlement_info
-- ----------------------------
DROP TABLE IF EXISTS `t_commission_settlement_info`;
CREATE TABLE `t_commission_settlement_info` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT,
  `iRelationID` int(11) NOT NULL DEFAULT '0' COMMENT '关联ID',
  `sBalanceNo` char(50) NOT NULL DEFAULT '' COMMENT '结算单号',
  `sBusinessNo` char(50) NOT NULL DEFAULT '' COMMENT '业务流水号',
  `iTransType` tinyint(2) NOT NULL DEFAULT '0' COMMENT '交易类型 1=佣金预提；2=佣金支付',
  `sOrderNo` char(50) NOT NULL COMMENT '订单号',
  `iOrderAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单收入',
  `iOrderOut` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单支出',
  `iCommissionBase` bigint(20) NOT NULL DEFAULT '0' COMMENT '计佣基数',
  `iLouPanIncome` bigint(20) NOT NULL DEFAULT '0' COMMENT '项目收入',
  `iCommissionRatio` int(11) NOT NULL DEFAULT '0' COMMENT '分佣率',
  `iCommissionAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '佣金',
  `iTaxAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '个税金额',
  `iFinalAmount` bigint(20) NOT NULL DEFAULT '0' COMMENT '应收佣金金额 即扣税最终金额',
  `iCommissionMonth` int(11) NOT NULL COMMENT '佣金月份',
  `iCommissionType` int(11) NOT NULL DEFAULT '0' COMMENT '佣金类型 新房推荐奖金 1001， 新房管理津贴 1002等 请参考文件',
  `sAccountName` char(50) NOT NULL COMMENT '账户名称',
  `sBankAccount` char(50) NOT NULL COMMENT '银行账号',
  `iBankID` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '银行id',
  `sBankName` char(50) NOT NULL COMMENT '银行名称',
  `idType` char(5) NOT NULL COMMENT '证件类型(I：身份证 P：护照 M：军官证 S：港澳通行证或台胞证 H：户口本O：其它)',
  `idNo` char(50) NOT NULL COMMENT '证件号',
  `iDoStatus` tinyint(3) NOT NULL DEFAULT '0' COMMENT '处理状态 0 未审核，1 审核中，2 审核完毕, 3 驳回',
  `iPayStatus` tinyint(1) DEFAULT '1' COMMENT '支付状态(1:支付创建，2：支付中，3：支付成功，4：支付失败)',
  `iComparedStatus` tinyint(3) NOT NULL DEFAULT '0' COMMENT '对账状态，0 未对账， 1:成功，2:补单成功，3:交易金额异常，4:交易状态异常，5:掉单',
  `iFailureDesc` varchar(100) NOT NULL DEFAULT '' COMMENT '失败原因',
  `iCallBackStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '通知状态（2 通知成功）',
  `bResend` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否重发 0 否， 1是',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0无效，1有效',
  `iCreateTime` int(11) NOT NULL COMMENT '创建时间',
  `iUpdateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COMMENT='佣金支付详情表';

-- ----------------------------
-- Records of t_commission_settlement_info
-- ----------------------------
INSERT INTO `t_commission_settlement_info` VALUES ('747', '148', 'hxt001', '1339', '1', '1692', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201605', '1001', '徐雯雯寿险3', 'b0M1XJ8nlWz32ZsLtqJ6JRKKf0kou2xiKtDZ/STw9B0=', '3', '中国建设银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463387852', '2016-05-16 16:40:31');
INSERT INTO `t_commission_settlement_info` VALUES ('748', '148', 'hxt001', '1340', '1', '1692', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1463387853', '2016-05-16 16:40:31');
INSERT INTO `t_commission_settlement_info` VALUES ('749', '148', 'hxt001', '1341', '1', '1692', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463387853', '2016-05-16 16:40:31');
INSERT INTO `t_commission_settlement_info` VALUES ('750', '148', 'hxt001', '1339', '2', '1692', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201605', '1001', '徐雯雯寿险3', 'b0M1XJ8nlWz32ZsLtqJ6JRKKf0kou2xiKtDZ/STw9B0=', '3', '中国建设银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1463387879', '2016-05-16 16:54:08');
INSERT INTO `t_commission_settlement_info` VALUES ('751', '148', 'hxt001', '1340', '2', '1692', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '1', '', '2', '0', '1', '1463387879', '2016-05-16 16:54:09');
INSERT INTO `t_commission_settlement_info` VALUES ('752', '148', 'hxt001', '1341', '2', '1692', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1463387880', '2016-05-16 16:54:10');
INSERT INTO `t_commission_settlement_info` VALUES ('753', '149', '323232', '1357', '1', '1700', '32323200', '0', '0', '32323200', '50', '16161600', '3232320', '12929280', '201605', '1001', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaZYRcXbrFHILexCVZkyJIow=', '2', '中国农业银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463399112', '2016-05-16 19:48:19');
INSERT INTO `t_commission_settlement_info` VALUES ('754', '149', '323232', '1358', '1', '1700', '32323200', '0', '0', '32323200', '4', '1292928', '258586', '1034342', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1463399113', '2016-05-16 19:48:19');
INSERT INTO `t_commission_settlement_info` VALUES ('755', '149', '323232', '1359', '1', '1700', '32323200', '0', '0', '32323200', '6', '1939392', '387878', '1551514', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463399113', '2016-05-16 19:48:19');
INSERT INTO `t_commission_settlement_info` VALUES ('756', '149', '323232', '1357', '2', '1700', '32323200', '0', '0', '32323200', '50', '16161600', '3232320', '12929280', '201605', '1001', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaZYRcXbrFHILexCVZkyJIow=', '2', '中国农业银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1463399229', '2016-05-16 19:54:15');
INSERT INTO `t_commission_settlement_info` VALUES ('757', '149', '323232', '1358', '2', '1700', '32323200', '0', '0', '32323200', '4', '1292928', '258586', '1034342', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '1', '', '2', '0', '1', '1463399230', '2016-05-16 19:54:16');
INSERT INTO `t_commission_settlement_info` VALUES ('758', '149', '323232', '1359', '2', '1700', '32323200', '0', '0', '32323200', '6', '1939392', '387878', '1551514', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1463399230', '2016-05-16 19:54:17');
INSERT INTO `t_commission_settlement_info` VALUES ('759', '150', 'zym16051610', '1334', '1', '1693', '1605161000', '0', '0', '1605161000', '4', '64206440', '12841288', '51365152', '201605', '1002', '赵永敏', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '3', '1', '0', '', '0', '0', '1', '1463399642', '2016-05-16 20:34:09');
INSERT INTO `t_commission_settlement_info` VALUES ('760', '150', 'zym16051610', '1334', '2', '1693', '1605161000', '0', '0', '1605161000', '4', '64206440', '12841288', '51365152', '201605', '1002', '赵永敏', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '3', '1', '0', '', '2', '0', '1', '1463400247', '2016-05-16 20:34:13');
INSERT INTO `t_commission_settlement_info` VALUES ('761', '151', 'ZYM051612', '1364', '1', '1701', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', 'AAAAAA', '3', '1', '0', '', '0', '0', '1', '1463401923', '2016-05-16 20:34:09');
INSERT INTO `t_commission_settlement_info` VALUES ('762', '151', 'ZYM051612', '1364', '2', '1701', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', 'AAAAAA', '3', '1', '0', '', '2', '0', '1', '1463402013', '2016-05-16 20:34:14');
INSERT INTO `t_commission_settlement_info` VALUES ('763', '152', 'zym051702', '1371', '1', '1704', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '徐雯雯', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '0', '0', '1', '1463469333', '2016-05-17 15:21:35');
INSERT INTO `t_commission_settlement_info` VALUES ('764', '153', 'zym16051703', '1375', '1', '1706', '1605170300', '0', '0', '1605170300', '50', '802585150', '160517030', '642068120', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'I', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1463469334', '2016-05-17 16:40:44');
INSERT INTO `t_commission_settlement_info` VALUES ('765', '153', 'zym16051703', '1376', '1', '1706', '1605170300', '0', '0', '1605170300', '4', '64206812', '12841362', '51365450', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463469334', '2016-05-17 16:40:44');
INSERT INTO `t_commission_settlement_info` VALUES ('766', '153', 'zym16051703', '1377', '1', '1706', '1605170300', '0', '0', '1605170300', '6', '96310218', '19262044', '77048174', '201605', '1003', '徐雯雯', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463469335', '2016-05-17 16:40:44');
INSERT INTO `t_commission_settlement_info` VALUES ('767', '152', 'zym051702', '1371', '2', '1704', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '徐雯雯', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '2', '0', '1', '1463469377', '2016-05-17 15:21:38');
INSERT INTO `t_commission_settlement_info` VALUES ('768', '153', 'zym16051703', '1375', '2', '1706', '1605170300', '0', '0', '1605170300', '50', '802585150', '160517030', '642068120', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'I', '120224198209216618', '2', '3', '1', '', '2', '0', '1', '1463469378', '2016-05-17 20:04:40');
INSERT INTO `t_commission_settlement_info` VALUES ('769', '153', 'zym16051703', '1376', '2', '1706', '1605170300', '0', '0', '1605170300', '4', '64206812', '12841362', '51365450', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '2', '3', '1', '', '2', '0', '1', '1463469378', '2016-05-17 20:04:41');
INSERT INTO `t_commission_settlement_info` VALUES ('770', '153', 'zym16051703', '1377', '2', '1706', '1605170300', '0', '0', '1605170300', '6', '96310218', '19262044', '77048174', '201605', '1003', '徐雯雯', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1463469379', '2016-05-17 20:04:43');
INSERT INTO `t_commission_settlement_info` VALUES ('771', '152', 'zym051702', '1369', '1', '1704', '2147483647', '0', '0', '2147483647', '50', '2147483647', '1000000000', '2147483647', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'I', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1463474785', '2016-05-17 16:46:25');
INSERT INTO `t_commission_settlement_info` VALUES ('772', '152', 'zym051702', '1370', '1', '1704', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1463474786', '2016-05-17 16:46:26');
INSERT INTO `t_commission_settlement_info` VALUES ('773', '154', 'zym051702', '1370', '2', '1704', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '3', '1', '0', '', '2', '0', '1', '1463474819', '2016-05-17 16:50:58');
INSERT INTO `t_commission_settlement_info` VALUES ('774', '155', 'zym051702', '1371', '2', '1704', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '赵永敏', 'XeemqoFaok0dPXN1pJgo0Bs+H+3UJXPpECQvrIYYvWg=', '1', '中国工商银行', 'I', '410923199002125423', '3', '1', '0', '', '2', '1', '1', '1463475083', '2016-05-17 16:52:50');
INSERT INTO `t_commission_settlement_info` VALUES ('775', '151', 'ZYM051612', '1365', '1', '1701', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '赵永敏', 'SE07JrhP9m0RgyuiKlBjHg==', '1', '中国工商银行', 'I', '410923199002125423', '0', '1', '0', '', '0', '0', '1', '1463477463', '2016-05-17 17:31:03');
INSERT INTO `t_commission_settlement_info` VALUES ('776', '156', 'ZYM051612', '1365', '2', '1701', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '赵永敏', 'SE07JrhP9m0RgyuiKlBjHg==', '1', '中国工商银行', 'I', '410923199002125423', '3', '1', '0', '', '2', '0', '1', '1463477522', '2016-05-17 17:36:20');
INSERT INTO `t_commission_settlement_info` VALUES ('777', '151', 'ZYM051612', '1363', '1', '1701', '2147483647', '0', '0', '2147483647', '50', '2147483647', '1000000000', '2147483647', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'I', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1463478173', '2016-05-17 17:42:53');
INSERT INTO `t_commission_settlement_info` VALUES ('778', '157', '456456', '1395', '1', '1702', '45645600', '0', '0', '45645600', '6', '2738736', '547747', '2190989', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463482263', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('779', '158', 'ZYM051612', '1364', '2', '1701', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '2', '2', '0', '', '2', '1', '1', '1463483319', '2016-06-13 18:03:06');
INSERT INTO `t_commission_settlement_info` VALUES ('780', '158', 'ZYM051612', '1365', '2', '1701', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '赵永敏', 'yGqAv/a6rKQCAqgHP+1feA==', '1', '中国工商银行', 'I', '410923199002125423', '2', '2', '0', '', '2', '1', '1', '1463483319', '2016-06-13 18:03:06');
INSERT INTO `t_commission_settlement_info` VALUES ('781', '159', 'hxt797', '1399', '1', '1722', '1000000056', '0', '0', '1000000056', '50', '500000028', '100000006', '400000022', '201605', '1001', '徐雯雯寿险3', 'b0M1XJ8nlWz32ZsLtqJ6JRKKf0kou2xiKtDZ/STw9B0=', '3', '中国建设银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463485683', '2016-05-17 19:57:28');
INSERT INTO `t_commission_settlement_info` VALUES ('782', '159', 'hxt797', '1400', '1', '1722', '1000000056', '0', '0', '1000000056', '4', '40000002', '8000000', '32000002', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1463485684', '2016-05-17 19:57:28');
INSERT INTO `t_commission_settlement_info` VALUES ('783', '159', 'hxt797', '1401', '1', '1722', '1000000056', '0', '0', '1000000056', '6', '60000003', '12000001', '48000002', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463485685', '2016-05-17 19:57:28');
INSERT INTO `t_commission_settlement_info` VALUES ('784', '159', 'hxt797', '1399', '2', '1722', '1000000056', '0', '0', '1000000056', '50', '500000028', '100000006', '400000022', '201605', '1001', '徐雯雯寿险3', 'b0M1XJ8nlWz32ZsLtqJ6JRKKf0kou2xiKtDZ/STw9B0=', '3', '中国建设银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1463485722', '2016-05-17 20:04:37');
INSERT INTO `t_commission_settlement_info` VALUES ('785', '159', 'hxt797', '1400', '2', '1722', '1000000056', '0', '0', '1000000056', '4', '40000002', '8000000', '32000002', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '1', '', '2', '0', '1', '1463485723', '2016-05-17 20:04:39');
INSERT INTO `t_commission_settlement_info` VALUES ('786', '159', 'hxt797', '1401', '2', '1722', '1000000056', '0', '0', '1000000056', '6', '60000003', '12000001', '48000002', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '4', '0', ':内部转帐交易失败', '2', '0', '1', '1463485724', '2016-05-17 20:25:11');
INSERT INTO `t_commission_settlement_info` VALUES ('787', '160', 'hxt797', '1401', '2', '1722', '1000000056', '0', '0', '1000000056', '6', '60000003', '12000001', '48000002', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '1', '1', '1463486980', '2016-05-17 20:12:40');
INSERT INTO `t_commission_settlement_info` VALUES ('788', '161', 'zym16051801', '1413', '1', '1724', '1605180100', '0', '0', '1605180100', '6', '96310800', '19262160', '77048640', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463549952', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('789', '161', 'zym16051801', '1413', '2', '1724', '1605180100', '0', '0', '1605180100', '6', '96310800', '19262160', '77048640', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463550056', '2016-06-13 20:09:44');
INSERT INTO `t_commission_settlement_info` VALUES ('790', '161', 'zym16051801', '1411', '1', '1724', '1605180100', '0', '0', '1605180100', '50', '802590100', '160518020', '642072080', '201605', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1463551008', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('791', '161', 'zym16051801', '1412', '1', '1724', '1605180100', '0', '0', '1605180100', '4', '64207200', '12841440', '51365760', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463551008', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('792', '161', 'zym16051801', '1411', '2', '1724', '1605180100', '0', '0', '1605180100', '50', '802590100', '160518020', '642072080', '201605', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '2', '0', '', '2', '0', '1', '1463551298', '2016-06-13 18:03:06');
INSERT INTO `t_commission_settlement_info` VALUES ('793', '161', 'zym16051801', '1412', '2', '1724', '1605180100', '0', '0', '1605180100', '4', '64207200', '12841440', '51365760', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463551299', '2016-06-13 20:09:11');
INSERT INTO `t_commission_settlement_info` VALUES ('794', '162', 'zym16051704', '1389', '1', '1707', '1605170400', '0', '0', '1605170400', '6', '96310224', '19262045', '77048179', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463552266', '2016-05-18 14:27:10');
INSERT INTO `t_commission_settlement_info` VALUES ('795', '162', 'zym16051704', '1389', '2', '1707', '1605170400', '0', '0', '1605170400', '6', '96310224', '19262045', '77048179', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463552389', '2016-05-18 15:28:04');
INSERT INTO `t_commission_settlement_info` VALUES ('796', '162', 'zym16051704', '1387', '1', '1707', '1605170400', '0', '0', '1605170400', '50', '802585200', '160517040', '642068160', '201605', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1463552489', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('797', '162', 'zym16051704', '1388', '1', '1707', '1605170400', '0', '0', '1605170400', '4', '64206816', '12841363', '51365453', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463552490', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('798', '162', 'zym16051704', '1387', '2', '1707', '1605170400', '0', '0', '1605170400', '50', '802585200', '160517040', '642068160', '201605', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '2', '0', '', '2', '0', '1', '1463552866', '2016-06-13 18:03:05');
INSERT INTO `t_commission_settlement_info` VALUES ('799', '162', 'zym16051704', '1388', '2', '1707', '1605170400', '0', '0', '1605170400', '4', '64206816', '12841363', '51365453', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463552866', '2016-06-13 20:09:12');
INSERT INTO `t_commission_settlement_info` VALUES ('800', '157', '456456', '1395', '2', '1702', '45645600', '0', '0', '45645600', '6', '2738736', '547747', '2190989', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463556686', '2016-06-13 20:09:11');
INSERT INTO `t_commission_settlement_info` VALUES ('801', '163', 'zym051709', '1381', '1', '1712', '2147483647', '0', '0', '2147483647', '50', '2147483647', '1000000000', '2147483647', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'I', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1463561097', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('802', '163', 'zym051709', '1382', '1', '1712', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463561098', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('803', '163', 'zym051709', '1383', '1', '1712', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '徐雯雯', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463561098', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('804', '150', 'zym16051610', '1333', '1', '1693', '1605161000', '0', '0', '1605161000', '50', '802580500', '160516100', '642064400', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1463561099', '2016-05-18 16:44:59');
INSERT INTO `t_commission_settlement_info` VALUES ('805', '150', 'zym16051610', '1335', '1', '1693', '1605161000', '0', '0', '1605161000', '6', '96309660', '19261932', '77047728', '201605', '1003', '赵永敏', 'mJbSl6fp9HbJjNgIBttUorfDwZ8avl7VRgYY6tRXs5o=', '1', '中国工商银行', 'M', '', '0', '1', '0', '', '0', '0', '1', '1463561099', '2016-05-18 16:44:59');
INSERT INTO `t_commission_settlement_info` VALUES ('806', '164', 'zym16051803', '1417', '1', '1732', '1605180300', '0', '0', '1605180300', '50', '802590200', '160518040', '642072160', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '3', '1', '0', '', '0', '0', '1', '1463561968', '2016-05-19 11:16:44');
INSERT INTO `t_commission_settlement_info` VALUES ('807', '164', 'zym16051803', '1418', '1', '1732', '1605180300', '0', '0', '1605180300', '4', '64207200', '12841440', '51365760', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '3', '1', '0', '', '0', '0', '1', '1463561969', '2016-05-19 11:16:44');
INSERT INTO `t_commission_settlement_info` VALUES ('808', '165', 'zym16051804', '1423', '1', '1733', '1605180400', '0', '0', '1605180400', '50', '802590200', '160518040', '642072160', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1463566652', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('809', '165', 'zym16051804', '1424', '1', '1733', '1605180400', '0', '0', '1605180400', '4', '64207200', '12841440', '51365760', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463566653', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('810', '165', 'zym16051804', '1425', '1', '1733', '1605180400', '0', '0', '1605180400', '6', '96310800', '19262160', '77048640', '201605', '1003', '赵永敏', 'vjEB/HSELqrQ1bnW3FtkUg==', '1', '中国工商银行', 'M', '123456789', '2', '1', '0', '', '0', '0', '1', '1463566653', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('811', '166', 'zym16051610', '1333', '2', '1693', '1605161000', '0', '0', '1605161000', '50', '802580500', '160516100', '642064400', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '4', '0', ':转账失败-YQ9982收款方户名输入错误验证收款方户名失败!', '2', '0', '1', '1463622831', '2016-06-13 18:24:13');
INSERT INTO `t_commission_settlement_info` VALUES ('812', '166', 'zym16051610', '1335', '2', '1693', '1605161000', '0', '0', '1605161000', '6', '96309660', '19261932', '77047728', '201605', '1003', '赵永敏', 'mJbSl6fp9HbJjNgIBttUorfDwZ8avl7VRgYY6tRXs5o=', '1', '中国工商银行', 'M', '', '2', '3', '0', '', '2', '0', '1', '1463622832', '2016-06-13 20:09:13');
INSERT INTO `t_commission_settlement_info` VALUES ('813', '164', 'zym16051803', '1417', '2', '1732', '1605180300', '0', '0', '1605180300', '50', '802590200', '160518040', '642072160', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '3', '1', '0', '', '2', '0', '1', '1463622832', '2016-05-19 11:20:06');
INSERT INTO `t_commission_settlement_info` VALUES ('814', '164', 'zym16051803', '1418', '2', '1732', '1605180300', '0', '0', '1605180300', '4', '64207200', '12841440', '51365760', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '3', '1', '0', '', '2', '0', '1', '1463622832', '2016-05-19 11:20:07');
INSERT INTO `t_commission_settlement_info` VALUES ('815', '165', 'zym16051804', '1423', '2', '1733', '1605180400', '0', '0', '1605180400', '50', '802590200', '160518040', '642072160', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '4', '0', ':转账失败-YQ9982收款方户名输入错误验证收款方户名失败!', '2', '0', '1', '1463622833', '2016-06-13 18:13:58');
INSERT INTO `t_commission_settlement_info` VALUES ('816', '165', 'zym16051804', '1424', '2', '1733', '1605180400', '0', '0', '1605180400', '4', '64207200', '12841440', '51365760', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1463622833', '2016-06-13 20:09:07');
INSERT INTO `t_commission_settlement_info` VALUES ('817', '165', 'zym16051804', '1425', '2', '1733', '1605180400', '0', '0', '1605180400', '6', '96310800', '19262160', '77048640', '201605', '1003', '赵永敏', 'vjEB/HSELqrQ1bnW3FtkUg==', '1', '中国工商银行', 'M', '123456789', '2', '3', '0', '', '2', '0', '1', '1463622834', '2016-06-13 20:09:05');
INSERT INTO `t_commission_settlement_info` VALUES ('818', '163', 'zym051709', '1382', '2', '1712', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'I', '120104196306042154', '2', '2', '0', '', '2', '0', '1', '1463622848', '2016-06-13 18:03:03');
INSERT INTO `t_commission_settlement_info` VALUES ('819', '163', 'zym051709', '1383', '2', '1712', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '徐雯雯', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '2', '0', '', '2', '0', '1', '1463622849', '2016-06-13 18:03:03');
INSERT INTO `t_commission_settlement_info` VALUES ('820', '167', 'zym16051901', '1449', '1', '1738', '1605190100', '0', '0', '1605190100', '6', '96311400', '19262280', '77049120', '201605', '1003', '赵永敏', '+FaOinhMsbzSFw4waUz+Xw==', '1', '中国工商银行', 'M', '987654321', '2', '1', '0', '', '0', '0', '1', '1463638378', '2016-05-19 14:32:18');
INSERT INTO `t_commission_settlement_info` VALUES ('821', '167', 'zym16051901', '1449', '2', '1738', '1605190100', '0', '0', '1605190100', '6', '96311400', '19262280', '77049120', '201605', '1003', '赵永敏', '+FaOinhMsbzSFw4waUz+Xw==', '1', '中国工商银行', 'M', '987654321', '2', '3', '0', '', '2', '0', '1', '1463638454', '2016-05-19 14:38:14');
INSERT INTO `t_commission_settlement_info` VALUES ('822', '167', 'zym16051901', '1448', '1', '1738', '1605190100', '0', '0', '1605190100', '4', '64207600', '12841520', '51366080', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463639073', '2016-05-19 14:32:18');
INSERT INTO `t_commission_settlement_info` VALUES ('823', '167', 'zym16051901', '1448', '2', '1738', '1605190100', '0', '0', '1605190100', '4', '64207600', '12841520', '51366080', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1463639168', '2016-05-19 14:38:16');
INSERT INTO `t_commission_settlement_info` VALUES ('824', '167', 'zym16051901', '1447', '1', '1738', '1605190100', '0', '0', '1605190100', '50', '802595100', '160519020', '642076080', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1463639360', '2016-05-19 14:34:36');
INSERT INTO `t_commission_settlement_info` VALUES ('825', '167', 'zym16051901', '1447', '2', '1738', '1605190100', '0', '0', '1605190100', '50', '802595100', '160519020', '642076080', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '3', '0', '', '2', '0', '1', '1463639566', '2016-05-19 14:38:06');
INSERT INTO `t_commission_settlement_info` VALUES ('826', '168', 'zym16051902', '1442', '1', '1739', '1605190200', '0', '0', '1605190200', '4', '64207600', '12841520', '51366080', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463640121', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('827', '168', 'zym16051902', '1442', '2', '1739', '1605190200', '0', '0', '1605190200', '4', '64207600', '12841520', '51366080', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1463640202', '2016-06-13 20:09:06');
INSERT INTO `t_commission_settlement_info` VALUES ('828', '168', 'zym16051902', '1441', '1', '1739', '1605190200', '0', '0', '1605190200', '50', '802595100', '160519020', '642076080', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1463640258', '2016-05-19 14:44:18');
INSERT INTO `t_commission_settlement_info` VALUES ('829', '169', 'zym16051904', '1459', '1', '1745', '1605190400', '0', '0', '1605190400', '50', '802595200', '160519040', '642076160', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1463642974', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('830', '169', 'zym16051904', '1460', '1', '1745', '1605190400', '0', '0', '1605190400', '4', '64207616', '12841523', '51366093', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463642974', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('831', '169', 'zym16051904', '1461', '1', '1745', '1605190400', '0', '0', '1605190400', '6', '96311424', '19262285', '77049139', '201605', '1003', '赵永敏', 'nWSztUrgkerUbhjPRyPNQswRs9uJXu77+sMfNr+njNg=', '1', '中国工商银行', 'M', '123456789', '2', '1', '0', '', '0', '0', '1', '1463642974', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('832', '169', 'zym16051904', '1459', '2', '1745', '1605190400', '0', '0', '1605190400', '50', '802595200', '160519040', '642076160', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '4', '0', ':转账失败-YQ9982收款方户名输入错误验证收款方户名失败!', '2', '0', '1', '1463643017', '2016-06-13 18:23:49');
INSERT INTO `t_commission_settlement_info` VALUES ('833', '169', 'zym16051904', '1460', '2', '1745', '1605190400', '0', '0', '1605190400', '4', '64207616', '12841523', '51366093', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1463643018', '2016-06-13 20:08:47');
INSERT INTO `t_commission_settlement_info` VALUES ('834', '169', 'zym16051904', '1461', '2', '1745', '1605190400', '0', '0', '1605190400', '6', '96311424', '19262285', '77049139', '201605', '1003', '赵永敏', 'nWSztUrgkerUbhjPRyPNQswRs9uJXu77+sMfNr+njNg=', '1', '中国工商银行', 'M', '123456789', '2', '3', '0', '', '2', '0', '1', '1463643018', '2016-06-13 20:08:46');
INSERT INTO `t_commission_settlement_info` VALUES ('835', '170', '78944774', '1435', '1', '1725', '2147483647', '0', '0', '2147483647', '50', '2147483647', '1000000000', '2147483647', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1463649352', '2016-05-19 17:31:58');
INSERT INTO `t_commission_settlement_info` VALUES ('836', '170', '78944774', '1436', '1', '1725', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463649352', '2016-05-19 17:31:58');
INSERT INTO `t_commission_settlement_info` VALUES ('837', '170', '78944774', '1437', '1', '1725', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1463649353', '2016-05-19 17:31:58');
INSERT INTO `t_commission_settlement_info` VALUES ('838', '170', '78944774', '1436', '2', '1725', '2147483647', '0', '0', '2147483647', '4', '400000000', '80000000', '320000000', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '2', '0', '', '2', '0', '1', '1463650252', '2016-05-19 17:32:03');
INSERT INTO `t_commission_settlement_info` VALUES ('839', '170', '78944774', '1437', '2', '1725', '2147483647', '0', '0', '2147483647', '6', '600000000', '120000000', '480000000', '201605', '1003', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '2', '2', '0', '', '2', '0', '1', '1463650253', '2016-05-19 17:32:02');
INSERT INTO `t_commission_settlement_info` VALUES ('840', '171', '1e298923892', '1471', '1', '1754', '1230000', '0', '0', '1230000', '50', '615000', '123000', '492000', '201605', '1001', '徐雯雯普通变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654230', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('841', '171', '1e298923892', '1472', '1', '1754', '1230000', '0', '0', '1230000', '4', '49200', '9840', '39360', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654230', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('842', '171', '1e298923892', '1473', '1', '1754', '1230000', '0', '0', '1230000', '6', '73800', '14760', '59040', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654231', '2016-06-13 17:45:56');
INSERT INTO `t_commission_settlement_info` VALUES ('843', '172', '12478841', '1483', '1', '1755', '1222000', '0', '0', '1222000', '50', '611000', '122200', '488800', '201605', '1001', '徐雯雯普通变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654231', '2016-06-13 17:46:01');
INSERT INTO `t_commission_settlement_info` VALUES ('844', '172', '12478841', '1484', '1', '1755', '1222000', '0', '0', '1222000', '4', '48880', '9776', '39104', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654232', '2016-06-13 17:46:01');
INSERT INTO `t_commission_settlement_info` VALUES ('845', '172', '12478841', '1485', '1', '1755', '1222000', '0', '0', '1222000', '6', '73320', '14664', '58656', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654232', '2016-06-13 17:46:01');
INSERT INTO `t_commission_settlement_info` VALUES ('846', '173', '44545487', '1489', '1', '1757', '589454500', '0', '0', '589454500', '50', '294727250', '58945450', '235781800', '201605', '1001', '徐雯雯普通变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654233', '2016-06-13 17:46:01');
INSERT INTO `t_commission_settlement_info` VALUES ('847', '173', '44545487', '1490', '1', '1757', '589454500', '0', '0', '589454500', '4', '23578180', '4715636', '18862544', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654233', '2016-06-13 17:46:01');
INSERT INTO `t_commission_settlement_info` VALUES ('848', '173', '44545487', '1491', '1', '1757', '589454500', '0', '0', '589454500', '6', '35367270', '7073454', '28293816', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1463654234', '2016-06-13 17:46:01');
INSERT INTO `t_commission_settlement_info` VALUES ('849', '171', '1e298923892', '1471', '2', '1754', '1230000', '0', '0', '1230000', '50', '615000', '123000', '492000', '201605', '1001', '徐雯雯普通变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654483', '2016-06-13 20:08:48');
INSERT INTO `t_commission_settlement_info` VALUES ('850', '171', '1e298923892', '1472', '2', '1754', '1230000', '0', '0', '1230000', '4', '49200', '9840', '39360', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654483', '2016-06-13 20:08:45');
INSERT INTO `t_commission_settlement_info` VALUES ('851', '171', '1e298923892', '1473', '2', '1754', '1230000', '0', '0', '1230000', '6', '73800', '14760', '59040', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654484', '2016-06-13 20:08:22');
INSERT INTO `t_commission_settlement_info` VALUES ('852', '172', '12478841', '1483', '2', '1755', '1222000', '0', '0', '1222000', '50', '611000', '122200', '488800', '201605', '1001', '徐雯雯普通变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654484', '2016-06-13 20:08:24');
INSERT INTO `t_commission_settlement_info` VALUES ('853', '172', '12478841', '1484', '2', '1755', '1222000', '0', '0', '1222000', '4', '48880', '9776', '39104', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654485', '2016-06-13 20:08:23');
INSERT INTO `t_commission_settlement_info` VALUES ('854', '172', '12478841', '1485', '2', '1755', '1222000', '0', '0', '1222000', '6', '73320', '14664', '58656', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654485', '2016-06-13 20:08:26');
INSERT INTO `t_commission_settlement_info` VALUES ('855', '173', '44545487', '1489', '2', '1757', '589454500', '0', '0', '589454500', '50', '294727250', '58945450', '235781800', '201605', '1001', '徐雯雯普通变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '2', '0', '', '2', '0', '1', '1463654486', '2016-06-13 18:03:02');
INSERT INTO `t_commission_settlement_info` VALUES ('856', '173', '44545487', '1490', '2', '1757', '589454500', '0', '0', '589454500', '4', '23578180', '4715636', '18862544', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654486', '2016-06-13 20:08:24');
INSERT INTO `t_commission_settlement_info` VALUES ('857', '173', '44545487', '1491', '2', '1757', '589454500', '0', '0', '589454500', '6', '35367270', '7073454', '28293816', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1463654487', '2016-06-13 20:08:25');
INSERT INTO `t_commission_settlement_info` VALUES ('858', '174', '11111111111111', '1519', '1', '1830', '10000', '0', '0', '10000', '50', '5000', '1000', '4000', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1464256554', '2016-05-26 17:57:19');
INSERT INTO `t_commission_settlement_info` VALUES ('859', '174', '11111111111111', '1520', '1', '1830', '10000', '0', '0', '10000', '4', '400', '80', '320', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1464256555', '2016-05-26 17:57:19');
INSERT INTO `t_commission_settlement_info` VALUES ('860', '174', '11111111111111', '1521', '1', '1830', '10000', '0', '0', '10000', '6', '600', '120', '480', '201605', '1003', '丁一', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1464256555', '2016-05-26 17:57:19');
INSERT INTO `t_commission_settlement_info` VALUES ('861', '174', '11111111111111', '1519', '2', '1830', '10000', '0', '0', '10000', '50', '5000', '1000', '4000', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '3', '0', '', '2', '0', '1', '1464256584', '2016-05-26 18:01:17');
INSERT INTO `t_commission_settlement_info` VALUES ('862', '174', '11111111111111', '1520', '2', '1830', '10000', '0', '0', '10000', '4', '400', '80', '320', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1464256585', '2016-05-26 18:18:13');
INSERT INTO `t_commission_settlement_info` VALUES ('863', '174', '11111111111111', '1521', '2', '1830', '10000', '0', '0', '10000', '6', '600', '120', '480', '201605', '1003', '丁一', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1464256585', '2016-05-26 18:18:12');
INSERT INTO `t_commission_settlement_info` VALUES ('864', '175', 'A10222', '1531', '1', '1873', '10000000', '0', '0', '10000000', '50', '5000000', '1000000', '4000000', '201605', '1001', '寿险徐雯雯2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102702', '2', '1', '0', '', '0', '0', '1', '1464576836', '2016-05-30 10:56:23');
INSERT INTO `t_commission_settlement_info` VALUES ('865', '175', 'A10222', '1532', '1', '1873', '10000000', '0', '0', '10000000', '4', '400000', '80000', '320000', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464576837', '2016-05-30 10:56:23');
INSERT INTO `t_commission_settlement_info` VALUES ('866', '175', 'A10222', '1533', '1', '1873', '10000000', '0', '0', '10000000', '6', '600000', '120000', '480000', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464576837', '2016-05-30 10:56:23');
INSERT INTO `t_commission_settlement_info` VALUES ('867', '175', 'A10222', '1531', '2', '1873', '10000000', '0', '0', '10000000', '50', '5000000', '1000000', '4000000', '201605', '1001', '寿险徐雯雯2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102702', '2', '3', '0', '', '2', '0', '1', '1464576921', '2016-05-30 11:04:35');
INSERT INTO `t_commission_settlement_info` VALUES ('868', '175', 'A10222', '1532', '2', '1873', '10000000', '0', '0', '10000000', '4', '400000', '80000', '320000', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464576921', '2016-05-30 11:04:31');
INSERT INTO `t_commission_settlement_info` VALUES ('869', '175', 'A10222', '1533', '2', '1873', '10000000', '0', '0', '10000000', '6', '600000', '120000', '480000', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464576922', '2016-05-30 11:02:47');
INSERT INTO `t_commission_settlement_info` VALUES ('870', '176', '1872', '1525', '1', '1872', '2147483647', '0', '0', '2147483647', '50', '2500000000', '500000000', '2000000000', '201605', '1001', '寿险徐雯雯2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102702', '2', '1', '0', '', '0', '0', '1', '1464577273', '2016-05-30 11:35:36');
INSERT INTO `t_commission_settlement_info` VALUES ('871', '176', '1872', '1526', '1', '1872', '2147483647', '0', '0', '2147483647', '4', '200000000', '40000000', '160000000', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464577273', '2016-05-30 11:22:48');
INSERT INTO `t_commission_settlement_info` VALUES ('872', '176', '1872', '1527', '1', '1872', '2147483647', '0', '0', '2147483647', '6', '300000000', '60000000', '240000000', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464577273', '2016-05-30 11:22:48');
INSERT INTO `t_commission_settlement_info` VALUES ('873', '176', '1872', '1526', '2', '1872', '2147483647', '0', '0', '2147483647', '4', '200000000', '40000000', '160000000', '201605', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464577290', '2016-05-30 11:47:59');
INSERT INTO `t_commission_settlement_info` VALUES ('874', '176', '1872', '1527', '2', '1872', '2147483647', '0', '0', '2147483647', '6', '300000000', '60000000', '240000000', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464577290', '2016-05-30 11:48:00');
INSERT INTO `t_commission_settlement_info` VALUES ('875', '176', '1872', '1525', '2', '1872', '5000000000', '0', '0', '5000000000', '50', '2500000000', '500000000', '2000000000', '201605', '1001', '寿险徐雯雯2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102702', '2', '3', '0', '', '2', '0', '1', '1464579370', '2016-05-30 11:47:07');
INSERT INTO `t_commission_settlement_info` VALUES ('876', '177', 'hxt20160531aa', '1537', '1', '1878', '5000000', '0', '0', '5000000', '50', '2500000', '500000', '2000000', '201605', '1001', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464665794', '2016-05-31 11:49:52');
INSERT INTO `t_commission_settlement_info` VALUES ('877', '177', 'hxt20160531aa', '1538', '1', '1878', '5000000', '0', '0', '5000000', '4', '200000', '40000', '160000', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1464665795', '2016-05-31 11:49:52');
INSERT INTO `t_commission_settlement_info` VALUES ('878', '177', 'hxt20160531aa', '1539', '1', '1878', '5000000', '0', '0', '5000000', '6', '300000', '60000', '240000', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464665795', '2016-05-31 11:49:52');
INSERT INTO `t_commission_settlement_info` VALUES ('879', '177', 'hxt20160531aa', '1537', '2', '1878', '5000000', '0', '0', '5000000', '50', '2500000', '500000', '2000000', '201605', '1001', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '2', '0', '', '2', '0', '1', '1464665820', '2016-05-31 11:50:04');
INSERT INTO `t_commission_settlement_info` VALUES ('880', '177', 'hxt20160531aa', '1538', '2', '1878', '5000000', '0', '0', '5000000', '4', '200000', '40000', '160000', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '2', '0', '', '2', '0', '1', '1464665820', '2016-05-31 11:50:03');
INSERT INTO `t_commission_settlement_info` VALUES ('881', '177', 'hxt20160531aa', '1539', '2', '1878', '5000000', '0', '0', '5000000', '6', '300000', '60000', '240000', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '2', '0', '', '2', '0', '1', '1464665821', '2016-05-31 11:50:03');
INSERT INTO `t_commission_settlement_info` VALUES ('882', '178', 'aaabbb', '1549', '1', '1881', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201605', '1001', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464680811', '2016-05-31 15:49:38');
INSERT INTO `t_commission_settlement_info` VALUES ('883', '178', 'aaabbb', '1550', '1', '1881', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1464680811', '2016-05-31 15:49:38');
INSERT INTO `t_commission_settlement_info` VALUES ('884', '178', 'aaabbb', '1551', '1', '1881', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464680812', '2016-05-31 15:49:38');
INSERT INTO `t_commission_settlement_info` VALUES ('885', '178', 'aaabbb', '1549', '2', '1881', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201605', '1001', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1464680825', '2016-05-31 15:55:56');
INSERT INTO `t_commission_settlement_info` VALUES ('886', '178', 'aaabbb', '1550', '2', '1881', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201605', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '1', '', '2', '0', '1', '1464680826', '2016-05-31 15:55:57');
INSERT INTO `t_commission_settlement_info` VALUES ('887', '178', 'aaabbb', '1551', '2', '1881', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201605', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1464680826', '2016-05-31 15:55:59');
INSERT INTO `t_commission_settlement_info` VALUES ('888', '179', 'fdd23423', '1555', '1', '1921', '2342300', '0', '0', '2342300', '50', '1171150', '234230', '936920', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1464771764', '2016-06-01 17:04:17');
INSERT INTO `t_commission_settlement_info` VALUES ('889', '179', 'fdd23423', '1556', '1', '1921', '2342300', '0', '0', '2342300', '4', '93692', '18738', '74954', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464771764', '2016-06-01 17:04:17');
INSERT INTO `t_commission_settlement_info` VALUES ('890', '179', 'fdd23423', '1557', '1', '1921', '2342300', '0', '0', '2342300', '6', '140538', '28108', '112430', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464771765', '2016-06-01 17:04:17');
INSERT INTO `t_commission_settlement_info` VALUES ('891', '179', 'fdd23423', '1555', '2', '1921', '2342300', '0', '0', '2342300', '50', '1171150', '234230', '936920', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '0', '', '2', '0', '1', '1464771794', '2016-06-01 17:09:37');
INSERT INTO `t_commission_settlement_info` VALUES ('892', '179', 'fdd23423', '1556', '2', '1921', '2342300', '0', '0', '2342300', '4', '93692', '18738', '74954', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464771795', '2016-06-01 17:09:43');
INSERT INTO `t_commission_settlement_info` VALUES ('893', '179', 'fdd23423', '1557', '2', '1921', '2342300', '0', '0', '2342300', '6', '140538', '28108', '112430', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464771795', '2016-06-01 17:09:51');
INSERT INTO `t_commission_settlement_info` VALUES ('894', '180', 'gg123132', '1561', '1', '1922', '23112300', '0', '0', '23112300', '50', '11556150', '2311230', '9244920', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1464772161', '2016-06-01 17:11:08');
INSERT INTO `t_commission_settlement_info` VALUES ('895', '180', 'gg123132', '1562', '1', '1922', '23112300', '0', '0', '23112300', '4', '924492', '184898', '739594', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464772162', '2016-06-01 17:11:08');
INSERT INTO `t_commission_settlement_info` VALUES ('896', '180', 'gg123132', '1563', '1', '1922', '23112300', '0', '0', '23112300', '6', '1386738', '277348', '1109390', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464772162', '2016-06-01 17:11:08');
INSERT INTO `t_commission_settlement_info` VALUES ('897', '180', 'gg123132', '1561', '2', '1922', '23112300', '0', '0', '23112300', '50', '11556150', '2311230', '9244920', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '0', '', '2', '0', '1', '1464772173', '2016-06-01 17:12:30');
INSERT INTO `t_commission_settlement_info` VALUES ('898', '180', 'gg123132', '1562', '2', '1922', '23112300', '0', '0', '23112300', '4', '924492', '184898', '739594', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464772173', '2016-06-01 17:12:41');
INSERT INTO `t_commission_settlement_info` VALUES ('899', '180', 'gg123132', '1563', '2', '1922', '23112300', '0', '0', '23112300', '6', '1386738', '277348', '1109390', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464772174', '2016-06-01 17:12:46');
INSERT INTO `t_commission_settlement_info` VALUES ('900', '181', 'A000144', '1567', '1', '1924', '5222000', '0', '0', '5222000', '50', '2611000', '522200', '2088800', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1464835455', '2016-06-02 10:45:23');
INSERT INTO `t_commission_settlement_info` VALUES ('901', '181', 'A000144', '1568', '1', '1924', '5222000', '0', '0', '5222000', '4', '208880', '41776', '167104', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464835456', '2016-06-02 10:45:23');
INSERT INTO `t_commission_settlement_info` VALUES ('902', '181', 'A000144', '1569', '1', '1924', '5222000', '0', '0', '5222000', '6', '313320', '62664', '250656', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1464835456', '2016-06-02 10:45:23');
INSERT INTO `t_commission_settlement_info` VALUES ('903', '181', 'A000144', '1567', '2', '1924', '5222000', '0', '0', '5222000', '50', '2611000', '522200', '2088800', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '0', '', '2', '0', '1', '1464835488', '2016-06-02 11:06:10');
INSERT INTO `t_commission_settlement_info` VALUES ('904', '181', 'A000144', '1568', '2', '1924', '5222000', '0', '0', '5222000', '4', '208880', '41776', '167104', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464835489', '2016-06-02 11:06:10');
INSERT INTO `t_commission_settlement_info` VALUES ('905', '181', 'A000144', '1569', '2', '1924', '5222000', '0', '0', '5222000', '6', '313320', '62664', '250656', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '0', '', '2', '0', '1', '1464835489', '2016-06-02 11:06:09');
INSERT INTO `t_commission_settlement_info` VALUES ('906', '182', 'dsfasdfdsafasdfsa', '1573', '1', '1928', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1464949872', '2016-06-06 19:20:53');
INSERT INTO `t_commission_settlement_info` VALUES ('907', '182', 'dsfasdfdsafasdfsa', '1574', '1', '1928', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1464949873', '2016-06-06 19:20:53');
INSERT INTO `t_commission_settlement_info` VALUES ('908', '182', 'dsfasdfdsafasdfsa', '1575', '1', '1928', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201606', '1003', '丁一', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1464949873', '2016-06-06 19:20:53');
INSERT INTO `t_commission_settlement_info` VALUES ('909', '182', 'dsfasdfdsafasdfsa', '1573', '2', '1928', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '4', '0', ':转账失败-YQ9982收款方户名输入错误验证收款方户名失败!', '2', '0', '1', '1464949906', '2016-06-07 10:15:16');
INSERT INTO `t_commission_settlement_info` VALUES ('910', '182', 'dsfasdfdsafasdfsa', '1574', '2', '1928', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '4', '0', ':转账失败-CD4324签订账户控制合约，非日间模式不能处理CD4324签订账户控制合约，非日间模式不能处理', '2', '0', '1', '1464949907', '2016-06-07 10:15:15');
INSERT INTO `t_commission_settlement_info` VALUES ('911', '182', 'dsfasdfdsafasdfsa', '1575', '2', '1928', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201606', '1003', '丁一', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '2', '4', '0', ':转账失败-CD4324签订账户控制合约，非日间模式不能处理CD4324签订账户控制合约，非日间模式不能处理', '2', '0', '1', '1464949907', '2016-06-07 10:15:17');
INSERT INTO `t_commission_settlement_info` VALUES ('912', '183', 'gdagffsgsdgfds', '1579', '1', '1937', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1465443791', '2016-06-09 11:45:23');
INSERT INTO `t_commission_settlement_info` VALUES ('913', '183', 'gdagffsgsdgfds', '1580', '1', '1937', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1465443792', '2016-06-09 11:45:23');
INSERT INTO `t_commission_settlement_info` VALUES ('914', '183', 'gdagffsgsdgfds', '1581', '1', '1937', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201606', '1003', '丁一', 'eiTJZFVBsRS+v8u5+k3gGVOgsJoR/l2dUy3L6itegkY=', '1', '中国工商银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1465443792', '2016-06-09 11:45:23');
INSERT INTO `t_commission_settlement_info` VALUES ('915', '183', 'gdagffsgsdgfds', '1579', '2', '1937', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '2', '0', '1', '1465443881', '2016-06-09 11:45:26');
INSERT INTO `t_commission_settlement_info` VALUES ('916', '183', 'gdagffsgsdgfds', '1580', '2', '1937', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '2', '0', '1', '1465443881', '2016-06-09 11:45:27');
INSERT INTO `t_commission_settlement_info` VALUES ('917', '183', 'gdagffsgsdgfds', '1581', '2', '1937', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201606', '1003', '丁一', 'eiTJZFVBsRS+v8u5+k3gGVOgsJoR/l2dUy3L6itegkY=', '1', '中国工商银行', 'I', '120104196306042154', '2', '1', '0', '', '2', '0', '1', '1465443881', '2016-06-09 11:45:28');
INSERT INTO `t_commission_settlement_info` VALUES ('918', '184', '20160613YJZF', '1585', '1', '1938', '500000', '0', '0', '500000', '50', '250000', '50000', '200000', '201606', '1001', '徐雯雯寿险3', 'eiTJZFVBsRS+v8u5+k3gGVOgsJoR/l2dUy3L6itegkY=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1465798537', '2016-06-13 14:56:14');
INSERT INTO `t_commission_settlement_info` VALUES ('919', '184', '20160613YJZF', '1586', '1', '1938', '500000', '0', '0', '500000', '4', '20000', '4000', '16000', '201606', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '1', '0', '', '0', '0', '1', '1465798538', '2016-06-13 14:56:14');
INSERT INTO `t_commission_settlement_info` VALUES ('920', '184', '20160613YJZF', '1587', '1', '1938', '500000', '0', '0', '500000', '6', '30000', '6000', '24000', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '1', '0', '', '0', '0', '1', '1465798539', '2016-06-13 14:56:14');
INSERT INTO `t_commission_settlement_info` VALUES ('921', '184', '20160613YJZF', '1585', '2', '1938', '500000', '0', '0', '500000', '50', '250000', '50000', '200000', '201606', '1001', '徐雯雯寿险3', 'eiTJZFVBsRS+v8u5+k3gGVOgsJoR/l2dUy3L6itegkY=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1465799982', '2016-06-13 17:10:58');
INSERT INTO `t_commission_settlement_info` VALUES ('922', '184', '20160613YJZF', '1586', '2', '1938', '500000', '0', '0', '500000', '4', '20000', '4000', '16000', '201606', '1002', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '1', '', '2', '0', '1', '1465799983', '2016-06-13 17:10:59');
INSERT INTO `t_commission_settlement_info` VALUES ('923', '184', '20160613YJZF', '1587', '2', '1938', '500000', '0', '0', '500000', '6', '30000', '6000', '24000', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '0', '1', '1465799983', '2016-06-13 17:11:00');
INSERT INTO `t_commission_settlement_info` VALUES ('924', '185', 'A99323', '1591', '1', '1959', '10000000', '0', '0', '10000000', '50', '5000000', '1000000', '4000000', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '3', '1', '0', '', '0', '0', '1', '1466140612', '2016-06-17 14:58:26');
INSERT INTO `t_commission_settlement_info` VALUES ('925', '185', 'A99323', '1592', '1', '1959', '10000000', '0', '0', '10000000', '4', '400000', '80000', '320000', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '0', '0', '1', '1466140613', '2016-06-17 14:58:26');
INSERT INTO `t_commission_settlement_info` VALUES ('926', '185', 'A99323', '1593', '1', '1959', '10000000', '0', '0', '10000000', '6', '600000', '120000', '480000', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '0', '0', '1', '1466140613', '2016-06-17 14:58:26');
INSERT INTO `t_commission_settlement_info` VALUES ('927', '185', 'A99323', '1591', '2', '1959', '10000000', '0', '0', '10000000', '50', '5000000', '1000000', '4000000', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '3', '1', '0', '', '2', '0', '1', '1466140656', '2016-06-17 14:58:27');
INSERT INTO `t_commission_settlement_info` VALUES ('928', '185', 'A99323', '1592', '2', '1959', '10000000', '0', '0', '10000000', '4', '400000', '80000', '320000', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '2', '0', '1', '1466140656', '2016-06-17 14:58:28');
INSERT INTO `t_commission_settlement_info` VALUES ('929', '185', 'A99323', '1593', '2', '1959', '10000000', '0', '0', '10000000', '6', '600000', '120000', '480000', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '2', '0', '1', '1466140656', '2016-06-17 14:58:29');
INSERT INTO `t_commission_settlement_info` VALUES ('930', '186', 'zym16051610', '1334', '2', '1693', '1605161000', '0', '0', '1605161000', '4', '64206440', '12841288', '51365152', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '1', '1', '1466140671', '2016-06-20 16:12:24');
INSERT INTO `t_commission_settlement_info` VALUES ('931', '168', 'zym16051902', '1441', '2', '1739', '1605190200', '0', '0', '1605190200', '50', '802595100', '160519020', '642076080', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466140675', '2016-06-17 13:17:55');
INSERT INTO `t_commission_settlement_info` VALUES ('932', '187', 'A0002223', '1597', '1', '1961', '12212100', '0', '0', '12212100', '50', '6106050', '1221210', '4884840', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '3', '1', '0', '', '0', '0', '1', '1466146362', '2016-06-17 14:58:26');
INSERT INTO `t_commission_settlement_info` VALUES ('933', '187', 'A0002223', '1598', '1', '1961', '12212100', '0', '0', '12212100', '4', '488484', '97697', '390787', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '0', '0', '1', '1466146362', '2016-06-17 14:58:26');
INSERT INTO `t_commission_settlement_info` VALUES ('934', '187', 'A0002223', '1599', '1', '1961', '12212100', '0', '0', '12212100', '6', '732726', '146545', '586181', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '0', '0', '1', '1466146362', '2016-06-17 14:58:26');
INSERT INTO `t_commission_settlement_info` VALUES ('935', '187', 'A0002223', '1597', '2', '1961', '12212100', '0', '0', '12212100', '50', '6106050', '1221210', '4884840', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '3', '1', '0', '', '2', '0', '1', '1466146438', '2016-06-17 14:58:30');
INSERT INTO `t_commission_settlement_info` VALUES ('936', '187', 'A0002223', '1598', '2', '1961', '12212100', '0', '0', '12212100', '4', '488484', '97697', '390787', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '2', '0', '1', '1466146438', '2016-06-17 14:58:31');
INSERT INTO `t_commission_settlement_info` VALUES ('937', '187', 'A0002223', '1599', '2', '1961', '12212100', '0', '0', '12212100', '6', '732726', '146545', '586181', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '3', '1', '0', '', '2', '0', '1', '1466146439', '2016-06-17 14:58:31');
INSERT INTO `t_commission_settlement_info` VALUES ('938', '188', 'A0002223', '1597', '2', '1961', '12212100', '0', '0', '12212100', '50', '6106050', '1221210', '4884840', '201606', '1001', '徐雯雯变寿险', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102700', '2', '3', '1', '', '2', '1', '1', '1466146989', '2016-06-18 19:49:26');
INSERT INTO `t_commission_settlement_info` VALUES ('939', '188', 'A0002223', '1598', '2', '1961', '12212100', '0', '0', '12212100', '4', '488484', '97697', '390787', '201606', '1002', '徐雯雯寿险3', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '1', '1', '1466146989', '2016-06-18 19:49:26');
INSERT INTO `t_commission_settlement_info` VALUES ('940', '188', 'A0002223', '1599', '2', '1961', '12212100', '0', '0', '12212100', '6', '732726', '146545', '586181', '201606', '1003', '徐雯雯寿险2', 'GjwJkWMP+NyLthaswpxWaQKBedM2cmG/6KiLqBdzRwQ=', '1', '中国工商银行', 'I', '110108197009102745', '2', '3', '1', '', '2', '1', '1', '1466146989', '2016-06-18 19:49:27');
INSERT INTO `t_commission_settlement_info` VALUES ('941', '189', 'dfsafasfasfda', '1615', '1', '1967', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1466254897', '2016-06-18 21:02:54');
INSERT INTO `t_commission_settlement_info` VALUES ('942', '189', 'dfsafasfasfda', '1616', '1', '1967', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1466254897', '2016-06-18 21:02:54');
INSERT INTO `t_commission_settlement_info` VALUES ('943', '189', 'dfsafasfasfda', '1617', '1', '1967', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201606', '1003', '丁一', 'b0M1XJ8nlWz32ZsLtqJ6JRKKf0kou2xiKtDZ/STw9B0=', '1', '中国工商银行', 'I', '15260119870721365X', '2', '1', '0', '', '0', '0', '1', '1466254898', '2016-06-18 21:02:54');
INSERT INTO `t_commission_settlement_info` VALUES ('944', '189', 'dfsafasfasfda', '1615', '2', '1967', '30000', '0', '0', '30000', '50', '15000', '3000', '12000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '3', '1', '', '2', '0', '1', '1466254907', '2016-06-18 21:19:21');
INSERT INTO `t_commission_settlement_info` VALUES ('945', '189', 'dfsafasfasfda', '1616', '2', '1967', '30000', '0', '0', '30000', '4', '1200', '240', '960', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '1', '', '2', '0', '1', '1466254907', '2016-06-18 21:19:21');
INSERT INTO `t_commission_settlement_info` VALUES ('946', '189', 'dfsafasfasfda', '1617', '2', '1967', '30000', '0', '0', '30000', '6', '1800', '360', '1440', '201606', '1003', '丁一', 'b0M1XJ8nlWz32ZsLtqJ6JRKKf0kou2xiKtDZ/STw9B0=', '1', '中国工商银行', 'I', '15260119870721365X', '2', '3', '1', '', '2', '0', '1', '1466254908', '2016-06-18 21:19:22');
INSERT INTO `t_commission_settlement_info` VALUES ('947', '190', 'zym16062104', '1651', '1', '1985', '10000000', '1000000', '9000000', '10000000', '50', '4500000', '900000', '3600000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466502582', '2016-06-21 17:49:42');
INSERT INTO `t_commission_settlement_info` VALUES ('948', '190', 'zym16062104', '1652', '1', '1985', '10000000', '1000000', '9000000', '10000000', '4', '360000', '72000', '288000', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466502583', '2016-06-21 17:49:43');
INSERT INTO `t_commission_settlement_info` VALUES ('949', '190', 'zym16062104', '1653', '1', '1985', '10000000', '1000000', '9000000', '10000000', '6', '540000', '108000', '432000', '201606', '1003', '赵永敏', '0PEw86JLuFyNu57SZEKyGA==', '1', '中国工商银行', 'I', '410923199002125423', '0', '1', '0', '', '0', '0', '1', '1466502583', '2016-06-21 17:49:43');
INSERT INTO `t_commission_settlement_info` VALUES ('950', '191', 'zym16062107', '1657', '1', '1993', '10000000', '100000', '9900000', '10000000', '50', '4950000', '990000', '3960000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1466561532', '2016-06-22 10:30:09');
INSERT INTO `t_commission_settlement_info` VALUES ('951', '191', 'zym16062107', '1658', '1', '1993', '10000000', '100000', '9900000', '10000000', '4', '396000', '79200', '316800', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1466561533', '2016-06-22 10:30:09');
INSERT INTO `t_commission_settlement_info` VALUES ('952', '191', 'zym16062107', '1659', '1', '1993', '10000000', '100000', '9900000', '10000000', '6', '594000', '118800', '475200', '201606', '1003', '赵永敏', 'ggWXkngkVbWLSacZxxI4R34hxdSr/3MSlrCdWYb7kJU=', '2', '中国农业银行', 'I', '410922198905263456', '2', '1', '0', '', '0', '0', '1', '1466561533', '2016-06-22 10:30:09');
INSERT INTO `t_commission_settlement_info` VALUES ('953', '190', 'zym16062104', '1651', '2', '1985', '10000000', '1000000', '9000000', '10000000', '50', '4500000', '900000', '3600000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466562184', '2016-06-22 10:23:04');
INSERT INTO `t_commission_settlement_info` VALUES ('954', '190', 'zym16062104', '1652', '2', '1985', '10000000', '1000000', '9000000', '10000000', '4', '360000', '72000', '288000', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466562185', '2016-06-22 10:23:05');
INSERT INTO `t_commission_settlement_info` VALUES ('955', '190', 'zym16062104', '1653', '2', '1985', '10000000', '1000000', '9000000', '10000000', '6', '540000', '108000', '432000', '201606', '1003', '赵永敏', '0PEw86JLuFyNu57SZEKyGA==', '1', '中国工商银行', 'I', '410923199002125423', '0', '1', '0', '', '0', '0', '1', '1466562185', '2016-06-22 10:23:05');
INSERT INTO `t_commission_settlement_info` VALUES ('956', '191', 'zym16062107', '1657', '2', '1993', '10000000', '100000', '9900000', '10000000', '50', '4950000', '990000', '3960000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '3', '0', '', '2', '0', '1', '1466562185', '2016-06-22 10:55:47');
INSERT INTO `t_commission_settlement_info` VALUES ('957', '191', 'zym16062107', '1658', '2', '1993', '10000000', '100000', '9900000', '10000000', '4', '396000', '79200', '316800', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '0', '', '2', '0', '1', '1466562185', '2016-06-22 10:56:18');
INSERT INTO `t_commission_settlement_info` VALUES ('958', '191', 'zym16062107', '1659', '2', '1993', '10000000', '100000', '9900000', '10000000', '6', '594000', '118800', '475200', '201606', '1003', '赵永敏', 'ggWXkngkVbWLSacZxxI4R34hxdSr/3MSlrCdWYb7kJU=', '2', '中国农业银行', 'I', '410922198905263456', '2', '3', '0', '', '2', '0', '1', '1466562185', '2016-06-22 10:56:32');
INSERT INTO `t_commission_settlement_info` VALUES ('959', '192', 'rtx789', '1681', '1', '2007', '150000', '13000', '137000', '150000', '50', '68500', '13700', '54800', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '1', '0', '', '0', '0', '1', '1466598563', '2016-06-22 21:01:41');
INSERT INTO `t_commission_settlement_info` VALUES ('960', '192', 'rtx789', '1682', '1', '2007', '150000', '13000', '137000', '150000', '4', '5480', '1096', '4384', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1466598563', '2016-06-22 21:01:41');
INSERT INTO `t_commission_settlement_info` VALUES ('961', '192', 'rtx789', '1683', '1', '2007', '150000', '13000', '137000', '150000', '6', '8220', '1644', '6576', '201606', '1003', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '2', '1', '0', '', '0', '0', '1', '1466598563', '2016-06-22 21:01:41');
INSERT INTO `t_commission_settlement_info` VALUES ('962', '192', 'rtx789', '1681', '2', '2007', '150000', '13000', '137000', '150000', '50', '68500', '13700', '54800', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '2', '3', '1', '', '2', '0', '1', '1466599205', '2016-06-23 10:18:25');
INSERT INTO `t_commission_settlement_info` VALUES ('963', '192', 'rtx789', '1682', '2', '2007', '150000', '13000', '137000', '150000', '4', '5480', '1096', '4384', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '2', '3', '1', '', '2', '0', '1', '1466599205', '2016-06-23 10:18:26');
INSERT INTO `t_commission_settlement_info` VALUES ('964', '192', 'rtx789', '1683', '2', '2007', '150000', '13000', '137000', '150000', '6', '8220', '1644', '6576', '201606', '1003', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '2', '3', '1', '', '2', '0', '1', '1466599206', '2016-06-23 10:18:26');
INSERT INTO `t_commission_settlement_info` VALUES ('965', '193', 'sb564', '1671', '1', '2002', '75000', '5000', '70000', '75000', '6', '4200', '840', '3360', '201606', '1003', '我认为', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466601482', '2016-06-22 21:18:02');
INSERT INTO `t_commission_settlement_info` VALUES ('966', '193', 'sb564', '1670', '1', '2002', '75000', '0', '0', '75000', '4', '2800', '560', '2240', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466601618', '2016-06-22 21:20:18');
INSERT INTO `t_commission_settlement_info` VALUES ('967', '193', 'sb564', '1670', '2', '2002', '75000', '5000', '70000', '75000', '4', '2800', '560', '2240', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466601629', '2016-06-22 21:20:29');
INSERT INTO `t_commission_settlement_info` VALUES ('968', '193', 'sb564', '1671', '2', '2002', '75000', '5000', '70000', '75000', '6', '4200', '840', '3360', '201606', '1003', '我认为', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466601630', '2016-06-22 21:20:30');
INSERT INTO `t_commission_settlement_info` VALUES ('969', '194', 'ewre123', '1695', '1', '2027', '20002100', '30254', '19971846', '20002100', '6', '1198311', '239662', '958649', '201606', '1003', '偶偶', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '1', '中国工商银行', 'I', '120224198209216618', '1', '1', '0', '', '0', '0', '1', '1466738349', '2016-06-24 11:34:01');
INSERT INTO `t_commission_settlement_info` VALUES ('970', '194', 'ewre123', '1695', '2', '2027', '20002100', '30254', '19971846', '20002100', '6', '1198311', '239662', '958649', '201606', '1003', '偶偶', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '1', '中国工商银行', 'I', '120224198209216618', '1', '1', '0', '', '0', '0', '1', '1466738619', '2016-06-24 11:34:01');
INSERT INTO `t_commission_settlement_info` VALUES ('971', '194', 'ewre123', '1693', '1', '2027', '20002100', '0', '0', '20002100', '50', '9985923', '1997185', '7988738', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '1', '1', '0', '', '0', '0', '1', '1466738703', '2016-06-24 11:34:01');
INSERT INTO `t_commission_settlement_info` VALUES ('972', '194', 'ewre123', '1694', '1', '2027', '20002100', '0', '0', '20002100', '4', '798874', '159775', '639099', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466741103', '2016-06-24 12:05:03');
INSERT INTO `t_commission_settlement_info` VALUES ('973', '195', 'we8795', '1707', '1', '2030', '546170', '54320', '491850', '546170', '6', '29511', '5902', '23609', '201606', '1003', '二恶', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '9', '招商银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466751471', '2016-06-24 14:57:51');
INSERT INTO `t_commission_settlement_info` VALUES ('974', '195', 'we8795', '1707', '2', '2030', '546170', '54320', '491850', '546170', '6', '29511', '5902', '23609', '201606', '1003', '二恶', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '9', '招商银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466752142', '2016-06-24 15:09:02');
INSERT INTO `t_commission_settlement_info` VALUES ('975', '195', 'we8795', '1706', '1', '2030', '546170', '0', '0', '546170', '4', '19674', '3935', '15739', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466752203', '2016-06-24 15:10:03');
INSERT INTO `t_commission_settlement_info` VALUES ('976', '157', '456456', '1393', '1', '1702', '45645600', '0', '45645600', '45645600', '50', '22822800', '4564560', '18258240', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466752321', '2016-06-24 15:12:01');
INSERT INTO `t_commission_settlement_info` VALUES ('977', '157', '456456', '1394', '1', '1702', '45645600', '0', '45645600', '45645600', '4', '1825824', '365165', '1460659', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466752321', '2016-06-24 15:12:01');
INSERT INTO `t_commission_settlement_info` VALUES ('978', '195', 'we8795', '1705', '1', '2030', '546170', '54320', '491850', '546170', '50', '245925', '49185', '196740', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466752321', '2016-06-24 15:12:01');
INSERT INTO `t_commission_settlement_info` VALUES ('979', '157', '456456', '1393', '2', '1702', '45645600', '0', '0', '45645600', '50', '22822800', '4564560', '18258240', '201605', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466752749', '2016-06-24 15:19:09');
INSERT INTO `t_commission_settlement_info` VALUES ('980', '157', '456456', '1394', '2', '1702', '45645600', '0', '0', '45645600', '4', '1825824', '365165', '1460659', '201605', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466752749', '2016-06-24 15:19:09');
INSERT INTO `t_commission_settlement_info` VALUES ('981', '195', 'we8795', '1705', '2', '2030', '546170', '0', '0', '546170', '50', '245925', '49185', '196740', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466752751', '2016-06-24 15:19:11');
INSERT INTO `t_commission_settlement_info` VALUES ('982', '195', 'we8795', '1706', '2', '2030', '546170', '0', '0', '546170', '4', '19674', '3935', '15739', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466752776', '2016-06-24 15:19:36');
INSERT INTO `t_commission_settlement_info` VALUES ('983', '196', 'zym16062402', '1718', '1', '2041', '1000000', '100000', '900000', '1000000', '4', '36000', '7200', '28800', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466754593', '2016-06-24 15:49:53');
INSERT INTO `t_commission_settlement_info` VALUES ('984', '197', 'A0555', '1711', '1', '2037', '5500000', '0', '5500000', '5500000', '50', '2750000', '550000', '2200000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466754593', '2016-06-24 15:49:53');
INSERT INTO `t_commission_settlement_info` VALUES ('985', '197', 'A0555', '1712', '1', '2037', '5500000', '0', '5500000', '5500000', '4', '220000', '44000', '176000', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466754593', '2016-06-24 15:49:53');
INSERT INTO `t_commission_settlement_info` VALUES ('986', '197', 'A0555', '1713', '1', '2037', '5500000', '0', '5500000', '5500000', '6', '330000', '66000', '264000', '201606', '1003', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466754594', '2016-06-24 15:49:54');
INSERT INTO `t_commission_settlement_info` VALUES ('987', '196', 'zym16062402', '1717', '1', '2041', '1000000', '100000', '900000', '1000000', '50', '450000', '90000', '360000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466754594', '2016-06-24 15:49:54');
INSERT INTO `t_commission_settlement_info` VALUES ('988', '196', 'zym16062402', '1718', '2', '2041', '1000000', '100000', '900000', '1000000', '4', '36000', '7200', '28800', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466755086', '2016-06-24 15:58:06');
INSERT INTO `t_commission_settlement_info` VALUES ('989', '197', 'A0555', '1711', '2', '2037', '5500000', '0', '5500000', '5500000', '50', '2750000', '550000', '2200000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466755100', '2016-06-24 15:58:20');
INSERT INTO `t_commission_settlement_info` VALUES ('990', '197', 'A0555', '1712', '2', '2037', '5500000', '0', '5500000', '5500000', '4', '220000', '44000', '176000', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466755100', '2016-06-24 15:58:20');
INSERT INTO `t_commission_settlement_info` VALUES ('991', '197', 'A0555', '1713', '2', '2037', '5500000', '0', '5500000', '5500000', '6', '330000', '66000', '264000', '201606', '1003', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '1', '中国工商银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466755101', '2016-06-24 15:58:21');
INSERT INTO `t_commission_settlement_info` VALUES ('992', '196', 'zym16062402', '1717', '2', '2041', '1000000', '100000', '900000', '1000000', '50', '450000', '90000', '360000', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466755101', '2016-06-24 15:58:21');
INSERT INTO `t_commission_settlement_info` VALUES ('993', '196', 'zym16062402', '1719', '1', '2041', '1000000', '0', '0', '1000000', '6', '54000', '10800', '43200', '201606', '1003', 'kewr', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466755204', '2016-06-24 16:00:04');
INSERT INTO `t_commission_settlement_info` VALUES ('994', '196', 'zym16062402', '1719', '2', '2041', '1000000', '100000', '900000', '1000000', '6', '54000', '10800', '43200', '201606', '1003', 'kewr', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466755680', '2016-06-24 16:08:00');
INSERT INTO `t_commission_settlement_info` VALUES ('995', '198', 'iwe879', '1737', '1', '2047', '500000', '213421', '286579', '500000', '6', '17195', '3439', '13756', '201606', '1003', '而特工', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466758494', '2016-06-24 16:54:54');
INSERT INTO `t_commission_settlement_info` VALUES ('996', '198', 'iwe879', '1737', '2', '2047', '500000', '213421', '286579', '500000', '6', '17195', '3439', '13756', '201606', '1003', '而特工', 'y1gbGr13v8M2gL8M7gv8Xw==', '3', '中国建设银行', 'I', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466758678', '2016-06-24 16:57:58');
INSERT INTO `t_commission_settlement_info` VALUES ('997', '198', 'iwe879', '1735', '1', '2047', '500000', '0', '0', '500000', '50', '143290', '28658', '114632', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466758804', '2016-06-24 17:00:04');
INSERT INTO `t_commission_settlement_info` VALUES ('998', '198', 'iwe879', '1736', '1', '2047', '500000', '0', '0', '500000', '4', '11463', '2293', '9170', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466758805', '2016-06-24 17:00:05');
INSERT INTO `t_commission_settlement_info` VALUES ('999', '198', 'iwe879', '1736', '2', '2047', '500000', '213421', '286579', '500000', '4', '11463', '2293', '9170', '201606', '1002', '郭桂勇', 'y1gbGr13v8M2gL8M7gv8Xw==', '5', '中信银行', 'S', '120104196306042154', '0', '1', '0', '', '0', '0', '1', '1466997784', '2016-06-27 11:23:04');
INSERT INTO `t_commission_settlement_info` VALUES ('1000', '198', 'iwe879', '1735', '2', '2047', '500000', '213421', '286579', '500000', '50', '143290', '28658', '114632', '201606', '1001', '李学科', 'XgzmobyHneZ2I+tJaQWQyLza0hZFQfDEQt3CStlBL4Q=', '16', '平安银行（原深圳发展银行）', 'P', '120224198209216618', '0', '1', '0', '', '0', '0', '1', '1466997798', '2016-06-27 11:23:18');

-- ----------------------------
-- Table structure for t_drop_down_list_code
-- ----------------------------
DROP TABLE IF EXISTS `t_drop_down_list_code`;
CREATE TABLE `t_drop_down_list_code` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT,
  `sCodeName` varchar(50) NOT NULL DEFAULT '' COMMENT '显示的选项名称',
  `iCodeType` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '此下拉列表选项对应的类型',
  `iStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '状态：0无效，1有效',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行更新时间',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='下拉列表字典表';

-- ----------------------------
-- Records of t_drop_down_list_code
-- ----------------------------
INSERT INTO `t_drop_down_list_code` VALUES ('1', '外网查询', '1', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('2', '综合判断', '1', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('3', '其它', '1', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('4', '联系上本人', '2', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('5', '联系上第三方', '2', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('6', '电话无法联系', '2', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('7', '电话失效', '2', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('8', '其它', '2', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('9', '冻结用户', '3', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('10', '解冻用户', '3', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('11', '待处理', '4', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('12', '疑似欺诈', '4', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('13', '待客户回电', '4', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('14', '排除风险结案', '4', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('15', '确认欺诈结案', '4', '1', '1462794782', '0', '0');
INSERT INTO `t_drop_down_list_code` VALUES ('16', '待客户回电结案', '4', '1', '1462794782', '0', '0');

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

-- ----------------------------
-- Table structure for t_loan_summary
-- ----------------------------
DROP TABLE IF EXISTS `t_loan_summary`;
CREATE TABLE `t_loan_summary` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '提现流水号',
  `sMobile` varchar(11) NOT NULL DEFAULT '10000000000' COMMENT '提现用户账号',
  `iAmount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '账户余额（￥）',
  `iMoney` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '提现金额（￥）',
  `sBankName` varchar(30) NOT NULL DEFAULT '' COMMENT '提现银行',
  `sBankCard` varchar(20) NOT NULL DEFAULT '6228481210208410423' COMMENT '银行卡号',
  `iGetCashTime` int(11) unsigned DEFAULT '0' COMMENT '提现申请时间',
  `iStatus` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '提现状态:0提现关闭,1未审核,2财务审核通过,3财务审核失败,4提现成功,5提现失败',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='小额提现情况审核表';

-- ----------------------------
-- Records of t_loan_summary
-- ----------------------------
INSERT INTO `t_loan_summary` VALUES ('1', '10000000000', '1000', '10', '平安银行', '6228481210208410423', '1460422576', '1', '1460422576', '1460422576');
INSERT INTO `t_loan_summary` VALUES ('2', '10000000000', '2000', '20', '平安银行', '6228481210208410423', '1460242576', '1', '1460242576', '1460242576');
INSERT INTO `t_loan_summary` VALUES ('3', '10000000000', '3000', '30', '平安银行', '6228481210208410423', '1460292576', '1', '1460292576', '1460292576');
INSERT INTO `t_loan_summary` VALUES ('4', '10000000000', '4000', '40', '平安银行', '6228481210208410423', '1460252276', '1', '1460252276', '1460252276');
INSERT INTO `t_loan_summary` VALUES ('5', '10000000000', '5000', '50', '平安银行', '6228481210208410423', '1460262876', '1', '1460262876', '1460262876');
INSERT INTO `t_loan_summary` VALUES ('6', '10000000000', '6000', '60', '平安银行', '6228481210208410423', '1460273476', '1', '1460273476', '1460273476');
INSERT INTO `t_loan_summary` VALUES ('7', '10000000000', '7000', '70', '平安银行', '6228481210208410423', '1460332576', '1', '1460332576', '1460332576');

-- ----------------------------
-- Table structure for t_mail_list
-- ----------------------------
DROP TABLE IF EXISTS `t_mail_list`;
CREATE TABLE `t_mail_list` (
  `iAutoId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮件ID',
  `sSubject` varchar(255) NOT NULL DEFAULT '' COMMENT '邮件标题',
  `sBodyText` text COMMENT '邮件内容',
  `sBodyEntity` text COMMENT '邮件体Entity的json串',
  `sAttachmentURL` varchar(255) NOT NULL DEFAULT '' COMMENT '附件地址。空串表示没有附件',
  `iTypeID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '邮件类型ID。对应t_mail_type的iAutoID',
  `iSentStatus` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT ' 发送状态(0：待发送；1：发送成功；2：发送失败；3：暂停发送, t_mail_type的iState为1停用时，此列要更新为3)',
  `iSentTimes` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '已发送次数',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行创建时间',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '行更新时间',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '逻辑删除状态: 0：逻辑删除，1：有效',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoId`),
  KEY `idx_updatetime` (`iUpdateTime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mail_list
-- ----------------------------
INSERT INTO `t_mail_list` VALUES ('135', '????????', '<html>\r\n\r\n<head>\r\n<meta http-equiv=Content-Type content=\"text/html; charset=gb2312\">\r\n<style>\r\n<!-- /* Style Definitions */\r\np.MsoNormal, li.MsoNormal, div.MsoNormal {\r\n margin: 0cm;\r\n    margin-bottom: .0001pt;\r\n text-align: justify;\r\n    font-size: 10.5pt;\r\n  font-family: \"Calibri\", \"sans-serif\";\r\n}\r\n\r\na:link, span.MsoHyperlink {\r\n   color: blue;\r\n    text-decoration: underline;\r\n text-underline: single;\r\n}\r\n\r\na:visited, span.MsoHyperlinkFollowed {\r\n  color: purple;\r\n  text-decoration: underline;\r\n text-underline: single;\r\n}\r\n\r\np.MsoAcetate, li.MsoAcetate, div.MsoAcetate {\r\n   margin: 0cm;\r\n    margin-bottom: .0001pt;\r\n text-align: justify;\r\n    font-size: 9.0pt;\r\n   font-family: \"Calibri\", \"sans-serif\";\r\n}\r\n\r\nspan.EmailStyle19 {\r\n   font-family: \"Calibri\", \"sans-serif\";\r\n   color: windowtext;\r\n}\r\n\r\n.MsoChpDefault {\r\n font-size: 10.0pt;\r\n}\r\n-->\r\n</style>\r\n\r\n<style>\r\n/* Style Definitions */\r\ntable.MsoNormalTable {\r\n  font-size: 10.0pt;\r\n  font-family: \"Times New Roman\", \"serif\";\r\n}\r\n</style>\r\n</head>\r\n\r\n<body lang=ZH-CN link=blue vlink=purple>\r\n\r\n    <div>\r\n\r\n       <p class=MsoNormal>\r\n         <b><span style=\'font-size: 18.0pt; font-family: ??; color: black\'>??????????</span></b>\r\n     </p>\r\n\r\n        <p class=MsoNormal>\r\n         <span>&nbsp;</span>\r\n     </p>\r\n\r\n        <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0\r\n            style=\'border-collapse: collapse; padding: 0cm 0cm 0cm 0cm\' width=\"60%\">\r\n            <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                 <p class=MsoNormal>????</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border: solid windowtext 1.0pt; border-left: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                  <p class=MsoNormal>??????</p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>????</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>\r\n                     <span lang=EN-US>??????</span>\r\n                  </p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>???</p>\r\n               </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>TradeDetectionJob.java</p>\r\n             </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>?????</p>\r\n               </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>\r\n                     <span lang=EN-US></span>\r\n                   </p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>??????</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>2016-06-14 20:25:30 CST</p>\r\n              </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>????</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>??????ID?300043 ????200014464 ??????????5?,???????????,??ID??4org.springframework.jdbc.BadSqlGrammarException: \r\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table \'test_db.t_mfts_trade1\' doesn\'t exist\r\n### The error may exist in class path resource [com/pingan/haofang/mfts/repository/RiskControlEffectRulesMapper.xml]\r\n### The error may involve com.pingan.haofang.mfts.dao.RiskControlEffectRulesMapper.getCheckResCount-Inline\r\n### The error occurred while setting parameters\r\n### SQL: select count(*) from t_mfts_trade1\r\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table \'test_db.t_mfts_trade1\' doesn\'t exist\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table \'test_db.t_mfts_trade1\' doesn\'t exist</p>\r\n               </td>\r\n           </tr>\r\n       </table>\r\n\r\n        <p class=MsoNormal>&nbsp;</p>\r\n\r\n       <p class=MsoNormal>&nbsp;</p>\r\n\r\n       <p class=MsoNormal>\r\n         <b><span style=\'font-size: 16.0pt; font-family: ??\'>??????</span></b>\r\n      </p>\r\n\r\n        <p class=MsoNormal>\r\n         <b><span style=\'font-size: 16.0pt\'>2016-06-14 20:25:30</span></b>\r\n     </p>\r\n    </div>\r\n</body>\r\n</html>\r\n', '{\"appName\":\"??????\",\"className\":\"TradeDetectionJob.java\",\"date\":\"2016-06-14 20:25:30\",\"mailSentDate\":\"2016-06-14 20:25:30\",\"mailSentFrom\":\"??????\",\"msg\":\"??????ID?300043 ????200014464 ??????????5?,???????????,??ID??4org.springframework.jdbc.BadSqlGrammarException: \\r\\n### Error querying database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table \'test_db.t_mfts_trade1\' doesn\'t exist\\r\\n### The error may exist in class path resource [com/pingan/haofang/mfts/repository/RiskControlEffectRulesMapper.xml]\\r\\n### The error may involve com.pingan.haofang.mfts.dao.RiskControlEffectRulesMapper.getCheckResCount-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: select count(*) from t_mfts_trade1\\r\\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table \'test_db.t_mfts_trade1\' doesn\'t exist\\n; bad SQL grammar []; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException: Table \'test_db.t_mfts_trade1\' doesn\'t exist\",\"serverName\":\"\",\"subject\":\"????????\",\"systemName\":\"??????\"}', '', '7', '0', '0', '1465907130', '1465907130', '1', '0');
INSERT INTO `t_mail_list` VALUES ('136', '交易实时监控异常', '<html>\r\n\r\n<head>\r\n<meta http-equiv=Content-Type content=\"text/html; charset=gb2312\">\r\n<style>\r\n<!-- /* Style Definitions */\r\np.MsoNormal, li.MsoNormal, div.MsoNormal {\r\n margin: 0cm;\r\n    margin-bottom: .0001pt;\r\n text-align: justify;\r\n    font-size: 10.5pt;\r\n  font-family: \"Calibri\", \"sans-serif\";\r\n}\r\n\r\na:link, span.MsoHyperlink {\r\n   color: blue;\r\n    text-decoration: underline;\r\n text-underline: single;\r\n}\r\n\r\na:visited, span.MsoHyperlinkFollowed {\r\n  color: purple;\r\n  text-decoration: underline;\r\n text-underline: single;\r\n}\r\n\r\np.MsoAcetate, li.MsoAcetate, div.MsoAcetate {\r\n   margin: 0cm;\r\n    margin-bottom: .0001pt;\r\n text-align: justify;\r\n    font-size: 9.0pt;\r\n   font-family: \"Calibri\", \"sans-serif\";\r\n}\r\n\r\nspan.EmailStyle19 {\r\n   font-family: \"Calibri\", \"sans-serif\";\r\n   color: windowtext;\r\n}\r\n\r\n.MsoChpDefault {\r\n font-size: 10.0pt;\r\n}\r\n-->\r\n</style>\r\n\r\n<style>\r\n/* Style Definitions */\r\ntable.MsoNormalTable {\r\n  font-size: 10.0pt;\r\n  font-family: \"Times New Roman\", \"serif\";\r\n}\r\n</style>\r\n</head>\r\n\r\n<body lang=ZH-CN link=blue vlink=purple>\r\n\r\n    <div>\r\n\r\n       <p class=MsoNormal>\r\n         <b><span style=\'font-size: 18.0pt; font-family: 宋体; color: black\'>【交易实时监控异常】</span></b>\r\n     </p>\r\n\r\n        <p class=MsoNormal>\r\n         <span>&nbsp;</span>\r\n     </p>\r\n\r\n        <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0\r\n            style=\'border-collapse: collapse; padding: 0cm 0cm 0cm 0cm\' width=\"60%\">\r\n            <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                 <p class=MsoNormal>异常系统</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border: solid windowtext 1.0pt; border-left: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                  <p class=MsoNormal>交易监控系统</p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常应用</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>\r\n                     <span lang=EN-US>交易信息侦测</span>\r\n                  </p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常类</p>\r\n               </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>TradeDetectionJob.java</p>\r\n             </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常服务器</p>\r\n               </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>\r\n                     <span lang=EN-US></span>\r\n                   </p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常发生时间</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>2016-06-15 09:30:30 CST</p>\r\n              </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常详情</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>交易信息主键ID：300043 交易号：200014464 在监测时遇到异常超过5次,异常信息：\r\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'\r\n### The error may involve com.pingan.haofang.mfts.dao.MftsTradeDetectionMapper.insertTradeDetection-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO t_mfts_trade_detection    (iTradeDataID,iNameListMark,sNameListStatus,sRuleMark,sRuleDetection,iCreateTime)     VALUES     (?,?,?,?,?,?)\r\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'\n; SQL []; Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'</p>\r\n               </td>\r\n           </tr>\r\n       </table>\r\n\r\n        <p class=MsoNormal>&nbsp;</p>\r\n\r\n       <p class=MsoNormal>&nbsp;</p>\r\n\r\n       <p class=MsoNormal>\r\n         <b><span style=\'font-size: 16.0pt; font-family: 宋体\'>交易信息侦测</span></b>\r\n      </p>\r\n\r\n        <p class=MsoNormal>\r\n         <b><span style=\'font-size: 16.0pt\'>2016-06-15 09:30:30</span></b>\r\n     </p>\r\n    </div>\r\n</body>\r\n</html>\r\n', '{\"appName\":\"交易信息侦测\",\"className\":\"TradeDetectionJob.java\",\"date\":\"2016-06-15 09:30:30\",\"mailSentDate\":\"2016-06-15 09:30:30\",\"mailSentFrom\":\"交易信息侦测\",\"msg\":\"交易信息主键ID：300043 交易号：200014464 在监测时遇到异常超过5次,异常信息：\\r\\n### Error updating database.  Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'\\r\\n### The error may involve com.pingan.haofang.mfts.dao.MftsTradeDetectionMapper.insertTradeDetection-Inline\\r\\n### The error occurred while setting parameters\\r\\n### SQL: INSERT INTO t_mfts_trade_detection    (iTradeDataID,iNameListMark,sNameListStatus,sRuleMark,sRuleDetection,iCreateTime)     VALUES     (?,?,?,?,?,?)\\r\\n### Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'\\n; SQL []; Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'; nested exception is com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException: Duplicate entry \'300043\' for key \'uidx_iTradeDataID\'\",\"serverName\":\"\",\"subject\":\"交易实时监控异常\",\"systemName\":\"交易监控系统\"}', '', '7', '0', '0', '1465954230', '1465954230', '1', '0');

-- ----------------------------
-- Table structure for t_mail_model
-- ----------------------------
DROP TABLE IF EXISTS `t_mail_model`;
CREATE TABLE `t_mail_model` (
  `iAutoID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模板类型号',
  `sTemplateName` varchar(100) NOT NULL DEFAULT '' COMMENT '模板名称',
  `sTemplateContent` text COMMENT '模板内容',
  `iState` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '模板启用状态：0启用；1停用',
  `sCreateUserName` varchar(100) NOT NULL DEFAULT '' COMMENT '模板创建者',
  `sUpdateUserName` varchar(100) NOT NULL DEFAULT '' COMMENT '模板更新者',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行更新时间',
  `iStatus` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态: 0：逻辑删除，1：有效',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mail_model
-- ----------------------------
INSERT INTO `t_mail_model` VALUES ('1', '交易监控系统-通用模板', '<html>\r\n\r\n<head>\r\n<meta http-equiv=Content-Type content=\"text/html; charset=gb2312\">\r\n<style>\r\n<!-- /* Style Definitions */\r\np.MsoNormal, li.MsoNormal, div.MsoNormal {\r\n margin: 0cm;\r\n    margin-bottom: .0001pt;\r\n text-align: justify;\r\n    font-size: 10.5pt;\r\n  font-family: \"Calibri\", \"sans-serif\";\r\n}\r\n\r\na:link, span.MsoHyperlink {\r\n   color: blue;\r\n    text-decoration: underline;\r\n text-underline: single;\r\n}\r\n\r\na:visited, span.MsoHyperlinkFollowed {\r\n  color: purple;\r\n  text-decoration: underline;\r\n text-underline: single;\r\n}\r\n\r\np.MsoAcetate, li.MsoAcetate, div.MsoAcetate {\r\n   margin: 0cm;\r\n    margin-bottom: .0001pt;\r\n text-align: justify;\r\n    font-size: 9.0pt;\r\n   font-family: \"Calibri\", \"sans-serif\";\r\n}\r\n\r\nspan.EmailStyle19 {\r\n   font-family: \"Calibri\", \"sans-serif\";\r\n   color: windowtext;\r\n}\r\n\r\n.MsoChpDefault {\r\n font-size: 10.0pt;\r\n}\r\n-->\r\n</style>\r\n\r\n<style>\r\n/* Style Definitions */\r\ntable.MsoNormalTable {\r\n  font-size: 10.0pt;\r\n  font-family: \"Times New Roman\", \"serif\";\r\n}\r\n</style>\r\n</head>\r\n\r\n<body lang=ZH-CN link=blue vlink=purple>\r\n\r\n    <div>\r\n\r\n       <p class=MsoNormal>\r\n         <b><span style=\'font-size: 18.0pt; font-family: 宋体; color: black\'>【${(info.subject)!\'\'}】</span></b>\r\n     </p>\r\n\r\n        <p class=MsoNormal>\r\n         <span>&nbsp;</span>\r\n     </p>\r\n\r\n        <table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0\r\n            style=\'border-collapse: collapse; padding: 0cm 0cm 0cm 0cm\' width=\"60%\">\r\n            <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                 <p class=MsoNormal>异常系统</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border: solid windowtext 1.0pt; border-left: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                  <p class=MsoNormal>${(info.systemName)!\'\'}</p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常应用</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>\r\n                     <span lang=EN-US>${(info.appName)!\'\'}</span>\r\n                  </p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常类</p>\r\n               </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>${(info.className)!\'\'}</p>\r\n             </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常服务器</p>\r\n               </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>\r\n                     <span lang=EN-US>${(info.serverName)!\'\'}</span>\r\n                   </p>\r\n                </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常发生时间</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>${(info.date)!\'\'} CST</p>\r\n              </td>\r\n           </tr>\r\n           <tr>\r\n                <td valign=top\r\n                  style=\'width: 10%; border: solid windowtext 1.0pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>异常详情</p>\r\n             </td>\r\n               <td valign=top\r\n                  style=\'width: 40%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; padding: 0cm 5.4pt 0cm 5.4pt\'>\r\n                   <p class=MsoNormal>${(info.msg)!\'\'}</p>\r\n               </td>\r\n           </tr>\r\n       </table>\r\n\r\n        <p class=MsoNormal>&nbsp;</p>\r\n\r\n       <p class=MsoNormal>&nbsp;</p>\r\n\r\n       <p class=MsoNormal>\r\n         <b><span style=\'font-size: 16.0pt; font-family: 宋体\'>${(info.mailSentFrom)!\'\'}</span></b>\r\n      </p>\r\n\r\n        <p class=MsoNormal>\r\n         <b><span style=\'font-size: 16.0pt\'>${(info.mailSentDate)!\'\'}</span></b>\r\n     </p>\r\n    </div>\r\n</body>\r\n</html>\r\n', '0', '刘岳峰', '刘岳峰', '1463624460', '1463624460', '1', '0');

-- ----------------------------
-- Table structure for t_mail_type
-- ----------------------------
DROP TABLE IF EXISTS `t_mail_type`;
CREATE TABLE `t_mail_type` (
  `iAutoID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮件类型号。0：数据异常；1：I/O异常；2：Redis缓存异常',
  `sTypeName` varchar(100) NOT NULL DEFAULT '' COMMENT '类型名称。如（数据异常；I/O异常；Redis缓存异常）',
  `iModelID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模板ID。对应模板表里的iAutoID',
  `sTo` text COMMENT '收件人',
  `sCc` text COMMENT 'CC',
  `sBcc` text COMMENT 'BCC',
  `sFromEmailAddress` varchar(100) NOT NULL DEFAULT '' COMMENT '发送人地址，如pub_PAHFProMon@pingan.com.cn',
  `sFromName` varchar(100) NOT NULL DEFAULT '' COMMENT '发送人名称，如平安好房业务监控',
  `iImportance` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '重要度：（0：Low; 1: Normal; 2:High）',
  `iState` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型启用状态：0启用；1停用',
  `sCreateUserName` varchar(100) NOT NULL DEFAULT '' COMMENT '类型创建者姓名',
  `sUpdateUserName` varchar(100) NOT NULL DEFAULT '' COMMENT '类型更新者姓名',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '行更新时间',
  `iStatus` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态: 0：逻辑删除，1：有效',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_mail_type
-- ----------------------------
INSERT INTO `t_mail_type` VALUES ('1', '交易监控报警-通用', '1', 'EX-GONGDAOSHUN700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn;EX-LIUGUANGHUA700@pingan.com.cn;EX-LIULI700@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('2', '准实时建案', '1', 'EX-GONGDAOSHUN700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('3', '登陆', '1', 'EX-FENGDAWEI600@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('4', '拉取数据', '1', 'EX-LIUGUANGHUA700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('5', '文件上传', '1', 'EX-LIUGUANGHUA700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('6', '读消息队列', '1', 'EX-LIULI700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('7', '交易侦测', '1', 'EX-LIULI700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('8', '打开案件-查询用户失败', '1', 'EX-GONGDAOSHUN700@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');
INSERT INTO `t_mail_type` VALUES ('9', 'http请求失败', '1', 'EX-FENGDAWEI600@pingan.com.cn;ZOUHAIJUN575@pingan.com.cn', '', '', 'pub_PAHFProMon@pingan.com.cn', '平安好房业务监控', '0', '0', '', '', '1463363316', '1463363316', '1', '0');

-- ----------------------------
-- Table structure for t_mfts_trade
-- ----------------------------
DROP TABLE IF EXISTS `t_mfts_trade`;
CREATE TABLE `t_mfts_trade` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `iItradeNo` int(11) NOT NULL DEFAULT '0' COMMENT '交易号',
  `iTradeType` int(4) NOT NULL DEFAULT '1' COMMENT '交易类型,1支付，2代收，代付',
  `iUserId` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `sUserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `sUserContact` varchar(100) NOT NULL DEFAULT '' COMMENT '手机号',
  `iBusinessID` int(11) NOT NULL DEFAULT '0' COMMENT '业务ID',
  `sBusinessOrderID` varchar(40) NOT NULL DEFAULT '' COMMENT '业务订单号',
  `iProductID` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `sThirdSerialNum` varchar(200) NOT NULL DEFAULT '' COMMENT '第三方订单号',
  `iAmount` int(11) NOT NULL DEFAULT '0' COMMENT '金额',
  `iChannelID` int(11) NOT NULL DEFAULT '0' COMMENT '支付渠道',
  `iBankID` int(11) NOT NULL DEFAULT '0' COMMENT '银行ID',
  `sCardUserName` varchar(100) NOT NULL DEFAULT '' COMMENT '银行持卡人姓名',
  `sIdentityID` varchar(45) NOT NULL DEFAULT '' COMMENT '银行持卡人身份证号',
  `sBankCard` varchar(100) NOT NULL DEFAULT '' COMMENT '银行卡号',
  `iStatus` int(4) NOT NULL DEFAULT '1' COMMENT '交易完成状态：1申请/2处理中/3成功/4失败',
  `iRequestTime` int(11) NOT NULL DEFAULT '0' COMMENT '交易请求时间',
  `iCompletedTime` int(11) NOT NULL DEFAULT '0' COMMENT '交易完成时间',
  `iCreateTime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iDealed` int(4) NOT NULL DEFAULT '0' COMMENT '是否处理,0未处理，1已处理',
  `iSourceType` int(4) NOT NULL DEFAULT '0' COMMENT '数据来源，0接口，2文件导入',
  `iExceptionTimes` int(1) NOT NULL DEFAULT '0' COMMENT '异常次数',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  `iCardType` int(4) NOT NULL DEFAULT '0' COMMENT '1=借记卡,2=信用卡',
  `sBankName` varchar(50) NOT NULL DEFAULT '' COMMENT '银行名称',
  `iFinanceID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '支付网关iFinanceID',
  `iTradeStatus` int(255) DEFAULT NULL,
  `sChannelName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iAutoID`),
  KEY `idx_iSourceType` (`iSourceType`) USING BTREE,
  KEY `idx_iDealed` (`iDealed`) USING BTREE,
  KEY `idx_iExceptionTimes` (`iExceptionTimes`) USING BTREE,
  KEY `idx_iSourceType_iDealed_iExceptionTimes` (`iSourceType`,`iDealed`,`iExceptionTimes`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=300047 DEFAULT CHARSET=utf8 COMMENT='支付数据表';

-- ----------------------------
-- Records of t_mfts_trade
-- ----------------------------
INSERT INTO `t_mfts_trade` VALUES ('300006', '200014463', '1', '111', 'ceshi', '18616914935', '2', '2016060801000000196357', '1', '33683247', '1', '1', '3', '', '', '', '1', '1465380116', '1465380112', '0', '1465954120', '2', '0', '0', '0', '2', '中国工商银行', '1', '1', '快钱');
INSERT INTO `t_mfts_trade` VALUES ('300043', '200014464', '1', '111', 'ceshi', '18616914935', '2', '2016060801000000196357', '1', '33683247', '1', '1', '3', '', '', '', '1', '1465380116', '1465380112', '0', '1465954230', '0', '0', '5', '0', '2', '中国工商银行', '1', '1', '快钱');
INSERT INTO `t_mfts_trade` VALUES ('300044', '200014465', '1', '111', 'ceshi', '18616914935', '2', '2016060801000000196357', '1', '33683247', '1', '1', '3', '', '', '', '1', '1465380116', '1465380112', '0', '1465954120', '2', '0', '0', '0', '2', '中国工商银行', '1', '1', '快钱');
INSERT INTO `t_mfts_trade` VALUES ('300045', '200014466', '1', '111', 'ceshi', '18616914935', '2', '2016060801000000196357', '1', '33683247', '1', '1', '3', '', '', '', '1', '1465380116', '1465380112', '0', '1465954120', '2', '0', '0', '0', '2', '中国工商银行', '1', '1', '快钱');
INSERT INTO `t_mfts_trade` VALUES ('300046', '200014467', '1', '111', 'ceshi', '18616914935', '2', '2016060801000000196357', '1', '33683247', '100', '1', '3', '', '', '', '1', '1465380116', '1465380112', '0', '1465954120', '2', '0', '0', '0', '2', '中国工商银行', '1', '1', '快钱');

-- ----------------------------
-- Table structure for t_mfts_trade_detection
-- ----------------------------
DROP TABLE IF EXISTS `t_mfts_trade_detection`;
CREATE TABLE `t_mfts_trade_detection` (
  `iAutoID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID主键-来自交易信息',
  `iTradeDataID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '交易数据表主键ID',
  `iNameListMark` tinyint(1) NOT NULL DEFAULT '0' COMMENT '名单标识（1黑名单，2白名单，3灰名单）',
  `sNameListStatus` varchar(200) NOT NULL DEFAULT '' COMMENT '黑白名触发序列 [黑-电话，黑-身份证]',
  `sRuleMark` varchar(300) DEFAULT NULL,
  `sRuleDetection` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '规则侦测触发规则序列 命中的规则逗号分隔',
  `iDealed` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否处理 0-未处理 1-已处理',
  `iExceptionTimes` int(1) NOT NULL DEFAULT '0' COMMENT '异常次数',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0：逻辑删除，1：有效',
  PRIMARY KEY (`iAutoID`),
  UNIQUE KEY `uidx_iTradeDataID` (`iTradeDataID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=474745 DEFAULT CHARSET=utf8 COMMENT='交易监控表';

-- ----------------------------
-- Records of t_mfts_trade_detection
-- ----------------------------
INSERT INTO `t_mfts_trade_detection` VALUES ('474740', '300006', '0', '', 'cs', '3', '0', '0', '1465954120', '0', '0', '1');
INSERT INTO `t_mfts_trade_detection` VALUES ('474741', '300043', '0', '', 'cs', '3', '0', '0', '1465954120', '0', '0', '1');
INSERT INTO `t_mfts_trade_detection` VALUES ('474742', '300044', '0', '', 'cs', '3', '0', '0', '1465954120', '0', '0', '1');
INSERT INTO `t_mfts_trade_detection` VALUES ('474743', '300045', '0', '', 'cs', '3', '0', '0', '1465954120', '0', '0', '1');
INSERT INTO `t_mfts_trade_detection` VALUES ('474744', '300046', '0', '', '100AmontTest,cs', '2,3', '0', '0', '1465954120', '0', '0', '1');

-- ----------------------------
-- Table structure for t_mfts_trade_queue
-- ----------------------------
DROP TABLE IF EXISTS `t_mfts_trade_queue`;
CREATE TABLE `t_mfts_trade_queue` (
  `iAutoID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID主键-来自交易信息',
  `iItradeNo` int(11) NOT NULL DEFAULT '0',
  `iTradeType` int(11) NOT NULL DEFAULT '0' COMMENT '交易类型,1支付，2代收，代付',
  `iDealed` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否处理 0-未处理 1-已处理',
  `iExceptionTimes` int(1) NOT NULL DEFAULT '0' COMMENT '异常次数',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '删除时间',
  `iStatus` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0：逻辑删除，1：有效',
  PRIMARY KEY (`iAutoID`),
  KEY `test` (`iItradeNo`,`iTradeType`)
) ENGINE=InnoDB AUTO_INCREMENT=310069 DEFAULT CHARSET=latin1 COMMENT='交易队列表';

-- ----------------------------
-- Records of t_mfts_trade_queue
-- ----------------------------
INSERT INTO `t_mfts_trade_queue` VALUES ('310059', '0', '1', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310060', '1', '2', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310061', '2', '3', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310062', '3', '4', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310063', '4', '5', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310064', '5', '6', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310065', '6', '7', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310066', '7', '8', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310067', '8', '9', '2', '0', '1465697902', '0', '0', '1');
INSERT INTO `t_mfts_trade_queue` VALUES ('310068', '9', '10', '2', '0', '1465697902', '0', '0', '1');

-- ----------------------------
-- Table structure for t_present_audit
-- ----------------------------
DROP TABLE IF EXISTS `t_present_audit`;
CREATE TABLE `t_present_audit` (
  `iAutoId` int(11) NOT NULL AUTO_INCREMENT COMMENT '提现流水号',
  `iUserNumber` int(11) DEFAULT NULL COMMENT '提现用户账号',
  `iAmount` int(11) DEFAULT NULL COMMENT '提现金额（￥)',
  `iDataTime` int(11) DEFAULT NULL COMMENT '提现申请时间',
  `iAuditStatus` int(11) DEFAULT NULL COMMENT '提现申请状态[1-未审核;2-财务审核通过;3-财务审核失败;4-提现成功;5-提现失败]',
  `iCreateTime` int(11) DEFAULT NULL COMMENT '创建时间',
  `iUpdateTime` int(11) DEFAULT NULL COMMENT '更新时间',
  `iStatus` int(1) DEFAULT NULL COMMENT '逻辑删除状态[0：逻辑删除，1：有效]',
  `iDeleteTime` int(11) DEFAULT NULL COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_present_audit
-- ----------------------------
INSERT INTO `t_present_audit` VALUES ('1', '1231', '2212', '1460563200', '2', '1460563200', '1461229413', null, null);
INSERT INTO `t_present_audit` VALUES ('2', '123', '225', '1460563200', '2', '1460563200', '1461229413', null, null);
INSERT INTO `t_present_audit` VALUES ('3', '12', '3', '1460563200', '2', '1460563200', '1461229413', null, null);
INSERT INTO `t_present_audit` VALUES ('4', '23', '34', '1460563200', '2', '1460563200', '1461229413', null, null);
INSERT INTO `t_present_audit` VALUES ('5', '34', '552', '1460563200', '2', '1460563200', '1461229413', null, null);
INSERT INTO `t_present_audit` VALUES ('6', '45', '5223', '1460563200', '1', '1460563200', '1461034223', null, null);
INSERT INTO `t_present_audit` VALUES ('7', '2', '23', '1460563200', '1', '1460563200', '1461034259', null, null);
INSERT INTO `t_present_audit` VALUES ('8', '345', '42', '1460563200', '1', '1460563200', null, null, null);
INSERT INTO `t_present_audit` VALUES ('9', '34', '42', '1460563200', '1', '1460563200', null, null, null);
INSERT INTO `t_present_audit` VALUES ('10', '45', '345', '1460563200', '1', '1460563200', null, null, null);
INSERT INTO `t_present_audit` VALUES ('11', '45', '345324523', '1460563200', '1', '1460563200', null, null, null);
INSERT INTO `t_present_audit` VALUES ('12', '64', '2345', '1460563200', '1', '1460563200', null, null, null);
INSERT INTO `t_present_audit` VALUES ('13', '435', '234', '1460563200', '1', '1460563200', null, null, null);
INSERT INTO `t_present_audit` VALUES ('14', '23', '23', '1460563200', '1', '1460563200', null, null, null);

-- ----------------------------
-- Table structure for t_priority
-- ----------------------------
DROP TABLE IF EXISTS `t_priority`;
CREATE TABLE `t_priority` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `iPriorityKey` int(11) NOT NULL DEFAULT '0' COMMENT '优先级key',
  `iPriorityValue` int(11) NOT NULL DEFAULT '0' COMMENT '优先级值',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='优先级配置表';

-- ----------------------------
-- Records of t_priority
-- ----------------------------
INSERT INTO `t_priority` VALUES ('1', '1', '10', '0', '0', '1', '0');
INSERT INTO `t_priority` VALUES ('2', '2', '30', '0', '0', '1', '0');
INSERT INTO `t_priority` VALUES ('3', '3', '20', '0', '0', '1', '0');

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sProductName` varchar(50) NOT NULL DEFAULT '' COMMENT '产品名称',
  `iFinanceId` int(11) NOT NULL,
  `iTradeType` tinyint(4) NOT NULL,
  `iCreateTime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '好房贷', '2', '2', '0', '0', '0');
INSERT INTO `t_product` VALUES ('2', '好房宝', '5', '2', '0', '0', '0');
INSERT INTO `t_product` VALUES ('3', '安安租', '6', '2', '0', '0', '0');
INSERT INTO `t_product` VALUES ('4', '安安租', '7', '1', '0', '0', '0');
INSERT INTO `t_product` VALUES ('5', '好房宝2.0', '7', '2', '0', '0', '0');
INSERT INTO `t_product` VALUES ('6', '好房宝2.0', '8', '1', '0', '0', '0');
INSERT INTO `t_product` VALUES ('7', '地产众筹', '8', '2', '0', '0', '0');
INSERT INTO `t_product` VALUES ('8', '地产众筹', '5', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for t_risk_bwg_list
-- ----------------------------
DROP TABLE IF EXISTS `t_risk_bwg_list`;
CREATE TABLE `t_risk_bwg_list` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '黑白灰名单ID',
  `iBWGMark` tinyint(4) unsigned DEFAULT '0' COMMENT '名单标识（1黑名单，2白名单，3灰名单）',
  `iBWGCategory` tinyint(4) unsigned DEFAULT '0' COMMENT '名单类别（1手机号，2卡号，3身份证号）',
  `sBWGContent` varchar(100) DEFAULT '' COMMENT '名单内容',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`),
  KEY `index_sBWGContent` (`sBWGContent`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='黑白灰名单表';

-- ----------------------------
-- Records of t_risk_bwg_list
-- ----------------------------
INSERT INTO `t_risk_bwg_list` VALUES ('1', '1', '1', '13122556699', '0', '0', '1', '0');
INSERT INTO `t_risk_bwg_list` VALUES ('2', '3', '2', '2253', '0', '0', '1', '0');
INSERT INTO `t_risk_bwg_list` VALUES ('3', '1', '3', '370', '0', '0', '1', '0');
INSERT INTO `t_risk_bwg_list` VALUES ('4', '2', '1', '110', '0', '0', '1', '0');

-- ----------------------------
-- Table structure for t_risk_control_edit_rules
-- ----------------------------
DROP TABLE IF EXISTS `t_risk_control_edit_rules`;
CREATE TABLE `t_risk_control_edit_rules` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `sRuleName` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `iRuleCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规则生成时间',
  `sCreateOperatorId` varchar(20) NOT NULL DEFAULT '' COMMENT '新增操作员Id',
  `sCreateOperator` varchar(60) DEFAULT NULL,
  `iRuleUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '规则更新时间',
  `sUpdateOperatorId` varchar(20) NOT NULL DEFAULT '' COMMENT '更新操作员Id',
  `sUpdateOperator` varchar(20) NOT NULL DEFAULT '' COMMENT '更新操作员',
  `iRuleStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '规则状态（2启用，1停用，0删除）',
  `sRuleContentCode` varchar(500) NOT NULL DEFAULT '' COMMENT 'sql形式规则内容',
  `sRuleContent` varchar(500) NOT NULL DEFAULT '' COMMENT '规则内容',
  `iEffectStatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '应用变更状态（1已应用，0未应用）',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`),
  KEY `index_sRuleName` (`sRuleName`),
  KEY `index_iRuleUpdateTime` (`iRuleUpdateTime`),
  KEY `index_sRuleName_iRuleUpdateTime` (`sRuleName`,`iRuleUpdateTime`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='风控侦测规则表';

-- ----------------------------
-- Records of t_risk_control_edit_rules
-- ----------------------------
INSERT INTO `t_risk_control_edit_rules` VALUES ('1', '2', '0', '', '', '0', '', '', '1', '', '', '0', '0', '0', '1', '0');
INSERT INTO `t_risk_control_edit_rules` VALUES ('2', '3', '0', '', '', '0', '', '', '1', '', '', '0', '0', '0', '1', '0');

-- ----------------------------
-- Table structure for t_risk_control_effect_rules
-- ----------------------------
DROP TABLE IF EXISTS `t_risk_control_effect_rules`;
CREATE TABLE `t_risk_control_effect_rules` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '规则ID',
  `sRuleName` varchar(50) NOT NULL DEFAULT '' COMMENT '规则名称',
  `sRuleContentCode` varchar(500) NOT NULL DEFAULT '' COMMENT 'sql形式规则内容',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='风控侦测生效规则表';

-- ----------------------------
-- Records of t_risk_control_effect_rules
-- ----------------------------
INSERT INTO `t_risk_control_effect_rules` VALUES ('2', '100AmontTest', 'select count(*) from t_mfts_trade t where (select count(*) from t_mfts_trade t1 where t1.iAmount<100 and t1.sUserName=@sUserName and t1.iAutoID<@iAutoID)>=3 and iAmount >=100 and t.sUserName=@sUserName and t.iAutoID=@iAutoID', '0', '0', '1', '0');
INSERT INTO `t_risk_control_effect_rules` VALUES ('3', 'cs', 'select count(*) from t_mfts_trade', '0', '0', '1', '0');

-- ----------------------------
-- Table structure for t_test
-- ----------------------------
DROP TABLE IF EXISTS `t_test`;
CREATE TABLE `t_test` (
  `iAutoId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iValue` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '年龄',
  `sName` varchar(60) NOT NULL DEFAULT '' COMMENT '姓名',
  `itset` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`iAutoId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='测试表';

-- ----------------------------
-- Records of t_test
-- ----------------------------
INSERT INTO `t_test` VALUES ('1', '123', '123', '1');
INSERT INTO `t_test` VALUES ('2', '123', '好的', '1');

-- ----------------------------
-- Table structure for t_user_lock
-- ----------------------------
DROP TABLE IF EXISTS `t_user_lock`;
CREATE TABLE `t_user_lock` (
  `iAutoID` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `iUserID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `iOperatorID` int(11) NOT NULL DEFAULT '0' COMMENT '操作员ID',
  `iCreateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `iUpdateTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `iStatus` int(2) NOT NULL DEFAULT '1' COMMENT '逻辑删除状态',
  `iDeleteTime` int(11) NOT NULL DEFAULT '0' COMMENT '逻辑删除时间',
  PRIMARY KEY (`iAutoID`),
  UNIQUE KEY `userIndex` (`iUserID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='用户锁定表';

-- ----------------------------
-- Records of t_user_lock
-- ----------------------------
INSERT INTO `t_user_lock` VALUES ('8', '3', '3', '1463046610', '0', '1', '0');
