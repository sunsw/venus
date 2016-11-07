package com.sunsw.mercury.service;

import com.sunsw.mercury.core.generic.GenericService;
import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.model.SysOrganization;

import java.util.List;

/**
 * 组织 业务 接口
 *
 * @author sunsw
 **/
public interface SysOrganizationService extends GenericService<SysOrganization, Long> {

	/**
	 * 根据组织Id查询所有下属组织Id（包括自身）
	 * @param orgId
	 * @return
	 */
	List<Long> selectSubOrg(Long orgId);
	
}
