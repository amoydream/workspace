-----------����ƽ̨ ������
create table T_SYS_SEQUENCE
(
  name VARCHAR2(255) primary key,
  seq  NUMBER
);
comment on column T_SYS_SEQUENCE.name is '����';
comment on column T_SYS_SEQUENCE.seq is 'idֵ';

create table T_SYS_LOGIN_LOG
(
  sessionid  VARCHAR2(100) primary key,
  logintype  VARCHAR2(10),
  logintime  VARCHAR2(30),
  loginip    VARCHAR2(30),
  logouttime VARCHAR2(30),
  userid     NUMBER
);
comment on column T_SYS_LOGIN_LOG.logintype  is '��¼����  ������ע��';
comment on column T_SYS_LOGIN_LOG.logintime  is '��¼ʱ��';
comment on column T_SYS_LOGIN_LOG.loginip  is '��¼����IP';
comment on column T_SYS_LOGIN_LOG.logouttime  is '�˳�ʱ��';
comment on column T_SYS_LOGIN_LOG.userid  is '��¼�û�ID';

create table T_SYS_USER
(
  user_id      NUMBER primary key,
  user_account VARCHAR2(50),
  user_name    VARCHAR2(60),
  password     VARCHAR2(40),
  dept_id      NUMBER,
  status       CHAR(1)
);
comment on column T_SYS_USER.user_account  is '�û���¼��';
comment on column T_SYS_USER.user_name  is '�û�������';
comment on column T_SYS_USER.password  is '��¼����(Md5����)';
comment on column T_SYS_USER.dept_id  is '��������ID';
comment on column T_SYS_USER.status is '0:ע��  1:���� 2��ͣ��';

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
comment on column T_SYS_ROLE.role_name  is '��ɫ��';
comment on column T_SYS_ROLE.role_description  is '��ɫ����';
comment on column T_SYS_ROLE.opt_permissions  is '��ɫӵ��Ȩ��(���Ƶ��˵�)';
comment on column T_SYS_ROLE.no_permissions  is '	��ɫ���߱�Ȩ��(���Ƶ����ܵ��ť��)';
comment on column T_SYS_ROLE.suporg  is '��������ID';
comment on column T_SYS_ROLE.status  is '״̬(0:ֹͣ 1������)';
comment on column T_SYS_ROLE.pid  is '�����ڵ�ID';

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
comment on column T_SYS_MODULE.name  is 'ģ������';
comment on column T_SYS_MODULE.address  is 'ģ�����url';
comment on column T_SYS_MODULE.orderindex  is '˳���';
comment on column T_SYS_MODULE.p_id  is '�ϼ�ID';
comment on column T_SYS_MODULE.mark  is '����ģ���ʶ';
comment on column T_SYS_MODULE.opentype  is '��������(0:�ڲ����� 1���ⲿ����)';
comment on column T_SYS_MODULE.iconclass  is 'ͼ����ʽ';
comment on column T_SYS_MODULE.modeltype  is 'ģ������';
comment on column T_SYS_MODULE.description  is '���ܽ���';
comment on column T_SYS_MODULE.usable  is '�Ƿ�����(0: �� 1����)';

create table T_SYS_PARAMETER
(
  id      NUMBER primary key,
  p_name  VARCHAR2(100),
  p_acode VARCHAR2(100),
  sup_id  NUMBER,
  remark  VARCHAR2(255)
);
comment on column T_SYS_PARAMETER.p_name  is '��������';
comment on column T_SYS_PARAMETER.p_acode  is '��������';
comment on column T_SYS_PARAMETER.sup_id  is '����ID';
comment on column T_SYS_PARAMETER.remark  is '��ע';


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
comment on column T_SYS_DEPARTMENT.d_number  is '���ű��';
comment on column T_SYS_DEPARTMENT.d_name  is '��������';
comment on column T_SYS_DEPARTMENT.d_pid  is '�ϼ�����';
comment on column T_SYS_DEPARTMENT.d_type  is '��������(0:�� 1���� 2���� 3����)';
comment on column T_SYS_DEPARTMENT.remark  is '��ע';

--------������־��
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
comment on column T_Sys_Operation_Log.opt_moudle is '����ģ��ID';
comment on column T_Sys_Operation_Log.opt_type is '�������� 0���� 1������ 2���޸� 3��ɾ��';
comment on column T_Sys_Operation_Log.opt_time is '����ʱ��';
comment on column T_Sys_Operation_Log.status is '״̬ 0��ʧ�� 1���ɹ�';
comment on column T_Sys_Operation_Log.login_ip is '����IP';
comment on column T_Sys_Operation_Log.opt_user is '������ID';
comment on column T_Sys_Operation_Log.content is '����';

