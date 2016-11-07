package com.sunsw.mercury.service.impl;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.AuthRoleMapper;
import com.sunsw.mercury.model.AuthRole;
import com.sunsw.mercury.service.AuthRoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 角色Service实现类
 *
 * @author sunsw
 */
@Service("authRoleService")
public class AuthRoleServiceImpl extends GenericServiceImpl<AuthRole, Long> implements AuthRoleService {

	@Resource
	private AuthRoleMapper authRoleMapper;

	@Override
	public GenericDao<AuthRole, Long> getDao() {
		return authRoleMapper;
	}

	@Override
	public List<AuthRole> selectRolesByUserId(Long userId) {
		return authRoleMapper.selectRolesByUserId(userId);
	}
}
