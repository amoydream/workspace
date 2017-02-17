-----------基础平台 基础表
create table T_SYS_SEQUENCE
(
  name VARCHAR2(255) primary key,
  seq  NUMBER
);
comment on column T_SYS_SEQUENCE.name is '表名';
comment on column T_SYS_SEQUENCE.seq is 'id值';

create table T_SYS_LOGIN_LOG
(
  sessionid  VARCHAR2(100) primary key,
  logintype  VARCHAR2(10),
  logintime  VARCHAR2(30),
  loginip    VARCHAR2(30),
  logouttime VARCHAR2(30),
  userid     NUMBER
);
comment on column T_SYS_LOGIN_LOG.logintype  is '登录类型  正常，注销';
comment on column T_SYS_LOGIN_LOG.logintime  is '登录时间';
comment on column T_SYS_LOGIN_LOG.loginip  is '登录机器IP';
comment on column T_SYS_LOGIN_LOG.logouttime  is '退出时间';
comment on column T_SYS_LOGIN_LOG.userid  is '登录用户ID';

create table T_SYS_USER
(
  user_id      NUMBER primary key,
  user_account VARCHAR2(50),
  user_name    VARCHAR2(60),
  password     VARCHAR2(40),
  dept_id      NUMBER,
  status       CHAR(1)
);
comment on column T_SYS_USER.user_account  is '用户登录名';
comment on column T_SYS_USER.user_name  is '用户中文名';
comment on column T_SYS_USER.password  is '登录密码(Md5加密)';
comment on column T_SYS_USER.dept_id  is '所属部门ID';
comment on column T_SYS_USER.status is '0:注销  1:正用 2：停用';

create table T_SYS_ROLE
(
  role_id          NUMBER primary key,
  role_name        VARCHAR2(50),
  role_description VARCHAR2(200),
  opt_permissions  CLOB,
  no_permissions   CLOB,
  suporg           NUMBER,
  status           CHAR(1),
  pid              NUMBER
);
comment on column T_SYS_ROLE.role_name  is '角色名';
comment on column T_SYS_ROLE.role_description  is '角色描述';
comment on column T_SYS_ROLE.opt_permissions  is '角色拥有权限(限制到菜单)';
comment on column T_SYS_ROLE.no_permissions  is '	角色不具备权限(限制到功能点或按钮级)';
comment on column T_SYS_ROLE.suporg  is '所属部门ID';
comment on column T_SYS_ROLE.status  is '状态(0:停止 1：在用)';
comment on column T_SYS_ROLE.pid  is '父级节点ID';

create table T_SYS_MODULE
(
  id          NUMBER primary key,
  name        VARCHAR2(100),
  address     VARCHAR2(100),
  orderindex  NUMBER,
  p_id        NUMBER,
  mark        VARCHAR2(50),
  opentype    CHAR(1),
  iconclass   VARCHAR2(100),
  modeltype   CHAR(1),
  description VARCHAR2(255),
  usable      CHAR(1)
);
comment on column T_SYS_MODULE.name  is '模块名称';
comment on column T_SYS_MODULE.address  is '模块访问url';
comment on column T_SYS_MODULE.orderindex  is '顺序号';
comment on column T_SYS_MODULE.p_id  is '上级ID';
comment on column T_SYS_MODULE.mark  is '块能模块标识';
comment on column T_SYS_MODULE.opentype  is '链接类型(0:内部链接 1：外部链接)';
comment on column T_SYS_MODULE.iconclass  is '图标样式';
comment on column T_SYS_MODULE.modeltype  is '模块类型';
comment on column T_SYS_MODULE.description  is '功能介绍';
comment on column T_SYS_MODULE.usable  is '是否启用(0: 否 1：是)';

create table T_SYS_PARAMETER
(
  id      NUMBER primary key,
  p_name  VARCHAR2(100),
  p_acode VARCHAR2(100),
  sup_id  NUMBER,
  remark  VARCHAR2(255)
);
comment on column T_SYS_PARAMETER.p_name  is '参数名称';
comment on column T_SYS_PARAMETER.p_acode  is '参数编码';
comment on column T_SYS_PARAMETER.sup_id  is '父级ID';
comment on column T_SYS_PARAMETER.remark  is '备注';


create table T_SYS_USERROLES
(
  id      NUMBER primary key,
  role_id NUMBER,
  user_id NUMBER
);

