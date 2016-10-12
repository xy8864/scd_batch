CREATE TABLE T_CUSTOMER_SIGN_CONTRACT
(
MODIFIED TIMESTAMP NOT NULL COMMENT '更新时间',
CREATED TIMESTAMP NOT NULL COMMENT '创建时间',
ID BIGINT NOT NULL AUTO_INCREMENT COMMENT '自增主键',
CUSTOMER_ID BIGINT NOT NULL COMMENT '客户ID',
ACCOUNT_ID BIGINT COMMENT '账号ID',
ACCOUNT_TYPE INT NOT NULL COMMENT '账号类型',
PRODUCT_ID BIGINT COMMENT '产品ID',
PRODUCT_NO BIGINT COMMENT '产品序号',
CONTRACT_ID BIGINT NOT NULL COMMENT '签约ID',
M_INTEREST INT NOT NULL COMMENT '定价因子：利息',
M_CHARGES INT NOT NULL COMMENT '定价因子：费用',
M_PENALTY INT NOT NULL COMMENT '定价因子：罚息',
M_OVERDUE INT NOT NULL COMMENT '定价因子：逾期费',
M_VIOLATE INT NOT NULL COMMENT '定价因子：违约金',
CONTRACT_STATUS INT NOT NULL COMMENT '签约状态',
BILL_DAY_RULE INT NOT NULL COMMENT '账单日规则',
BILL_DAY INT COMMENT '账单日',
REPAY_DAY_RULE INT NOT NULL COMMENT '还款日规则',
REPAY_DAY VARCHAR(50) COMMENT '还款日',
GRACE_DAY INT COMMENT '宽限期',
INTEREST_START_TYPE INT COMMENT '起息日类型',
PRIMARY KEY(ID),
INDEX IDX_CUSTOMER(CUSTOMER_ID),
INDEX IDX_ACCOUNT(ACCOUNT_ID),
UNIQUE IDX_CONTRACT(CONTRACT_ID)
) ENGINE=InnoDB COMMENT='客户签约表';

 insert into T_CUSTOMER_SIGN_CONTRACT (CREATED, CUSTOMER_ID, ACCOUNT_ID, PRODUCT_ID, PRODUCT_NO, CONTRACT_ID,
 M_INTEREST, M_CHARGES, M_PENALTY, M_OVERDUE, M_VIOLATE, CONTRACT_STATUS, BILL_DAY_RULE, BILL_DAY,
 REPAY_DAY_RULE, REPAY_DAY, GRACE_DAY, INTEREST_START_TYPE)
 values(now(), 11, 12, 13, 14, 15, 1500, 1400, 1300, 1200, 1100, 1, 2, 15, 1, 3, 3, 1);