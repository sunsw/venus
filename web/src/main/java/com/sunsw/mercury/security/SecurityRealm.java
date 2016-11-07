package com.sunsw.mercury.security;

import com.sunsw.mercury.core.utils.PasswordUtils;
import com.sunsw.mercury.model.AuthPermission;
import com.sunsw.mercury.model.AuthRole;
import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.service.AuthPermissionService;
import com.sunsw.mercury.service.AuthRoleService;
import com.sunsw.mercury.service.AuthUserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户身份验证,授权 Realm 组件
 *
 * @author sunsw
 **/
@Component
public class SecurityRealm extends AuthorizingRealm {

	@Resource
	private AuthUserService authUserService;

	@Resource
	private AuthRoleService authRoleService;

	@Resource
	private AuthPermissionService authPermissionService;

	/**
	 * 权限检查
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		String username = String.valueOf(principals.getPrimaryPrincipal());

		final AuthUser user = authUserService.selectByUsername(username);
		final List<AuthRole> roleInfos = authRoleService.selectRolesByUserId(user.getId());
		for (AuthRole role : roleInfos) {
			// 添加角色
			authorizationInfo.addRole(role.getRoleSign());

			// 添加角色权限
			final List<AuthPermission> permissions = authPermissionService.selectPermissionsByRoleId(role.getId());
			for (AuthPermission permission : permissions) {
				authorizationInfo.addStringPermission(permission.getPermissionSign());
			}
		}
		return authorizationInfo;
	}

	/**
	 * 登录验证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String username = String.valueOf(token.getPrincipal());
		String password = new String((char[]) token.getCredentials());
		// 通过数据库进行验证
		final AuthUser authentication = authUserService.selectByUsername(username);
		if (authentication == null || !PasswordUtils.validatePassword(password, authentication.getPassword())) {
			throw new AuthenticationException("Auth failed.");
		}
		SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(username, password, getName());
		return authenticationInfo;
	}
}
