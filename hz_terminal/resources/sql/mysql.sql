/*基础平台基础表 */
CREATE TABLE T_SYS_LOGIN_LOG (
  sessionid VARCHAR(100) NOT NULL ,
  logintype VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '登录类型  正常，注销',
  logintime VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '登录时间',
  loginip VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '登录机器IP',
  logouttime VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '退出时间',
  userid INT(11) NOT NULL COMMENT '登录用户ID',
  PRIMARY KEY (sessionid)
);

CREATE TABLE T_SYS_USER (
  user_id INT(11) NOT NULL AUTO_INCREMENT,
  user_account VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '用户登录名',
  user_name VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '用户中文名',
  PASSWORD VARCHAR(40) COLLATE utf8_bin DEFAULT NULL COMMENT '登录密码(Md5加密)',
  dept_id INT(11) NOT NULL COMMENT '所属部门ID',
  STATUS CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '0:注销  1:正用 2：停用',
  PRIMARY KEY (user_id)
);

CREATE TABLE T_SYS_ROLE
(
  role_id          INT(11) NOT NULL AUTO_INCREMENT,
  role_name        VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '角色名',
  role_description VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '角色描述',
  opt_permissions  LONGTEXT COLLATE utf8_bin DEFAULT NULL COMMENT '角色拥有权限(限制到菜单)',
  no_permissions   LONGTEXT COLLATE utf8_bin DEFAULT NULL COMMENT '角色不具备权限(限制到功能点或按钮级)',
  suporg           INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '所属部门ID',
  STATUS           CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态(0:停止 1：在用)',
  pid              INT(11) COLLATE utf8_bin NOT NULL COMMENT '父级节点ID',
  PRIMARY KEY (role_id)
);

CREATE TABLE T_SYS_MODULE
(
  id          INT(11) NOT NULL AUTO_INCREMENT,
  NAME        VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '模块名称',
  address     VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '模块访问url',
  orderindex  INT(4) COLLATE utf8_bin DEFAULT NULL COMMENT '顺序号',
  p_id        INT(11) NOT NULL COMMENT '上级ID',
  mark        VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '块能模块标识',
  opentype    CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '链接类型(0:内部链接 1：外部链接)',
  iconclass   VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '图标样式',
  modeltype   CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '模块类型',
  description VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '功能介绍',
  usable      CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否启用(0: 否 1：是)',
  PRIMARY KEY (id)
);

CREATE TABLE T_SYS_PARAMETER
(
  id      INT(11) NOT NULL AUTO_INCREMENT,
  p_name  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '参数名称',
  p_acode VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '参数编码',
  sup_id  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '父级ID',
  remark  VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
);

CREATE TABLE T_SYS_USERROLES
(
  id      INT(11) NOT NULL AUTO_INCREMENT,
  role_id INT(11),
  user_id INT(11),
  PRIMARY KEY (id)
);

CREATE TABLE T_SYS_DEPARTMENT
(
  d_id     INT(11) NOT NULL AUTO_INCREMENT,
  d_number VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '部门编号',
  d_name   VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '部门名称',
  d_pid    INT(11) NOT NULL COMMENT '上级部门',
  d_type   CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '部门类型(0:市 1：区 2：县 3：镇)',
  remark   VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (d_id)
);
/*操作日志表*/
create table T_Sys_Operation_Log(
       id         INT(11) NOT NULL AUTO_INCREMENT,
       opt_moudle INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '功能模块ID',
       opt_type   char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '操作类型 0：查 1：新增 2：修改 3：删除',
       opt_time   varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '操作时间',
       status     char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '状态 0：失败 1：成功',
       login_ip   varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '访问IP',
       opt_user   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '操作者ID',
       content    LONGTEXT COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
	   PRIMARY KEY (id)
);
/*数据权限管理表*/
create table T_Sys_DataRelation
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  dept_id  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '主部门ID',
  service_id  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '业务ID',
  other_dept INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '跨部门ID',
  PRIMARY KEY (id)
);
create table T_Sys_DataService
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  serviceName  varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '业务名称',
  serviceTable  varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '业务表',
  serviceView varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '业务视图',
  remark varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '业务描述',
  model_id    INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '业务关联功能点ID',
  PRIMARY KEY (id)
);

