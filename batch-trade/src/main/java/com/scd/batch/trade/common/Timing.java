package com.scd.batch.trade.common;

import java.util.concurrent.TimeUnit;

import com.google.common.base.Stopwatch;

public class Timing {

    public static long timing(Stopwatch stopwatch) {

        return stopwatch.elapsed(TimeUnit.MILLISECONDS);
    }

}
