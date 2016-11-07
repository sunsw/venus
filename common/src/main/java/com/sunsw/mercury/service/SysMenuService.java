package com.sunsw.mercury.service;

import com.sunsw.mercury.core.generic.GenericService;
import com.sunsw.mercury.model.SysMenu;

import java.util.List;
import java.util.Map;

/**
 * 菜单 业务 接口
 *
 * @author sunsw
 **/
public interface SysMenuService extends GenericService<SysMenu, Long> {

	/**
	 * 根据userId查询菜单
	 *
	 * @param userId
	 * @return
	 */
	List<SysMenu> selectByUserId(Long userId);

	/**
	 * 获取角色菜单配置关系for shiro
	 *
	 * @return
	 */
	Map<String, String> selectRoleMenuMap();

}