/*流程表*/
CREATE TABLE T_WF_FORM
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  fname  VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '表单名称',
  fcode  VARCHAR(60) NOT NULL COMMENT '表单code',
  remark VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '表单描述',
  STATUS CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '表单状态（启用：00S 作废：00X）',
  PRIMARY KEY (id)
);

CREATE TABLE T_WF_ATTR
(
  id         INT(11) NOT NULL AUTO_INCREMENT,
  attrname   VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '属性名称',
  sqltype    CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '属性类型',
  acode      VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '属性code',
  remark     VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '属性描述',
  symbol     CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '统计标志（001：开始时间 002：结束时间）',
  fcode      VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '表单code',
  defvalue   VARCHAR(6) COLLATE utf8_bin DEFAULT NULL COMMENT '默认值 （001：申请人名称 002：部门名称 003:申请人名称可编辑 004：部门名称可编辑）',
  selcontent VARCHAR(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '下拉列表字段',
  selfalg    CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '下拉列表其他标志',
  numgs      VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '数值格式',
  PRIMARY KEY (id)
);

create table T_WF_TEMPLATE
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  tname  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程名称',
  tcode  VARCHAR(6) COLLATE utf8_bin DEFAULT NULL COMMENT '流程类型',
  remark VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '流程描述',
  ftype CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '流程方式（固定：00A 自由：00X）',
  status CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '流程状态（启用：00S 禁用：00X）',
  suporg   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '所属市县',
  formid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (id)
);

create table T_WF_POINT
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  wfid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '流程ID',
  pname  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '节点名称',
  checkuser VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '审批人',
  porder    INT(3) COLLATE utf8_bin DEFAULT NULL COMMENT '排序',
  ptype CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '节点类型（普通：00A 会签：00H）',
  PRIMARY KEY (id)
);

create table T_WF_INSTANCE
(
  id        INT(11) NOT NULL AUTO_INCREMENT,
  name      VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '申请标题',
  fjid      VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '附件ID',
  applicant INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '申请人ID',
  marktime  VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '申请时间',
  pointid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '当前节点ID',
  status    VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '状态（草稿：00A 审批中：00V 通过：00S 不通过：00X 回撤：00R）',
  wfid      INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '流程ID',
  stime     VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '开始时间(用于统计)',
  etime     VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '结束时间(用于统计)',
  content   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '申请内容ID',
  oauser VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '申请参与人(用于统计)',
  PRIMARY KEY (id)
);


create table T_WF_HISTORY
(
  id         INT(11) NOT NULL AUTO_INCREMENT,
  instid 	 INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '实例ID',
  pointid    INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '节点ID',
  checktype  CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '审批类型 同意00S 不同意 00X 撤回 00R',
  content    VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '审批内容',
  checkuser  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '审批人',
  marktime   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '审批时间',
  porder     VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '序号',
  rtset      VARCHAR(6) COLLATE utf8_bin DEFAULT NULL COMMENT '作废标志（回退RT 正常ZC 代办DB 管理员操作ADMIN）',
  PRIMARY KEY (id)
);

