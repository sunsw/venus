package com.sunsw.mercury.entry;

/**
 * 通用返回结果
 * Created by sunsw on 2016/7/5.
 */
public class CommonResult<T> {

	private boolean status;
	private String code;
	private String message;
	private T data;

	public CommonResult() {
	}

	public CommonResult(boolean status) {
		this.status = status;
	}

	public CommonResult(boolean status, String code, String message) {
		this.status = status;
		this.code = code;
		this.message = message;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
}
