package com.sunsw.mercury.service.impl;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.AuthPermissionMapper;
import com.sunsw.mercury.model.AuthPermission;
import com.sunsw.mercury.service.AuthPermissionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 权限Service实现类
 *
 * @author sunsw
 */
@Service("authPermissionService")
public class AuthPermissionServiceImpl extends GenericServiceImpl<AuthPermission, Long> implements AuthPermissionService {

	@Resource
	private AuthPermissionMapper authPermissionMapper;

	@Override
	public GenericDao<AuthPermission, Long> getDao() {
		return authPermissionMapper;
	}

	@Override
	public List<AuthPermission> selectPermissionsByRoleId(Long roleId) {
		return authPermissionMapper.selectPermissionsByRoleId(roleId);
	}

}
