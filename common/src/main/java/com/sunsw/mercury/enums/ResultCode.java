package com.sunsw.mercury.enums;

/**
 * 系统代码
 * Created by sunsw on 2016/4/1.
 */
public enum ResultCode {

	USER_STATUS_ENABLE("Y", "ENABLE"),
	USER_STATUS_DISABLE("N", "DISABLE"),

	REQUEST_STATUS_NOT_LOGIN("0", "NOT LOGIN"),
	REQUEST_STATUS_OK("1", "SUCCESS"),
	REQUEST_STATUS_BAD("0", "FAILURE");

	private String code;
	private String msg;

	ResultCode(String code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}

}
