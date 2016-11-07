package com.sunsw.mercury;

import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.model.SysMenu;
import com.sunsw.mercury.service.AuthUserService;
import com.sunsw.mercury.service.SysMenuService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

/**
 * Unit test for simple App.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class AppTest extends AbstractJUnit4SpringContextTests {

	@Resource
	private AuthUserService authUserService;

	@Resource
	private SysMenuService sysMenuService;

	@Test
	public void testApp() {
		AuthUser user = authUserService.selectByUsername("tourpm");
		System.out.println(user.toString());
	}

	@Test
	public void testMenu() {
//		List<SysMenu>  list = sysMenuService.selectByUserId(5l);
//		System.out.println(list.size());
		sysMenuService.selectRoleMenuMap();
	}
}
