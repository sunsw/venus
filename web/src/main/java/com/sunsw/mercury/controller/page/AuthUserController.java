package com.sunsw.mercury.controller.page;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.sunsw.mercury.core.utils.PasswordUtils;
import com.sunsw.mercury.entry.CommonResult;
import com.sunsw.mercury.enums.ResultCode;
import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.service.AuthUserService;
import com.sunsw.mercury.service.SysMenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.List;

/**
 * 用户控制器
 *
 * @author sunsw
 **/
@Controller
@RequestMapping(value = "/page/user")
public class AuthUserController {

	@Resource
	private AuthUserService authUserService;
	@Resource
	private SysMenuService sysMenuService;

	/**
	 * 用户登录
	 *
	 * @param user
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login")
	public String login(AuthUser user, Model model, HttpServletRequest request) {
		try {
			Subject subject = SecurityUtils.getSubject();
			// 已登陆则 跳到首页
			if (subject.isAuthenticated()) {
				return "redirect:/";
			}
			// 身份验证
			subject.login(new UsernamePasswordToken(user.getUsername(), user.getPassword()));
			// 验证成功在Session中保存用户信息
			final AuthUser authUserInfo = authUserService.selectByUsername(user.getUsername());
			request.getSession().setAttribute("userInfo", authUserInfo);
		} catch (AuthenticationException e) {
			// 身份验证失败
			model.addAttribute("error", "用户名或密码错误！");
			return "login";
		}
		return "redirect:/";
	}

	/**
	 * 用户登出
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("userInfo");
		// 登出操作
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "login";
	}

	/**
	 * 用户注册
	 *
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@Valid AuthUser user, BindingResult result, Model model, HttpServletRequest request) {
		try {
			String pwd_echo = request.getParameter("password_confirmation");
			if (!user.getPassword().equals(pwd_echo)) {
				model.addAttribute("error", "两次密码输入不一致");
				return "register";
			}
			user.setEmail(user.getEmail());
			String pwd_hash = PasswordUtils.md5Hex(user.getPassword());
			user.setCreateTime(new Date());
			user.setStatus(ResultCode.USER_STATUS_ENABLE.getCode());
			user.setPassword(pwd_hash);
			int ret = authUserService.insert(user);
			if (ret != 1) {
				model.addAttribute("error", "注册失败，请检查输入信息");
				return "register";
			}
		} catch (AuthenticationException e) {
			model.addAttribute("error", "注册失败，请检查输入信息");
			return "register";
		} catch (DuplicateKeyException e) {
			model.addAttribute("error", "用户已存在");
			return "register";
		} catch (Exception e) {
			model.addAttribute("error", "注册失败，请检查输入信息");
			return "register";
		}
		return "redirect:/logout";
	}

	/**
	 * 创建用户
	 */
	@RequestMapping(value = "/create")
	@ResponseBody
	public CommonResult createUser(@Valid AuthUser user, BindingResult bind, HttpServletRequest request) {
		CommonResult result = new CommonResult();
		if (bind.hasErrors()) {
			List<ObjectError> errorList = bind.getAllErrors();
			String err = "";
			for (ObjectError error : errorList) {
				err += error.getDefaultMessage() + ";";
			}
			result.setStatus(false);
			result.setMessage(err);
			return result;
		}
		try {
			String pwd_hash = PasswordUtils.md5Hex(user.getPassword());
			user.setPassword(pwd_hash);
			user.setStatus(ResultCode.USER_STATUS_ENABLE.getCode());
			int ret = authUserService.insert(user);
			if (ret != 1) {
				result.setStatus(false);
				result.setMessage("注册失败，请检查输入信息！");
				return result;
			}
		} catch (Exception e) {
			result.setStatus(false);
			result.setMessage("注册失败，请检查输入信息！");
			return result;
		}
		result.setStatus(true);
		return result;
	}

	/**
	 * 修改密码
	 *
	 * @param oldPsw
	 * @param newPsw
	 * @param confPsw
	 * @param request
	 * @return logout:未登录 misMatch:新密码两次不匹配 wrongPsw:原密码错误 fail:修改失败 success:修改成功
	 */
	@RequestMapping(value = "/changePsw", method = RequestMethod.POST)
	@ResponseBody
	public String changePsw(String oldPsw, String newPsw, String confPsw, HttpServletRequest request) {
		AuthUser currentUser = (AuthUser) request.getAttribute("userInfo");
		if (currentUser == null) {
			return "logout";
		}

		if (!newPsw.equals(confPsw)) {
			return "misMatch";
		}
		if (!PasswordUtils.validatePassword(oldPsw, currentUser.getPassword())) {
			return "wrongPsw";
		}
		String newPsw_hash = PasswordUtils.md5Hex(newPsw);
		currentUser.setPassword(newPsw_hash);
		int ret = authUserService.update(currentUser);
		if (ret != 1) {
			return "fail";
		}
		return "success";
	}

	@RequestMapping(value = "/list")
	public ModelAndView changePsw(AuthUser authUser, PageInfo<AuthUser> pageInfo) {
		ModelAndView mv = new ModelAndView("authUserList");
		if (pageInfo.getPageNum() == 0) {
			pageInfo.setPageNum(1);
		}
		if (pageInfo.getPageSize() == 0) {
			pageInfo.setPageSize(10);
		}
		pageInfo = authUserService.selectList(null, pageInfo);
		mv.addObject("pageInfo", pageInfo);
		return mv;
	}

}
