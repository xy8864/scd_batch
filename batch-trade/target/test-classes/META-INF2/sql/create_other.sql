DROP TABLE IF EXISTS M_PRODUCT_RULE;
CREATE TABLE M_PRODUCT_RULE
(
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  PRODUCT_ID BIGINT NOT NULL COMMENT '基础产品ID',
  PRODUCT_NAME CHARACTER VARYING(32) NOT NULL COMMENT '基础产品名称',
  DESCRIPTION CHARACTER VARYING(500) NOT NULL COMMENT '描述',
  PRODUCT_NO BIGINT NOT NULL COMMENT '产品序号',
  PRODUCT_RULE_STATUS INT NOT NULL COMMENT '产品规则状态',
  ACCOUNT_TYPE INT NOT NULL COMMENT ' 账户类型',
  CYCLE_TYPE INT NOT NULL COMMENT '分期类型',
  CYCLE_COUNT INT NOT NULL COMMENT '分期期数',
  REPAY_MODE_ID BIGINT NOT NULL COMMENT '还款方式ID，关联息费模块还款方式表',
  INTEREST_RATE_ID BIGINT NOT NULL COMMENT '利息定价ID，关联息费模块利息定价表',
  CHARGES_RATE_ID BIGINT NOT NULL COMMENT '手续费定价ID，关联息费模块手续费定价表',
  PENALTY_RATE_ID BIGINT NOT NULL COMMENT '罚息定价ID，关联息费模块罚息定价表',
  OVERDUE_RATE_ID BIGINT NOT NULL COMMENT '滞纳金定价ID，关联息费模块滞纳金定价表',
  EXPENSE_RATE_ID BIGINT NOT NULL COMMENT '违约金定价ID，关联息费模块违约金定价表',
  MINI_REPAY_TYPE INT NOT NULL COMMENT '最小还款额方式',
  INTEREST_START_TYPE INT NOT NULL COMMENT '起息日规则',
  INTEREST_START_DAY INT NOT NULL COMMENT '起息日',
  CREDIT_LIMIT_RULE_ID BIGINT NOT NULL COMMENT '信用额度规则模板ID',
  PERIOD_GRACE INT NOT NULL COMMENT '宽限期，从还款日开始计算',
  MINI_REPAY_RATE INT NOT NULL COMMENT '最小还款比例，分母为10000',
  MINI_REPAY_AMOUNT INT NOT NULL COMMENT '最小还款金额',
  WRITE_OFF_RULE_ID BIGINT NOT NULL COMMENT '冲销顺序规则ID',
  BILL_DAY_RULE INT NOT NULL COMMENT '账单日规则',
  BILL_DAY INT NOT NULL COMMENT '账单日',
  REPAY_DAY_RULE INT NOT NULL COMMENT '还款日规则',
  CONSUME_INSTALLMENT_RULE INT NOT NULL COMMENT '消费分期规则',
  BILL_INSTALLMENT_RULE INT NOT NULL COMMENT '账单分期规则	',
  REPAY_DAY INT NOT NULL COMMENT '还款日',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  MODIFY_ID BIGINT NOT NULL COMMENT '修改人ID',
  START_DATE TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '有效期开始时间',
  END_DATE TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '有效期结束时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  CREATE_ID BIGINT NOT NULL COMMENT '创建人ID',
  VERIFIED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '审核时间',
  VERIFY_ID BIGINT NOT NULL COMMENT '审核人ID',
  PRIMARY KEY(ID)
)
  ENGINE = InnoDB COMMENT='产品规则表';

DROP TABLE IF EXISTS T_INSTALLMENT_SCHEDULE;
CREATE TABLE T_INSTALLMENT_SCHEDULE
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  LOAN_ID BIGINT NOT NULL COMMENT '借据号',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT NOT NULL COMMENT '账号ID',
  PRODUCT_ID BIGINT NOT NULL COMMENT '产品ID',
  PRODUCT_NO BIGINT NOT NULL COMMENT '产品序号',
  CONTRACT_ID BIGINT NOT NULL COMMENT '签约ID',
  INSTALLMENT_MADE_NO INT NOT NULL COMMENT '借据被分期序号',
  LOAN_SCHEDULE_NO INT NOT NULL COMMENT '借据期序号',
  ACCOUNT_DATE DATE NOT NULL COMMENT '账务日期',
  TRANSACTION_DATE DATE NOT NULL COMMENT '交易日期',
  DUE_DATE DATE NOT NULL COMMENT '到期日',
  GRACE_DATE DATE NOT NULL COMMENT '宽限日',
  STATUS INT NOT NULL COMMENT '还款计划状态',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '上一次交易流水ID',
  PRINCIPAL BIGINT NOT NULL COMMENT '本金总额',
  PRINCIPAL_REPAY BIGINT NOT NULL COMMENT '本金已还金额',
  PRINCIPAL_UNPAID BIGINT NOT NULL COMMENT '本金未还',
  INTEREST BIGINT NOT NULL COMMENT '利息总额',
  INTEREST_REPAY BIGINT NOT NULL COMMENT '利息已还金额',
  INTEREST_UNPAID BIGINT NOT NULL COMMENT '利息未还',
  CHARGES BIGINT NOT NULL COMMENT '费用总额',
  CHARGES_REPAY BIGINT NOT NULL COMMENT '费用已还金额',
  CHARGES_UNPAID BIGINT NOT NULL COMMENT '费用未还',
  PENALTY BIGINT NOT NULL COMMENT '罚息总额',
  PENALTY_REPAY BIGINT NOT NULL COMMENT '罚息已还金额',
  PENALTY_UNPAID BIGINT NOT NULL COMMENT '罚息未还',
  OVERDUE BIGINT NOT NULL COMMENT '逾期费总额',
  OVERDUE_REPAY BIGINT NOT NULL COMMENT '逾期费已还金额',
  OVERDUE_UNPAID BIGINT NOT NULL COMMENT '逾期费未还',
  VIOLATE BIGINT NOT NULL COMMENT '违约金总额',
  VIOLATE_REPAY BIGINT NOT NULL COMMENT '违约金已还金额',
  VIOLATE_UNPAID BIGINT NOT NULL COMMENT '违约金未还',
  ACCRUAL BIGINT COMMENT '当期计提',
  SECURITY_STATUS INT COMMENT '证券化状态',
  SECURITY_SALE_DATE DATE COMMENT '证券化销售日期',
  SECURITY_INSTITUTION_ID BIGINT COMMENT '证券化销售机构ID',
  PRIMARY KEY(ID),
  INDEX IDX_STATUS(STATUS),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_LOAN(LOAN_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID),
  INDEX IDX_GRACE_DATE(GRACE_DATE)
)
  ENGINE = InnoDB COMMENT='分期还款计划表';

