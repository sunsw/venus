package com.sunsw.mercury.security;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.CollectionUtils;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;
import java.util.Set;

/**
 * 角色验证 or
 * Created by sunsw on 2016/6/24.
 */
@Component("anyRolesFilter")
public class AnyRolesAuthorizationFilter extends AuthorizationFilter {

	public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws IOException {
		Subject subject = getSubject(request, response);
		String[] rolesArray = (String[]) mappedValue;
		if (rolesArray == null || rolesArray.length == 0) {
			return true;
		}
		Set<String> roles = CollectionUtils.asSet(rolesArray);
		for (String role : roles) {
			if (subject.hasRole(role)) {
				return true;
			}
		}
		return false;
	}
}
