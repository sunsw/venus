package com.sunsw.mercury.service.impl;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.SysMenuMapper;
import com.sunsw.mercury.model.SysMenu;
import com.sunsw.mercury.service.SysMenuService;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 菜单接口实现类
 * <p>
 * Created by sunsw on 2016/7/1.
 */
@Service("sysMenuService")
public class SysMenuServiceImpl extends GenericServiceImpl<SysMenu, Long> implements SysMenuService {

	@Resource
	private SysMenuMapper sysMenuMapper;

	@Override
	public GenericDao<SysMenu, Long> getDao() {
		return sysMenuMapper;
	}

	@Override
	public List<SysMenu> selectByUserId(Long userId) {
		return this.sysMenuMapper.selectByUserId(userId);
	}

	@Override
	public Map<String, String> selectRoleMenuMap() {
		Map<String, String> map = new HashedMap();
		List<Map> list = this.sysMenuMapper.selectRoleMenuMap();
		for (Map<String, String> e : list) {
			map.put(e.get("url"), e.get("roles"));
		}
		return map;
	}
}