------------����Ȩ�޹����
create table T_Sys_DataRelation
(
  id     NUMBER(11) primary key,
  dept_id  NUMBER(11),
  service_id  NUMBER(11),
  other_dept NUMBER(11)
);

comment on column T_Sys_DataRelation.dept_id is '������ID';
comment on column T_Sys_DataRelation.service_id is 'ҵ��ID';
comment on column T_Sys_DataRelation.other_dept is '�粿��ID';


create table T_Sys_DataService
(
  id     NUMBER(11) primary key,
  serviceName  varchar2(100),
  serviceTable  varchar2(100),
  serviceView varchar2(100),
  remark varchar2(2000),
  model_id    NUMBER(11)
);

comment on column T_Sys_DataService.serviceName is 'ҵ������';
comment on column T_Sys_DataService.serviceTable is 'ҵ���';
comment on column T_Sys_DataService.serviceView is 'ҵ����ͼ';
comment on column T_Sys_DataService.remark is 'ҵ������';
comment on column T_Sys_DataService.model_id is 'ҵ��������ܵ�ID';



--------------------------------���̱�
create table T_WF_FORM
(
  id     NUMBER(11) primary key,
  fname  VARCHAR2(60),
  fcode  VARCHAR2(60) not null,
  remark VARCHAR2(2000),
  status CHAR(3)
);
comment on column T_WF_FORM.id  is '���̱�ID';
comment on column T_WF_FORM.fname  is '������';
comment on column T_WF_FORM.fcode  is '��code';
comment on column T_WF_FORM.remark  is '������';
comment on column T_WF_FORM.status  is '��״̬�����ã�00S ���ϣ�00X��';

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
comment on column T_WF_ATTR.id  is '������ID';
comment on column T_WF_ATTR.attrname  is '��������';
comment on column T_WF_ATTR.sqltype  is '��������';
comment on column T_WF_ATTR.acode  is '����code';
comment on column T_WF_ATTR.remark  is '��������';
comment on column T_WF_ATTR.symbol  is 'ͳ�Ʊ�־��001����ʼʱ�� 002������ʱ�䣩';
comment on column T_WF_ATTR.fcode  is '��code';
comment on column T_WF_ATTR.defvalue  is 'Ĭ��ֵ ��001������������ 002���������� 003:���������ƿɱ༭ 004���������ƿɱ༭��';
comment on column T_WF_ATTR.selcontent  is '�����б��ֶ�';
comment on column T_WF_ATTR.selfalg  is '�����б�������־';
comment on column T_WF_ATTR.numgs  is '��ֵ��ʽ';

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
  is '����ID';
comment on column T_WF_TEMPLATE.tname
  is '��������';
comment on column T_WF_TEMPLATE.tcode
  is '��������';
comment on column T_WF_TEMPLATE.ftype
  is '���̷�ʽ���̶���00A ���ɣ�00X��';
comment on column T_WF_TEMPLATE.remark
  is '��������';
comment on column T_WF_TEMPLATE.status
  is '����״̬�����ã�00S ���ã�00X��';
comment on column T_WF_TEMPLATE.suporg
  is '��������';
comment on column T_WF_TEMPLATE.formid
  is '��ID';  
  
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
  is '�ڵ�ID';
comment on column T_WF_POINT.pname
  is '�ڵ�����';
comment on column T_WF_POINT.checkuser
  is '������';
comment on column T_WF_POINT.ptype
  is '�ڵ����ͣ���ͨ��00A ��ǩ��00H��';
comment on column T_WF_POINT.porder
  is '����';
comment on column T_WF_POINT.wfid
  is '����ID';
  
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
  is 'ʵ��ID';
comment on column T_WF_INSTANCE.name
  is '�������';
comment on column T_WF_INSTANCE.fjid
  is '����ID';
comment on column T_WF_INSTANCE.applicant
  is '������';
comment on column T_WF_INSTANCE.marktime
  is '����ʱ��';
comment on column T_WF_INSTANCE.pointid
  is '��ǰ�ڵ�ID';
comment on column T_WF_INSTANCE.status
  is '״̬���ݸ壺00A �����У�00V ͨ����00S ��ͨ����00X �س���00R��';
comment on column T_WF_INSTANCE.stime
  is '��ʼʱ��';
comment on column T_WF_INSTANCE.etime
  is '����ʱ��';
comment on column T_WF_INSTANCE.content
  is '��������';
comment on column T_WF_INSTANCE.oauser
  is '���������(����ͳ��)';
  
  
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
  is '��ʷID';