DROP TABLE IF EXISTS T_LOAN;
CREATE TABLE T_LOAN
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  LOAN_ID BIGINT NOT NULL COMMENT '借据号',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT NOT NULL COMMENT '账号ID',
  PRODUCT_ID BIGINT NOT NULL COMMENT '产品ID',
  PRODUCT_NO BIGINT NOT NULL COMMENT '产品序号',
  CONTRACT_ID BIGINT NOT NULL COMMENT '签约ID',
  INSTALLMENT_COUNT INT NOT NULL COMMENT '分期期数',
  LOAN_AGE INT NOT NULL COMMENT '借据账龄',
  ACCOUNT_DATE DATE NOT NULL COMMENT '账务日期',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '上一次交易流水ID',
  INSTALLMENT_MADE_NO INT NOT NULL COMMENT '借据当前使用的被分期序号',
  INSTALLMENT_MADE_TIMES INT COMMENT '借据被分期的总次数',
  INTEREST_START_DATE DATE NOT NULL COMMENT '起息日期',
  LOAN_CHANNEL INT COMMENT '放款渠道',
  FINANCING_SOURCE BIGINT NOT NULL COMMENT '资金机构',
  REPAY_DAY INT NOT NULL COMMENT '还款日',
  GRACE_DAY INT NOT NULL COMMENT '宽限期',
  PRINCIPAL BIGINT NOT NULL COMMENT '本金总额',
  PRINCIPAL_REPAY BIGINT NOT NULL COMMENT '本金已还金额',
  PRINCIPAL_UNPAID BIGINT NOT NULL COMMENT '本金未还',
  INTEREST BIGINT NOT NULL COMMENT '利息总额',
  INTEREST_REPAY BIGINT NOT NULL COMMENT '利息已还金额',
  INTEREST_UNPAID BIGINT NOT NULL COMMENT '利息未还',
  INTEREST_MULTIPLIER BIGINT NOT NULL COMMENT '利息因子',
  CHARGES BIGINT NOT NULL COMMENT '费用总额',
  CHARGES_REPAY BIGINT NOT NULL COMMENT '费用已还金额',
  CHARGES_UNPAID BIGINT NOT NULL COMMENT '费用未还',
  CHARGES_MULTIPLIER BIGINT NOT NULL COMMENT '费用因子',
  PENALTY BIGINT NOT NULL COMMENT '罚息总额',
  PENALTY_REPAY BIGINT NOT NULL COMMENT '罚息已还金额',
  PENALTY_UNPAID BIGINT NOT NULL COMMENT '罚息未还',
  PENALTY_MULTIPLIER BIGINT NOT NULL COMMENT '罚息因子',
  OVERDUE BIGINT NOT NULL COMMENT '滞纳金总额',
  OVERDUE_REPAY BIGINT NOT NULL COMMENT '滞纳金已还金额',
  OVERDUE_UNPAID BIGINT NOT NULL COMMENT '滞纳金未还',
  OVERDUE_MULTIPLIER BIGINT NOT NULL COMMENT '滞纳金因子',
  VIOLATE BIGINT NOT NULL COMMENT '违约金总额',
  VIOLATE_REPAY BIGINT NOT NULL COMMENT '违约金已还金额',
  VIOLATE_UNPAID BIGINT NOT NULL COMMENT '违约金未还',
  VIOLATE_MULTIPLIER BIGINT NOT NULL COMMENT '违约金因子',
  DISCOUNT BIGINT NOT NULL COMMENT '贴息总额',
  IS_DISCOUNT_REFUND INT NOT NULL COMMENT '退款时是否退贴息',
  DISCOUNT_REFUND BIGINT COMMENT '退款时退贴息的金额',
  LOAN_STATUS INT NOT NULL COMMENT '贷款状态',
  ACCOUNTING_PRINCIPAL BIGINT NOT NULL COMMENT '会计本金总额',
  IRR BIGINT NOT NULL COMMENT '内部收益率',
  WRITE_OFF_ID INT NOT NULL COMMENT '冲销方式',
  SECURITY_STATUS INT COMMENT '证券化状态',
  SECURITY_SALE_DATE DATE COMMENT '证券化销售日期',
  SECURITY_INSTITUTION_ID BIGINT COMMENT '证券化销售机构id',
  NOTES CHARACTER VARYING(32) COMMENT '摘要说明',
  APPLY_DATE DATE NOT NULL COMMENT '申请日期',
  CONFIRM_DATE DATE COMMENT '确认日期',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_LOAN(LOAN_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID)
)
  ENGINE = InnoDB COMMENT='借据表';

