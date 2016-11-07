package com.sunsw.mercury.service;

import com.github.pagehelper.PageInfo;
import com.sunsw.mercury.core.generic.GenericService;
import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.model.AuthUserExample;

import java.util.List;

/**
 * 用户 业务 接口
 *
 * @author sunsw
 **/
public interface AuthUserService extends GenericService<AuthUser, Long> {

	/**
	 * 根据用户名查询用户
	 *
	 * @param username
	 * @return
	 */
	AuthUser selectByUsername(String username);

	/**
	 * 根据组织Id查询用户
	 *
	 * @param orgId
	 * @return
	 */
	List<AuthUser> selectByOrg(Long orgId);

	/**
	 * 修改密码
	 *
	 * @param userId
	 * @param psw
	 * @return
	 */
	int updatePsw(Long userId, String psw);

	/**
	 * 查询
	 *
	 * @param example
	 * @return
	 */
	PageInfo<AuthUser> selectList(AuthUserExample example, PageInfo<AuthUser> pageInfo);

}