comment on column T_WF_HISTORY.instid
  is 'ʵ��ID';
comment on column T_WF_HISTORY.pointid
  is '�ڵ�ID';
comment on column T_WF_HISTORY.checktype
  is '�������� ͬ��00S ��ͬ�� 00X ���� 00R';
comment on column T_WF_HISTORY.content
  is '��������';
comment on column T_WF_HISTORY.checkuser
  is '������';
comment on column T_WF_HISTORY.marktime
  is '����ʱ��';
comment on column T_WF_HISTORY.porder
  is '���';
comment on column T_WF_HISTORY.rtset
  is '���ϱ�־������RT ����ZC ����DB��';
-------------����
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
  is '����ID';
comment on column T_ATTACHMENT.name
  is '��������';
comment on column T_ATTACHMENT.url
  is '������ַ';
comment on column T_ATTACHMENT.m_type
  is '��������';
comment on column T_ATTACHMENT.m_size
  is '������С';
comment on column T_ATTACHMENT.uploadid
  is '�ϴ���';
comment on column T_ATTACHMENT.uploaddate
  is '�ϴ�ʱ��';
------------�Զ���
create table T_AUTOTABLE
(
  id     NUMBER(11) primary key,
  table_name  VARCHAR2(100),
  table_code  VARCHAR2(60) not null,
  dba_type varchar2(10),
  dba_name VARCHAR2(200),
  model_path VARCHAR2(2000)
);

comment on column T_AUTOTABLE.table_name is '������';
comment on column T_AUTOTABLE.table_code is '�����';
comment on column T_AUTOTABLE.dba_type is '���ݿ�����';
comment on column T_AUTOTABLE.dba_name is '����Դ';
comment on column T_AUTOTABLE.model_path is '��·��';

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

comment on column T_autoAttr.attrname is '�ֶ�����';
comment on column T_autoAttr.attrcode is '�ֶα���';
comment on column T_autoAttr.attrtype is '�ֶ����ͣ�001���ַ� 002����ֵ 003������ 004���ı���';
comment on column T_autoAttr.ispkid is '�Ƿ�������1���� 0����';
comment on column T_autoAttr.tcode is '������';
comment on column T_autoAttr.remark is '��ע';

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
comment on column T_autoAttr_ext.attrid is '�ֶ�ID';
comment on column T_autoAttr_ext.viewid is '��ͼID';
comment on column T_autoAttr_ext.uitype is '�ؼ����ͣ�001��ʱ��ؼ� 002������� 003�������� 004����ѡ�� 005����ѡ�� 006���ı���';
comment on column T_autoAttr_ext.issearch is '�Ƿ��ѯ��1���� 0����';
comment on column T_autoAttr_ext.isadd is '�Ƿ�������1���� 0����';
comment on column T_autoAttr_ext.isedit is '�Ƿ��޸ģ�1���� 0����';
comment on column T_autoAttr_ext.isview is '�Ƿ�ɼ���1���� 0����';
comment on column T_autoAttr_ext.staticval is '��̬����';
comment on column T_autoAttr_ext.deafulval is 'Ĭ��ֵ';
comment on column T_autoAttr_ext.uival is '�ؼ�����ֵ';

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
comment on column T_AUTOVIEW.id  is '����ID';
comment on column T_AUTOVIEW.data_source  is '���� ���ݱ�';
comment on column T_AUTOVIEW.view_layout  is 'ҳ�沼�� north���� center���� south���� west���� east����';
comment on column T_AUTOVIEW.view_type  is '��ͼ���� 00M����ҳ 00A������ 00U���޸�';
comment on column T_AUTOVIEW.view_path  is '�洢��ַ';
comment on column T_AUTOVIEW.view_name  is '��ͼ����';
comment on column T_AUTOVIEW.controller  is 'controller����';
comment on column T_AUTOVIEW.pack_path  is '��·��';


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
comment on column T_BUS_MAPCONFIG.ID is '����';
comment on column T_BUS_MAPCONFIG.LNG  is '����';
comment on column T_BUS_MAPCONFIG.LAT  is 'γ��';
comment on column T_BUS_MAPCONFIG.ZOOM  is '�Ŵ���';
comment on column T_BUS_MAPCONFIG.APIURL  is 'arcgis api��ַ';
comment on column T_BUS_MAPCONFIG.GISURL  is 'arcgis ��ͼ��ַ';
comment on column T_BUS_MAPCONFIG.ONLINEMAP  is '0:arcgis��ͼ  1:�ٶȵ�ͼ';


