-- 用户表
drop table if exists tUsers;
create table tUsers (
	id int(10) auto_increment primary key comment '用户ID',
	userName varchar(20) not null comment '用户昵称',
	account varchar(10) not null unique comment '用户名',
	`password` varchar(20) not null comment '密码',
	gender int(1) default 2 comment '性别（0: 女, 1: 男, 2: 保密）',
	age int(3) comment '年龄',
	birthday date comment '生日',
	telephone varchar(11) comment '联系电话',
	address varchar(255) comment '收货地址',
	email varchar(255) comment '邮箱',
	avatar varchar(255) comment '头像',
	userType int(1) default 0 comment '用户类型（0: 实名用户, 1: 管理员）',
	balance decimal(10, 2) default 0.00 comment '余额',
	`status` int(1) default 0 comment '用户状态（0: 不在线, 1: 在线）'
);
insert into tUsers values (null, '管理员', 'admin', 'password', 2, null, null, '16612341234', null, null, 'avatars/admin.png', 1, 0.0, 0);

-- 商品类型表
drop table if exists tGoodsTypes;
create table tGoodsTypes (
	id int(10) auto_increment primary key comment '商品类型ID',
	goodsTypesName varchar(20) not null comment '商品类型名称'
);
insert into tGoodsTypes values 
(null, '男装'),
(null, '女装'),
(null, '鞋袜'),
(null, '饰品'),
(null, '数码电子'),
(null, '电器家具'),
(null, '百货'),
(null, '图书'),
(null, '医药'),
(null, '宠物花卉'),
(null, '生活载具'),
(null, '二手房');

-- 商品表
drop table if exists tGoods;
create table tGoods (
	id int(10) auto_increment primary key comment '商品ID',
	userId int(10) not null comment '用户ID',
	goodsName varchar(50) not null comment '商品名称',
	goodsPicture varchar(255) comment '商品图片',
	goodsTypeId int(10) comment '商品类型',
	goodsDetail varchar(255) comment '商品详细描述',
	goodsQuantity int not null comment '商品数量',
	goodsPrice decimal(10, 2) not null comment '商品价格',
	goodsStatus int(1) not null comment '商品状态（0: 求购, 1: 在售）',
	goodsReviewId int(10) comment '商品评价',
	foreign key (userId) references tUsers(id),
	foreign key (goodsTypeId) references tGoodsTypes(id)
);

-- 用户商品表
drop table if exists tUsersGoods;
create table tUsersGoods (
	id int(10) auto_increment primary key comment '用户商品表ID',
	userId int(10) not null comment '用户ID',
	goodsId int(10) not null comment '商品ID'
);

-- 商品评价表
drop table if exists tGoodsReviews;
create table tGoodsReviews (
	id int(10) auto_increment primary key comment '商品评价ID',
	userId int(10) not null comment '用户ID',
	goodsId int(10) not null comment '商品ID',
	goodsReviewTime datetime comment '评价时间',
	goodsReviewDetail varchar(255) comment '商品评价内容'
);

-- 订单表
drop table if exists tOrders; 
create table tOrders (
	id int(10) auto_increment primary key comment '订单ID',
	userId int(10) not null comment '用户ID',
	goodsId int(10) not null comment '商品ID',
	buyQuantity int(10) not null comment '购买数量',
	orderTime datetime not null comment '订单时间',
	orderStatus int(1) default -1 comment '订单状态(0: 待付款, 1: 已付款, 2: 已收货)',
	foreign key (userId) references tUsers(id),
	foreign key (goodsId) references tGoods(id)
);

-- 购物车表
drop table if exists tShoppingCars;
create table tShoppingCars (
	id int(10) auto_increment primary key comment '购物车ID',
	userId int(10) not null comment '用户ID',
	goodsId int(10) not null comment '商品ID',
	buyQuantity int(10) default 0 comment '购买数量',
	foreign key (userId) references tUsers(id),
	foreign key (goodsId) references tGoods(id)
);