create table T_SYS_DEPARTMENT
(
  d_id     NUMBER primary key,
  d_number VARCHAR2(30),
  d_name   VARCHAR2(100),
  d_pid    NUMBER,
  d_type   CHAR(1),
  remark   VARCHAR2(255)
);
comment on column T_SYS_DEPARTMENT.d_number  is '部门编号';
comment on column T_SYS_DEPARTMENT.d_name  is '部门名称';
comment on column T_SYS_DEPARTMENT.d_pid  is '上级部门';
comment on column T_SYS_DEPARTMENT.d_type  is '部门类型(0:市 1：区 2：县 3：镇)';
comment on column T_SYS_DEPARTMENT.remark  is '备注';

--------操作日志表
create table T_Sys_Operation_Log(
       id         number(11) primary key,
       opt_moudle number(11),
       opt_type   char(1),
       opt_time   varchar2(20),
       status     char(1),
       login_ip   varchar2(20),
       opt_user   number(11),
       content    clob
);
comment on column T_Sys_Operation_Log.opt_moudle is '功能模块ID';
comment on column T_Sys_Operation_Log.opt_type is '操作类型 0：查 1：新增 2：修改 3：删除';
comment on column T_Sys_Operation_Log.opt_time is '操作时间';
comment on column T_Sys_Operation_Log.status is '状态 0：失败 1：成功';
comment on column T_Sys_Operation_Log.login_ip is '访问IP';
comment on column T_Sys_Operation_Log.opt_user is '操作者ID';
comment on column T_Sys_Operation_Log.content is '内容';

------------数据权限管理表
create table T_Sys_DataRelation
(
  id     NUMBER(11) primary key,
  dept_id  NUMBER(11),
  service_id  NUMBER(11),
  other_dept NUMBER(11)
);

comment on column T_Sys_DataRelation.dept_id is '主部门ID';
comment on column T_Sys_DataRelation.service_id is '业务ID';
comment on column T_Sys_DataRelation.other_dept is '跨部门ID';


create table T_Sys_DataService
(
  id     NUMBER(11) primary key,
  serviceName  varchar2(100),
  serviceTable  varchar2(100),
  serviceView varchar2(100),
  remark varchar2(2000),
  model_id    NUMBER(11)
);

comment on column T_Sys_DataService.serviceName is '业务名称';
comment on column T_Sys_DataService.serviceTable is '业务表';
comment on column T_Sys_DataService.serviceView is '业务视图';
comment on column T_Sys_DataService.remark is '业务描述';
comment on column T_Sys_DataService.model_id is '业务关联功能点ID';



--------------------------------流程表
create table T_WF_FORM
(
  id     NUMBER(11) primary key,
  fname  VARCHAR2(60),
  fcode  VARCHAR2(60) not null,
  remark VARCHAR2(2000),
  status CHAR(3)
);
comment on column T_WF_FORM.id  is '流程表单ID';
comment on column T_WF_FORM.fname  is '表单名称';
comment on column T_WF_FORM.fcode  is '表单code';
comment on column T_WF_FORM.remark  is '表单描述';
comment on column T_WF_FORM.status  is '表单状态（启用：00S 作废：00X）';

create table T_WF_ATTR
(
  id         NUMBER(11) primary key,
  attrname   VARCHAR2(60),
  sqltype    CHAR(3),
  acode      VARCHAR2(200),
  remark     VARCHAR2(255),
  symbol     CHAR(3),
  fcode      VARCHAR2(60),
  defvalue   VARCHAR2(6),
  selcontent VARCHAR2(1000),
  selfalg    CHAR(1),
  numgs      VARCHAR2(2000)
);
comment on column T_WF_ATTR.id  is '表单属性ID';
comment on column T_WF_ATTR.attrname  is '属性名称';
comment on column T_WF_ATTR.sqltype  is '属性类型';
comment on column T_WF_ATTR.acode  is '属性code';
comment on column T_WF_ATTR.remark  is '属性描述';
comment on column T_WF_ATTR.symbol  is '统计标志（001：开始时间 002：结束时间）';
comment on column T_WF_ATTR.fcode  is '表单code';
comment on column T_WF_ATTR.defvalue  is '默认值 （001：申请人名称 002：部门名称 003:申请人名称可编辑 004：部门名称可编辑）';
comment on column T_WF_ATTR.selcontent  is '下拉列表字段';
comment on column T_WF_ATTR.selfalg  is '下拉列表其他标志';
comment on column T_WF_ATTR.numgs  is '数值格式';

