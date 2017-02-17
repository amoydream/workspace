/*����ƽ̨������ */
CREATE TABLE T_SYS_LOGIN_LOG (
  sessionid VARCHAR(100) NOT NULL ,
  logintype VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '��¼����  ������ע��',
  logintime VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '��¼ʱ��',
  loginip VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '��¼����IP',
  logouttime VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '�˳�ʱ��',
  userid INT(11) NOT NULL COMMENT '��¼�û�ID',
  PRIMARY KEY (sessionid)
);

CREATE TABLE T_SYS_USER (
  user_id INT(11) NOT NULL AUTO_INCREMENT,
  user_account VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '�û���¼��',
  user_name VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '�û�������',
  PASSWORD VARCHAR(40) COLLATE utf8_bin DEFAULT NULL COMMENT '��¼����(Md5����)',
  dept_id INT(11) NOT NULL COMMENT '��������ID',
  STATUS CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '0:ע��  1:���� 2��ͣ��',
  PRIMARY KEY (user_id)
);

CREATE TABLE T_SYS_ROLE
(
  role_id          INT(11) NOT NULL AUTO_INCREMENT,
  role_name        VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '��ɫ��',
  role_description VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '��ɫ����',
  opt_permissions  LONGTEXT COLLATE utf8_bin DEFAULT NULL COMMENT '��ɫӵ��Ȩ��(���Ƶ��˵�)',
  no_permissions   LONGTEXT COLLATE utf8_bin DEFAULT NULL COMMENT '��ɫ���߱�Ȩ��(���Ƶ����ܵ��ť��)',
  suporg           INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '��������ID',
  STATUS           CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '״̬(0:ֹͣ 1������)',
  pid              INT(11) COLLATE utf8_bin NOT NULL COMMENT '�����ڵ�ID',
  PRIMARY KEY (role_id)
);

CREATE TABLE T_SYS_MODULE
(
  id          INT(11) NOT NULL AUTO_INCREMENT,
  NAME        VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ģ������',
  address     VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ģ�����url',
  orderindex  INT(4) COLLATE utf8_bin DEFAULT NULL COMMENT '˳���',
  p_id        INT(11) NOT NULL COMMENT '�ϼ�ID',
  mark        VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT '����ģ���ʶ',
  opentype    CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '��������(0:�ڲ����� 1���ⲿ����)',
  iconclass   VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ͼ����ʽ',
  modeltype   CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'ģ������',
  description VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '���ܽ���',
  usable      CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�Ƿ�����(0: �� 1����)',
  PRIMARY KEY (id)
);

CREATE TABLE T_SYS_PARAMETER
(
  id      INT(11) NOT NULL AUTO_INCREMENT,
  p_name  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  p_acode VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  sup_id  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '����ID',
  remark  VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '��ע',
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
  d_number VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '���ű��',
  d_name   VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  d_pid    INT(11) NOT NULL COMMENT '�ϼ�����',
  d_type   CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '��������(0:�� 1���� 2���� 3����)',
  remark   VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '��ע',
  PRIMARY KEY (d_id)
);
/*������־��*/
create table T_Sys_Operation_Log(
       id         INT(11) NOT NULL AUTO_INCREMENT,
       opt_moudle INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '����ģ��ID',
       opt_type   char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�������� 0���� 1������ 2���޸� 3��ɾ��',
       opt_time   varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '����ʱ��',
       status     char(1) COLLATE utf8_bin DEFAULT NULL COMMENT '״̬ 0��ʧ�� 1���ɹ�',
       login_ip   varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '����IP',
       opt_user   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '������ID',
       content    LONGTEXT COLLATE utf8_bin DEFAULT NULL COMMENT '����',
	   PRIMARY KEY (id)
);
/*����Ȩ�޹����*/
create table T_Sys_DataRelation
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  dept_id  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '������ID',
  service_id  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҵ��ID',
  other_dept INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '�粿��ID',
  PRIMARY KEY (id)
);
create table T_Sys_DataService
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  serviceName  varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҵ������',
  serviceTable  varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҵ���',
  serviceView varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҵ����ͼ',
  remark varchar(2000) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҵ������',
  model_id    INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҵ��������ܵ�ID',
  PRIMARY KEY (id)
);

/*���̱�*/
CREATE TABLE T_WF_FORM
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  fname  VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  fcode  VARCHAR(60) NOT NULL COMMENT '��code',
  remark VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  STATUS CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '��״̬�����ã�00S ���ϣ�00X��',
  PRIMARY KEY (id)
);

