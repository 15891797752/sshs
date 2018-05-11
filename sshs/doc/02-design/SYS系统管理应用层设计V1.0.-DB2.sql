-- 建表脚本-DB2
-- 机构表
CREATE TABLE SYS_ORG(
  ORG_ID  VARCHAR (32) NOT NULL,
  ORG_CODE  VARCHAR (32),
  ORG_NAME  VARCHAR (256),
  ORG_BRIEF  VARCHAR (100),
  PARENT_ORG_CODE  VARCHAR (32),
  ORG_CATEGORY  VARCHAR (10),
  ORG_LEVEL  VARCHAR (32),
  ORG_GRADE  VARCHAR (32),
  PATH_NAME  VARCHAR (100),
  STATUS  VARCHAR (10),
  COUNTRY  VARCHAR (10),
  EMAIL  VARCHAR (100),
  OFFICE_ADDR  VARCHAR (512),
  POST  VARCHAR (100),
  TEL  VARCHAR (100),
  CONTACT  VARCHAR (100),
  ORG_FI_NO  VARCHAR (60),
  ORG_PAY_NO  VARCHAR (60),
  ORG_CREDIT_NO  VARCHAR (60),
  ORG_PERMIT_NO  VARCHAR (60),
  ORG_REG_NO  VARCHAR (60),
  ORG_ID_NUMBER  VARCHAR (60),
  ORG_TAX_NO  VARCHAR (60),
  ORG_CREATE_DATE  TIMESTAMP,
  ORG_START_DATE  VARCHAR (10),
  ORG_END_DATE  VARCHAR (10),
  ORG_HEADER  VARCHAR (32),
  NODE_NO  VARCHAR (32),
  HIGHER_MNG_ORG  VARCHAR (1000),
  IS_LEAF  VARCHAR (10),
  BUSI_STATUS  VARCHAR (10),
  AREA_CODE  VARCHAR (10),
  ORDERS  DECIMAL (5),
  OWN_LINE  VARCHAR (10),
  VER_NO  DECIMAL (5),
  APPLY_STATUS  VARCHAR (60),
  OPER_TYPE  VARCHAR (1),
  OPER_RELA_ID  VARCHAR (60),
  APPLY_EMP_NO  VARCHAR (60),
  APPLY_DATE  TIMESTAMP,
  APPLY_REASON  VARCHAR (4000),
  PROCESS_INSTANCE_ID  VARCHAR (32),
  REMARK  VARCHAR (100),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_ORG PRIMARY KEY (ORG_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_ORG IS '系统管理-机构表';
 COMMENT ON SYS_ORG(
ORG_ID IS  '机构ID',
ORG_CODE IS  '机构编码',
ORG_NAME IS  '机构名称',
ORG_BRIEF IS  '机构简称',
PARENT_ORG_CODE IS  '直接上级机构ID',
ORG_CATEGORY IS  '机构类别:01--机构,02--部门',
ORG_LEVEL IS  '机构层级（树形结构层级）',
ORG_GRADE IS  '机构级别：总行，分行，支行等',
PATH_NAME IS  '中文路径：用‘.’隔开各层级路径名称:.a.b.c.',
STATUS IS  '状态：01--启用,02--停用',
COUNTRY IS  '国家或地区:中国、中国香港、美国等,字典表数据',
EMAIL IS  '联系邮箱',
OFFICE_ADDR IS  '办公地址',
POST IS  '邮政编码',
TEL IS  '联系电话',
CONTACT IS  '联系人',
ORG_FI_NO IS  '金融机构编码（人行）',
ORG_PAY_NO IS  '支付行号（人行）',
ORG_CREDIT_NO IS  '机构信用代码（人行）',
ORG_PERMIT_NO IS  '金融许可证号码（银监）',
ORG_REG_NO IS  '营业执照注册号（工商）',
ORG_ID_NUMBER IS  '组织机构代码证号码',
ORG_TAX_NO IS  '税务登记证号码',
ORG_CREATE_DATE IS  '成立日期',
ORG_START_DATE IS  '营业开始时间',
ORG_END_DATE IS  '营业终止时间',
ORG_HEADER IS  '机构负责人',
NODE_NO IS  '网点号',
HIGHER_MNG_ORG IS  '代管机构：01,02,03',
IS_LEAF IS  '是否最末端',
BUSI_STATUS IS  '营业状态',
AREA_CODE IS  '行政区划代码',
ORDERS IS  '顺序号',
OWN_LINE IS  '所属条线',
VER_NO IS  '版本号',
APPLY_STATUS IS  '审批状态',
OPER_TYPE IS  '操作类型：合并，撤销，转移，修改',
OPER_RELA_ID IS  '关联主键：合并，撤销，转移，修改的关联ID',
APPLY_EMP_NO IS  '申请人',
APPLY_DATE IS  '申请日期',
APPLY_REASON IS  '申请原因',
PROCESS_INSTANCE_ID IS  '审批流ID',
REMARK IS  '备注',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 岗位表
CREATE TABLE SYS_POST(
  POST_ID  VARCHAR (32) NOT NULL,
  POST_NO  VARCHAR (32) NOT NULL,
  POST_NAME  VARCHAR (50) NOT NULL,
  POST_SERIAL  VARCHAR (32),
  POST_SERIAL_CHILD  VARCHAR (32),
  POST_DESC  VARCHAR (255),
  STAND_ORG_CODE  VARCHAR (36),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_POST PRIMARY KEY (POST_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_POST IS '系统管理-岗位表';
 COMMENT ON SYS_POST(
POST_ID IS  '岗位主键',
POST_NO IS  '岗位编号',
POST_NAME IS  '岗位名称',
POST_SERIAL IS  '岗位序列:管理序列、专业序列、营销序列、技能序列',
POST_SERIAL_CHILD IS  '岗位子序列',
POST_DESC IS  '岗位描述',
STAND_ORG_CODE IS  '所属标准部门',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 用户基本信息表
CREATE TABLE SYS_USER(
  USER_ID  VARCHAR (32) NOT NULL,
  USER_CODE  VARCHAR (32) NOT NULL,
  USER_NAME  VARCHAR (32) NOT NULL,
  USER_NAME_EN  VARCHAR (32),
  USER_NAME_PY  VARCHAR (50),
  USER_NAME_FR  VARCHAR (36),
  ORG_CODE  VARCHAR (36),
  POST_NO  VARCHAR (32),
  USER_SEX  VARCHAR (2),
  NATIONALITY  VARCHAR (3),
  ETHNIC  VARCHAR (50),
  NATIVE_PLACE  VARCHAR (100),
  BIRTH_PLACE  VARCHAR (50),
  BIRTH_DATE  TIMESTAMP,
  ID_DECIMAL  VARCHAR (20),
  PHOTO_ID  VARCHAR (100),
  JOIN_DATE  TIMESTAMP,
  STATUS  VARCHAR (10),
  TELLER_ID  VARCHAR (32),
  RESIDENTIAL_ADDRESS  VARCHAR (1000),
  MOBILE_PHONE  VARCHAR (32),
  REMARK  VARCHAR (250),
  PASSWORD  VARCHAR (200),
  SALT  VARCHAR (32),
  ONLINE_STATUS  VARCHAR (10),
  IP_ADDR  VARCHAR (60),
  USER_THEME  VARCHAR (32),
  PD_COUNT  VARCHAR (32),
  PD_MODTIME  VARCHAR (32),
  PD_LOCKTIME  VARCHAR (32),
  LAST_SIGNON_TIME  TIMESTAMP,
  LAST_SIGNOUT_TIME  TIMESTAMP,
  LEGAL_ORG  VARCHAR (50),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_USER PRIMARY KEY (USER_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_USER IS '系统管理-用户基本信息表';
 COMMENT ON SYS_USER(
USER_ID IS  '主键',
USER_CODE IS  '用户编号',
USER_NAME IS  '姓名',
USER_NAME_EN IS  '英文名',
USER_NAME_PY IS  '拼音码',
USER_NAME_FR IS  '曾用名',
ORG_CODE IS  '机构编号:到具体的部门、支行和二级中心',
POST_NO IS  '岗位',
USER_SEX IS  '性别:1－男性，2－女性，9－未说明性别',
NATIONALITY IS  '国籍',
ETHNIC IS  '民族:01=汉族',
NATIVE_PLACE IS  '籍贯',
BIRTH_PLACE IS  '出生地',
BIRTH_DATE IS  '出生日期',
ID_DECIMAL IS  '身份证号码',
PHOTO_ID IS  '证件照',
JOIN_DATE IS  '入职日期',
STATUS IS  '用户状态:0-无效，1-有效',
TELLER_ID IS  '柜员编号',
RESIDENTIAL_ADDRESS IS  '现居住地址',
MOBILE_PHONE IS  '手机',
REMARK IS  '备注',
PASSWORD IS  '密码',
SALT IS  '盐（密码）',
ONLINE_STATUS IS  '在线状态:在线、离线、锁定',
IP_ADDR IS  'IP地址',
USER_THEME IS  '用户皮肤',
PD_COUNT IS  '密码输入次数',
PD_MODTIME IS  '密码修改时间',
PD_LOCKTIME IS  '密码锁定时间',
LAST_SIGNON_TIME IS  '最后一次登陆时间',
LAST_SIGNOUT_TIME IS  '最后一次退出时间',
LEGAL_ORG IS  '法人机构编号',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 用户扩展信息表
CREATE TABLE SYS_USER_EXT(
  USER_ID  VARCHAR (32) NOT NULL,
  POLITICAL_STATUS  VARCHAR (10),
  PARTY_TIME  VARCHAR (10),
  MARITAL_STATUS  VARCHAR (10),
  BLOOD_TYPE  VARCHAR (10),
  ENGLISH_LEVEL  VARCHAR (10),
  COMPUTER_LEVEL  VARCHAR (10),
  WORK_TIME  VARCHAR (50),
  INDUCTION_TYPE  VARCHAR (10),
  EMPLOY_WAY  VARCHAR (10),
  EMP_STATUS  VARCHAR (10),
  JOIN_DATE  TIMESTAMP,
  HEIGHT  DECIMAL (5,2),
  WEIGHT  DECIMAL (5,2),
  CHILD_NUM  DECIMAL (2),
  HEALTH_STATE  VARCHAR (10),
  HIGHEST_EDU  VARCHAR (2),
  HIGHEST_DEGREE  VARCHAR (2),
  CONTACT_ADDRESS  VARCHAR (1000),
  POSTCODE_CONTACT  VARCHAR (32),
  RESIDENTIAL_ADDRESS  VARCHAR (1000),
  POSTCODE_RESIDENTIAL  VARCHAR (32),
  DOMICILE_ADDRESS  VARCHAR (1000),
  POSTCODE_DOMICILE  VARCHAR (32),
  HOUSEHOLD_REG  VARCHAR (1),
  EMAIL  VARCHAR (64),
  MOBILE_PHONE  VARCHAR (32),
  HOME_TELPHONE  VARCHAR (32),
  EMERGENCY_CONTACT  VARCHAR (32),
  EMERGENCY_CONTACT_PHONE  VARCHAR (32),
  QQ  VARCHAR (32),
  WECHAT  VARCHAR (32),
  REMARK  VARCHAR (250),
  LEGAL_ORG  VARCHAR (50),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_USER_EXT PRIMARY KEY (USER_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_USER_EXT IS '系统管理-用户扩展信息表';
 COMMENT ON SYS_USER_EXT(
USER_ID IS  '主键',
POLITICAL_STATUS IS  '政治面貌:团员、党员、其他党派人士、无党派',
PARTY_TIME IS  '入党时间',
MARITAL_STATUS IS  '婚姻状况:10-未婚；20-已婚；21-离婚；40-丧偶；',
BLOOD_TYPE IS  '血型:A型、B型、AB型、O型、未知血型',
ENGLISH_LEVEL IS  '英语等级',
COMPUTER_LEVEL IS  '计算机等级',
WORK_TIME IS  '参加工作年月',
INDUCTION_TYPE IS  '入职类型:社会招录、资源性人才引进、系统内调入、系统外调入',
EMPLOY_WAY IS  '用工方式:合同制员工
派遣制员工
实习员工',
EMP_STATUS IS  '员工状态:在职在岗
在编不在岗的
离岗退养
转非
退休
死亡',
JOIN_DATE IS  '入职日期',
HEIGHT IS  '身高',
WEIGHT IS  '体重',
CHILD_NUM IS  '子女人数',
HEALTH_STATE IS  '健康状况:健康
一般
慢性疾病
生理缺陷
残废
较弱',
HIGHEST_EDU IS  '最高学历:中专、高中、大专、专科、本科、研究生（硕士）、研究生（博士）',
HIGHEST_DEGREE IS  '最高学位:0-其他；1-名誉博士；
2-博士；
3-硕士；
4-学士；
9-未知。',
CONTACT_ADDRESS IS  '通讯地址',
POSTCODE_CONTACT IS  '通讯地址邮编',
RESIDENTIAL_ADDRESS IS  '现居住地址',
POSTCODE_RESIDENTIAL IS  '现居住地邮编',
DOMICILE_ADDRESS IS  '户籍所在地',
POSTCODE_DOMICILE IS  '户籍所在地邮编',
HOUSEHOLD_REG IS  '户籍类型:城镇,非城镇',
EMAIL IS  '电子邮箱',
MOBILE_PHONE IS  '手机',
HOME_TELPHONE IS  '家庭电话',
EMERGENCY_CONTACT IS  '紧急联系人',
EMERGENCY_CONTACT_PHONE IS  '紧急联系人手机',
QQ IS  'QQ号',
WECHAT IS  '微信号',
REMARK IS  '备注',
LEGAL_ORG IS  '法人机构编号',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 菜单表
CREATE TABLE SYS_MENU(
  MENU_CODE  VARCHAR (32) NOT NULL,
  MENU_NAME  VARCHAR (100),
  MENU_TYPE  VARCHAR (2),
  MENU_URL  VARCHAR (256),
  PARENT_MENU_CODE  VARCHAR (32),
  MENU_MODULE  VARCHAR (32),
  IS_RELATIVE_PATH  VARCHAR (10),
  MENU_LEVEL  DECIMAL (5),
  MENU_SEQ  DECIMAL(5),
  MENU_ICON  VARCHAR (100),
  MENU_ICONA  VARCHAR (100),
  IS_VISIBLE  VARCHAR (10),
  OPEN_MODE  VARCHAR (20),
  MENU_TIP  VARCHAR (100),
  IS_START  VARCHAR (10),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_MENU PRIMARY KEY (MENU_CODE)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_MENU IS '系统管理-菜单表';
 COMMENT ON SYS_MENU(
MENU_CODE IS  '菜单编码',
MENU_NAME IS  '菜单名称',
MENU_TYPE IS  '菜单类型:0-节点，1-功能',
MENU_URL IS  '菜单路径URL',
PARENT_MENU_CODE IS  '所属父菜单',
MENU_MODULE IS  '所属模块',
IS_RELATIVE_PATH IS  '是否相对路径',
MENU_LEVEL IS  '菜单层次',
MENU_SEQ IS  '同级菜单顺序号',
MENU_ICON IS  '菜单图标路径/或样式',
MENU_ICONA IS  '菜单激活图标路径/或样式',
IS_VISIBLE IS  '是否可视:1-是,0-否',
OPEN_MODE IS  '主窗口打开、弹出窗口打开',
MENU_TIP IS  '提示信息',
IS_START IS  '是否启用:1-是,0-否',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 菜单国际化表
CREATE TABLE SYS_MENU_I18N(
  I18N_ID  VARCHAR (32) NOT NULL,
  MENU_CODE  VARCHAR (32),
  LANGUAGE  VARCHAR (10),
  COUNTRY  VARCHAR (10),
  MENU_LABEL  VARCHAR (100),
  MENU_TIP  VARCHAR (100),
  IS_START  VARCHAR (10),
  CRT_USER_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_MENU_I18N PRIMARY KEY (I18N_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_MENU_I18N IS '系统管理-菜单国际化表';
 COMMENT ON SYS_MENU_I18N(
I18N_ID IS  'I18N_ID',
MENU_CODE IS  '菜单编码',
LANGUAGE IS  '语言',
COUNTRY IS  '国家',
MENU_LABEL IS  '菜单显示（中文）',
MENU_TIP IS  '提示信息',
IS_START IS  '是否启用:01--是,02--否',
CRT_USER_CODE IS  '创建人',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 角色表
CREATE TABLE SYS_ROLE(
  ROLE_CODE  VARCHAR (32) NOT NULL,
  ROLE_NAME  VARCHAR (100),
  REMARK  VARCHAR (1000),
  ROLE_LEVEL  VARCHAR (10),
  STATUS  VARCHAR (10),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_ROLE PRIMARY KEY (ROLE_CODE)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_ROLE IS '系统管理-角色表';
 COMMENT ON SYS_ROLE(
ROLE_CODE IS  '角色编码',
ROLE_NAME IS  '角色名称',
REMARK IS  '角色描述',
ROLE_LEVEL IS  '角色级别:对应机构级别',
STATUS IS  '状态:01--启用，02--停用',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 用户角色对照表
CREATE TABLE SYS_USER_ROLE(
  USER_ROLE_ID  VARCHAR (32) NOT NULL,
  USER_CODE  VARCHAR (32),
  ROLE_CODE  VARCHAR (32),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_USER_ROLE PRIMARY KEY (USER_ROLE_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_USER_ROLE IS '系统管理-用户角色对照表';
 COMMENT ON SYS_USER_ROLE(
USER_ROLE_ID IS  'ID',
USER_CODE IS  '用户编号',
ROLE_CODE IS  '角色编号',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 角色权限表
CREATE TABLE SYS_AUTHORIZE(
  AUTHORIZE_ID  VARCHAR (32) NOT NULL,
  RESOURCE_ID  VARCHAR (32) NOT NULL,
  RESOURCE_NAME  VARCHAR (100),
  ROLE_CODE  VARCHAR (32),
  RESOURCE_TYPE  VARCHAR (10),
  AUTHORIZE_TYPE  VARCHAR (2),
  DATA_AUTH_TYPE  VARCHAR (10),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_AUTHORIZE PRIMARY KEY (AUTHORIZE_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_AUTHORIZE IS '系统管理-角色权限表';
 COMMENT ON SYS_AUTHORIZE(
AUTHORIZE_ID IS  '权限ID',
RESOURCE_ID IS  '资源ID(包括菜单ID和按钮ID)',
RESOURCE_NAME IS  '资源名称',
ROLE_CODE IS  '角色编号',
RESOURCE_TYPE IS  '资源类型:01-菜单,02-按钮',
AUTHORIZE_TYPE IS  '授权类型:01-操作,02-授权,03-全部',
DATA_AUTH_TYPE IS  '权限级别，对应机构级别（RESOURCE_TYPE为01且AUTHORIZE_TYPE为01或03时该字段可用）',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 数据字典表
CREATE TABLE SYS_DICTIONARIES(
  DICT_ID  VARCHAR (32) NOT NULL,
  PARENT_ID  VARCHAR (32),
  DICT_TYPE  VARCHAR (1),
  DICT_CODE  VARCHAR (32),
  DICT_NAME  VARCHAR (100),
  DICT_DESC  VARCHAR (100),
  STATUS  VARCHAR (32),
  SORT_NO  DECIMAL (10),
  IS_SYSTEM  VARCHAR (2),
  MODULE  VARCHAR (10),
  LEGAL_ORG  VARCHAR (32),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_DICTIONARIES PRIMARY KEY (DICT_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_DICTIONARIES IS '系统管理-数据字典表';
 COMMENT ON SYS_DICTIONARIES(
DICT_ID IS  'ID',
PARENT_ID IS  '上级ID',
DICT_TYPE IS  '类型:0-分类,1-字典项,2-字典子项,3-字典码值',
DICT_CODE IS  '代码',
DICT_NAME IS  '名称',
DICT_DESC IS  '描述',
STATUS IS  '状态1:有效0:无效',
SORT_NO IS  '排序',
IS_SYSTEM IS  '是否系统类1:系统类0:业务类',
MODULE IS  '模块',
LEGAL_ORG IS  '法人行社',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 数据字典国际化表
CREATE TABLE SYS_DICTIONARIES_I18N(
  I18N_ID  VARCHAR (32) NOT NULL,
  DICT_ID  VARCHAR (32),
  DICT_CODE  VARCHAR (32),
  LANGUAGE  VARCHAR (10),
  COUNTRY  VARCHAR (10),
  DICT_NAME  VARCHAR (100),
  DICT_DESC  VARCHAR (100),
  STATUS  VARCHAR (32),
  LEGAL_ORG  VARCHAR (32),
  UPD_USER_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_DICTIONARIES_I18N PRIMARY KEY (I18N_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_DICTIONARIES_I18N IS '系统管理-数据字典国际化表';
 COMMENT ON SYS_DICTIONARIES_I18N(
I18N_ID IS  'I18N_ID',
DICT_ID IS  'ID',
DICT_CODE IS  '代码',
LANGUAGE IS  '语言',
COUNTRY IS  '国家',
DICT_NAME IS  '名称',
DICT_DESC IS  '描述',
STATUS IS  '状态1:有效0:无效',
LEGAL_ORG IS  '法人行社',
UPD_USER_CODE IS  '修改人',
UPD_DATE IS  '修改日期'
);
COMMIT;
-- 代码生成表
CREATE TABLE SYS_CODER(
  CODER_ID  VARCHAR (32) NOT NULL,
  TITLE  VARCHAR (100),
  MODEL_NAME  VARCHAR (200),
  MODEL_NAME_CN  VARCHAR (200),
  PACKAGE_NAME  VARCHAR (200),
  CLASS_NAME  VARCHAR (100),
  FUNCTION_NAME  VARCHAR (100),
  TABLE_NAME  VARCHAR (50),
  TABLE_COMMENT  VARCHAR (200),
  FIELDS  BLOB,
  CODER_TYPE  VARCHAR (10),
  CRT_USER_CODE  VARCHAR (32),
  CRT_ORG_CODE  VARCHAR (32),
  CRT_DATE  TIMESTAMP,
  UPD_USER_CODE  VARCHAR (32),
  UPD_ORG_CODE  VARCHAR (32),
  UPD_DATE  TIMESTAMP,
CONSTRAINT SYS_CODER PRIMARY KEY (CODER_ID)
) IN TS_PAMS_PROD INDEX IN TS_PAMS_PROD_IND;
 COMMENT ON TABLE SYS_CODER IS '系统管理-代码生成表';
 COMMENT ON SYS_CODER(
CODER_ID IS  '代码生成ID',
TITLE IS  '描述',
MODEL_NAME IS  '模块名',
MODEL_NAME_CN IS  '模块名(中文)',
PACKAGE_NAME IS  '包名',
CLASS_NAME IS  '类名',
FUNCTION_NAME IS  '功能名称',
TABLE_NAME IS  '表名',
TABLE_COMMENT IS  '表描述',
FIELDS IS  '字段列表',
CODER_TYPE IS  '类型(单表，树形，主从表)',
CRT_USER_CODE IS  '创建人',
CRT_ORG_CODE IS  '创建机构',
CRT_DATE IS  '创建日期',
UPD_USER_CODE IS  '修改人',
UPD_ORG_CODE IS  '修改机构',
UPD_DATE IS  '修改日期'
);
COMMIT;

