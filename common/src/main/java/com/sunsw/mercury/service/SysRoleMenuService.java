package com.sunsw.mercury.service;

import com.sunsw.mercury.core.generic.GenericService;
import com.sunsw.mercury.model.SysRoleMenu;

/**
 * 角色与菜单关系 业务 接口
 *
 * @author sunsw
 **/
public interface SysRoleMenuService extends GenericService<SysRoleMenu, Long> {

	/**
	 * 删除某角色下的所有菜单
	 *
	 * @param roleId
	 * @return
	 */
	int deleteByRoleId(Long roleId);

}
