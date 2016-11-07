package com.sunsw.mercury.service.impl;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.SysRoleMenuMapper;
import com.sunsw.mercury.model.SysRoleMenu;
import com.sunsw.mercury.model.SysRoleMenuExample;
import com.sunsw.mercury.service.SysRoleMenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 角色菜单Service实现类
 *
 * @author sunsw
 */
@Service("sysRoleMenuService")
public class SysRoleMenuServiceImpl extends GenericServiceImpl<SysRoleMenu, Long> implements SysRoleMenuService {

	@Resource
	private SysRoleMenuMapper sysRoleMenuMapper;

	@Override
	public GenericDao<SysRoleMenu, Long> getDao() {
		return sysRoleMenuMapper;
	}

	@Override
	public int deleteByRoleId(Long roleId) {
		SysRoleMenuExample example = new SysRoleMenuExample();
		example.createCriteria().andRoleIdEqualTo(roleId);
		return sysRoleMenuMapper.deleteByExample(example);
	}
}
