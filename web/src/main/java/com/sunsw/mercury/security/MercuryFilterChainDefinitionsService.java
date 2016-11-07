package com.sunsw.mercury.security;

import com.sunsw.mercury.service.SysMenuService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * 加载第三方角色资源配置服务类
 * Created by sunsw on 2016/4/13.
 */
public class MercuryFilterChainDefinitionsService extends AbstractFilterChainDefinitionsService {

	@Resource
	private SysMenuService sysMenuService;

	@Override
	public Map<String, String> initOtherFilterChains() {
		return sysMenuService.selectRoleMenuMap();
	}

}
