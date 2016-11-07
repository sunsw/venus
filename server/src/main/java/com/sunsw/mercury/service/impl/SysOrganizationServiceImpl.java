package com.sunsw.mercury.service.impl;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.SysOrganizationMapper;
import com.sunsw.mercury.model.SysOrganization;
import com.sunsw.mercury.service.SysOrganizationService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * 组织Service实现类
 *
 * @author sunsw
 */
@Service("sysOrganizationService")
public class SysOrganizationServiceImpl extends GenericServiceImpl<SysOrganization, Long> implements SysOrganizationService {

	@Resource
	private SysOrganizationMapper sysOrganizationMapper;

	@Override
	public GenericDao<SysOrganization, Long> getDao() {
		return sysOrganizationMapper;
	}

	@Override
	public List<Long> selectSubOrg(Long orgId) {
		List<Long> result = Arrays.asList(orgId);
		List<Long> subMenu = sysOrganizationMapper.selectByParentId(orgId);
		if (null != subMenu && !subMenu.isEmpty()) {
			for (Long sid : subMenu) {
				result.addAll(selectSubOrg(sid));
			}
		}
		return result;
	}
}
