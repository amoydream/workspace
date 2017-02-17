package com.lauvan.taglib;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.lauvan.system.vo.UserInfoVo;

/**
 * 
 * ClassName: PermissionTag 
 * @Description: 权限校验标签
 * @author 钮炜炜
 * @date 2015年11月5日 上午8:30:20
 */
public class PermissionTag extends RequestContextAwareTag{

	private static final long serialVersionUID = -3647178045760831483L;
	private String privilege;

	public String getPrivilege() {
		return privilege;
	}

	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

	@Override
	protected int doStartTagInternal() throws Exception {
		UserInfoVo uVo = (UserInfoVo) pageContext.getSession().getAttribute("userVo");
		boolean result = false;
		if (uVo.getPermissions().contains(this.privilege)) {
			result = true;
		}
		return result? EVAL_BODY_INCLUDE : SKIP_BODY;
	}
}