DROP TABLE IF EXISTS M_WRITE_OFF;
CREATE TABLE M_WRITE_OFF
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  WRITE_OFF_ID INT COMMENT '冲销顺序ID',
  WRITE_OFF_ORDER CHARACTER VARYING(32) NOT NULL COMMENT '冲销顺序',
  PRIMARY KEY(ID)
)
  ENGINE = InnoDB COMMENT='冲销顺序表';

DROP TABLE IF EXISTS T_BILL;
CREATE TABLE T_BILL
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  BILL_ID BIGINT COMMENT '账单ID',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT NOT NULL COMMENT '账号ID',
  PRODUCT_ID BIGINT COMMENT '产品ID',
  PRODUCT_NO BIGINT COMMENT '产品序号',
  ACCOUNT_DATE DATE NOT NULL COMMENT '帐务日期',
  BILL_DATE DATE NOT NULL COMMENT '账单日',
  DUE_DATE DATE NOT NULL COMMENT '到期还款日',
  PRINCIPAL BIGINT NOT NULL COMMENT '本金总金额',
  PRINCIPAL_REPAID BIGINT NOT NULL COMMENT '本金已还金额',
  PRINCIPAL_UNPAID BIGINT NOT NULL COMMENT '本金未还金额',
  CHARGES BIGINT NOT NULL COMMENT '费用总额',
  CHARGES_REPAID BIGINT NOT NULL COMMENT '费用已还金额',
  CHARGES_UNPAID BIGINT NOT NULL COMMENT '费用未还金额',
  PENALTY BIGINT NOT NULL COMMENT '罚息总额',
  PENALTY_REPAID BIGINT NOT NULL COMMENT '罚息已还金额',
  PENALTY_UNPAID BIGINT NOT NULL COMMENT '罚息未还金额',
  OVERDUE BIGINT NOT NULL COMMENT '逾期费总额',
  OVERDUE_REPAID BIGINT NOT NULL COMMENT '逾期费已还金额',
  OVERDUE_UNPAID BIGINT NOT NULL COMMENT '逾期费未还金额',
  VIOLATE BIGINT COMMENT '违约金总额',
  VIOLATE_REPAID BIGINT NOT NULL COMMENT '违约金已还金额',
  VIOLATE_UNPAID BIGINT COMMENT '违约金未还金额',
  MIN_REPAY BIGINT COMMENT '最小还款额',
  REPAY_STATUS INT NOT NULL COMMENT '还款状态',
  OVERDUE_STATUS INT NOT NULL COMMENT '逾期状态',
  INSTALLMENT_STATUS INT NOT NULL COMMENT '转分期状态',
  WRITE_OFF_ID INT NOT NULL COMMENT '冲销方式',
  REPAY_DATE DATE COMMENT '还款日期',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID),
  INDEX IDX_BILL(BILL_ID)
)
  ENGINE = InnoDB COMMENT='账单表';

DROP TABLE IF EXISTS T_CONSUME;
CREATE TABLE T_CONSUME
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT COMMENT '账号ID',
  PRODUCT_ID BIGINT COMMENT '产品ID',
  PRODUCT_NO BIGINT COMMENT '产品序号',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '交易ID',
  CONSUME_ID BIGINT NOT NULL COMMENT '消费明细ID',
  BILL_ID BIGINT COMMENT '对应账单ID',
  TRANSACTION_DATE DATE NOT NULL COMMENT '交易发起日期',
  TRANSACTION_CONFIRMED_DATE DATE COMMENT '交易确认日期',
  TRANSACTION_CANCELLED_DATE DATE COMMENT '交易取消日期',
  BILL_DATE DATE NOT NULL COMMENT '账单日期',
  REPAY_DATE DATE NOT NULL COMMENT '还款日期',
  CONSUME_AMOUNT BIGINT NOT NULL COMMENT '交易总额',
  CONSUME_STATUS INT NOT NULL COMMENT '消费状态',
  REPAID_AMOUNT BIGINT COMMENT '已还金额',
  BILL_STATUS INT NOT NULL COMMENT '账单状态',
  INSTALLMENT_STATUS INT NOT NULL COMMENT '分期状态',
  INSTALLMENT_BILL_ID BIGINT COMMENT '转分期的分期账单id',
  NOTES CHARACTER VARYING(32) COMMENT '摘要说明',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_COSUME(CONSUME_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID)
)
  ENGINE = InnoDB COMMENT='信用消费明细表';

