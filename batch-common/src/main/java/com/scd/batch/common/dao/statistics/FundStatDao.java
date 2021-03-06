package com.scd.batch.common.dao.statistics;

import com.scd.batch.common.entity.statistics.FundStatEntity;
import com.scd.batch.common.mybatis.multidb.DataSourceType;
import com.scd.batch.common.mybatis.multidb.MultiDB;
import com.scd.batch.common.utils.TableSpec;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface FundStatDao {

    @MultiDB(ds = DataSourceType.BATCH)
    int insert(@Param("ts") TableSpec ts,
               @Param("entity") FundStatEntity entity);

    @MultiDB(ds = DataSourceType.BATCH)
    int checkExists(@Param("ts") TableSpec ts,
                    @Param("transDate") Date transDate);

    @MultiDB(ds = DataSourceType.BATCH)
    int updateIncrement(@Param("ts") TableSpec ts,
                        @Param("entity") FundStatEntity entity);

    @MultiDB(ds = DataSourceType.BATCH)
    List<FundStatEntity> getStatList(@Param("ts") TableSpec ts,
                                     @Param("start") long start,
                                     @Param("num") long num);
}
