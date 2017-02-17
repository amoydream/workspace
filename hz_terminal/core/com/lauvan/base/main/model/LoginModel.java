package com.lauvan.base.main.model;

import java.io.Serializable;

public class LoginModel implements Serializable {
	private static final long	serialVersionUID	= 1L;
	private Number				userId;
	private String				userAccount;
	private String				userName;
	private String				seatID;						// 坐席号码
	private Integer				seatPriority;				// 坐席排序
	private String				loginIP;					// 登陆IP
	private String				seatIP;						// 坐席IP
	private Integer				ugrpNO;						// 坐席员技能组编号
	private Integer				opLevel;					// 坐席员操作权限
	private Integer				callLevel;					// 坐席员拨打权限
	private String				limit;
	private String				xdlimit;					// 限制的功能点
	private String				sessionId;
	private String				orgCode;					// 当前部门代码
	private String				orgName;					// 当前部门
	private String				rootOrgCode;				// 父级市县标志
	private Number				rootOrgId;					// 父级市县ID

	private boolean             isLeader;                   // 是否是领导
	private boolean				isAdmin;					// 是否是管理员
	private boolean				isSuper;					// 是否是超级管理员

	private String				roleName;					// 角色名--手机需要

	private Number				orgId;						// 当前部门ID

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Number getUserId() {
		return userId;
	}

	public void setUserId(Number userId) {
		this.userId = userId;
	}

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSeatID() {
		return seatID;
	}

	public void setSeatID(String seatID) {
		this.seatID = seatID;
	}

	public Integer getSeatPriority() {
		return seatPriority;
	}

	public void setSeatPriority(Integer seatPriority) {
		this.seatPriority = seatPriority;
	}

	public String getLoginIP() {
		return loginIP;
	}

	public void setLoginIP(String loginIP) {
		this.loginIP = loginIP;
	}

	public String getSeatIP() {
		return seatIP;
	}

	public void setSeatIP(String seatIP) {
		this.seatIP = seatIP;
	}

	public Integer getUgrpNO() {
		return ugrpNO;
	}

	public void setUgrpNO(Integer ugrpNO) {
		this.ugrpNO = ugrpNO;
	}

	public Integer getOpLevel() {
		return opLevel;
	}

	public void setOpLevel(Integer opLevel) {
		this.opLevel = opLevel;
	}

	public Integer getCallLevel() {
		return callLevel;
	}

	public void setCallLevel(Integer callLevel) {
		this.callLevel = callLevel;
	}

	public String getLimit() {
		return limit;
	}

	public void setLimit(String limit) {
		this.limit = limit;
	}

	public String getXdlimit() {
		return xdlimit;
	}

	public void setXdlimit(String xdlimit) {
		this.xdlimit = xdlimit;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getRootOrgCode() {
		return rootOrgCode;
	}

	public void setRootOrgCode(String rootOrgCode) {
		this.rootOrgCode = rootOrgCode;
	}

	public Number getRootOrgId() {
		return rootOrgId;
	}

	public void setRootOrgId(Number rootOrgId) {
		this.rootOrgId = rootOrgId;
	}

	public boolean isLeader() {
		return isLeader;
	}

	public void setLeader(boolean isLeader) {
		this.isLeader = isLeader;
	}

	public boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public boolean getIsSuper() {
		return isSuper;
	}

	public void setIsSuper(boolean isSuper) {
		this.isSuper = isSuper;
	}

	public Number getOrgId() {
		return orgId;
	}

	public void setOrgId(Number orgId) {
		this.orgId = orgId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (sessionId == null ? 0 : sessionId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if(this == obj) {
			return true;
		}
		if(obj == null) {
			return false;
		}
		if(getClass() != obj.getClass()) {
			return false;
		}
		LoginModel other = (LoginModel)obj;
		if(sessionId == null) {
			if(other.sessionId != null) {
				return false;
			}
		} else if(!sessionId.equals(other.sessionId)) {
			return false;
		}
		return true;
	}
}