------------------����
-------�û�
insert into T_SYS_USER (USER_ID, USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
values (2, 'admin', 'admin', 'QPDnjYqApi0=', 1, '1');

insert into T_SYS_USER (USER_ID, USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
values (1, 'super', 'super', 'QPDnjYqApi0=', 1, '1');
------------��ɫ
insert into T_SYS_ROLE (ROLE_ID, ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
values (1, '��������Ա', '��������Ա', '12,9,8,13,14,15,10,35,34,16', '', 0, '1', null);

insert into T_SYS_ROLE (ROLE_ID, ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
values (2, '����Ա', null, '12,9,8,13,14,38,11,43,15,10,16,70,69,74', '', 1, '1', null);
-------��ɫ���û���ϵ
insert into T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
values (1, 1, 1);

insert into T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
values (2, 2, 2);

-----------����
insert into T_SYS_DEPARTMENT (D_ID, D_NUMBER, D_NAME, D_PID, D_TYPE, REMARK)
values (1, '12345', '�㶫����', 0, '0', 'qqqqbbbb');

--------------------����ģ��
insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (8, '��̨����', null, 1, 0, 'OaManagement', '0', null, '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (9, 'Ȩ�޹���', null, 1, 8, 'authority', '0', 'icon-lock', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (10, 'ϵͳ����', null, 2, 8, 'sysmanagement', '0', 'icon-cog', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (11, '����������', null, 2, 8, 'workflow', '0', 'icon-script', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (12, '��ɫ����', 'Main/role', 1, 9, 'rolemg', '0', 'icon-groupadd', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (13, '�û�����', 'Main/user', 2, 9, 'usermg', '0', 'icon-user', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (14, '��֯��������', 'Main/department', 3, 9, 'departmentmg', '0', 'icon-outline', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (15, '����ģ��', 'Main/module', 1, 10, 'functionmg', '0', 'icon-applicationviewcolumns', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (16, '��������', 'Main/common', 2, 10, 'commonmg', '0', 'icon-bookopen', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (17, '����', 'Main/role/add', 1, 12, 'roleAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (18, '�޸�', 'Main/role/edit', 2, 12, 'roleEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (19, 'ɾ��', 'Main/role/delete', 3, 12, 'roleDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (20, '����', 'Main/user/add', 1, 13, 'userAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (21, '�޸�', 'Main/user/edit', 2, 13, 'userEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (22, 'ɾ��', 'Main/user/delete', 3, 13, 'userDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (23, '����', 'Main/department/add', 1, 14, 'departmentAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (24, '�޸�', 'Main/department/edit', 2, 14, 'departmentEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (25, 'ɾ��', 'Main/department/delete', 3, 14, 'departmentDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (31, '����', 'Main/module/add', 1, 15, 'moduleAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (32, '�޸�', 'Main/module/edit', 2, 15, 'moduleEdit', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (33, 'ɾ��', 'Main/module/delete', 3, 15, 'moduleDelete', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (38, '���̱����', 'Main/wfForm', 1, 11, 'form_main', '0', 'icon-applicationformadd', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (41, '����', 'Main/wfForm/add', 1, 38, 'form_add', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (42, 'ɾ��', 'Main/wfForm/delete', 2, 38, 'form_del', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (43, '�����������', 'Main/wfTemplate', 2, 11, 'wf_template', '0', 'icon-applicationlink', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (44, '����', 'Main/wfTemplate/add', 1, 43, 'wftempalte_add', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (45, '�޸�', 'Main/wfTemplate/update', 2, 43, 'wftemplate_update', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (46, 'ɾ��', 'Main/wfTemplate/delete', 3, 43, 'wf_template_delete', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (56, '����', 'Main/common/add', 1, 16, 'addCommon', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (57, '�޸�', 'Main/common/edit', 2, 16, 'updCommon', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (58, 'ɾ��', 'Main/common/delete', 3, 16, 'delCommon', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (61, 'Ȩ�޷���', 'Main/role/authAssign', 4, 12, 'authAssign', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (62, '�û�����', 'Main/role/userAssign', 5, 12, 'userAssign', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (63, '������', 'Main/wfForm/view', 3, 38, 'form_view', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (64, '��������', 'Main/wfForm/attrView', 4, 38, 'form_attrView', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (65, 'У���˺�Ψһ��', 'Main/user/ifExistAccount', 4, 13, 'userAccount', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (66, 'У�����Ψһ��', 'Main/department/ifExistCode', 4, 14, 'departmentCode', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (67, 'У�����Ψһ��', 'Main/wfForm/check', 5, 38, 'form_checkCode', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (68, 'У��ģ���ʶΨһ��', 'Main/module/ifExsitMark', 4, 15, 'moduleMark', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (69, '��������', null, 3, 10, 'automg', '0', 'icon-wrench', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (70, '�������', 'Main/autoObject', 1, 69, 'autoObjectmg', '0', 'icon-databasewrench', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (71, '����', 'Main/autoObject/add', 1, 70, 'autoObj_Add', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (72, 'ɾ��', 'Main/autoObject/delete', 2, 70, 'autoObj_del', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (73, 'У�����Ψһ��', 'Main/autoObject/check', 3, 70, 'autoObj_check', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (74, '��ͼ����', 'Main/autoView', 2, 69, 'autoViewmg', '0', 'icon-applicationosxkey', '0', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (75, '����', 'Main/autoView/add', 1, 74, 'autoViewAdd', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (76, 'ɾ��', null, 2, 74, 'autoViewDel', '0', null, '1', null, '1');

insert into T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (77, 'Ԥ��', 'Main/autoView/view', 3, 74, 'autoView_view', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (81, '�ҵ�����', 'Main/wfInstance', 3, 11, 'wfinstancemg', '0', 'icon-plugin', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (82, '����', 'Main/wfInstance/add', 1, 81, 'wfinstAdd', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (83, '�޸�', 'Main/wfInstance/edit', 2, 81, 'wfinstUpd', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (84, 'ɾ��', 'Main/wfInstance/delete', 3, 81, 'wfinstDel', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (85, '����', 'Main/wfInstance/redo', 4, 81, 'wfinstRedo', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (86, '�ҵ�����', 'Main/wfVerify', 4, 11, 'wfVerifymg', '0', 'icon-pluginedit', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (87, '����', 'Main/wfVerify/verify', 1, 86, 'wfVerify', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (88, '���ݹ���', 'Main/dataService', 4, 9, 'dataServicemg', '0', 'icon-bricks', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (89, '��������Ȩ��', 'Main/dataservice/dataRole', 1, 88, 'dataService_add', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (90, 'ɾ��', 'Main/dataService/delete', 2, 88, 'dataService_del', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (91, 'ҵ�����', 'Main/service', 2, 10, 'servicemg', '0', 'icon-brick', '0', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (92, '����', 'Main/service/add', 1, 91, 'service_add', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (93, '�޸�', 'Main/service/edit', 2, 91, 'service_upd', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (94, 'ɾ��', 'Main/service/delete', 3, 91, 'service_del', '0', null, '1', null, '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (95, '��ͼ����', '', 5, 8, 'gismanage', '0', 'icon-world', '0', '', '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (96, '��ͼ����', 'Main/geographic/manage', 1, 95, 'gisconfig', '0', 'icon-worldconnect', '0', '', '1');

insert into t_sys_module (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
values (97, '���ò鿴', 'Main/geographic/manage/index', 1, 96, 'gismanageview', '0', '', '1', '', '1');




--------------����
insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (1, '��������', 'XZJB', 0, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (2, '��', '0', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (3, '��', '1', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (5, '��', '2', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (7, '��', '3', 1, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (8, '����Ա����', 'GLCS', 0, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (9, '����Ա', 'admin', 8, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (10, '�������', 'AUTO', 0, null);

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (11, 'model', 'upload/autoTemplate/model.java', 10, 'model��ģ���ļ�');

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (12, 'jsp', 'upload/autoTemplate/jsp', 10, 'jspģ���ļ�');

insert into T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (13, 'controller', 'upload/autoTemplate/controller.java', 10, 'controller��ģ���ļ�');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (14, '��������', 'LCLX', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (15, '���', '00A', 14, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (16, '�Ӱ�', '00B', 14, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (17, '����', '00C', 14, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (18, '״̬', 'LCZT', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (19, '����', '00S', 18, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (20, '�ڵ�����', 'JDLX', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (24, '��ͨ', '00A', 20, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (25, '��ǩ', '00H', 20, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (26, '����', '00X', 18, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (27, '���̷�ʽ', 'LCFS', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (28, '�̶�', '00A', 27, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (29, '����', '00X', 27, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (30, 'ʵ��״̬', 'WFZT', 0, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (31, '�ݸ�', '00A', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (32, '������', '00V', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (33, 'ͨ��', '00S', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (35, '��ͨ��', '00X', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (36, '����', '00R', 30, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (37, '��ʷ״̬', 'WFRT', 0, '������ת��ʷ״̬');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (38, '��ת��', 'ZC', 37, '����');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (39, '����', 'RT', 37, '���ط�����');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (40, '����', 'TR', 37, '�Լ���������');

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (41, '����Ա����', 'ADMIN', 37, null);

insert into t_sys_parameter (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
values (42, '����������', 'SYSSET', 0, null);

--------------����
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

