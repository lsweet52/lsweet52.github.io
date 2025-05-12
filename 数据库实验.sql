create database PSS;

use PSS;

create table region(
    region_key int primary key auto_increment comment '地区编号',
    name varchar(25) comment '地区名称',
    region_comment varchar(125) comment '备注'
)comment '地区表';

create table nation(
    nation_key int primary key auto_increment comment '国家编号',
    name varchar(25) comment '国家名称',
#   外键  constraint region_key foreign key (region_key) references region(region_key),
    nation_comment varchar(125) comment '备注'
)comment '国家表';

create table supplier(
    supp_key int primary key auto_increment comment '供应商编号',
    name varchar(25) comment '供应商名称',
    address varchar(40) comment '供应商地址',
#     nation,外键
    phone varchar(15) comment '供应商电话',
    account_balance real comment '账户余额',
    supplier_comment varchar(150) comment '备注'
)comment '供应商表';

create table part(
    part_key int primary key auto_increment comment '零件编号',
    name varchar(55) comment '零件名称',
    mfgr varchar(25) comment '制造商',
    brand varchar(10) comment '品牌',
    type varchar(25) comment '类型',
    size int comment '尺寸',
    container varchar(10) comment '包装',
    retailprice real comment '零售价格',
    part_comment varchar(25) comment '备注'
)comment '零件表';

create table partsupp(
    零件编号，
    供应商编号，
                     可用梳理，
                     供应价格，
                     备注
                     定义主码，表级约束
)comment '零件供应联系表';

create table customer(
    cust_key int primary key auto_increment comment '顾客编号',
    name varchar(25) comment '姓名',
    address varchar(40) comment '地址',
    nation_key ,
    phone varchar(15) comment '电话',
    account_balance real comment '账户余额',
    mktsegment varchar(10) comment '市场分区',
    customer_comment varchar(150) comment '备注'
)comment '顾客表';

create table orders(
    order_key int primary key auto_increment comment '订单编号',
    cust_key,
    order_status char(1) comment '订单状态',
    total_price real comment '订单总金额',
    order_date date comment '订单日期',
    order_priority varchar(15) comment '订单优先级',
    clerk varchar(15) comment '记账员',
    ship_priority int comment '运输优先级别',
    order_comment varchar(100) comment '备注'
)comment '订单表';

