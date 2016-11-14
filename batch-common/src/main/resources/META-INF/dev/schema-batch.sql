

DROP TABLE IF EXISTS DAY_CUT_INFO;
CREATE TABLE DAY_CUT_INFO (
  ID INT primary key NOT NULL AUTO_INCREMENT,
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01',
  ACCOUNT_DATE DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS DAY_CUT_INFO_HIST;
CREATE TABLE DAY_CUT_INFO_HIST (
  ID INT  primary key NOT NULL AUTO_INCREMENT,
  DAY_CUT_MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  DAY_CUT_CREATED TIMESTAMP NOT NULL DEFAULT '2010-01-01 00:00:00',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01',
  ACCOUNT_DATE DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS T_BATCH_RESULT;
CREATE TABLE T_BATCH_RESULT (
  ID INT  primary key NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录修改时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '记录创建时间',
  BATCH_STATUS INT NOT NULL DEFAULT '0' COMMENT '跑批状态: 1-跑批结束, 2-正在跑批',
  ACCOUNT_DATE DATE NOT NULL DEFAULT '2010-01-01' COMMENT '账务日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS T_JOB;
CREATE TABLE T_JOB (
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录修改时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2010-01-01 00:00:00' COMMENT '记录创建时间',
  ID INT primary key NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  PHASE INT NOT NULL COMMENT '处理阶段',
  PHASE_STATUS INT NOT NULL COMMENT '阶段状态',
  RETRY_TIME INT NOT NULL COMMENT '重试次数',
  CHECK_POINT INT NOT NULL COMMENT '失败时恢复点',
  JOB_TYPE INT NOT NULL COMMENT '任务类型',
  DATABASE_ID VARCHAR(255) NOT NULL COMMENT '分库号',
  TABLE_ID VARCHAR(255) NOT NULL COMMENT '分表号',
  UUID VARCHAR(255) NOT NULL COMMENT '运行该任务的处理机UUID',
  ACCOUNT_DATE DATE NOT NULL COMMENT '账务日期',
  START_TIME TIMESTAMP NOT NULL DEFAULT '2010-01-01 00:00:00' COMMENT '任务运行开始时间',
  END_TIME TIMESTAMP NOT NULL DEFAULT '2010-01-01 00:00:00' COMMENT '任务运行结束时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS H_JOB;
CREATE TABLE `H_JOB` (
  `ID` bigint(20) UNSIGNED NOT NULL  COMMENT '任务ID',
  `REMAINDER` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '任务分片 Hash 余数',
  `DIVISOR` int(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT '任务分片 Hash 除数',
  `JOB_STATUS` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '任务状态:1-INIT, 2-PROCESSING, 3-FAIL, 4-DONE',
  `JOB_TYPE` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '任务类型:1-LOAN,2-CREDIT,3-PRE(任务清理,任务分配,日切,全局唯一任务)',
  `RETRY_TIME` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '任务失败重试次数',
  `DATABASE_ID` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '分库名字(后缀)',
  `TABLE_ID` VARCHAR(64) NOT NULL DEFAULT '' COMMENT '分表名字(后缀)',
  `JOB_UUID` varchar(64) NOT NULL DEFAULT '' COMMENT '任务处理机唯一ID',
  `STATUS` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '记录状态:0-正常, 1-不可用',
  `ACCOUNT_DATE` date NOT NULL default '0000-00-00' COMMENT '账务日期',
  `MODIFIED` timestamp NOT NULL COMMENT '记录修改时间',
  `START_TIME` timestamp NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '任务开始时间',
  `END_TIME` timestamp NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '任务结束时间',
  `CREATED` timestamp NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '记录创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS M_WORKER_NODE;
CREATE TABLE M_WORKER_NODE (
  ID BIGINT primary key NOT NULL AUTO_INCREMENT,
  HOST_NAME VARCHAR(64) NOT NULL,
  PORT VARCHAR(64) NOT NULL,
  TYPE INT NOT NULL,
  LAUNCH_DATE DATE NOT NULL,
  MODIFIED TIMESTAMP,
  CREATED TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS T_FAIL_RECORD;
CREATE TABLE `T_FAIL_RECORD` (
  `ID` BIGINT UNSIGNED  NOT NULL COMMENT '自增主键',
  `FAILURE_ID` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败类型对应的 ID, 比如客户失败则记录失败客户ID',
  `FAILURE_TYPE` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败类型',
  `JOB_ID` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '来自 T_JOB 表的主键',
  `JOB_UUID` varchar(64) NOT NULL DEFAULT '' COMMENT 'JOB 的 UUID',
  `ACCOUNT_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '账务日期',
  `CREATED` timestamp NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '记录创建时间',
  `MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录修改时间',
  `STATUS` TINYINT UNSIGNED NOT NULL DEFAULT '0' COMMENT '失败状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '失败记录表';




DROP TABLE IF EXISTS `s_assetsstat`;
CREATE TABLE `s_assetsstat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL COMMENT '日期',
  `CURRENT` double DEFAULT NULL COMMENT '流动性产品',
  `FIX_PLAN` double DEFAULT NULL COMMENT '定期计划',
  `FIX_PROJECT` double DEFAULT NULL COMMENT '定期项目',
  `BALANCE` double DEFAULT NULL COMMENT '财主账户余额',
  `FROZEN` double DEFAULT NULL COMMENT '冻结金额',
  `VERSION` int(11) DEFAULT NULL COMMENT '版本',
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '平台资产管理规模报表';


DROP TABLE IF EXISTS `s_borrowerrepayplan`;
CREATE TABLE `s_borrowerrepayplan` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DUE_DATE` date NOT NULL COMMENT '到期日',
  `BORROWER_ID` bigint(20) NOT NULL COMMENT '融资方ID',
  `BORROWER_NAME` varchar(256) NOT NULL COMMENT '融资方名称',
  `PROJECT_CODE` varchar(64) NOT NULL COMMENT '项目编号',
  `PROJECT_NAME` varchar(256) NOT NULL COMMENT '项目名称',
  `REPAY_TYPE` int(11) NOT NULL COMMENT '还款方式',
  `DUE_PRINCIPAL` double NOT NULL,
  `DUE_INTEREST` double NOT NULL,
  `DUE_SUM` double NOT NULL,
  `REPAY_PRINCIPAL` double NOT NULL,
  `REPAY_INTEREST` double NOT NULL,
  `REPAY_SUM` double NOT NULL,
  `VERSION` int(11) NOT NULL,
  `CREATED` timestamp NULL DEFAULT NULL,
  `MODIFIED` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `s_expenditurestat`;
CREATE TABLE `s_expenditurestat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `DATE` date NOT NULL COMMENT '日期',
  `TYPE` int(11) NOT NULL COMMENT '支出类型',
  `AMOUNT` double NOT NULL COMMENT '金额',
  `VERSION` int(11) NOT NULL COMMENT '版本',
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `s_fixproductduestat`;
CREATE TABLE `s_fixproductduestat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `DUE_DATE` date NOT NULL COMMENT '到期日期',
  `FIX_PLAN_PRINCIPAL` double NOT NULL COMMENT '定期计划到期本金',
  `FIX_PLAN_INTEREST` double NOT NULL COMMENT '定期计划到期利息',
  `FIX_PROJECT_PRINCIPAL` double NOT NULL COMMENT '定期项目到期本金',
  `FIX_PROJECT_INTEREST` double NOT NULL COMMENT '定期项目到期利息',
  `SUM_AMT` double NOT NULL COMMENT '总计',
  `VERSION` int(11) NOT NULL,
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `s_fundstat`;
CREATE TABLE `s_fundstat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECHARGE` double NOT NULL COMMENT '充值汇总金额',
  `WITHDRAW` double NOT NULL COMMENT '提现汇总金额',
  `TRANS_DATE` date NOT NULL COMMENT '业务日期',
  `VERSION` int(11) NOT NULL,
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `s_projectlimit`;
CREATE TABLE `s_projectlimit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROJECT_CODE` varchar(64) NOT NULL COMMENT '项目编号',
  `PROJECT_NAME` varchar(256) NOT NULL COMMENT '项目标的名称',
  `TOTAL` double NOT NULL COMMENT '项目计划融资额度',
  `BID` double NOT NULL COMMENT '已发标额度',
  `UNBID` double NOT NULL COMMENT '未发标额度',
  `WITHDRAW` double NOT NULL COMMENT '已提现金额',
  `PAID_PRINCIPAL` double NOT NULL COMMENT '已还本金',
  `UNPAID_PRINCIPAL` double NOT NULL,
  `PAID_INTEREST` double NOT NULL,
  `UNPAID_INTEREST` double NOT NULL,
  `VERSION` int(11) NOT NULL,
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `r_transfer_error`;
CREATE TABLE `r_transfer_error` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TRANS_ID` varchar(128) DEFAULT NULL COMMENT '业务日期',
  `TRANSFER_TYPE` smallint(6) DEFAULT NULL COMMENT '删除标记 0未删除，1删除',
  `ERROR_TYPE` smallint(6) DEFAULT NULL COMMENT '删除标记 0未删除，1删除',
  `A_VALUE` varchar(1024) DEFAULT NULL COMMENT '交易类型',
  `B_VALUE` varchar(1024) DEFAULT NULL COMMENT '订单号',
  `A_JSON` varchar(1024) DEFAULT NULL COMMENT '订单日期',
  `B_JSON` varchar(1024) DEFAULT NULL COMMENT '商户客户号',
  `ERROR_STATUS` smallint(6) DEFAULT NULL COMMENT '投资人客户号',
  `VERSION` smallint(6) DEFAULT NULL,
  `CREATED` timestamp NULL DEFAULT NULL,
  `MODIFIED` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `r_cash_transfer`;
CREATE TABLE `r_cash_transfer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TRANS_DATE` date DEFAULT NULL COMMENT '业务日期',
  `DELETE_FLAG` smallint(6) DEFAULT NULL COMMENT '删除标记 0未删除，1删除',
  `TRANSFER_TYPE` smallint(6) DEFAULT NULL COMMENT '交易类型',
  `ORD_ID` varchar(256) DEFAULT NULL COMMENT '订单号',
  `ORD_DATE` date DEFAULT NULL COMMENT '订单日期',
  `MER_CUST_ID` varchar(128) DEFAULT NULL COMMENT '商户客户号',
  `INVEST_CUST_ID` varchar(128) DEFAULT NULL COMMENT '投资人客户号',
  `BORR_CUST_ID` varchar(128) DEFAULT NULL COMMENT '借款人客户号',
  `TRANS_AMT` double(19,0) DEFAULT NULL COMMENT '交易金额',
  `PNR_DATE` date DEFAULT NULL COMMENT '汇付交易日期',
  `PNR_SEQ_ID` varchar(128) DEFAULT NULL COMMENT '汇付交易流水',
  `TRANS_STAT` varchar(16) DEFAULT NULL COMMENT '汇付取现交易状态',
  `FEE_OBJ_TYPE` varchar(64) DEFAULT NULL COMMENT '支付网关业务代号',
  `FEE_AMT` double(19,0) DEFAULT NULL COMMENT '手续费金额',
  `SERV_FEE` double(19,0) DEFAULT NULL COMMENT '手续费扣款客户号',
  `SERV_FEE_ACCTID` varchar(128) DEFAULT NULL COMMENT '手续费扣款子账户号',
  `VERSION` smallint(6) DEFAULT NULL,
  `CREATED` timestamp ,
  `MODIFIED` timestamp ,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `r_loanpayment_transfer`;
CREATE TABLE `r_loanpayment_transfer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TRANS_DATE` date DEFAULT NULL COMMENT '业务日期',
  `DELETE_FLAG` smallint(6) DEFAULT NULL COMMENT '删除标记 0未删除，1删除',
  `TRANSFER_TYPE` smallint(6) DEFAULT NULL COMMENT '交易类型',
  `ORD_ID` varchar(256) DEFAULT NULL COMMENT '订单号',
  `ORD_DATE` date DEFAULT NULL COMMENT '订单日期',
  `MER_CUST_ID` varchar(128) DEFAULT NULL COMMENT '商户客户号',
  `INVEST_CUST_ID` varchar(128) DEFAULT NULL COMMENT '投资人客户号',
  `BORR_CUST_ID` varchar(128) DEFAULT NULL COMMENT '借款人客户号',
  `TRANS_AMT` double(19,0) DEFAULT NULL COMMENT '交易金额',
  `PNR_DATE` date DEFAULT NULL COMMENT '汇付交易日期',
  `PNR_SEQ_ID` varchar(128) DEFAULT NULL COMMENT '汇付交易流水',
  `TRANS_STAT` varchar(16) DEFAULT NULL COMMENT '汇付取现交易状态',
  `VERSION` smallint(6) DEFAULT NULL,
  `CREATED` timestamp,
  `MODIFIED` timestamp,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `r_save_transfer`;
CREATE TABLE `r_save_transfer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TRANS_DATE` date DEFAULT NULL COMMENT '业务日期',
  `DELETE_FLAG` smallint(6) DEFAULT NULL COMMENT '删除标记 0未删除，1删除',
  `TRANSFER_TYPE` smallint(6) DEFAULT NULL COMMENT '交易类型',
  `ORD_ID` varchar(256) DEFAULT NULL COMMENT '订单号',
  `ORD_DATE` date DEFAULT NULL COMMENT '订单日期',
  `MER_CUST_ID` varchar(128) DEFAULT NULL COMMENT '商户客户号',
  `INVEST_CUST_ID` varchar(128) DEFAULT NULL COMMENT '投资人客户号',
  `BORR_CUST_ID` varchar(128) DEFAULT NULL COMMENT '借款人客户号',
  `TRANS_AMT` double(19,0) DEFAULT NULL COMMENT '交易金额',
  `PNR_DATE` date DEFAULT NULL COMMENT '汇付交易日期',
  `PNR_SEQ_ID` varchar(128) DEFAULT NULL COMMENT '汇付交易流水',
  `TRANS_STAT` varchar(16) DEFAULT NULL COMMENT '汇付取现交易状态',
  `GATE_BUSI_ID` varchar(128) DEFAULT NULL,
  `OPEN_BANK_ID` varchar(128) DEFAULT NULL,
  `OPEN_ACCT_ID` varchar(128) DEFAULT NULL,
  `FEE_AMT` double(19,0) DEFAULT NULL,
  `FEE_CUST_ID` varchar(128) DEFAULT NULL,
  `FEE_ACCT_ID` varchar(128) DEFAULT NULL,
  `VERSION` smallint(6) DEFAULT NULL,
  `CREATED` timestamp,
  `MODIFIED` timestamp,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `s_user_accumulative_profit`;
CREATE TABLE `s_user_accumulative_profit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` varchar(32) NOT NULL DEFAULT '' COMMENT '用户id',
  `total_profit` decimal(14,6) NOT NULL DEFAULT '0.000000' COMMENT '累计收益',
  `current_invest_profit` decimal(14,6) NOT NULL DEFAULT '0.000000' COMMENT '秒钱宝在投收益',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录生成时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录最近更改时间',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `s_user_daily_profit`;
CREATE TABLE `s_user_daily_profit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `uid` varchar(32) NOT NULL DEFAULT '' COMMENT '用户id',
  `date` varchar(16) NOT NULL DEFAULT '0000-00-00' COMMENT '收益日期',
  `profit` decimal(14,6) NOT NULL DEFAULT '0.000000' COMMENT '今日收益',
  `current_profit` decimal(14,6) NOT NULL DEFAULT '0.000000' COMMENT '秒钱宝收益',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录生成时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录最近更改时间',
  `version` int(11) NOT NULL DEFAULT '1' COMMENT '版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `s_user_assets`;
CREATE TABLE `s_user_assets` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UID` varchar(128) NOT NULL,
  `TRANS_DATE` date NOT NULL,
  `ASSET` double NOT NULL,
  `VERSION` int(11) DEFAULT NULL,
  `CREATED` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `r_balance`;
CREATE TABLE `r_balance` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_CUST_ID` varchar(64) NOT NULL,
  `AVL_BAL` double DEFAULT NULL,
  `ACCT_BAL` double DEFAULT NULL,
  `FRZ_BAL` double DEFAULT NULL,
  `VERSION` int(11) DEFAULT NULL,
  `CREATED` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `r_trf_transfer`;
CREATE TABLE `r_trf_transfer` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TRANS_DATE` date DEFAULT NULL COMMENT '业务日期',
  `DELETE_FLAG` smallint(6) DEFAULT NULL COMMENT '删除标记 0未删除，1删除',
  `TRANSFER_TYPE` smallint(6) DEFAULT NULL COMMENT '交易类型',
  `ORD_ID` varchar(256) DEFAULT NULL COMMENT '订单号',
  `ORD_DATE` date DEFAULT NULL COMMENT '订单日期',
  `MER_CUST_ID` varchar(128) DEFAULT NULL COMMENT '商户客户号',
  `INVEST_CUST_ID` varchar(128) DEFAULT NULL COMMENT '投资人客户号',
  `BORR_CUST_ID` varchar(128) DEFAULT NULL COMMENT '借款人客户号',
  `TRANS_AMT` double(19,0) DEFAULT NULL COMMENT '交易金额',
  `PNR_DATE` date DEFAULT NULL COMMENT '汇付交易日期',
  `PNR_SEQ_ID` varchar(128) DEFAULT NULL COMMENT '汇付交易流水',
  `TRANS_STAT` varchar(16) DEFAULT NULL COMMENT '汇付取现交易状态',
  `GATE_BUSI_ID` varchar(128) DEFAULT NULL,
  `OPEN_BANK_ID` varchar(128) DEFAULT NULL,
  `OPEN_ACCT_ID` varchar(128) DEFAULT NULL,
  `FEE_AMT` double(19,0) DEFAULT NULL,
  `FEE_CUST_ID` varchar(128) DEFAULT NULL,
  `FEE_ACCT_ID` varchar(128) DEFAULT NULL,
  `VERSION` smallint(6) DEFAULT NULL,
  `CREATED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MODIFIED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=329 DEFAULT CHARSET=utf8;


insert into DAY_CUT_INFO values(
1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_DATE
);

