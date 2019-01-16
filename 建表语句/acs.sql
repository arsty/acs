//Access control system

//创建用户表
CREATE TABLE tb_user(
	id bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Id',
	u_id VARCHAR(12) not null UNIQUE comment '工号/登录名',
	u_pwd VARCHAR(32) not null comment '密码，加密储存',
	fullname VARCHAR(20) not null comment '姓名',
	class VARCHAR(100) comment '班级',
	college VARCHAR(50) comment '二级学院',
	phone VARCHAR(20) DEFAULT null comment '联系手机,默认为空',
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '创建时间',
	CONSTRAINT PRIMARY KEY(id)
)comment '用户信息表，根据用户角色判断是否能够登录后台，根据权限判断用户是否能够开门'


//创建角色表
CREATE TABLE tb_role(
	id BIGINT(20) not null auto_increment PRIMARY key comment '角色id',
	role_name VARCHAR(64) not null comment '名称',
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '创建时间',
	description VARCHAR(200) comment '角色描述'
)comment '用户角色信息,主要是无权登录后台的普通用户，以及可以登录后台的管理员和超级管理员'


//创建权限表
CREATE TABLE tb_right(
	id BIGINT(20) not null auto_increment PRIMARY key comment '权限ID',
	range_name VARCHAR(64) not null comment '权限名称',
	description VARCHAR(200) comment '描述权限'
)comment '权限表'



//创建组表，用于用户分组，便于权限管理
CREATE TABLE tb_group(
	id BIGINT(20) not null auto_increment PRIMARY key comment '组ID',
	group_name VARCHAR(64) not null comment '组名称',
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '创建时间',
	description VARCHAR(200) comment '组信息描述'
)comment '用于用户分组，便于权限管理'



//角色权限表
CREATE TABLE tb_role_right(
	id BIGINT(20) not null auto_increment PRIMARY KEY comment '标识ID',
	role_id BIGINT(20) not null comment '角色id',
	right_id BIGINT(20) not null comment '权限id'
)comment '角色权限表'



//学校位置表
CREATE TABLE tb_location(
	id int(10) not null auto_increment PRIMARY KEY,
	floor VARCHAR(20) not null comment '哪栋楼,如信息楼',
	house VARCHAR(10) not null comment '门牌号,如215',
)comment '学校信息表'


//门禁信息表
CREATE TABLE tb_ac(
	ac_id int(10) not null auto_increment PRIMARY KEY comment '门禁编号',
	status TINYINT DEFAULT null comment '1开启状态，0关闭状态',
	location_id int(10) not null comment '位置id,用于确定门禁所在位置',
	note VARCHAR(200) comment '备注'
)comment '门禁信息表'


//操作日志表
CREATE TABLE tb_log(
	log_id BIGINT(20) not null auto_increment PRIMARY key, 
	op_type TINYINT not null comment '操作类型：1开门，0关门',
	u_id VARCHAR(12) not null comment '操作人',
	op_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '操作时间'
)
