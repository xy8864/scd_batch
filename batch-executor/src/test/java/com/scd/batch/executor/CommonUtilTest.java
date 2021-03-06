package com.scd.batch.executor;

import com.scd.batch.common.utils.CommonUtil;
import com.scd.batch.common.utils.ShortDate;
import junit.framework.Assert;
import org.junit.Test;

import java.util.Date;

public class CommonUtilTest {

    @Test
    public void testDate() {
        Date d1 = new Date();
        Date d2 = new Date();

        int count = CommonUtil.betweenTwoDays(d1, d2);

        System.out.println(count);

        Assert.assertTrue(count == 0);
    }

    @Test
    public void testFirstDayOfMonth() {
        Date date1 = ShortDate.valueOf(20160501).toDate();
        Date date2 = ShortDate.valueOf(20160502).toDate();

        boolean flagTrue = CommonUtil.isFirstDayOfMonth(date1);
        boolean flagFalse = CommonUtil.isFirstDayOfMonth(date2);

        System.out.println(flagTrue);
        System.out.println(flagFalse);

        Assert.assertTrue(flagTrue);
        Assert.assertFalse(flagFalse);
    }

    @Test
    public void testExpiringPoint() {
        Date d1 = new Date();
        Date d2 = new Date();

        Date d11 = ShortDate.valueOf(20160501).toDate();
        Date d12 = ShortDate.valueOf(20160502).toDate();

        boolean flagFalse = CommonUtil.expiringPoint(d1, d2);
        boolean flagTrue = CommonUtil.expiringPoint(d11, d12);

        System.out.println(flagFalse);
        System.out.println(flagTrue);

        Assert.assertTrue(flagTrue);
        Assert.assertFalse(flagFalse);
    }

//    @Test
//    public void testGetDirPath() {
//        String root = "/tmp";
//        ShortDate d = ShortDate.today();
//
//        String path = CommonUtil.getDirPath(root, new ExecutorContext().addAttach(ShortDate.class, d));
//
//        System.out.println(path);
//
//    }
//
//    @Test
//    public void testGetFileName() {
//        JobControl control = new JobControl();
//        control.setDatabaseId("0");
//        control.setTableId("0");
//
//        String fileName = CommonUtil.getFileName("/tmp", control);
//
//        System.out.println(fileName);
//    }

    @Test
    public void testGetBillDay() {
        ShortDate now = ShortDate.valueOf(20160518);


    }

}
