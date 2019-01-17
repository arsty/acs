/*
	《门禁控制系统(Access control system)数据库设计概述》
	1、用户，角色，权限的关系
	角色：可以理解为一定数量的权限的集合，权限的载体，要给某个用户授予权限，不需要直接将权限授予用户，可以直接将"管理者"这个角色赋予用户
	权限：这里的权限主要是指能否登陆后台，能否开启某个或某一区域内的门，还有就是规定的时间段开启某个门
	关系：一个用户拥有多个角色(管理员和教师)，每一个角色拥有若干权限，也就是用户与角色之间，角色与权限之间，一般是多对多的关系(需要通过中间表建立联系)
	
	2、分组
	当用户较多时，要给系统每个用户逐一授权，是件繁琐的事情，这就需要分组了，每个组内有多个用户，除了给用户授权外，还可以给用户组授权

	3、问题
	要给用户授权某一层楼的门禁
	这是权限和门禁的关系
	所以要不要再弄个权限-门禁表呢？
	还是给门禁分组，然后使用组id？
*/

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
)comment '用户信息表'


CREATE TABLE tb_role(
	id BIGINT(20) not null auto_increment PRIMARY key comment '角色id',
	role_name VARCHAR(64) not null comment '名称',
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '创建时间',
	description VARCHAR(200) comment '角色描述'
)comment '用户角色信息,无权登录后台的普通用户，可以登录后台的管理员和超级管理员'


CREATE TABLE tb_right(
	id BIGINT(20) not null auto_increment PRIMARY key comment '权限ID',
	right_name VARCHAR(64) not null comment '权限名称',
	range VARCHAR(12) not null comment '权限范围',
	description VARCHAR(200) comment '权限具体描述'
)comment '权限表'



CREATE TABLE tb_group(
	id BIGINT(20) not null auto_increment PRIMARY key comment '组ID',
	group_name VARCHAR(64) not null comment '组名称',
	description VARCHAR(200) comment '组信息描述',
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '创建时间'
)comment '用于用户分组，便于权限管理'



CREATE TABLE group_right(
	gr_id BIGINT(20) not null AUTO_INCREMENT PRIMARY key,
	g_id BIGINT(20) not null comment '组id',
	r_id BIGINT(20) not null comment '权限id',
	right_type TINYINT not null comment '1,允许,0,不允许'
)comment '组权限表'



CREATE TABLE tb_role_right(
	id BIGINT(20) not null auto_increment PRIMARY KEY comment '标识ID',
	role_id BIGINT(20) not null comment '角色id',
	right_id BIGINT(20) not null comment '权限id',
	right_type TINYINT not null comment '1,允许,0,不允许'
)comment '角色权限表'



CREATE TABLE user_right(
	id BIGINT(20) not null  PRIMARY KEY comment '标识ID',
	u_id VARCHAR(12) not null comment '操作人',
	right_id BIGINT(20) not null comment '权限id',
	ac_id int(10) not null comment '门禁编号',
	right_type TINYINT not null comment '1,允许,0,不允许'
)comment '用户权限表'



CREATE TABLE user_role(
	id BIGINT(20) not null  PRIMARY KEY comment '标识ID',
	u_id VARCHAR(12) not null comment '操作人',
	role_id BIGINT(20) not null comment '角色id',
)comment '用户角色表'



CREATE TABLE tb_position(
	id int(10) not null auto_increment PRIMARY KEY,
	house VARCHAR(20) not null comment '哪栋楼,如信息楼',
	floor VARCHAR(10) not null comment '楼层,如2楼',
	locate VARCHAR(10) not null comment '具体门牌号,如215'
)comment '学校位置信息表'



CREATE TABLE tb_ac(
	ac_id int(10) not null auto_increment PRIMARY KEY comment '门禁编号',
	status TINYINT DEFAULT null comment '1开启状态，0关闭状态',
	pos_id int(10) not null comment '位置id,用于确定门禁所在位置',
	note VARCHAR(200) comment '备注'
)comment '门禁信息表'


CREATE TABLE tb_log(
	log_id BIGINT(20) not null auto_increment PRIMARY key, 
	u_id VARCHAR(12) not null comment '操作人',
	ac_id int(10) not null comment '门禁编号',
	op_type TINYINT not null comment '操作类型：1刷卡，0扫码',
	door_status TINYINT not null comment '1进入，0离开',
	op_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment '操作时间'
)comment '日志记录表'