package com.sunsw.mercury.security;

import java.util.Map;

/**
 * Created by sunsw on 2016/4/13.
 */
public interface FilterChainDefinitionsService {

	/**
	 * 初始化框架权限资源配置
	 */
	Map<String, String> loadFilterChainDefinitions();

	/**
	 * 重新加载框架权限资源配置 (强制线程同步)
	 */
	void reCreateFilterChains();

	/**
	 * 初始化第三方权限资源配置
	 */
	Map<String, String> initOtherFilterChains();
}
