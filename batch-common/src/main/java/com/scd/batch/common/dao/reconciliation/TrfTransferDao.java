package com.scd.batch.common.dao.reconciliation;

import com.scd.batch.common.entity.reconciliation.TransferEntity;
import com.scd.batch.common.utils.TableSpec;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface TrfTransferDao {

    List<Long> getAllTransferIds(@Param("ts") TableSpec ts,
                                 @Param("transDate") Date transDate);

    int batchInsert(@Param("ts") TableSpec ts,
                    @Param("entityList") List<TransferEntity> entityList);

    List<TransferEntity> getListByPage(@Param("ts") TableSpec ts,
                                           @Param("transDate") Date transDate,
                                           @Param("batchIds") List<Long> batchIds);

    int deleteTrfTransfer(@Param("ts") TableSpec ts,
                           @Param("transDate") Date transDate);
}