create table T_WF_TEMPLATE
(
  id     NUMBER(11) primary key,
  tname  VARCHAR2(100),
  tcode  VARCHAR2(6),
  remark VARCHAR2(2000),
  ftype CHAR(3),
  status CHAR(3),
  suporg   VARCHAR2(20),
  formid   number(11)
);

comment on column T_WF_TEMPLATE.id
  is '流程ID';
comment on column T_WF_TEMPLATE.tname
  is '流程名称';
comment on column T_WF_TEMPLATE.tcode
  is '流程类型';
comment on column T_WF_TEMPLATE.ftype
  is '流程方式（固定：00A 自由：00X）';
comment on column T_WF_TEMPLATE.remark
  is '流程描述';
comment on column T_WF_TEMPLATE.status
  is '流程状态（启用：00S 禁用：00X）';
comment on column T_WF_TEMPLATE.suporg
  is '所属市县';
comment on column T_WF_TEMPLATE.formid
  is '表单ID';  
  
create table T_WF_POINT
(
  id     NUMBER(11) primary key,
  wfid   NUMBER(11),
  pname  VARCHAR2(100),
  checkuser VARCHAR2(2000),
  porder    NUMBER(3),
  ptype CHAR(3)
);

comment on column T_WF_POINT.id
  is '节点ID';
comment on column T_WF_POINT.pname
  is '节点名称';
comment on column T_WF_POINT.checkuser
  is '审批人';
comment on column T_WF_POINT.ptype
  is '节点类型（普通：00A 会签：00H）';
comment on column T_WF_POINT.porder
  is '排序';
comment on column T_WF_POINT.wfid
  is '流程ID';
  
create table T_WF_INSTANCE
(
  id        NUMBER(11) primary key,
  name      VARCHAR2(60),
  fjid      VARCHAR2(200),
  applicant NUMBER(11),
  marktime  VARCHAR2(20),
  pointid   NUMBER(11),
  status    VARCHAR2(10),
  wfid      NUMBER(11),
  stime     VARCHAR2(30),
  etime     VARCHAR2(30),
  content   NUMBER(11),
  oauser VARCHAR2(2000)
);
comment on column T_WF_INSTANCE.id
  is '实例ID';
comment on column T_WF_INSTANCE.name
  is '申请标题';
comment on column T_WF_INSTANCE.fjid
  is '附件ID';
comment on column T_WF_INSTANCE.applicant
  is '申请人';
comment on column T_WF_INSTANCE.marktime
  is '申请时间';
comment on column T_WF_INSTANCE.pointid
  is '当前节点ID';
comment on column T_WF_INSTANCE.status
  is '状态（草稿：00A 审批中：00V 通过：00S 不通过：00X 回撤：00R）';
comment on column T_WF_INSTANCE.stime
  is '开始时间';
comment on column T_WF_INSTANCE.etime
  is '结束时间';
comment on column T_WF_INSTANCE.content
  is '申请内容';
comment on column T_WF_INSTANCE.oauser
  is '申请参与人(用于统计)';
  
  
create table T_WF_HISTORY
(
  id         NUMBER(11) primary key,
  instid NUMBER(11),
  pointid    NUMBER(11),
  checktype  CHAR(3),
  content    VARCHAR2(2000),
  checkuser  NUMBER(11),
  marktime   VARCHAR2(20),
  porder     VARCHAR2(10),
  rtset      VARCHAR2(6)
);
comment on column T_WF_HISTORY.id
  is '历史ID';
comment on column T_WF_HISTORY.instid
  is '实例ID';
comment on column T_WF_HISTORY.pointid
  is '节点ID';
comment on column T_WF_HISTORY.checktype
  is '审批类型 同意00S 不同意 00X 撤回 00R';
comment on column T_WF_HISTORY.content
  is '审批内容';
comment on column T_WF_HISTORY.checkuser
  is '审批人';
comment on column T_WF_HISTORY.marktime
  is '审批时间';
comment on column T_WF_HISTORY.porder
  is '序号';
comment on column T_WF_HISTORY.rtset
  is '作废标志（回退RT 正常ZC 代办DB）';
