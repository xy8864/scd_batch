package com.scd.batch.common.entity.statistics;

import com.scd.batch.common.entity.Entity;

import java.util.Date;

/**
 * 平台线上支出报表
 */
public class ExpenditureStatEntity extends Entity {

    // 日期
    private Date transDate;

    /**
     * 支出类型，支出明细，主要是当日各种促销券的实际使用金额，
     * 具体类型有：红包，秒钱卡，加息卡，双倍加息卡，当前限此4种
     */
    private int type;

    // 金额
    private double amount;

    public ExpenditureStatEntity() {
    }

    public ExpenditureStatEntity(Date transDate, int type, double amount) {
        this.transDate = transDate;
        this.type = type;
        this.amount = amount;
    }

    public Date getTransDate() {
        return transDate;
    }

    public void setTransDate(Date transDate) {
        this.transDate = transDate;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }


}