DROP TABLE IF EXISTS T_CREDIT_INSTALLMENT;
CREATE TABLE T_CREDIT_INSTALLMENT
(
  MODIFIED TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  INSTALLMENT_TYPE INT COMMENT '分期类型',
  BILL_ID BIGINT COMMENT '账单ID',
  CONSUME_ID BIGINT COMMENT '消费ID',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT NOT NULL COMMENT '账号ID',
  PRODUCT_ID BIGINT COMMENT '产品ID',
  PRODUCT_NO BIGINT COMMENT '产品序号',
  INSTALLMENT_COUNT INT COMMENT '总分期数',
  INSTALLMENT_NO INT COMMENT '分期序号',
  ACCOUNT_DATE DATE NOT NULL COMMENT '帐务日期',
  BILL_DATE DATE NOT NULL COMMENT '账单日',
  DUE_DATE DATE NOT NULL COMMENT '到期还款日',
  PRINCIPAL BIGINT NOT NULL COMMENT '本金总金额',
  PRINCIPAL_REPAID BIGINT NOT NULL COMMENT '本金已还金额',
  PRINCIPAL_UNPAID BIGINT NOT NULL COMMENT '本金未还金额',
  CHARGES BIGINT NOT NULL COMMENT '费用总额',
  CHARGES_REPAID BIGINT NOT NULL COMMENT '费用已还金额',
  CHARGES_UNPAID BIGINT NOT NULL COMMENT '费用未还金额',
  PENALTY BIGINT NOT NULL COMMENT '罚息总额',
  PENALTY_REPAID BIGINT NOT NULL COMMENT '罚息已还金额',
  PENALTY_UNPAID BIGINT NOT NULL COMMENT '罚息未还金额',
  OVERDUE BIGINT NOT NULL COMMENT '逾期费总额',
  OVERDUE_REPAID BIGINT NOT NULL COMMENT '逾期费已还金额',
  OVERDUE_UNPAID BIGINT NOT NULL COMMENT '逾期费未还金额',
  VIOLATE BIGINT COMMENT '违约金总额',
  VIOLATE_REPAID BIGINT NOT NULL COMMENT '违约金已还金额',
  VIOLATE_UNPAID BIGINT COMMENT '违约金未还金额',
  REPAID_STATUS INT NOT NULL COMMENT '还款状态',
  INSTALLMENT_STATUS INT NOT NULL COMMENT '信用支付分期状态',
  PRIMARY KEY(ID),
  INDEX IDX_COSUME(CONSUME_ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID),
  INDEX IDX_BILL(BILL_ID)
)
  ENGINE = InnoDB COMMENT='信用支付分期表';

DROP TABLE IF EXISTS T_CUSTOMER_SIGN_CONTRACT;
CREATE TABLE T_CUSTOMER_SIGN_CONTRACT
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT COMMENT '账号ID',
  PRODUCT_ID BIGINT COMMENT '产品ID',
  PRODUCT_NO BIGINT COMMENT '产品序号',
  CONTRACT_ID BIGINT NOT NULL COMMENT '签约ID',
  M_INTEREST INT NOT NULL COMMENT '定价因子：利息',
  M_CHARGES INT NOT NULL COMMENT '定价因子：费用',
  M_PENALTY INT NOT NULL COMMENT '定价因子：罚息',
  M_OVERDUE INT NOT NULL COMMENT '定价因子：逾期费',
  M_VIOLATE INT NOT NULL COMMENT '定价因子：违约金',
  M_DISCOUNT INT NOT NULL COMMENT '定价因子：贴息',
  CONTRACT_STATUS INT NOT NULL COMMENT '签约状态',
  BILL_DAY_RULE INT NOT NULL COMMENT '账单日规则',
  BILL_DAY INT COMMENT '账单日',
  REPAY_DAY_RULE INT NOT NULL COMMENT '还款日规则',
  REPAY_DAY INT COMMENT '还款日',
  GRACE_DAY INT COMMENT '宽限期',
  INTEREST_START_TYPE INT COMMENT '起息日类型',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID)
)
  ENGINE = InnoDB COMMENT='客户签约表';

DROP TABLE IF EXISTS T_INSTALLMENT_SCHEDULE;
CREATE TABLE T_INSTALLMENT_SCHEDULE
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  LOAN_ID BIGINT NOT NULL COMMENT '借据号',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT NOT NULL COMMENT '账号ID',
  PRODUCT_ID BIGINT NOT NULL COMMENT '产品ID',
  PRODUCT_NO BIGINT NOT NULL COMMENT '产品序号',
  CONTRACT_ID BIGINT NOT NULL COMMENT '签约ID',
  INSTALLMENT_MADE_NO INT NOT NULL COMMENT '借据被分期序号',
  LOAN_SCHEDULE_NO INT NOT NULL COMMENT '借据期序号',
  ACCOUNT_DATE DATE NOT NULL COMMENT '账务日期',
  TRANSACTION_DATE DATE NOT NULL COMMENT '交易日期',
  DUE_DATE DATE NOT NULL COMMENT '到期日',
  GRACE_DATE DATE NOT NULL COMMENT '宽限日',
  STATUS INT NOT NULL COMMENT '还款计划状态',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '上一次交易流水ID',
  PRINCIPAL BIGINT NOT NULL COMMENT '本金总额',
  PRINCIPAL_REPAY BIGINT NOT NULL COMMENT '本金已还金额',
  PRINCIPAL_UNPAID BIGINT NOT NULL COMMENT '本金未还',
  INTEREST BIGINT NOT NULL COMMENT '利息总额',
  INTEREST_REPAY BIGINT NOT NULL COMMENT '利息已还金额',
  INTEREST_UNPAID BIGINT NOT NULL COMMENT '利息未还',
  CHARGES BIGINT NOT NULL COMMENT '费用总额',
  CHARGES_REPAY BIGINT NOT NULL COMMENT '费用已还金额',
  CHARGES_UNPAID BIGINT NOT NULL COMMENT '费用未还',
  PENALTY BIGINT NOT NULL COMMENT '罚息总额',
  PENALTY_REPAY BIGINT NOT NULL COMMENT '罚息已还金额',
  PENALTY_UNPAID BIGINT NOT NULL COMMENT '罚息未还',
  OVERDUE BIGINT NOT NULL COMMENT '逾期费总额',
  OVERDUE_REPAY BIGINT NOT NULL COMMENT '逾期费已还金额',
  OVERDUE_UNPAID BIGINT NOT NULL COMMENT '逾期费未还',
  VIOLATE BIGINT NOT NULL COMMENT '违约金总额',
  VIOLATE_REPAY BIGINT NOT NULL COMMENT '违约金已还金额',
  VIOLATE_UNPAID BIGINT NOT NULL COMMENT '违约金未还',
  ACCRUAL BIGINT COMMENT '当期计提',
  SECURITY_STATUS INT COMMENT '证券化状态',
  SECURITY_SALE_DATE DATE COMMENT '证券化销售日期',
  SECURITY_INSTITUTION_ID BIGINT COMMENT '证券化销售机构ID',
  PRIMARY KEY(ID),
  INDEX IDX_STATUS(STATUS),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_LOAN(LOAN_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID),
  INDEX IDX_GRACE_DATE(GRACE_DATE)
)
  ENGINE = InnoDB COMMENT='分期还款计划表';

