package com.scd.batch.trade.mock;


import com.scd.batch.common.job.executor.AbstractExecutor;
import com.scd.batch.common.job.executor.ExecutorContext;

/**
 * Created by pippo on 16/4/27.
 */
public class SubExecutor extends AbstractExecutor {

    // private static Logger logger = LoggerFactory.getLogger(LoopExecutor.class);

    public SubExecutor(String name) {
        super(name);
    }

    @Override
    public void initialize() {

    }

    @Override
    public boolean beforeExecute(ExecutorContext context) {
        logger.debug("before execute:[{}]", getName());
        return true;
    }

    @Override
    public void execute(ExecutorContext context) {
        logger.debug("execute:[{}]", getName());
    }

    @Override
    public void afterExecute(ExecutorContext context) {
        logger.debug("after execute:[{}]", getName());
    }

}
