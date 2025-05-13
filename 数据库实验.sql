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
    region_key int comment '所属地区编号',
    constraint region_key foreign key (region_key) references region(region_key),
    nation_comment varchar(125) comment '备注'
)comment '国家表';

create table supplier(
    supp_key int primary key auto_increment comment '供应商编号',
    name varchar(25) comment '供应商名称',
    address varchar(40) comment '供应商地址',
    nation_key int comment '国家编号',
    constraint nation_key foreign key (nation_key) references nation(nation_key),
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
    part_key int comment '零件编号', 
    constraint part_key foreign key (part_key) references part(part_key),
    supp_key int comment '供应商编号', 
    constraint supp_key foreign key (supp_key) references supplier(supp_key),
    availqty int comment '可用数量',
    partsupp_comment varchar(200) comment '备注',
    primary key (part_key, supp_key)
)comment '零件供应联系表';

create table customer(
    cust_key int primary key auto_increment comment '顾客编号',
    name varchar(25) comment '姓名',
    address varchar(40) comment '地址',
    nation_key int comment '国家编号',
    constraint nation_key foreign key (nation_key) references nation(nation_key),
    phone varchar(15) comment '电话',
    account_balance real comment '账户余额',
    mktsegment varchar(10) comment '市场分区',
    customer_comment varchar(150) comment '备注'
)comment '顾客表';

create table orders(
    order_key int primary key auto_increment comment '订单编号',
    cust_key int comment '顾客编号',
    constraint cust_key foreign key (cust_key) references customer(cust_key),
    order_status char(1) comment '订单状态',
    total_price real comment '订单总金额',
    order_date date comment '订单日期',
    order_priority varchar(15) comment '订单优先级',
    clerk varchar(15) comment '记账员',
    ship_priority int comment '运输优先级别',
    order_comment varchar(100) comment '备注'
)comment '订单表';

create table lineitem(
    order_key int comment '订单编号',
    constraint order_key foreign key (order_key) references orders(order_key),
    part_key int comment '零件编号',
    constraint part_key foreign key (part_key) references part(part_key),
    supp_key int comment '供应商编号',
    constraint supp_key foreign key (supp_key) references supplier(supp_key),
    line_number int comment '订单明细编号',
    quantity real comment '数量',
    extended_price real comment '订单明细价格',
    discount real comment '折扣',
    tax real comment '税率',
    return_flag char(1) comment '退货标记',
    line_status char(1) comment '订单明细状态',
    ship_date date comment '装货日期',
    commit_date date comment '委托日期',
    receip_date date comment '签收日期',
    ship_instruct varchar(25) comment '装运说明',
    ship_mode varchar(25) comment '装运方式',
    lineitem_comment varchar(50) comment '备注',
    primary key (order_key, line_number),
    foreign key (part_key, supp_key) references partsupp(part_key, supp_key)
)comment '订单明细表';

