package com.sunsw.mercury.service;

import com.sunsw.mercury.core.generic.GenericService;
import com.sunsw.mercury.model.AuthPermission;

import java.util.List;

/**
 * 权限 业务接口
 *
 * @author sunsw
 **/
public interface AuthPermissionService extends GenericService<AuthPermission, Long> {

	List<AuthPermission> selectPermissionsByRoleId(Long roleId);

}
