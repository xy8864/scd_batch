package com.scd.batch.common.dao.acct;

import com.scd.batch.common.entity.acct.UserAccumulativeProfitEntity;
import com.scd.batch.common.mybatis.multidb.DataSourceType;
import com.scd.batch.common.mybatis.multidb.MultiDB;
import com.scd.batch.common.utils.TableSpec;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 用户累计收益
 */
@Repository
public interface UserAccumulateProfitDao {

    @MultiDB(ds = DataSourceType.BATCH)
    int insert(@Param("ts") TableSpec ts,
               @Param("entity") UserAccumulativeProfitEntity entity);

    @MultiDB(ds = DataSourceType.BATCH)
    int checkExists(@Param("ts") TableSpec ts,
                    @Param("uid") String uid);

    @MultiDB(ds = DataSourceType.BATCH)
    int updateIncrement2DB(@Param("ts") TableSpec ts,
                           @Param("entity") UserAccumulativeProfitEntity entity);


}
