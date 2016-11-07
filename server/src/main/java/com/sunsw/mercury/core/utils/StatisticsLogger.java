package com.sunsw.mercury.core.utils;

import org.slf4j.Logger;

/**
 * Created by sunsw on 2015/9/7.
 */
public class StatisticsLogger {
	private static boolean alarmSwitch = false;
	private static boolean monitorSwitch = false;

	public static void info(String requestId, Logger logger, String errMessage) {
		logger.info("statistics:result=true,errCode=1,uid=" + requestId
				+ ",errMessage=" + errMessage + ",alarmSwitch=" + alarmSwitch + ",monitorSwitch=" + monitorSwitch);
	}

	public static void info(String requestId, Logger logger, int errCode, String errMessage) {
		logger.info("statistics:result=true,errCode=" + errCode + ",uid=" + requestId
				+ ",errMessage=" + errMessage + ",alarmSwitch=" + alarmSwitch + ",monitorSwitch=" + monitorSwitch);
	}

	public static void info(String requestId, Logger logger, int errCode, String errMessage, boolean alarmSwitch, boolean monitorSwitch) {
		logger.info("statistics:result=true,errCode=" + errCode + ",uid=" + requestId
				+ ",errMessage=" + errMessage + ",alarmSwitch=" + alarmSwitch + ",monitorSwitch=" + monitorSwitch);
	}

	public static void error(String requestId, Logger logger, String errMessage) {
		logger.error("statistics:result=false,errCode=0,uid=" + requestId
				+ ",errMessage=" + errMessage + ",alarmSwitch=" + alarmSwitch + ",monitorSwitch=" + monitorSwitch);
	}

	public static void error(String requestId, Logger logger, int errCode, String errMessage) {
		logger.error("statistics:result=false,errCode=" + errCode + ",uid=" + requestId
				+ ",errMessage=" + errMessage + ",alarmSwitch=" + alarmSwitch + ",monitorSwitch=" + monitorSwitch);
	}

	public static void error(String requestId, Logger logger, int errCode, String errMessage, boolean alarmSwitch, boolean monitorSwitch) {
		logger.error("statistics:result=false,errCode=" + errCode + ",uid=" + requestId
				+ ",errMessage=" + errMessage + ",alarmSwitch=" + alarmSwitch + ",monitorSwitch=" + monitorSwitch);
	}

}
