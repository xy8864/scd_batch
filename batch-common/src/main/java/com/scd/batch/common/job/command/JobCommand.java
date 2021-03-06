package com.scd.batch.common.job.command;

import com.scd.batch.common.job.LifeCycle;
import org.springframework.context.ApplicationContext;

import com.google.common.base.Preconditions;

public class JobCommand extends AbstractCommand {

    /**
     * Sub commands
     */
    enum Job {
        // 日切
        SWITCH("switch"),

        // 任务控制
        PREPARE("prepare"),

        // 日间认购调度
        DayRedeemSchedule("dayRedeemSchedule"),

        /**
         * 灵活调度
         */
        BidLoanSchedule("bidLoanSchedule"),

        RedeemSchedule("redeemSchedule"),

        BidBuyBackSchedule("bidBuyBackSchedule"),

        PreAutoBuySchedule("preAutoBuySchedule"),

        AutoBuySchedule("autoBuySchedule"),

        UpdateBankCardQuotaSchedule("updateBankCardQuotaSchedule"),

        UpdateUserRegisterCountToRedis("updateUserRegisterCountToRedis"),


        /**
         * 对账
         */
        // loan
        Loan_Crawler("loanCrawler"),

        Loan_Loader("loanLoader"),

        LoanEntity_Loader("loanEntityLoader"),

        Loan_Calculator("loanCalculator"),

        // payment
        Payment_Crawler("paymentCrawler"),

        Payment_Loader("paymentLoader"),

        CreditRepayReal_Loader("creditRepayRealLoader"),

        Payment_Calculator("paymentCalculator"),

        // cash
        Cash_Crawler("cashCrawler"),

        Cash_Loader("cashLoader"),

        WithdrawL_Loader("withDrawlLoader"),

        Cash_Calculator("cashCalculator"),

        // save
        Save_Crawler("saveCrawler"),

        Save_Loader("saveLoader"),

        Recharge_Loader("rechargeLoader"),

        Save_Calculator("saveCalculator"),

        // trf
        //Trf_Crawler("trfCrawler"),

        //Trf_Calculator("trfCalculator"),
        HuiFu_UserBalance_Crawler("huiFuUserBalanceCrawler"),


        /**
         * 统计相关
         */
        PROJECT_LIMIT("projectLimit"),

        BORROWER_REPAY_PLAN("borrowerRepayPlan"),

        FUND_STAT("fundStat"),

        FIX_PLAN_DUE("fixPlanDue"),

        FIX_PROJECT_DUE("fixProjectDue"),

        EXPENTIDURE("expentidure"),

        ASSETS_PROJECT("assetsProject"),

        ASSETS_BALANCE("assetsBalance"),

        /**
         * 收益
         */
        UserCurrentProfitCalculateJob("userCurrentProfitCalculate"),

        UserDailyProfitCalculateJob("userDailyProfitCalculate"),

        LastDayAssetsCalculateJob("lastDayAssetsCalculate"),


        /**
         * 事后处理
         */

        PostHandling("postHandling"),

        Notice("notice");

        /**
         * Job desc
         */
        public final String name;

        Job(String name) {
            this.name = name;
        }

        public static Job nameOf(String jobName) {
            for (Job job : Job.values()) {
                if (job.name.equals(jobName)) {
                    return job;
                }
            }
            return null;
        }
    }

    public JobCommand(CommandOptions commandOptions, ApplicationContext context) {
        super(commandOptions, context);
    }

    @Override
    public void validateOptions() {
        Preconditions.checkState(commandOptions != null, "Missing command options!");
    }

    @Override
    public void run() {
        LifeCycle executor = (LifeCycle) context.getBean(commandOptions.getJobName() + ".job");

        // start the executor
        executor.start();
    }
}
