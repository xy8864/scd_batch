package com.scd.batch.statistics.service;


import com.scd.batch.common.TestUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:META-INF/ApplicationContext-statistics.xml")
public class ProjectLimitServiceTest extends AbstractJUnit4SpringContextTests {

    @Autowired
    private ProjectLimitService limitService;

    @Test
    public void testBatchUpdate2DB() {
        limitService.batchUpdate2DB(TestUtil.buildProjectLimitList());
    }
}
