package com.sunsw.mercury.service;

import com.sunsw.mercury.core.generic.GenericService;
import com.sunsw.mercury.model.AuthRole;

import java.util.List;

/**
 * 角色 业务接口
 *
 * @author sunsw
 **/
public interface AuthRoleService extends GenericService<AuthRole, Long> {

	List<AuthRole> selectRolesByUserId(Long userId);

}