DROP TABLE IF EXISTS H_BILL_OPERATION;
CREATE TABLE H_BILL_OPERATION
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '交易流水ID',
  BILL_ID BIGINT NOT NULL COMMENT '账单ID',
  CUSTOMER_ID BIGINT COMMENT '客户ID',
  ACCOUNT_ID BIGINT COMMENT '账号ID',
  OPERATION INT NOT NULL COMMENT '操作类型',
  ORIGINAL_REPAY_STATUS INT NOT NULL COMMENT '变更前还款状态',
  NEW_REPAY_STATUS INT NOT NULL COMMENT '变更后还款状态',
  ORIGINAL_TOTAL_PRINCIPAL BIGINT NOT NULL COMMENT '变更前本金总额',
  NEW_TOTAL_PRINCIPAL BIGINT NOT NULL COMMENT '变更后本金总额',
  ORIGINAL_REPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更前已还本金',
  NEW_REPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更后已还本金',
  ORIGINAL_UNPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更前未还本金',
  NEW_UNPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更后未还本金',
  ORIGINAL_TOTAL_INTEREST BIGINT NOT NULL COMMENT '变更前利息总额',
  NEW_TOTAL_INTEREST BIGINT NOT NULL COMMENT '变更后利息总额',
  ORIGINAL_REPAID_INTEREST BIGINT NOT NULL COMMENT '变更前已还利息',
  NEW_REPAID_INTEREST BIGINT NOT NULL COMMENT '变更后已还利息',
  ORIGINAL_UNPAID_INTEREST BIGINT NOT NULL COMMENT '变更前未还利息',
  NEW_UNPAID_INTEREST BIGINT NOT NULL COMMENT '变更后未还利息',
  ORIGINAL_TOTAL_CHARGES BIGINT NOT NULL COMMENT '变更前费用总额',
  NEW_TOTAL_CHARGES BIGINT NOT NULL COMMENT '变更后费用总额',
  ORIGINAL_REPAID_CHARGES BIGINT NOT NULL COMMENT '变更前已还金额',
  NEW_REPAID_CHARGES BIGINT NOT NULL COMMENT '变更后已还金额',
  ORIGINAL_UNPAID_CHARGES BIGINT NOT NULL COMMENT '变更前未还金额',
  NEW_UNPAID_CHARGES BIGINT NOT NULL COMMENT '变更后未还金额',
  ORIGINAL_TOTAL_PENALTY BIGINT NOT NULL COMMENT '变更前罚息总额',
  NEW_TOTAL_PENALTY BIGINT NOT NULL COMMENT '变更后费用罚息',
  ORIGINAL_REPAID_PENALTY BIGINT NOT NULL COMMENT '变更前已还罚息',
  NEW_REPAID_PENALTY BIGINT NOT NULL COMMENT '变更后已还罚息',
  ORIGINAL_UNPAID_PENALTY BIGINT NOT NULL COMMENT '变更前未还罚息',
  NEW_UNPAID_PENALTY BIGINT NOT NULL COMMENT '变更后未还罚息',
  ORIGINAL_TOTAL_OVERDUE BIGINT NOT NULL COMMENT '变更前逾期费总额',
  NEW_TOTAL_OVERDUE BIGINT NOT NULL COMMENT '变更后逾期费总额',
  ORIGINAL_REPAID_OVERDUE BIGINT NOT NULL COMMENT '变更前已还逾期费',
  NEW_REPAID_OVERDUE BIGINT NOT NULL COMMENT '变更后已还逾期费',
  ORIGINAL_UNPAID_OVERDUE BIGINT NOT NULL COMMENT '变更前未还逾期费',
  NEW_UNPAID_OVERDUE BIGINT NOT NULL COMMENT '变更后未还逾期费',
  ORIGINAL_TOTAL_VIOLATE BIGINT NOT NULL COMMENT '变更前违约金总额',
  NEW_TOTAL_VIOLATE BIGINT NOT NULL COMMENT '变更后违约金总额',
  ORIGINAL_REPAID_VIOLATE BIGINT NOT NULL COMMENT '变更前已还违约金',
  NEW_REPAID_VIOLATE BIGINT NOT NULL COMMENT '变更后已还违约金',
  ORIGINAL_UNPAID_VIOLATE BIGINT NOT NULL COMMENT '变更前未还违约金',
  NEW_UNPAID_VIOLATE BIGINT NOT NULL COMMENT '变更后未还违约金',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID),
  INDEX IDX_BILL(BILL_ID)
)
  ENGINE = InnoDB COMMENT='账单操作流水表';

