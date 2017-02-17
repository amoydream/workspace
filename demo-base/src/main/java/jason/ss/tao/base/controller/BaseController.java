package jason.ss.tao.base.controller;

import org.springframework.web.servlet.view.UrlBasedViewResolver;

public class BaseController {
	public static String forward(String view) {
		return UrlBasedViewResolver.FORWARD_URL_PREFIX + view;
	}

	public static String redirect(String view) {
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX + view;
	}
}
