package com.scd.batch.common.job.batch;

@FunctionalInterface
public interface TargetStatisticsHandler {

    /**
     * Initialize handler
     */
    default void init() {
    }

    /**
     * Close handler
     */
    default void close() {
    }

    /**
     * Clear. Such as remove existed target data
     */
    default void clear() {
    }

    /**
     * Batch handle source data comes from {@link SourceDataProvider#batchRead()}. Lambda supported
     *
     * @return
     */
    void handle(String line);

    /**
     * After all the batch lines are handled
     */
    default void postHandler() {
    }

}