DROP TABLE IF EXISTS H_INSTALLMENT_SCHEDULE_OPERATION;
CREATE TABLE H_INSTALLMENT_SCHEDULE_OPERATION
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '交易流水ID',
  LOAN_ID BIGINT NOT NULL COMMENT '借据ID',
  SCHEDULE_NO INT NOT NULL COMMENT '分期序号',
  INSTALLMENT_MADE_NO INT NOT NULL COMMENT '借据被分期序号',
  CUSTOMER_ID BIGINT COMMENT '客户ID',
  ACCOUNT_ID BIGINT COMMENT '账号ID',
  OPERATION INT NOT NULL COMMENT '操作类型',
  ORIGINAL_STATUS INT NOT NULL COMMENT '变更前借据状态',
  NEW_STATUS INT NOT NULL COMMENT '变更后借据状态',
  ORIGINAL_TOTAL_PRINCIPAL BIGINT NOT NULL COMMENT '变更前本金总额',
  NEW_TOTAL_PRINCIPAL BIGINT NOT NULL COMMENT '变更后本金总额',
  ORIGINAL_REPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更前已还本金',
  NEW_REPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更后已还本金',
  ORIGINAL_UNPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更前未还本金',
  NEW_UNPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更后未还本金',
  ORIGINAL_TOTAL_INTEREST BIGINT NOT NULL COMMENT '变更前利息总额',
  NEW_TOTAL_INTEREST BIGINT NOT NULL COMMENT '变更后利息总额',
  ORIGINAL_REPAID_INTEREST BIGINT NOT NULL COMMENT '变更前已还利息',
  NEW_REPAID_INTEREST BIGINT NOT NULL COMMENT '变更后已还利息',
  ORIGINAL_UNPAID_INTEREST BIGINT NOT NULL COMMENT '变更前未还利息',
  NEW_UNPAID_INTEREST BIGINT NOT NULL COMMENT '变更后未还利息',
  ORIGINAL_TOTAL_CHARGES BIGINT NOT NULL COMMENT '变更前费用总额',
  NEW_TOTAL_CHARGES BIGINT NOT NULL COMMENT '变更后费用总额',
  ORIGINAL_REPAID_CHARGES BIGINT NOT NULL COMMENT '变更前已还金额',
  NEW_REPAID_CHARGES BIGINT NOT NULL COMMENT '变更后已还金额',
  ORIGINAL_UNPAID_CHARGES BIGINT NOT NULL COMMENT '变更前未还金额',
  NEW_UNPAID_CHARGES BIGINT NOT NULL COMMENT '变更后未还金额',
  ORIGINAL_TOTAL_PENALTY BIGINT NOT NULL COMMENT '变更前罚息总额',
  NEW_TOTAL_PENALTY BIGINT NOT NULL COMMENT '变更后费用罚息',
  ORIGINAL_REPAID_PENALTY BIGINT NOT NULL COMMENT '变更前已还罚息',
  NEW_REPAID_PENALTY BIGINT NOT NULL COMMENT '变更后已还罚息',
  ORIGINAL_UNPAID_PENALTY BIGINT NOT NULL COMMENT '变更前未还罚息',
  NEW_UNPAID_PENALTY BIGINT NOT NULL COMMENT '变更后未还罚息',
  ORIGINAL_TOTAL_OVERDUE BIGINT NOT NULL COMMENT '变更前滞纳金总额',
  NEW_TOTAL_OVERDUE BIGINT NOT NULL COMMENT '变更后滞纳金总额',
  ORIGINAL_REPAID_OVERDUE BIGINT NOT NULL COMMENT '变更前已还滞纳金',
  NEW_REPAID_OVERDUE BIGINT NOT NULL COMMENT '变更后已还滞纳金',
  ORIGINAL_UNPAID_OVERDUE BIGINT NOT NULL COMMENT '变更前未还滞纳金',
  NEW_UNPAID_OVERDUE BIGINT NOT NULL COMMENT '变更后未还滞纳金',
  ORIGINAL_TOTAL_VIOLATE BIGINT NOT NULL COMMENT '变更前违约金总额',
  NEW_TOTAL_VIOLATE BIGINT NOT NULL COMMENT '变更后违约金总额',
  ORIGINAL_REPAID_VIOLATE BIGINT NOT NULL COMMENT '变更前已还违约金',
  NEW_REPAID_VIOLATE BIGINT NOT NULL COMMENT '变更后已还违约金',
  ORIGINAL_UNPAID_VIOLATE BIGINT NOT NULL COMMENT '变更前未还违约金',
  NEW_UNPAID_VIOLATE BIGINT NOT NULL COMMENT '变更后未还违约金',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_LOAN(LOAN_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID)
)
  ENGINE = InnoDB COMMENT='贷款分期计划操作流水表';