-------------附件
create table T_ATTACHMENT
(
  id         NUMBER(11) primary key,
  name       VARCHAR2(300),
  url        VARCHAR2(1000),
  m_type     VARCHAR2(10),
  m_size     VARCHAR2(10),
  uploadid   NUMBER(11),
  marktime   VARCHAR2(20),
  uploaddate VARCHAR2(20)
);
comment on column T_ATTACHMENT.id
  is '附件ID';
comment on column T_ATTACHMENT.name
  is '附件名称';
comment on column T_ATTACHMENT.url
  is '附件地址';
comment on column T_ATTACHMENT.m_type
  is '附件类型';
comment on column T_ATTACHMENT.m_size
  is '附件大小';
comment on column T_ATTACHMENT.uploadid
  is '上传者';
comment on column T_ATTACHMENT.uploaddate
  is '上传时间';
------------自动化
create table T_AUTOTABLE
(
  id     NUMBER(11) primary key,
  table_name  VARCHAR2(100),
  table_code  VARCHAR2(60) not null,
  dba_type varchar2(10),
  dba_name VARCHAR2(200),
  model_path VARCHAR2(2000)
);

comment on column T_AUTOTABLE.table_name is '表名称';
comment on column T_AUTOTABLE.table_code is '表编码';
comment on column T_AUTOTABLE.dba_type is '数据库类型';
comment on column T_AUTOTABLE.dba_name is '数据源';
comment on column T_AUTOTABLE.model_path is '包路径';

create table T_autoAttr
(
  id     NUMBER(11) primary key,
  attrname  VARCHAR2(100),
  attrcode  VARCHAR2(60) not null,
  attrtype CHAR(3),
  ispkid CHAR(1),
  tcode varchar2(200),
  remark varchar2(255)
);

comment on column T_autoAttr.attrname is '字段名称';
comment on column T_autoAttr.attrcode is '字段编码';
comment on column T_autoAttr.attrtype is '字段类型（001：字符 002：数值 003：日期 004：文本）';
comment on column T_autoAttr.ispkid is '是否主键（1：是 0：否）';
comment on column T_autoAttr.tcode is '表名称';
comment on column T_autoAttr.remark is '备注';

create table T_autoAttr_ext
(
  id     NUMBER(11) primary key,
  viewid  NUMBER(11),
  attrid  NUMBER(11),
  filedcode VARCHAR2(60),
  filedtext VARCHAR2(100),
  filedwidth VARCHAR2(11),
  uitype  VARCHAR2(6) not null,
  issearch CHAR(1),
  isadd CHAR(1),
  isedit CHAR(1),
  isview CHAR(1),
  staticval VARCHAR2(255),
  deafulval VARCHAR2(200),
  uival VARCHAR2(2000)
);
comment on column T_autoAttr_ext.attrid is '字段ID';
comment on column T_autoAttr_ext.viewid is '视图ID';
comment on column T_autoAttr_ext.uitype is '控件类型（001：时间控件 002：输入框 003：下拉框 004：复选框 005：单选框 006：文本框）';
comment on column T_autoAttr_ext.issearch is '是否查询（1：是 0：否）';
comment on column T_autoAttr_ext.isadd is '是否新增（1：是 0：否）';
comment on column T_autoAttr_ext.isedit is '是否修改（1：是 0：否）';
comment on column T_autoAttr_ext.isview is '是否可见（1：是 0：否）';
comment on column T_autoAttr_ext.staticval is '静态参数';
comment on column T_autoAttr_ext.deafulval is '默认值';
comment on column T_autoAttr_ext.uival is '控件变量值';

create table T_AUTOVIEW
(
  id          NUMBER(11) not null primary key,
  data_source VARCHAR2(255),
  view_layout VARCHAR2(50),
  view_type   VARCHAR2(20),
  view_path   VARCHAR2(2000),
  view_name   VARCHAR2(600),
  controller  VARCHAR2(600),
  pack_path   VARCHAR2(2000)
);
comment on column T_AUTOVIEW.id  is '主键ID';
comment on column T_AUTOVIEW.data_source  is '对象 数据表';
comment on column T_AUTOVIEW.view_layout  is '页面布局 north：上 center：中 south：下 west：左 east：右';
comment on column T_AUTOVIEW.view_type  is '视图类型 00M：主页 00A：新增 00U：修改';
comment on column T_AUTOVIEW.view_path  is '存储地址';
comment on column T_AUTOVIEW.view_name  is '视图名称';
comment on column T_AUTOVIEW.controller  is 'controller类名';
comment on column T_AUTOVIEW.pack_path  is '包路径';