/*附件表*/
create table T_ATTACHMENT
(
  id        INT(11) NOT NULL AUTO_INCREMENT,
  name       VARCHAR(300) COLLATE utf8_bin DEFAULT NULL COMMENT '文件名称',
  url        VARCHAR(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '文件地址',
  m_type     VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '文件类型',
  m_size     VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '文件大小',
  uploadid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '上传者ID',
  marktime   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '标记时间年月日',
  uploaddate VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '上传时间',
  PRIMARY KEY (id)
);

/**函数**/
/*获取下级部门*/
DROP FUNCTION IF EXISTS getChildLst;

DELIMITER // 

CREATE FUNCTION `getChildLst`(rootId VARCHAR(11))
RETURNS VARCHAR(1000)
BEGIN
DECLARE sTemp VARCHAR(1000);
DECLARE sTempChd VARCHAR(1000);

SET sTemp = '$';
SET sTempChd = rootId;

WHILE sTempChd IS NOT NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT GROUP_CONCAT(d_id) INTO sTempChd FROM t_sys_department WHERE FIND_IN_SET(d_pid,sTempChd)>0;
END WHILE;
RETURN sTemp;
END
//

/*获取顶级部门*/
DROP FUNCTION IF EXISTS getRootLst;

DELIMITER // 

CREATE FUNCTION `getRootLst`(childId VARCHAR(11))
RETURNS VARCHAR(1000)
BEGIN
DECLARE sTemp VARCHAR(1000);
DECLARE sTempChd VARCHAR(1000);

SET sTemp = '$';
SET sTempChd = childId;

WHILE sTempChd IS NOT NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT GROUP_CONCAT(d_pid) INTO sTempChd FROM t_sys_department WHERE FIND_IN_SET(d_id,sTempChd)>0;
END WHILE;
RETURN sTemp;
END
//

/*获取除了某部门以下的其他下级部门*/
DROP FUNCTION IF EXISTS getChildLstExt;

DELIMITER // 

CREATE FUNCTION `getChildLstExt`(rootId VARCHAR(11),extId INT(11))
RETURNS VARCHAR(1000)
BEGIN
DECLARE sTemp VARCHAR(1000);
DECLARE sTempChd VARCHAR(1000);
DECLARE sExt INT(11);

SET sTemp = '$';
SET sTempChd = rootId;
SET sExt = extId;

WHILE sTempChd IS NOT NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT GROUP_CONCAT(d_id) INTO sTempChd FROM t_sys_department WHERE FIND_IN_SET(d_pid,sTempChd)>0 AND d_id<>sExt;
END WHILE;
RETURN sTemp;
END
//

/**基础数据*/
/*用户*/
INSERT INTO T_SYS_USER (USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
VALUES ('super', 'super', 'QPDnjYqApi0=', 1, '1');

INSERT INTO T_SYS_USER (USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
VALUES ( 'admin', 'admin', 'QPDnjYqApi0=', 1, '1');

/*角色*/
INSERT INTO T_SYS_ROLE ( ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
VALUES ('超级管理员', '超级管理员', '12,9,8,13,14,15,10,35,34,16', '', 0, '1', 0);

INSERT INTO T_SYS_ROLE ( ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
VALUES ('管理员', NULL, '12,9,8,13,14,38,11,43,15,10,16,70,69,74', '', 1, '1', 0);
/*角色与用户关系*/
INSERT INTO T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
VALUES (1, 1, 1);

INSERT INTO T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
VALUES (2, 2, 2);

/*部门*/
INSERT INTO T_SYS_DEPARTMENT (D_NUMBER, D_NAME, D_PID, D_TYPE, REMARK)
VALUES ( '12345', '广东立沃', 0, '0', 'qqqqbbbb');

/*参数*/
INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (1, '行政级别', 'XZJB', 0, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (2, '市', '0', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (3, '区', '1', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (5, '县', '2', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (7, '镇', '3', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (8, '管理员参数', 'GLCS', 0, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (9, '管理员', 'admin', 8, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (10, '对象参数', 'AUTO', 0, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (11, 'model', 'upload/autoTemplate/model.java', 10, 'model类模板文件');

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (12, 'jsp', 'upload/autoTemplate/jsp', 10, 'jsp模板文件');

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (13, 'controller', 'upload/autoTemplate/controller.java', 10, 'controller类模板文件');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (14, '流程类型', 'LCLX', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (15, '请假', '00A', 14, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (16, '加班', '00B', 14, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (17, '外勤', '00C', 14, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (18, '状态', 'LCZT', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (19, '启用', '00S', 18, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (20, '节点类型', 'JDLX', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (24, '普通', '00A', 20, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (25, '会签', '00H', 20, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (26, '禁用', '00X', 18, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (27, '流程方式', 'LCFS', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (28, '固定', '00A', 27, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (29, '自由', '00X', 27, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (30, '实例状态', 'WFZT', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (31, '草稿', '00A', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (32, '审批中', '00V', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (33, '通过', '00S', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (35, '不通过', '00X', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (36, '撤回', '00R', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (37, '历史状态', 'WFRT', 0, '流程流转历史状态');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (38, '流转中', 'ZC', 37, '正常');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (39, '回退', 'RT', 37, '返回发起人');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (40, '撤回', 'TR', 37, '自己主动撤回');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (41, '管理员代办', 'ADMIN', 37, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (42, '导航条参数', 'SYSSET', 0, null);

/*功能模块*/
INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (8, '后台管理', NULL, 1, 0, 'OaManagement', '0', NULL, '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (9, '权限管理', NULL, 1, 8, 'authority', '0', 'icon-lock', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (10, '系统管理', NULL, 2, 8, 'sysmanagement', '0', 'icon-cog', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (11, '工作流管理', NULL, 2, 8, 'workflow', '0', 'icon-script', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (12, '角色管理', 'Main/role', 1, 9, 'rolemg', '0', 'icon-groupadd', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (13, '用户管理', 'Main/user', 2, 9, 'usermg', '0', 'icon-user', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (14, '组织机构管理', 'Main/department', 3, 9, 'departmentmg', '0', 'icon-outline', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (15, '功能模块', 'Main/module', 1, 10, 'functionmg', '0', 'icon-applicationviewcolumns', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (16, '参数管理', 'Main/common', 2, 10, 'commonmg', '0', 'icon-bookopen', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (17, '增加', 'Main/role/add', 1, 12, 'roleAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (18, '修改', 'Main/role/edit', 2, 12, 'roleEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (19, '删除', 'Main/role/delete', 3, 12, 'roleDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (20, '增加', 'Main/user/add', 1, 13, 'userAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (21, '修改', 'Main/user/edit', 2, 13, 'userEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (22, '删除', 'Main/user/delete', 3, 13, 'userDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (23, '增加', 'Main/department/add', 1, 14, 'departmentAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (24, '修改', 'Main/department/edit', 2, 14, 'departmentEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (25, '删除', 'Main/department/delete', 3, 14, 'departmentDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (31, '增加', 'Main/module/add', 1, 15, 'moduleAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (32, '修改', 'Main/module/edit', 2, 15, 'moduleEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (33, '删除', 'Main/module/delete', 3, 15, 'moduleDelete', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (38, '流程表单设计', 'Main/wfForm', 1, 11, 'form_main', '0', 'icon-applicationformadd', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (41, '增加', 'Main/wfForm/add', 1, 38, 'form_add', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (42, '删除', 'Main/wfForm/delete', 2, 38, 'form_del', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (43, '工作流程设计', 'Main/wfTemplate', 2, 11, 'wf_template', '0', 'icon-applicationlink', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (44, '增加', 'Main/wfTemplate/add', 1, 43, 'wftempalte_add', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (45, '修改', 'Main/wfTemplate/update', 2, 43, 'wftemplate_update', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (46, '删除', 'Main/wfTemplate/delete', 3, 43, 'wf_template_delete', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (56, '新增', 'Main/common/add', 1, 16, 'addCommon', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (57, '修改', 'Main/common/edit', 2, 16, 'updCommon', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (58, '删除', 'Main/common/delete', 3, 16, 'delCommon', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (61, '权限分配', 'Main/role/authAssign', 4, 12, 'authAssign', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (62, '用户分配', 'Main/role/userAssign', 5, 12, 'userAssign', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (63, '表单详情', 'Main/wfForm/view', 3, 38, 'form_view', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (64, '属性详情', 'Main/wfForm/attrView', 4, 38, 'form_attrView', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (65, '校验账号唯一性', 'Main/user/ifExistAccount', 4, 13, 'userAccount', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (66, '校验编码唯一性', 'Main/department/ifExistCode', 4, 14, 'departmentCode', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (67, '校验编码唯一性', 'Main/wfForm/check', 5, 38, 'form_checkCode', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (68, '校验模块标识唯一性', 'Main/module/ifExsitMark', 4, 15, 'moduleMark', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (69, '开发工具', NULL, 3, 10, 'automg', '0', 'icon-wrench', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (70, '对象管理', 'Main/autoObject', 1, 69, 'autoObjectmg', '0', 'icon-databasewrench', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (71, '新增', 'Main/autoObject/add', 1, 70, 'autoObj_Add', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (72, '删除', 'Main/autoObject/delete', 2, 70, 'autoObj_del', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (73, '校验编码唯一性', 'Main/autoObject/check', 3, 70, 'autoObj_check', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (74, '视图管理', 'Main/autoView', 2, 69, 'autoViewmg', '0', 'icon-applicationosxkey', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (75, '新增', 'Main/autoView/add', 1, 74, 'autoViewAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (76, '删除', NULL, 2, 74, 'autoViewDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (77, '预览', 'Main/autoView/view', 3, 74, 'autoView_view', '0', NULL, '1', NULL, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (81, '我的申请', 'Main/wfInstance', 3, 11, 'wfinstancemg', '0', 'icon-plugin', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (82, '新增', 'Main/wfInstance/add', 1, 81, 'wfinstAdd', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (83, '修改', 'Main/wfInstance/edit', 2, 81, 'wfinstUpd', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (84, '删除', 'Main/wfInstance/delete', 3, 81, 'wfinstDel', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (85, '撤回', 'Main/wfInstance/redo', 4, 81, 'wfinstRedo', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (86, '我的审批', 'Main/wfVerify', 4, 11, 'wfVerifymg', '0', 'icon-pluginedit', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (87, '审批', 'Main/wfVerify/verify', 1, 86, 'wfVerify', '0', null, '1', null, '1');

/*自动化*/
CREATE TABLE T_AUTOTABLE
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  table_name  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '表名称',
  table_code  VARCHAR(60) NOT NULL COMMENT '表编码',
  dba_type VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '数据库类型',
  dba_name VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '数据源',
  model_path VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '包路径',
  PRIMARY KEY (id)
);

CREATE TABLE T_autoAttr
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  attrname  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '字段名称',
  attrcode  VARCHAR(60) NOT NULL COMMENT '字段编码',
  attrtype CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '字段类型（001：字符 002：数值 003：日期 004：文本）',
  ispkid CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否主键（1：是 0：否）',
  tcode VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '表名称',
  remark VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (id)
);

CREATE TABLE T_autoAttr_ext
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  viewid  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '视图ID',
  attrid  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '字段名称',
  filedcode VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '控件编码',
  filedtext VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '控件名称',
  filedwidth VARCHAR(11) COLLATE utf8_bin DEFAULT NULL COMMENT '控件宽度',
  uitype  VARCHAR(6) NOT NULL COMMENT '控件类型（001：时间控件 002：输入框 003：下拉框 004：复选框 005：单选框 006：文本框）',
  issearch CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否查询（1：是 0：否）',
  isadd CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否新增（1：是 0：否）',
  isedit CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否修改（1：是 0：否）',
  isview CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '是否可见（1：是 0：否）',
  staticval VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '静态参数',
  deafulval VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '变量值',
  uival VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '变量文本',
  PRIMARY KEY (id)
);

CREATE TABLE T_AUTOVIEW
(
  id          INT(11) NOT NULL AUTO_INCREMENT,
  data_source VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '对象 数据表',
  view_layout VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '页面布局 north：上 center：中 south：下 west：左 east：右',
  view_type   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '视图类型 00M：主页 00A：新增 00U：修改',
  view_path   VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '存储地址',
  view_name   VARCHAR(600) COLLATE utf8_bin DEFAULT NULL COMMENT '视图名称',
  controller  VARCHAR(600) COLLATE utf8_bin DEFAULT NULL COMMENT 'controller类名',
  pack_path   VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '包路径',
  PRIMARY KEY (id)
);
