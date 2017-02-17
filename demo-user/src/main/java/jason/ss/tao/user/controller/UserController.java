package jason.ss.tao.user.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jason.ss.tao.base.controller.BaseController;
import jason.ss.tao.user.model.UserDto;
import jason.ss.tao.user.model.validator.UserValidator;
import jason.ss.tao.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
	@Resource(name = "userService")
	private UserService		service;

	@Resource(name = "userValidator")
	private UserValidator	validator;

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(@ModelAttribute UserDto user) {
		return "user/register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@Valid @ModelAttribute UserDto user, BindingResult errors, @RequestParam("portrait") MultipartFile file) {
		if(errors.hasErrors()) {
			return "user/register";
		}
		service.save(user);
		return redirect("/user/list");
	}

	@RequestMapping(value = "/list")
	public String list(Model model) {
		model.addAttribute("userList", service.getAllUser());
		return "user/list";
	}

	@RequestMapping(value = "/{userId}/update")
	public String update(@PathVariable Integer userId, @ModelAttribute UserDto user)
		throws Exception {
		PropertyUtils.copyProperties(user, service.get(userId));
		return "user/update";
	}

	@RequestMapping(value = "/{userId}/update", method = RequestMethod.POST)
	public String update(@PathVariable Integer userId, @Valid @ModelAttribute UserDto user, BindingResult errors) {
		if(errors.hasErrors()) {
			return "user/update";
		}
		service.update(user);
		return redirect("/user/list");
	}

	@RequestMapping(value = "/{userId}/delete")
	public String delete(@PathVariable Integer userId) {
		service.delete(userId);
		return redirect("/user/list");
	}

	@ExceptionHandler
	public String handlerException(Exception e, HttpServletRequest request) {
		request.setAttribute("errMsg", e.getMessage());
		e.printStackTrace();
		return "error/exception";
	}
}
