package com.sunsw.mercury.controller.page;

import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.model.SysMenu;
import com.sunsw.mercury.service.SysMenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 视图控制器,返回jsp视图给前端
 *
 * @author sunsw
 **/
@Controller
@RequestMapping("/")
public class CommonController {

	@Resource
	private SysMenuService sysMenuService;

	/**
	 * 首页
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView model = new ModelAndView("index");
		Subject subject = SecurityUtils.getSubject();
		// 已登陆则 跳到首页
		if (subject.isAuthenticated()) {
			AuthUser authUser = (AuthUser) request.getSession().getAttribute("userInfo");
			List<SysMenu> menus = sysMenuService.selectByUserId(authUser.getId());
			model.addObject("menus", menus);
			return model;
		}
		return new ModelAndView("login");
	}

	/**
	 * 登录页
	 */
	@RequestMapping("/page/login")
	public String login() {
		Subject subject = SecurityUtils.getSubject();
		// 已登陆则 跳到首页
		if (subject.isAuthenticated()) {
			return "redirect:/page/user/logout";
		}
		return "login";
	}

	/**
	 * 注册页
	 */
	@RequestMapping("/page/register")
	public String register() {
		return "register";
	}

	/**
	 * 404页
	 */
	@RequestMapping("/404")
	public String error404() {
		return "404";
	}

	/**
	 * 401页
	 */
	@RequestMapping("/401")
	public String error401() {
		return "401";
	}

	/**
	 * 500页
	 */
	@RequestMapping("/500")
	public String error500() {
		return "500";
	}

	/**
	 * 400页
	 */
	@RequestMapping("/400")
	public String error400() {
		return "400";
	}

}