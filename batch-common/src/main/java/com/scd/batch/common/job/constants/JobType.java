package com.scd.batch.common.job.constants;


import com.scd.batch.common.utils.EnumType;

/**
 * 任务类型.
 */
public enum JobType implements EnumType<JobType, Integer> {


    /**
     * 灵活调度批跑
     */

    /**
     * 批量赎回任务
     */
    RedeemScheduleJob(4001),

    /**
     * 更新银行卡限额任务
     */
    UpdateBankCardQuotaScheduleJob(4002),


    /**
     * 对账相关
     *
     */

    /**
     * 放款流水抓取任务
     */
    LoanCrawlerJob(1001),

    /**
     * 放款对账
     */
    LoanCalculatorJob(1002),

    /**
     * 还款流水抓取任务
     */
    PaymentCrawlerJob(1003),

    /**
     * 还款对账
     */
    PaymentCalculatorJob(1004),


    /**
     * 提现流水抓取任务
     */
    CashCrawlerJob(1005),

    /**
     * 提现流水对账任务
     */
    CashCalculatorJob(1006),

    /**k
     * 充值流水抓取任务
     */
    SaveCrawlerJob(1007),

    /**
     * 充值流水对账任务
     */
    SaveCalculatorJob(1008),

    /**
     * 商户扣款流水抓取任务
     */
    TrfCrawlerJob(1009),

    /**
     * 商户扣款流水对账任务
     */
    TrfCalculatorJob(1010),


    /**
     * 统计分析
     *
     */

    /**
     * 项目额度
     */
    ProjectLimitCalculateJob(2001),

    /**
     * 借款人还款计划
     */
    BorrowerRepayPlanStatCalculateJob(2002),

    /**
     * 充值提现统计
     */
    FundStatCalculateJob(2003),

    /**
     * 定期计划
     */
    FixPlanDueStatCalculateJob(2004),

    /**
     * 定期项目
     */
    FixProjectDueStatCalculateJob(2005),

    /**
     * 平台支出
     */
    ExpenditureCalculateJob(2006),

    /**
     * 项目资产统计
     */
    AssetsStatProjectCalculateJob(2007),

    /**
     * 余额资产统计
     */
    AssetsStatBalanceCalculateJob(2008),


    /**
     * 计息
     */

    /**
     * 每日收益统计
     */
    UserProfitCalculateJob(3001);


    public final int type;

    JobType(int type) {
        this.type = type;
    }

    @Override
    public Integer getType() {
        return this.type;
    }
}