CREATE TABLE T_WF_ATTR
(
  id         INT(11) NOT NULL AUTO_INCREMENT,
  attrname   VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  sqltype    CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  acode      VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '����code',
  remark     VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  symbol     CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT 'ͳ�Ʊ�־��001����ʼʱ�� 002������ʱ�䣩',
  fcode      VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '��code',
  defvalue   VARCHAR(6) COLLATE utf8_bin DEFAULT NULL COMMENT 'Ĭ��ֵ ��001������������ 002���������� 003:���������ƿɱ༭ 004���������ƿɱ༭��',
  selcontent VARCHAR(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '�����б��ֶ�',
  selfalg    CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�����б�������־',
  numgs      VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '��ֵ��ʽ',
  PRIMARY KEY (id)
);

create table T_WF_TEMPLATE
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  tname  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  tcode  VARCHAR(6) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  remark VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  ftype CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '���̷�ʽ���̶���00A ���ɣ�00X��',
  status CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '����״̬�����ã�00S ���ã�00X��',
  suporg   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  formid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '��ID',
  PRIMARY KEY (id)
);

create table T_WF_POINT
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  wfid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '����ID',
  pname  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '�ڵ�����',
  checkuser VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  porder    INT(3) COLLATE utf8_bin DEFAULT NULL COMMENT '����',
  ptype CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '�ڵ����ͣ���ͨ��00A ��ǩ��00H��',
  PRIMARY KEY (id)
);

create table T_WF_INSTANCE
(
  id        INT(11) NOT NULL AUTO_INCREMENT,
  name      VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '�������',
  fjid      VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '����ID',
  applicant INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '������ID',
  marktime  VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '����ʱ��',
  pointid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '��ǰ�ڵ�ID',
  status    VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '״̬���ݸ壺00A �����У�00V ͨ����00S ��ͨ����00X �س���00R��',
  wfid      INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '����ID',
  stime     VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '��ʼʱ��(����ͳ��)',
  etime     VARCHAR(30) COLLATE utf8_bin DEFAULT NULL COMMENT '����ʱ��(����ͳ��)',
  content   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '��������ID',
  oauser VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '���������(����ͳ��)',
  PRIMARY KEY (id)
);


create table T_WF_HISTORY
(
  id         INT(11) NOT NULL AUTO_INCREMENT,
  instid 	 INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT 'ʵ��ID',
  pointid    INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '�ڵ�ID',
  checktype  CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '�������� ͬ��00S ��ͬ�� 00X ���� 00R',
  content    VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '��������',
  checkuser  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  marktime   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '����ʱ��',
  porder     VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '���',
  rtset      VARCHAR(6) COLLATE utf8_bin DEFAULT NULL COMMENT '���ϱ�־������RT ����ZC ����DB ����Ա����ADMIN��',
  PRIMARY KEY (id)
);

/*������*/
create table T_ATTACHMENT
(
  id        INT(11) NOT NULL AUTO_INCREMENT,
  name       VARCHAR(300) COLLATE utf8_bin DEFAULT NULL COMMENT '�ļ�����',
  url        VARCHAR(1000) COLLATE utf8_bin DEFAULT NULL COMMENT '�ļ���ַ',
  m_type     VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '�ļ�����',
  m_size     VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '�ļ���С',
  uploadid   INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '�ϴ���ID',
  marktime   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '���ʱ��������',
  uploaddate VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '�ϴ�ʱ��',
  PRIMARY KEY (id)
);

/**����**/
/*��ȡ�¼�����*/
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

/*��ȡ��������*/
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

/*��ȡ����ĳ�������µ������¼�����*/
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

