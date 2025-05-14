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
    constraint fk_nation_region_key foreign key (region_key) references region(region_key),
    nation_comment varchar(125) comment '备注'
)comment '国家表';

create table supplier(
    supp_key int primary key auto_increment comment '供应商编号',
    name varchar(25) comment '供应商名称',
    address varchar(40) comment '供应商地址',
    nation_key int comment '国家编号',
    constraint fk_supplier_nation_key foreign key (nation_key) references nation(nation_key),
    phone varchar(15) comment '供应商电话',
    account_balance decimal(15,2) comment '账户余额',
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
    retailprice decimal(15,2) comment '零售价格',
    part_comment varchar(25) comment '备注'
)comment '零件表';

create table partsupp(
    part_key int comment '零件编号',
    constraint fk_partsupp_part_key foreign key (part_key) references part(part_key),
    supp_key int comment '供应商编号',
    constraint fk_partsupp_supp_key foreign key (supp_key) references supplier(supp_key),
    availqty int comment '可用数量',
    partsupp_comment varchar(200) comment '备注',
    primary key (part_key, supp_key)
)comment '零件供应联系表';
alter table partsupp add column supply_cost decimal(15,2) comment '供应价格';

create table customer(
    cust_key int primary key auto_increment comment '顾客编号',
    name varchar(25) comment '姓名',
    address varchar(40) comment '地址',
    nation_key int comment '国家编号',
    constraint fk_customer_nation_key foreign key (nation_key) references nation(nation_key),
    phone varchar(15) comment '电话',
    account_balance decimal(15,2) comment '账户余额',
    mktsegment varchar(10) comment '市场分区',
    customer_comment varchar(150) comment '备注'
)comment '顾客表';

create table orders(
    order_key int primary key auto_increment comment '订单编号',
    cust_key int comment '顾客编号',
    constraint fk_orders_cust_key foreign key (cust_key) references customer(cust_key),
    order_status char(1) comment '订单状态',
    total_price decimal(15,2) comment '订单总金额',
    order_date date comment '订单日期',
    order_priority varchar(15) comment '订单优先级',
    clerk varchar(15) comment '记账员',
    ship_priority int comment '运输优先级别',
    order_comment varchar(100) comment '备注'
)comment '订单表';

create table lineitem(
    order_key int comment '订单编号',
    constraint fk_lineitem_order_key foreign key (order_key) references orders(order_key),
    part_key int comment '零件编号',
    constraint fk_lineitem_part_key foreign key (part_key) references part(part_key),
    supp_key int comment '供应商编号',
    constraint fk_lineitem_supp_key foreign key (supp_key) references supplier(supp_key),
    line_number int comment '订单明细编号',
    quantity decimal(15,2) comment '数量',
    extended_price decimal(15,2) comment '订单明细价格',
    discount decimal(5,2) comment '折扣',
    tax decimal(5,2) comment '税率',
    return_flag char(1) comment '退货标记',
    line_status char(1) comment '订单明细状态',
    ship_date date comment '装货日期',
    commit_date date comment '委托日期',
    receipt_date date comment '签收日期',
    ship_instruct varchar(25) comment '装运说明',
    ship_mode varchar(25) comment '装运方式',
    lineitem_comment varchar(50) comment '备注',
    primary key (order_key, line_number),
    constraint fk_lineitem_part_supp_key foreign key (part_key, supp_key) references partsupp(part_key, supp_key)
)comment '订单明细表';


# 查询供应商的名称，地址和联系电话
select name, address, phone from supplier;

# 查询近一周内提交的总价大于1000原的订单编号，顾客编号，等订单的所有信息
select * from orders where order_date >= now() - interval 7 day and total_price > 1000;

# 统计每个顾客的订单金额
select c.cust_key, sum(o.total_price) from customer c, orders o
                                      where c.cust_key = o.cust_key group by c.cust_key;

# 查询订单平均金额超过1000的顾客编号机器姓名
select c.cust_key, c.name from customer c, orders o where c.cust_key = o.cust_key
                    group by c.cust_key, c.name having avg(o.total_price) > 1000;

# 查询与‘金仓集团’在同一个国家的供应商编号，名称，地址信息
select s1.supp_key, s1.name, s1.address from supplier s1, supplier s2
         where s1.nation_key = s2.nation_key and s2.name = '金仓集团';

# 查询供应价格大于零售价格的零件名，制造商名，零售价，供应价格
select p.name, p.mfgr, p.retailprice, ps.supply_cost from part p, partsupp ps
         where p.part_key = ps.part_key and ps.supply_cost > p.retailprice;