DROP TABLE IF EXISTS H_LOAN_OPERATION;
CREATE TABLE H_LOAN_OPERATION
(
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  TRANSACTION_ID BIGINT NOT NULL COMMENT '交易流水ID',
  LOAN_ID BIGINT NOT NULL COMMENT '借据ID',
  CUSTOMER_ID BIGINT COMMENT '客户ID',
  ACCOUNT_ID BIGINT COMMENT '账号ID',
  OPERATION SMALLINT NOT NULL COMMENT '操作类型',
  ORIGINAL_DISCOUNT_REFUND BIGINT NOT NULL COMMENT '变更前退款时退贴息的金额',
  NEW_DISCOUNT_REFUND BIGINT NOT NULL COMMENT '变更后退款时退贴息的金额',
  ORIGINAL_INSTALLMENT_MADE_NO INT NOT NULL COMMENT '变更前被分期序号',
  NEW_INSTALLMENT_MADE_NO INT NOT NULL COMMENT '变更后被分期序号',
  ORIGINAL_STATUS INT NOT NULL COMMENT '变更前借据状态',
  NEW_STATUS INT NOT NULL COMMENT '变更后借据状态',
  ORIGINAL_TOTAL_PRINCIPAL BIGINT NOT NULL COMMENT '变更前本金总额',
  NEW_TOTAL_PRINCIPAL BIGINT NOT NULL COMMENT '变更后本金总额',
  ORIGINAL_REPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更前已还本金',
  NEW_REPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更后已还本金',
  ORIGINAL_UNPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更前未还本金',
  NEW_UNPAID_PRINCIPAL BIGINT NOT NULL COMMENT '变更后未还本金',
  ORIGINAL_TOTAL_INTEREST BIGINT NOT NULL COMMENT '变更前利息总额',
  NEW_TOTAL_INTEREST BIGINT NOT NULL COMMENT '变更后利息总额',
  ORIGINAL_REPAID_INTEREST BIGINT NOT NULL COMMENT '变更前已还利息',
  NEW_REPAID_INTEREST BIGINT NOT NULL COMMENT '变更后已还利息',
  ORIGINAL_UNPAID_INTEREST BIGINT NOT NULL COMMENT '变更前未还利息',
  NEW_UNPAID_INTEREST BIGINT NOT NULL COMMENT '变更后未还利息',
  ORIGINAL_TOTAL_CHARGES BIGINT NOT NULL COMMENT '变更前费用总额',
  NEW_TOTAL_CHARGES BIGINT NOT NULL COMMENT '变更后费用总额',
  ORIGINAL_REPAID_CHARGES BIGINT NOT NULL COMMENT '变更前已还金额',
  NEW_REPAID_CHARGES BIGINT NOT NULL COMMENT '变更后已还金额',
  ORIGINAL_UNPAID_CHARGES BIGINT NOT NULL COMMENT '变更前未还金额',
  NEW_UNPAID_CHARGES BIGINT NOT NULL COMMENT '变更后未还金额',
  ORIGINAL_TOTAL_PENALTY BIGINT NOT NULL COMMENT '变更前罚息总额',
  NEW_TOTAL_PENALTY BIGINT NOT NULL COMMENT '变更后费用罚息',
  ORIGINAL_REPAID_PENALTY BIGINT NOT NULL COMMENT '变更前已还罚息',
  NEW_REPAID_PENALTY BIGINT NOT NULL COMMENT '变更后已还罚息',
  ORIGINAL_UNPAID_PENALTY BIGINT NOT NULL COMMENT '变更前未还罚息',
  NEW_UNPAID_PENALTY BIGINT NOT NULL COMMENT '变更后未还罚息',
  ORIGINAL_TOTAL_OVERDUE BIGINT NOT NULL COMMENT '变更前逾期费总额',
  NEW_TOTAL_OVERDUE BIGINT NOT NULL COMMENT '变更后逾期费总额',
  ORIGINAL_REPAID_OVERDUE BIGINT NOT NULL COMMENT '变更前已还逾期费',
  NEW_REPAID_OVERDUE BIGINT NOT NULL COMMENT '变更后已还逾期费',
  ORIGINAL_UNPAID_OVERDUE BIGINT NOT NULL COMMENT '变更前未还逾期费',
  NEW_UNPAID_OVERDUE BIGINT NOT NULL COMMENT '变更后未还逾期费',
  ORIGINAL_TOTAL_VIOLATE BIGINT NOT NULL COMMENT '变更前违约金总额',
  NEW_TOTAL_VIOLATE BIGINT NOT NULL COMMENT '变更后违约金总额',
  ORIGINAL_REPAID_VIOLATE BIGINT NOT NULL COMMENT '变更前已还违约金',
  NEW_REPAID_VIOLATE BIGINT NOT NULL COMMENT '变更后已还违约金',
  ORIGINAL_UNPAID_VIOLATE BIGINT NOT NULL COMMENT '变更前未还违约金',
  NEW_UNPAID_VIOLATE BIGINT NOT NULL COMMENT '变更后未还违约金',
  ORIGINAL_PROD_NO BIGINT NOT NULL COMMENT '变更前产品序号',
  NEW_PROD_NO BIGINT NOT NULL COMMENT '变更后产品序号',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID),
  INDEX IDX_LOAN(LOAN_ID),
  INDEX IDX_ACCOUNT(ACCOUNT_ID)
)
  ENGINE = InnoDB COMMENT='贷款借据操作流水表';

DROP TABLE IF EXISTS M_PRODUCT_INFO;
CREATE TABLE M_PRODUCT_INFO
(
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  PRODUCT_ID BIGINT NOT NULL COMMENT '基础产品ID',
  PRODUCT_NAME CHARACTER VARYING(32) NOT NULL COMMENT '基础产品名称',
  ACCOUNT_TYPE INT NOT NULL COMMENT '账户类型',
  DESCRIPTION CHARACTER VARYING(200) NOT NULL COMMENT '描述',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  VERIFIED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '审核时间',
  CREATE_ID BIGINT NOT NULL COMMENT '创建人ID',
  MODIFY_ID BIGINT NOT NULL COMMENT '修改人ID',
  VERIFY_ID BIGINT NOT NULL COMMENT '审核人ID',
  PRIMARY KEY(ID)
)
  ENGINE = InnoDB COMMENT='产品定义表';