/**��������*/
/*�û�*/
INSERT INTO T_SYS_USER (USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
VALUES ('super', 'super', 'QPDnjYqApi0=', 1, '1');

INSERT INTO T_SYS_USER (USER_ACCOUNT, USER_NAME, PASSWORD, DEPT_ID, STATUS)
VALUES ( 'admin', 'admin', 'QPDnjYqApi0=', 1, '1');

/*��ɫ*/
INSERT INTO T_SYS_ROLE ( ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
VALUES ('��������Ա', '��������Ա', '12,9,8,13,14,15,10,35,34,16', '', 0, '1', 0);

INSERT INTO T_SYS_ROLE ( ROLE_NAME, ROLE_DESCRIPTION, OPT_PERMISSIONS, NO_PERMISSIONS, SUPORG, STATUS, PID)
VALUES ('����Ա', NULL, '12,9,8,13,14,38,11,43,15,10,16,70,69,74', '', 1, '1', 0);
/*��ɫ���û���ϵ*/
INSERT INTO T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
VALUES (1, 1, 1);

INSERT INTO T_SYS_USERROLES (ID, ROLE_ID, USER_ID)
VALUES (2, 2, 2);

/*����*/
INSERT INTO T_SYS_DEPARTMENT (D_NUMBER, D_NAME, D_PID, D_TYPE, REMARK)
VALUES ( '12345', '�㶫����', 0, '0', 'qqqqbbbb');

/*����*/
INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (1, '��������', 'XZJB', 0, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (2, '��', '0', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (3, '��', '1', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (5, '��', '2', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (7, '��', '3', 1, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (8, '����Ա����', 'GLCS', 0, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (9, '����Ա', 'admin', 8, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (10, '�������', 'AUTO', 0, NULL);

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (11, 'model', 'upload/autoTemplate/model.java', 10, 'model��ģ���ļ�');

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (12, 'jsp', 'upload/autoTemplate/jsp', 10, 'jspģ���ļ�');

INSERT INTO T_SYS_PARAMETER (ID, P_NAME, P_ACODE, SUP_ID, REMARK)
VALUES (13, 'controller', 'upload/autoTemplate/controller.java', 10, 'controller��ģ���ļ�');

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

/*����ģ��*/
INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (8, '��̨����', NULL, 1, 0, 'OaManagement', '0', NULL, '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (9, 'Ȩ�޹���', NULL, 1, 8, 'authority', '0', 'icon-lock', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (10, 'ϵͳ����', NULL, 2, 8, 'sysmanagement', '0', 'icon-cog', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (11, '����������', NULL, 2, 8, 'workflow', '0', 'icon-script', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (12, '��ɫ����', 'Main/role', 1, 9, 'rolemg', '0', 'icon-groupadd', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (13, '�û�����', 'Main/user', 2, 9, 'usermg', '0', 'icon-user', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (14, '��֯��������', 'Main/department', 3, 9, 'departmentmg', '0', 'icon-outline', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (15, '����ģ��', 'Main/module', 1, 10, 'functionmg', '0', 'icon-applicationviewcolumns', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (16, '��������', 'Main/common', 2, 10, 'commonmg', '0', 'icon-bookopen', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (17, '����', 'Main/role/add', 1, 12, 'roleAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (18, '�޸�', 'Main/role/edit', 2, 12, 'roleEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (19, 'ɾ��', 'Main/role/delete', 3, 12, 'roleDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (20, '����', 'Main/user/add', 1, 13, 'userAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (21, '�޸�', 'Main/user/edit', 2, 13, 'userEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (22, 'ɾ��', 'Main/user/delete', 3, 13, 'userDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (23, '����', 'Main/department/add', 1, 14, 'departmentAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (24, '�޸�', 'Main/department/edit', 2, 14, 'departmentEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (25, 'ɾ��', 'Main/department/delete', 3, 14, 'departmentDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (31, '����', 'Main/module/add', 1, 15, 'moduleAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (32, '�޸�', 'Main/module/edit', 2, 15, 'moduleEdit', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (33, 'ɾ��', 'Main/module/delete', 3, 15, 'moduleDelete', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (38, '���̱����', 'Main/wfForm', 1, 11, 'form_main', '0', 'icon-applicationformadd', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (41, '����', 'Main/wfForm/add', 1, 38, 'form_add', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (42, 'ɾ��', 'Main/wfForm/delete', 2, 38, 'form_del', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (43, '�����������', 'Main/wfTemplate', 2, 11, 'wf_template', '0', 'icon-applicationlink', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (44, '����', 'Main/wfTemplate/add', 1, 43, 'wftempalte_add', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (45, '�޸�', 'Main/wfTemplate/update', 2, 43, 'wftemplate_update', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (46, 'ɾ��', 'Main/wfTemplate/delete', 3, 43, 'wf_template_delete', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (56, '����', 'Main/common/add', 1, 16, 'addCommon', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (57, '�޸�', 'Main/common/edit', 2, 16, 'updCommon', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (58, 'ɾ��', 'Main/common/delete', 3, 16, 'delCommon', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (61, 'Ȩ�޷���', 'Main/role/authAssign', 4, 12, 'authAssign', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (62, '�û�����', 'Main/role/userAssign', 5, 12, 'userAssign', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (63, '������', 'Main/wfForm/view', 3, 38, 'form_view', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (64, '��������', 'Main/wfForm/attrView', 4, 38, 'form_attrView', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (65, 'У���˺�Ψһ��', 'Main/user/ifExistAccount', 4, 13, 'userAccount', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (66, 'У�����Ψһ��', 'Main/department/ifExistCode', 4, 14, 'departmentCode', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (67, 'У�����Ψһ��', 'Main/wfForm/check', 5, 38, 'form_checkCode', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (68, 'У��ģ���ʶΨһ��', 'Main/module/ifExsitMark', 4, 15, 'moduleMark', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (69, '��������', NULL, 3, 10, 'automg', '0', 'icon-wrench', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (70, '�������', 'Main/autoObject', 1, 69, 'autoObjectmg', '0', 'icon-databasewrench', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (71, '����', 'Main/autoObject/add', 1, 70, 'autoObj_Add', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (72, 'ɾ��', 'Main/autoObject/delete', 2, 70, 'autoObj_del', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (73, 'У�����Ψһ��', 'Main/autoObject/check', 3, 70, 'autoObj_check', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (74, '��ͼ����', 'Main/autoView', 2, 69, 'autoViewmg', '0', 'icon-applicationosxkey', '0', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (75, '����', 'Main/autoView/add', 1, 74, 'autoViewAdd', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (76, 'ɾ��', NULL, 2, 74, 'autoViewDel', '0', NULL, '1', NULL, '1');

INSERT INTO T_SYS_MODULE (ID, NAME, ADDRESS, ORDERINDEX, P_ID, MARK, OPENTYPE, ICONCLASS, MODELTYPE, DESCRIPTION, USABLE)
VALUES (77, 'Ԥ��', 'Main/autoView/view', 3, 74, 'autoView_view', '0', NULL, '1', NULL, '1');

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

/*�Զ���*/
CREATE TABLE T_AUTOTABLE
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  table_name  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  table_code  VARCHAR(60) NOT NULL COMMENT '�����',
  dba_type VARCHAR(10) COLLATE utf8_bin DEFAULT NULL COMMENT '���ݿ�����',
  dba_name VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '����Դ',
  model_path VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '��·��',
  PRIMARY KEY (id)
);

CREATE TABLE T_autoAttr
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  attrname  VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '�ֶ�����',
  attrcode  VARCHAR(60) NOT NULL COMMENT '�ֶα���',
  attrtype CHAR(3) COLLATE utf8_bin DEFAULT NULL COMMENT '�ֶ����ͣ�001���ַ� 002����ֵ 003������ 004���ı���',
  ispkid CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�Ƿ�������1���� 0����',
  tcode VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '������',
  remark VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '��ע',
  PRIMARY KEY (id)
);

CREATE TABLE T_autoAttr_ext
(
  id     INT(11) NOT NULL AUTO_INCREMENT,
  viewid  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '��ͼID',
  attrid  INT(11) COLLATE utf8_bin DEFAULT NULL COMMENT '�ֶ�����',
  filedcode VARCHAR(60) COLLATE utf8_bin DEFAULT NULL COMMENT '�ؼ�����',
  filedtext VARCHAR(100) COLLATE utf8_bin DEFAULT NULL COMMENT '�ؼ�����',
  filedwidth VARCHAR(11) COLLATE utf8_bin DEFAULT NULL COMMENT '�ؼ����',
  uitype  VARCHAR(6) NOT NULL COMMENT '�ؼ����ͣ�001��ʱ��ؼ� 002������� 003�������� 004����ѡ�� 005����ѡ�� 006���ı���',
  issearch CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�Ƿ��ѯ��1���� 0����',
  isadd CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�Ƿ�������1���� 0����',
  isedit CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�Ƿ��޸ģ�1���� 0����',
  isview CHAR(1) COLLATE utf8_bin DEFAULT NULL COMMENT '�Ƿ�ɼ���1���� 0����',
  staticval VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '��̬����',
  deafulval VARCHAR(200) COLLATE utf8_bin DEFAULT NULL COMMENT '����ֵ',
  uival VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '�����ı�',
  PRIMARY KEY (id)
);

CREATE TABLE T_AUTOVIEW
(
  id          INT(11) NOT NULL AUTO_INCREMENT,
  data_source VARCHAR(255) COLLATE utf8_bin DEFAULT NULL COMMENT '���� ���ݱ�',
  view_layout VARCHAR(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'ҳ�沼�� north���� center���� south���� west���� east����',
  view_type   VARCHAR(20) COLLATE utf8_bin DEFAULT NULL COMMENT '��ͼ���� 00M����ҳ 00A������ 00U���޸�',
  view_path   VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '�洢��ַ',
  view_name   VARCHAR(600) COLLATE utf8_bin DEFAULT NULL COMMENT '��ͼ����',
  controller  VARCHAR(600) COLLATE utf8_bin DEFAULT NULL COMMENT 'controller����',
  pack_path   VARCHAR(2000) COLLATE utf8_bin DEFAULT NULL COMMENT '��·��',
  PRIMARY KEY (id)
);
