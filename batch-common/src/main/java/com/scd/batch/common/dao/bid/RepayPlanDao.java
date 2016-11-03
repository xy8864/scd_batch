package com.scd.batch.common.dao.bid;

import com.scd.batch.common.entity.statistics.bid.BorrowerRepayEntity;
import com.scd.batch.common.entity.statistics.bid.RepayPlanStatEntity;
import com.scd.batch.common.mybatis.multidb.DataSourceType;
import com.scd.batch.common.mybatis.multidb.MultiDB;
import com.scd.batch.common.utils.TableSpec;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RepayPlanDao {

    // 按照项目统计应还本金和利息
    @MultiDB(ds = DataSourceType.BID)
    List<RepayPlanStatEntity> getProjectLimitList(@Param("ts") TableSpec ts, @Param("batchProjectCode") List<String>
            batchProjectCode);


    // 按照项目期序统计金额
    @MultiDB(ds = DataSourceType.BID)
    List<BorrowerRepayEntity> getProjectRepayPlanListByTerm(@Param("ts") TableSpec ts, @Param("batchProjectCode")
            List<String> batchProjectCode);

}