package com.sunsw.mercury.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.core.generic.GenericServiceImpl;
import com.sunsw.mercury.dao.AuthUserMapper;
import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.model.AuthUserExample;
import com.sunsw.mercury.service.AuthUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户Service实现类
 *
 * @author sunsw
 */
@Service("authUserService")
public class AuthUserServiceImpl extends GenericServiceImpl<AuthUser, Long> implements AuthUserService {

	@Resource
	private AuthUserMapper authUserMapper;

	@Override
	public GenericDao<AuthUser, Long> getDao() {
		return authUserMapper;
	}

	@Override
	public AuthUser selectByUsername(String username) {
		AuthUserExample example = new AuthUserExample();
		example.createCriteria().andUsernameEqualTo(username);
		final List<AuthUser> list = authUserMapper.selectByExample(example);
		if (list == null || list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}

	@Override
	public List<AuthUser> selectByOrg(Long orgId) {
		AuthUserExample example = new AuthUserExample();
		example.createCriteria().andOrganizationIdEqualTo(orgId);
		final List<AuthUser> list = authUserMapper.selectByExample(example);
		if (list == null || list.isEmpty()) {
			return null;
		}
		return list;
	}

	@Override
	public int updatePsw(Long userId, String psw) {
		AuthUser authUser = new AuthUser();
		authUser.setId(userId);
		authUser.setPassword(psw);
		return authUserMapper.updateByPrimaryKeySelective(authUser);
	}

	public PageInfo<AuthUser> selectList(AuthUserExample example, PageInfo<AuthUser> pageInfo) {
		PageHelper.startPage(pageInfo.getPageNum(), pageInfo.getPageSize());
		List<AuthUser> list = authUserMapper.selectByExample(example);
		return new PageInfo<AuthUser>(list);
	}

}
