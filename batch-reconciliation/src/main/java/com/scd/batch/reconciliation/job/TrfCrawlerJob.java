package com.scd.batch.reconciliation.job;

import com.scd.batch.common.constant.reconciliation.TransferType;
import com.scd.batch.common.entity.reconciliation.TransferEntity;
import com.scd.batch.common.job.batch.*;
import com.scd.batch.common.job.constants.JobType;
import com.scd.batch.common.job.constants.PhaseType;
import com.scd.batch.common.job.executor.ExecutorContext;
import com.scd.batch.common.utils.CommonUtil;
import com.scd.batch.common.utils.Pagination;
import com.scd.batch.common.utils.ShortDate;
import com.scd.batch.reconciliation.crawler.TrfCrawler;
import com.scd.batch.reconciliation.service.TransferBatchUpdateService;
import org.apache.commons.collections.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * 商户扣款抓取任务
 */
public class TrfCrawlerJob extends CrawlerDataFlowBatchJob {

    @Resource
    private TrfCrawler crawler;

    @Resource
    private TransferBatchUpdateService batchUpdate;

    @Override
    protected JobType getJobType() {
        return JobType.TrfCalculatorJob;
    }

    @Override
    protected PhaseType getCurrentPhase() {
        return PhaseType.LOAD;
    }

    @Override
    protected PhaseType getNextPhase() {
        return null;
    }

    @Override
    protected SourceDataProvider getSourceDataProvider() {
        // Source from HF
        return () -> batchRead(getExecutorContext());
    }

    @Override
    protected DataFlowCalculator getDataFlowCalculator() {
        // No data calculate
        return getNoOpCalculator();
    }

    @Override
    protected TargetDataHandler getTargetDataHandler() {
        // Target save to local file
        return getTargetFileHandler();
    }

    /**
     * Closure: batch crawl from HuiFu
     */
    public List<String> batchRead(ExecutorContext context) {

        Pagination pagination = context.getAttach(Pagination.class);
        // 业务日期
        ShortDate transDate = context.getAttach(ShortDate.class);


        List<TransferEntity> entityList = crawler.crawler(transDate,
                TransferType.CASH,
                pagination);

        if (CollectionUtils.isEmpty(entityList)) {
            return null;
        }

        // 清理当天的旧数据
        batchUpdate.deleteTrfTransfer(transDate.toDate());

        // batch insert DB
        batchUpdate.batchInsertTrfTransfer(entityList);

        return CommonUtil.transform2Lines(entityList);
    }

}
