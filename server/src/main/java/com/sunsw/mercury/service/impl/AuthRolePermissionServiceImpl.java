package com.sunsw.mercury.service.impl;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.AuthRolePermissionMapper;
import com.sunsw.mercury.model.AuthRolePermission;
import com.sunsw.mercury.service.AuthRolePermissionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 角色权限Service实现类
 *
 * @author sunsw
 */
@Service("authRolePermissionService")
public class AuthRolePermissionServiceImpl extends GenericServiceImpl<AuthRolePermission, Long> implements AuthRolePermissionService {

	@Resource
	private AuthRolePermissionMapper authRolePermissionMapper;

	@Override
	public GenericDao<AuthRolePermission, Long> getDao() {
		return authRolePermissionMapper;
	}

}