DROP TABLE IF EXISTS M_PRICING_METHOD;
CREATE TABLE M_PRICING_METHOD
(
  STATUS INT NOT NULL COMMENT '状态',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  PRICING_METHOD_ID BIGINT NOT NULL COMMENT '定价方式ID',
  PRICING_METHOD_NAME CHARACTER VARYING(150) NOT NULL COMMENT '定价方式名称',
  PRICING_TYPE INT NOT NULL COMMENT '定价类型',
  PRICING_MODE INT NOT NULL COMMENT '定价计算规则',
  FIXED_AMOUNT BIGINT NOT NULL COMMENT '固定收取金额',
  MIN_AMOUNT BIGINT NOT NULL COMMENT '最小收取金额',
  PERCENT_VALUE INT NOT NULL COMMENT '利率',
  PRINCIPAL_MODE INT NOT NULL COMMENT '本金处理方式',
  YMD_FLAG INT NOT NULL COMMENT '年月日标志',
  YEAR_BASE_DAY INT NOT NULL COMMENT '年基准天数',
  MONTH_BASE_DAY INT NOT NULL COMMENT '月基准天数',
  PRIMARY KEY(ID),
  INDEX IDX_PRICE(PRICING_METHOD_ID)
)
  ENGINE = InnoDB COMMENT='息费定价方式表';

DROP TABLE IF EXISTS T_CUSTOMER_ACCOUNT;
CREATE TABLE T_CUSTOMER_ACCOUNT
(
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  ACCOUNT_ID BIGINT NOT NULL COMMENT '账号ID',
  ACCOUNT_TYPE INT NOT NULL COMMENT '账号类型',
  ACCOUNT_AGING INT NOT NULL COMMENT '账号账龄',
  CUSTOMER_ACCOUNT_STATUS INT NOT NULL COMMENT '账号状态',
  DEBIT_STATUS INT NOT NULL COMMENT '借贷状态',
  PRINCIPAL BIGINT COMMENT '本金余额',
  PRINCIPAL_USABLE BIGINT COMMENT '可用本金余额',
  PRINCIPAL_FREEZE BIGINT COMMENT '冻结本金金额',
  PRINCIPAL_TRANSIT BIGINT COMMENT '在途本金余额',
  INTEREST BIGINT COMMENT '利息余额',
  INTEREST_USABLE BIGINT COMMENT '可用利息余额',
  INTEREST_FREEZE BIGINT COMMENT '冻结利息金额',
  INTEREST_TRANSIT BIGINT COMMENT '在途利息余额',
  CHARGES BIGINT COMMENT '费用余额',
  CHARGES_USABLE BIGINT COMMENT '可用费用余额',
  CHARGES_FREEZE BIGINT COMMENT '冻结费用金额',
  CHARGES_TRANSIT BIGINT COMMENT '在途费用余额',
  PENALTY BIGINT COMMENT '罚息余额',
  PENALTY_USABLE BIGINT COMMENT '可用罚息余额',
  PENALTY_FREEZE BIGINT COMMENT '冻结罚息金额',
  PENALTY_TRANSIT BIGINT COMMENT '在途罚息余额',
  OVERDUE BIGINT COMMENT '滞纳金余额',
  OVERDUE_USABLE BIGINT COMMENT '可用滞纳金余额',
  OVERDUE_FREEZE BIGINT COMMENT '冻结滞纳金金额',
  OVERDUE_TRANSIT BIGINT COMMENT '在途滞纳金余额',
  VIOLATE BIGINT COMMENT '违约金余额',
  VIOLATE_USABLE BIGINT COMMENT '可用违约金余额',
  VIOLATE_FREEZE BIGINT COMMENT '冻结违约金金额',
  VIOLATE_TRANSIT BIGINT COMMENT '在途违约金余额',
  ID_GENERATE_DATE DATE NOT NULL COMMENT '客户ID生成时间',
  DELETE_FLAG INT COMMENT '记录物理状态',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  PRIMARY KEY(ID),
  INDEX IDX_CUSTOMER(CUSTOMER_ID)
)
  ENGINE = InnoDB COMMENT='客户账号信息表';

DROP TABLE IF EXISTS T_CUSTOMER_INFO;
CREATE TABLE T_CUSTOMER_INFO
(
  ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
  CERTIFICATE_TYPE INT NOT NULL COMMENT '证件类型',
  CERTIFICATE_ID CHARACTER VARYING(32) NOT NULL COMMENT '证件号码',
  TELEPHONE_NO CHARACTER VARYING(16) COMMENT '电话号码',
  CUSTOMER_STATUS INT COMMENT '客户状态',
  DEBIT_STATUS INT NOT NULL COMMENT '借贷状态',
  CUSTOMER_GRADE INT COMMENT '客户等级',
  CUSTOMER_NAME CHARACTER VARYING(64) NOT NULL COMMENT '客户姓名',
  ID_GENERATE_DATE DATE NOT NULL COMMENT '客户ID生成日期',
  DELETE_FLAG INT NOT NULL COMMENT '逻辑删除标记',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '创建时间',
  PRIMARY KEY(ID)
)
  ENGINE = InnoDB COMMENT='客户信息表';

DROP TABLE IF EXISTS M_CREDIT_LIMIT_CONTROL;
CREATE TABLE M_CREDIT_LIMIT_CONTROL (
  ID BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '',
  CONTROL_ID BIGINT NOT NULL COMMENT '',
  UP_PROPAGATE_TYPE INT NOT NULL COMMENT '',
  LOOP_FLAG INT NOT NULL COMMENT '',
  RELEASE_MODE INT NOT NULL COMMENT '',
  MODIFIED TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  CREATED TIMESTAMP NOT NULL DEFAULT '2000-01-01 00:00:01' COMMENT '',
  STATUS INT NOT NULL COMMENT ''
)
  ENGINE = InnoDB COMMENT = '信用额度控制表';