create table T_BUS_MAPCONFIG
(
  ID        NUMBER not null primary key,
  LNG       NUMBER,
  LAT       NUMBER,
  ZOOM      NUMBER,
  APIURL    VARCHAR2(200),
  GISURL    VARCHAR2(200),
  ONLINEMAP CHAR(1)
);
comment on column T_BUS_MAPCONFIG.ID is '主键';
comment on column T_BUS_MAPCONFIG.LNG  is '经度';
comment on column T_BUS_MAPCONFIG.LAT  is '纬度';
comment on column T_BUS_MAPCONFIG.ZOOM  is '放大级数';
comment on column T_BUS_MAPCONFIG.APIURL  is 'arcgis api地址';
comment on column T_BUS_MAPCONFIG.GISURL  is 'arcgis 地图地址';
comment on column T_BUS_MAPCONFIG.ONLINEMAP  is '0:arcgis地图  1:百度地图';


------------------数据
-------用户
insert into T_SYS_USER (USER_ID, USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
values (2, 'admin', 'admin', 'QPDnjYqApi0=', 1, '1');

insert into T_SYS_USER (USER_ID, USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
values (1, 'super', 'super', 'QPDnjYqApi0=', 1, '1');
------------角色
insert into T_SYS_ROLE (ROLE_ID, ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
values (1, '超级管理员', '超级管理员', '12,9,8,13,14,15,10,35,34,16', '', 0, '1', null);

insert into T_SYS_ROLE (ROLE_ID, ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
values (2, '管理员', null, '12,9,8,13,14,38,11,43,15,10,16,70,69,74', '', 1, '1', null);
-------角色与用户关系
insert into T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
values (1, 1, 1);

insert into T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
values (2, 2, 2);

-----------部门
insert into T_SYS_DEPARTMENT (D_ID, D_NUMBER, D_NAME, D_PID, D_TYPE, REMARK)
values (1, '12345', '广东立沃', 0, '0', 'qqqqbbbb');

--------------------功能模块
insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (8, '后台管理', null, 1, 0, 'OaManagement', '0', null, '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (9, '权限管理', null, 1, 8, 'authority', '0', 'icon-lock', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (10, '系统管理', null, 2, 8, 'sysmanagement', '0', 'icon-cog', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (11, '工作流管理', null, 2, 8, 'workflow', '0', 'icon-script', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (12, '角色管理', 'Main/role', 1, 9, 'rolemg', '0', 'icon-groupadd', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (13, '用户管理', 'Main/user', 2, 9, 'usermg', '0', 'icon-user', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (14, '组织机构管理', 'Main/department', 3, 9, 'departmentmg', '0', 'icon-outline', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (15, '功能模块', 'Main/module', 1, 10, 'functionmg', '0', 'icon-applicationviewcolumns', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (16, '参数管理', 'Main/common', 2, 10, 'commonmg', '0', 'icon-bookopen', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (17, '增加', 'Main/role/add', 1, 12, 'roleAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (18, '修改', 'Main/role/edit', 2, 12, 'roleEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (19, '删除', 'Main/role/delete', 3, 12, 'roleDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (20, '增加', 'Main/user/add', 1, 13, 'userAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (21, '修改', 'Main/user/edit', 2, 13, 'userEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (22, '删除', 'Main/user/delete', 3, 13, 'userDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (23, '增加', 'Main/department/add', 1, 14, 'departmentAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (24, '修改', 'Main/department/edit', 2, 14, 'departmentEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (25, '删除', 'Main/department/delete', 3, 14, 'departmentDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (31, '增加', 'Main/module/add', 1, 15, 'moduleAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (32, '修改', 'Main/module/edit', 2, 15, 'moduleEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (33, '删除', 'Main/module/delete', 3, 15, 'moduleDelete', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (38, '流程表单设计', 'Main/wfForm', 1, 11, 'form_main', '0', 'icon-applicationformadd', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (41, '增加', 'Main/wfForm/add', 1, 38, 'form_add', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (42, '删除', 'Main/wfForm/delete', 2, 38, 'form_del', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (43, '工作流程设计', 'Main/wfTemplate', 2, 11, 'wf_template', '0', 'icon-applicationlink', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (44, '增加', 'Main/wfTemplate/add', 1, 43, 'wftempalte_add', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (45, '修改', 'Main/wfTemplate/update', 2, 43, 'wftemplate_update', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (46, '删除', 'Main/wfTemplate/delete', 3, 43, 'wf_template_delete', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (56, '新增', 'Main/common/add', 1, 16, 'addCommon', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (57, '修改', 'Main/common/edit', 2, 16, 'updCommon', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (58, '删除', 'Main/common/delete', 3, 16, 'delCommon', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (61, '权限分配', 'Main/role/authAssign', 4, 12, 'authAssign', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (62, '用户分配', 'Main/role/userAssign', 5, 12, 'userAssign', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (63, '表单详情', 'Main/wfForm/view', 3, 38, 'form_view', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (64, '属性详情', 'Main/wfForm/attrView', 4, 38, 'form_attrView', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (65, '校验账号唯一性', 'Main/user/ifExistAccount', 4, 13, 'userAccount', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (66, '校验编码唯一性', 'Main/department/ifExistCode', 4, 14, 'departmentCode', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (67, '校验编码唯一性', 'Main/wfForm/check', 5, 38, 'form_checkCode', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (68, '校验模块标识唯一性', 'Main/module/ifExsitMark', 4, 15, 'moduleMark', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (69, '开发工具', null, 3, 10, 'automg', '0', 'icon-wrench', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (70, '对象管理', 'Main/autoObject', 1, 69, 'autoObjectmg', '0', 'icon-databasewrench', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (71, '新增', 'Main/autoObject/add', 1, 70, 'autoObj_Add', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (72, '删除', 'Main/autoObject/delete', 2, 70, 'autoObj_del', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (73, '校验编码唯一性', 'Main/autoObject/check', 3, 70, 'autoObj_check', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (74, '视图管理', 'Main/autoView', 2, 69, 'autoViewmg', '0', 'icon-applicationosxkey', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (75, '新增', 'Main/autoView/add', 1, 74, 'autoViewAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (76, '删除', null, 2, 74, 'autoViewDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (77, '预览', 'Main/autoView/view', 3, 74, 'autoView_view', '0', null, '1', null, '1');

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

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (88, '数据管理', 'Main/dataService', 4, 9, 'dataServicemg', '0', 'icon-bricks', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (89, '配置数据权限', 'Main/dataservice/dataRole', 1, 88, 'dataService_add', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (90, '删除', 'Main/dataService/delete', 2, 88, 'dataService_del', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (91, '业务管理', 'Main/service', 2, 10, 'servicemg', '0', 'icon-brick', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (92, '新增', 'Main/service/add', 1, 91, 'service_add', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (93, '修改', 'Main/service/edit', 2, 91, 'service_upd', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (94, '删除', 'Main/service/delete', 3, 91, 'service_del', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (95, '地图管理', '', 5, 8, 'gismanage', '0', 'icon-world', '0', '', '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (96, '地图配置', 'Main/geographic/manage', 1, 95, 'gisconfig', '0', 'icon-worldconnect', '0', '', '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (97, '配置查看', 'Main/geographic/manage/index', 1, 96, 'gismanageview', '0', '', '1', '', '1');




--------------参数
insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (1, '行政级别', 'XZJB', 0, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (2, '市', '0', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (3, '区', '1', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (5, '县', '2', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (7, '镇', '3', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (8, '管理员参数', 'GLCS', 0, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (9, '管理员', 'admin', 8, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (10, '对象参数', 'AUTO', 0, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (11, 'model', 'upload/autoTemplate/model.java', 10, 'model类模板文件');

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (12, 'jsp', 'upload/autoTemplate/jsp', 10, 'jsp模板文件');

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (13, 'controller', 'upload/autoTemplate/controller.java', 10, 'controller类模板文件');

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

--------------序列
insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Sys_Module', 97);

insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Sys_Role', 2);

insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Sys_UserRoles', 2);

insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Sys_Parameter', 42);

insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Sys_User', 2);

insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Sys_Department', 1);

insert into T_SYS_SEQUENCE (NAME, SEQ)
values ('T_Bus_MapConfig', 1);


insert into t_bus_mapconfig (ID, LNG, LAT, ZOOM, APIURL, GISURL, ONLINEMAP)
values (1, 114.45847, 22.796621, 14, '', '', '1');

