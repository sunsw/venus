package com.sunsw.mercury.core.utils;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.io.InputStream;

/**
 * PasswordUtils : 程序工具类，提供大量的便捷方法
 *
 * @author sunsw
 */
public class PasswordUtils {

	/**
	 * md5加密
	 *
	 * @param value 要加密的值
	 * @return md5加密后的值
	 */
	public static String md5Hex(String value) {
		return DigestUtils.md5Hex(value);
	}

	/**
	 * md5加密
	 *
	 * @param in 要加密的流
	 * @return md5加密后的值
	 */
	public static String md5Hex(InputStream in) throws IOException {
		return DigestUtils.md5Hex(in);
	}

	/**
	 * sha1加密
	 *
	 * @param value 要加密的值
	 * @return sha1加密后的值
	 */
	public static String sha1Hex(String value) {
		return DigestUtils.sha1Hex(value);
	}

	/**
	 * sha256加密
	 *
	 * @param value 要加密的值
	 * @return sha256加密后的值
	 */
	public static String sha256Hex(String value) {
		return DigestUtils.sha256Hex(value);
	}

	/**
	 * 验证密码
	 *
	 * @param inputPsw 输入密码
	 * @param dbPsw    数据库密码
	 * @return
	 */
	public static boolean validatePassword(String inputPsw, String dbPsw) {
		if (StringUtils.isEmpty(inputPsw) || StringUtils.isEmpty(dbPsw)) {
			return false;
		}
		return PasswordUtils.md5Hex(inputPsw).equalsIgnoreCase(dbPsw);
	}
}
