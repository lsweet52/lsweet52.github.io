create database pss;

drop database pss;

use pss;








-- =======================


create table region(
    region_key int primary key auto_increment comment '地区编号',
    name varchar(25) not null comment '地区名称',
    region_comment varchar(125) comment '备注'
)comment '地区表';

create table nation(
    nation_key int primary key auto_increment comment '国家编号',
    name varchar(25) unique comment '国家名称',
    region_key int default 0 comment '所属地区编号',
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
    return_flag char(1) check(return_flag in('A', 'R', 'N')) comment '退货标记',
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

create trigger trg_check_shipdate_insert
before insert on lineitem
for each row
begin
    if new.ship_date >= new.receipt_date then
        signal sqlstate '45000'
        set message_text = '装货日期必须早于签收日期';
    end if;
end;


#  插入数据
-- 插入地区表数据
INSERT INTO region (name, region_comment) VALUES
('北美', '北美地区'),
('南美', '南美地区'),
('欧洲', '欧洲地区'),
('亚洲', '亚洲地区'),
('非洲', '非洲地区');

-- 插入国家表数据
INSERT INTO nation (name, region_key, nation_comment) VALUES
('美国', 1, '美洲国家'),
('加拿大', 1, '美洲国家'),
('巴西', 2, '南美国家'),
('德国', 3, '欧洲国家'),
('法国', 3, '欧洲国家'),
('日本', 4, '亚洲国家'),
('中国', 4, '亚洲国家'),
('印度', 4, '亚洲国家'),
('南非', 5, '非洲国家'),
('埃及', 5, '非洲国家');

-- 插入供应商表数据
INSERT INTO supplier (name, address, nation_key, phone, account_balance, supplier_comment) VALUES
('供应商A', '地址A', 1, '111-1111', 1000.00, '优质供应商'),
('供应商B', '地址B', 2, '222-2222', 1200.00, '稳定供应商'),
('供应商C', '地址C', 3, '333-3333', 900.00, '欧洲供应商'),
('供应商D', '地址D', 4, '444-4444', 800.00, '亚洲供应商'),
('供应商E', '地址E', 5, '555-5555', 700.00, '非洲供应商'),
('供应商F', '地址F', 1, '111-6666', 600.00, '优质供应商'),
('供应商G', '地址G', 2, '222-7777', 400.00, '稳定供应商'),
('供应商H', '地址H', 3, '333-8888', 500.00, '欧洲供应商'),
('供应商I', '地址I', 4, '444-9999', 300.00, '亚洲供应商'),
('供应商J', '地址J', 5, '555-0000', 200.00, '非洲供应商');

-- 插入零件表数据
INSERT INTO part (name, mfgr, brand, type, size, container, retailprice, part_comment) VALUES
('零件A', '制造商1', '品牌A', '类型1', 10, '箱A', 100.50, '优秀零件'),
('零件B', '制造商1', '品牌B', '类型2', 20, '箱B', 200.00, '普通零件'),
('零件C', '制造商2', '品牌C', '类型1', 30, '箱C', 300.75, '优质零件'),
('零件D', '制造商2', '品牌D', '类型3', 40, '箱D', 400.25, '次品零件'),
('零件E', '制造商3', '品牌E', '类型2', 50, '箱E', 500.00, '常规零件'),
('零件F', '制造商3', '品牌F', '类型1', 60, '箱F', 600.10, '优秀零件'),
('零件G', '制造商4', '品牌G', '类型3', 70, '箱G', 700.90, '优质零件'),
('零件H', '制造商4', '品牌H', '类型2', 80, '箱H', 800.80, '次品零件'),
('零件I', '制造商5', '品牌I', '类型1', 90, '箱I', 900.30, '常规零件'),
('零件J', '制造商5', '品牌J', '类型3', 100, '箱J', 1000.00, '优秀零件');

-- 插入零件供应联系表数据
INSERT INTO partsupp (part_key, supp_key, availqty, supply_cost, partsupp_comment) VALUES
(1, 1, 100, 50.00, '良好'),
(2, 2, 200, 60.00, '良好'),
(3, 3, 150, 70.00, '优质'),
(4, 4, 300, 80.00, '稳定'),
(5, 5, 250, 90.00, '常规'),
(6, 6, 120, 45.00, '良好'),
(7, 7, 80, 55.00, '稳定'),
(8, 8, 60, 65.00, '优质'),
(9, 9, 50, 75.00, '普通'),
(10, 10, 40, 85.00, '常规');

-- 插入顾客表数据
INSERT INTO customer (name, address, nation_key, phone, account_balance, mktsegment, customer_comment) VALUES
('顾客A', '地址A', 1, '111-1111', 1000.00, '分区1', '稳定顾客'),
('顾客B', '地址B', 2, '222-2222', 2000.00, '分区2', '优质顾客'),
('顾客C', '地址C', 3, '333-3333', 3000.00, '分区3', '普通顾客'),
('顾客D', '地址D', 4, '444-4444', 4000.00, '分区1', '长期顾客'),
('顾客E', '地址E', 5, '555-5555', 5000.00, '分区2', '优质顾客'),
('顾客F', '地址F', 1, '111-6666', 600.00, '分区3', '普通顾客'),
('顾客G', '地址G', 2, '222-7777', 400.00, '分区1', '新顾客'),
('顾客H', '地址H', 3, '333-8888', 500.00, '分区2', '普通顾客'),
('顾客I', '地址I', 4, '444-9999', 300.00, '分区3', '稳定顾客'),
('顾客J', '地址J', 5, '555-0000', 200.00, '分区1', '长期顾客');

-- 插入订单表数据
INSERT INTO orders (cust_key, order_status, total_price, order_date, order_priority, clerk, ship_priority, order_comment) VALUES
(1, 'O', 1500.00, '2025-01-01', '高', '记账员A', 1, '加急'),
(2, 'F', 2500.00, '2025-02-01', '低', '记账员B', 2, '普通'),
(3, 'P', 3500.00, '2025-03-01', '中', '记账员C', 3, '延迟'),
(4, 'O', 4500.00, '2025-04-01', '高', '记账员D', 4, '加急'),
(5, 'F', 5500.00, '2025-05-01', '低', '记账员E', 5, '普通'),
(6, 'P', 6500.00, '2025-06-01', '中', '记账员F', 1, '延迟'),
(7, 'O', 7500.00, '2025-07-01', '高', '记账员G', 2, '加急'),
(8, 'F', 8500.00, '2025-08-01', '低', '记账员H', 3, '普通'),
(9, 'P', 9500.00, '2025-09-01', '中', '记账员I', 4, '延迟'),
(10, 'O', 10500.00, '2025-10-01', '高', '记账员J', 5, '加急');

-- 插入订单明细表数据
INSERT INTO lineitem (order_key, part_key, supp_key, line_number, quantity, extended_price, discount, tax, return_flag, line_status, ship_date, commit_date, receipt_date, ship_instruct, ship_mode, lineitem_comment) VALUES
(1, 1, 1, 1, 10.00, 500.00, 0.10, 0.05, 'N', 'O', '2025-01-05', '2025-01-10', '2025-01-15', '快速运输', '陆运', '优质明细'),
(2, 2, 2, 2, 20.00, 1000.00, 0.15, 0.08, 'N', 'O', '2025-02-05', '2025-02-10', '2025-02-15', '普通运输', '海运', '普通明细');




# 实验3.2
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

# 查询供应价格大于零售价格的零件名，制造商名，零售价，供应价格(普通连接)
select p.name, p.mfgr, p.retailprice, ps.supply_cost from part p, partsupp ps
         where ps.supply_cost > p.retailprice;

# (自然连接)
select p.name, p.mfgr, p.retailprice, ps.supply_cost from part p, partsupp ps
         where p.part_key = ps.part_key and ps.supply_cost > p.retailprice;

# 查询顾客'苏举库'订购的订单编号，总价，及其订购的零件编号，数量，明细价格
select o.order_key, o.total_price, l.part_key, l.quantity, l.extended_price from
        customer c, orders o, lineitem l
         where c.cust_key = o.cust_key and o.order_key = l.order_key and c.name = '苏举库';


# 实验3.3
# 查询订购了"海大"制造的"船舶模拟驾驶舱"的顾客


# 查询没有购买过"海大"制造的"船舶模拟驾驶舱"的顾客

# 查询至少购买过"张三"购买过的全部零件的顾客姓名

# 查询在订单平均金额超过10000原的顾客中，中国籍顾客的信息

# 查询顾客"张三"和"李四"都订购过的全部零件的信息
# 1.

# 2.

# 顾客"张三"订购过而"李四"没订购过的零件的信息



# 实验3.4
#


# 实验3.5
# (1)创建视图（省略视图列名）
# 创建一个“海大汽配”供应商供应的零件视图V_DLMU_PartSuppl,要求列出供应零件的编号，零件名称，可用数量，零售价格，供应价格，备注信息
create view V_DLMU_PartSuppl as select p.part_key, p.name, ps.availqty, p.retailprice, ps.supply_cost, p.part_comment
        from part p, partsupp ps, supplier s
        where p.part_key = ps.part_key and s.supp_key = ps.supp_key and s.name = '海大汽配';

# (2)创建视图（不能省略列名的情况）
# 创建一个视图V_CustAvgOrder,按顾客统计平均每个订单的购买金额和零件数量，要求输出顾客编号，姓名，平均购买金额和平均购买零件数量
create view V_CustAvgOrder(Custkey, Cname, Avgprice, Avgquantity) as
    select c.cust_key, max(c.name), avg(o.total_price),
    avg(l.quantity) from customer c, orders o, lineitem l
    where c.cust_key = o.cust_key and l.order_key = o.order_key
    group by c.cust_key;

#(3)创建视图（with check option）
#使用with check option ,创建一个“海大汽配”供应商供应的零件视图V_DLMU_PartSupp2,要全球列出供应零件的编号，可用数量，供应价格等，然后通过视图分别曾家，删除，和修改一条"海大汽配"d的零件供应记录，验证with check option是否起作用
create view V_DLMU_PartSupp2 as
    select part_key, supp_key, availqty, partsupp.supply_cost from partsupp
    where supp_key = (select supp_key from supplier where name = '海大汽配')
with check option;

insert into V_DLMU_PartSupp2 values(58889, 5048, 704, 77760);

update V_DLMU_PartSupp2 set supply_cost = 12 where supp_key = 58889;

delete from V_DLMU_PartSupp2 where supp_key = 58889;


#(4) 可更新的视图（行列子集视图）
# 创建一个“海大汽配”供应商供应的零件视图V_DLMU_PartSupp3,要求列出供应零件的编号，可用数量，供应价格，然后通过改视图分别增加，删除，和修改一条“海大汽配”零件供应记录，验证该视图是否可以跟新，并比较第3题和本题结果有何异同
create view V_DLMU_PartSupp3 as select part_key, supp_key, availqty,partsupp.supply_cost from
    partsupp where supp_key = (select supp_key from supplier where name = '海大汽配');

insert into V_DLMU_PartSupp3 values(58889, 5048, 704, 77760);

update V_DLMU_PartSupp3 set supply_cost = 12 where supp_key = 58889;

delete from V_DLMU_PartSupp3 where supp_key = 58889;

#(5)不可更改的视图
# 第二题中创建的视图是可更新的吗？通过sql更新语句加以验证，并说明原因
insert into V_CustAvgOrder values(100000,null,20,2000);

#(6)删除视图(RESTRICT/CASCADE)
/*
创建顾客订购零件明细视图V_CustOrd，要求列出顾客编号、姓名、购买零件数、金额;在该视图的基础上，再创建
第2题的视图V_CustAvgOrder，然后使用RESTRICT 选项删除视图 V_CustOrd，观察现象并解释原因。利用CASCADE
选项删除视图V_CustOrd，观察现象并检查V_CustAvgOrder是否存在。解释原因。
*/
create view V_CustOrd(Custkey, Cname, Qty, Extprice) as
    select c.cust_key, c.name, l.quantity, l.extended_price from
    customer c, orders o, lineitem l
    where c.cust_key = o.cust_key and o.order_key = l.order_key;

create view V_CustAvgOrder(Custkey, Cname, Avgqty, Avgprice) as
    select Custkey, max(Cname), avg(Qty), avg(Extprice)
    from V_CustOrd group by Custkey;

drop view V_CustOrd;




# 实验3.6
# (1)创建唯一索引
# 在零件表的零件名称字段上创建唯一索引
create unique index idx_part_name on part(name);

# (2)创建函数索引（对某个属性的函数创建索引，称为函数索引）
# 在零件表的零件名称字段上创建一个零件名称长度的函数索引
create index idx_part_name_fun on part((length(name)));

# (3)创建复合索引(对两个及两个以上的属性创建索引，称为复合索引)
# 在零件表的制造商和品牌两个字段上创建一个复合索引
create unique index idx_part_mfgr_brand on part(mfgr, brand);

# (4)创建聚簇索引
# 在零件表的制造商字段上创建一个聚簇索引
create unique index idx_part_mfgr on part(mfgr);
/*
(5)创建哈希索引，在零件表的名称字段上创建一个哈希索引
*/
create index idx_part_name_hash on part ((crc32(name)));
/*
(6)修改索引名称，修改零件表的名称字段上的索引名
*/
drop index idx_part_name_hash on part;

create index idx_part_name_hash_new on part(name) using hash;

# (7)分析某个sql查询语句执行是是否使用了使用
explain select * from part where name = '零件';
# (8)验证索引效率，创建一个函数TestIndex,自动计算sql查询执行的时间
DELIMITER $$

CREATE FUNCTION TestIndex(p_partname CHAR(55))
RETURNS INTEGER
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE begintime DATETIME(6);
    DECLARE endtime DATETIME(6);
    DECLARE durationtime INT;
    DECLARE dummy INT DEFAULT 0;

    -- 获取开始时间
    SET begintime = CURRENT_TIMESTAMP(6);

    -- 执行查询（仅统计匹配行数）
    SELECT COUNT(*) INTO dummy FROM Part WHERE Name = p_partname;

    -- 获取结束时间
    SET endtime = CURRENT_TIMESTAMP(6);

    -- 计算耗时（单位：毫秒）
    SET durationtime = TIMESTAMPDIFF(MICROSECOND, begintime, endtime) DIV 1000;

    RETURN durationtime;
END$$

DELIMITER ;

select * from part where part_key = 9;

# 实验4.1
# (1)创建用户
-- 1.
create user 'David'@'localhost' identified by '123456';
create user 'Tom'@'localhost' identified by '123456';
create user 'Kathy'@localhost identified by '123456';
-- 2.
create user 'Jeffery' identified by '123456';
create user 'Jane' identified by '123456';
create user 'Mike' identified by '123456';
# (2)创建角色并分配权限
-- 1.
create role PurchaseQueryRole;
grant select on PSS.part to 'PurchaseQueryRole';
grant select on PSS.supplier to PurchaseQueryRole;
grant select on PSS.partsupp to PurchaseQueryRole;

create role SaleQueryRole;
grant select on PSS.orders to SaleQueryRole;
grant select on PSS.lineitem to SaleQueryRole;

create role CustomerQueryRole;
grant select on PSS.customer to CustomerQueryRole;
grant select on PSS.nation to CustomerQueryRole;
grant select on PSS.region to CustomerQueryRole;

-- 2.为各个部门分别创建一个职员角色，对本部门信息具有查看，插入权限
create role PurchaseEmployeeRole;
grant select, insert on PSS.part to PurchaseEmployeeRole;
grant select, insert on PSS.supplier to PurchaseEmployeeRole;
grant select, insert on PSS.partsupp to PurchaseEmployeeRole;

create role SaleEmployeeRole;
grant select, insert on PSS.orders to SaleEmployeeRole;
grant select, insert on PSS.lineitem to SaleEmployeeRole;

create role CustomerEmployeeRole;
grant select, insert on PSS.customer to CustomerEmployeeRole;
grant select, insert on PSS.nation to CustomerEmployeeRole;
grant select, insert on PSS.region to CustomerEmployeeRole;

/*3.为各部门创建一个经理角色，相应角色对本部门的信息具有完全控制权限，对其部门的信息具有查询权。
  经理有权给本部门职员分配权限。
 */
create role PurchaseManagerRole;
grant all on PSS.part to PurchaseManagerRole;
grant all on PSS.supplier to PurchaseManagerRole;
grant all on PSS.partsupp to PurchaseManagerRole;
grant SaleQueryRole to PurchaseManagerRole;
grant CustomerQueryRole to PurchaseManagerRole;

create role SaleManagerRole;
grant all on PSS.orders to SaleManagerRole;
grant all on PSS.lineitem to SaleManagerRole;
grant PurchaseQueryRole to SaleManagerRole;
grant CustomerQueryRole to SaleManagerRole;

create role CustomerManagerRole;
grant all on PSS.customer to CustomerManagerRole;
grant all on PSS.nation to CustomerManagerRole;
grant all on PSS.region to CustomerManagerRole;
grant PurchaseQueryRole to CustomerQueryRole;
grant SaleQueryRole to CustomerQueryRole;

-- (3)给用户分配权限
-- 1.给各部门经理分配权限
grant PurchaseManagerRole to David with admin option ;
grant SaleManagerRole to Tom with admin option ;
grant CustomerManagerRole to Kathy with admin option ;

-- 2.给各部门职员分配权限
grant PurchaseEmployeeRole to Jeffery;
grant SaleEmployeeRole to Jane;
grant CustomerEmployeeRole to Mike;

# (4)回收角色或用户权限
-- 1.收回客户经理角色的销售信息查看权限
revoke SaleQueryRole from CustomerManagerRole;

-- 2.回收Mike的客户部门职员权限
revoke CustomerEmployeeRole from Mike;



-- ======================================


alter table nation drop primary key;


insert into supplier values(11,'test1','test1','101','12345678',0.0,'test1');
insert into supplier values(11,'test2','test2','102','22345678',0.0,'test2');


-- =======================================
drop database pss;







-- (1) 创建表时定义参照完整性

/*-- 先定义地区表的实体完整性
CREATE TABLE Region (
    Regionkey INTEGER PRIMARY KEY,
    Name CHAR(25),
    Comment VARCHAR(152)
);

-- 再定义国家表上的参照完整性（列级参照完整性）
CREATE TABLE Nation (
    Nationkey INTEGER PRIMARY KEY,
    Name CHAR(25),
    Regionkey INTEGER REFERENCES Region(Regionkey),  -- 列级参照完整性
    Comment VARCHAR(152)
);

-- 或者使用表级参照完整性
CREATE TABLE Nation (
    Nationkey INTEGER PRIMARY KEY,
    Name CHAR(25),
    Regionkey INTEGER,
    Comment VARCHAR(152),
    CONSTRAINT FK_Nation_regionkey FOREIGN KEY (Regionkey) REFERENCES Region(Regionkey)  -- 表级参照完整性
);

-- (2) 创建表后定义参照完整性

-- 定义国家表的参照完整性
CREATE TABLE Nation (
    Nationkey INTEGER PRIMARY KEY,
    Name CHAR(25),
    Regionkey INTEGER,
    Comment VARCHAR(152)
);

ALTER TABLE Nation
ADD CONSTRAINT FK_Nation_regionkey
FOREIGN KEY (Regionkey) REFERENCES Region(Regionkey);

-- (3) 定义参照完整性（外码由多个属性组成）

-- 定义订单明细表的参照完整性
-- 创建PartSupp表
CREATE TABLE PartSupp (
    Partkey INTEGER,
    Suppkey INTEGER,
    Availqty INTEGER,
    Supplycost REAL,
    Comment VARCHAR(199),
    PRIMARY KEY(Partkey, Suppkey)
);

-- 创建Lineitem表，并定义外键约束
CREATE TABLE Lineitem (
    Orderkey INTEGER REFERENCES Orders(Orderkey),
    Partkey INTEGER REFERENCES Part(Partkey),
    Suppkey INTEGER REFERENCES Supplier(Suppkey),
    Linenumber INTEGER,
    Quantity REAL,
    Extendedprice REAL,
    Discount REAL,
    Tax REAL,
    Returnflag CHAR(1),
    Linestatus CHAR(1),
    Shipdate DATE,
    Commitdate DATE,
    Receiptdate DATE,
    Shipinstruct CHAR(25),
    Shipmode CHAR(10),
    Comment VARCHAR(44),
    PRIMARY KEY(Orderkey, Linenumber),
    FOREIGN KEY (Partkey, Suppkey) REFERENCES PartSupp(Partkey, Suppkey)
);

-- 创建Nation表，并定义参照完整性的违约处理
CREATE TABLE Nation (
    Nationkey INTEGER PRIMARY KEY,
    Name CHAR(25),
    Regionkey INTEGER,
    Comment VARCHAR(152),
    CONSTRAINT FK_Nation_regionkey FOREIGN KEY (Regionkey) REFERENCES Region(Regionkey) ON DELETE SET NULL ON UPDATE SET NULL
);*/

-- (5).删除参照完整性
-- 删除国家表的外码
# alter table nation drop constraint fk_nation_region_key;



-- (6).插入一条国家记录，验证参照完整性是否起作用
# insert into nation(nation_key, name, region_key, nation_comment)
#     values(12, 'nation1', '1001', 'comment1');


-- ===================


-- 5.3
create trigger trg_check_shipdate_insert
before insert on lineitem
for each row
begin
    if new.ship_date >= new.receipt_date then
        signal sqlstate '45000'
        set message_text = '装货日期必须早于签收日期';
    end if;
end;


-- (5).修改lineitem的一条记录验证是否违反check约束
update lineitem set ship_date = '2015-01-05', receipt_date = '2015-01-01'
    where order_key = 2 and line_number = 1;



-- ========================
-- 实验5.4 触发器实验
-- (1).after触发器
delimiter $$

create trigger trg_lineitem_price_update
after update on lineitem
for each row
begin
    declare l_valuediff decimal(10,2);

    /* 计算价格修正值 */
    set l_valuediff = new.extended_price * (1 - new.discount) * (1 + new.tax)
                    - old.extended_price * (1 - old.discount) * (1 + old.tax);

    /* 更新订单的总价 */
    update orders set total_price = total_price + l_valuediff
    where order_key = new.order_key;
end$$

delimiter ;

-- ====================


show triggers;

-- =====================
-- (2)insert触发器
delimiter $$

create trigger trl_lineitem_price_insert
after insert on lineitem
for each row
begin
    declare l_valuediff decimal(15,2);
    set l_valuediff = new.extended_price * (1 - new.discount) * (1 + new.tax);
    update orders set total_price = total_price + l_valuediff
    where order_key = new.order_key;
end$$

delimiter ;

-- (3)delete触发器
delimiter $$

create trigger trl_lineitem_priice_delete
after delete on lineitem
for each row
begin
    declare l_valuediff decimal(15,2);
    set l_valuediff = -old.extended_price * (1 - old.discount) * (1 + old.tax);
    update orders set total_price = total_price - l_valuediff
    where order_key = old.order_key;
end$$

delimiter ;

-- (4)验证触发器trl_lineitem_price_update
select total_price from orders where order_key = 1;

update lineitem set tax = tax + 0.005 where order_key = 1 and line_number = 1;

select total_price from orders where order_key = 1;

-- (5)before触发器
-- 1.before update触发器
delimiter $$

create trigger trl_lineitem_quantity_update
before update on lineitem
for each row
begin
    declare l_valuediff integer;
    declare l_availqty integer;
    set l_valuediff = new.quantity - old.quantity;

    select availqty into l_availqty from partsupp
        where part_key = new.part_key and supp_key = new.supp_key;

    if(l_availqty - l_valuediff >= 0) then
        update partsupp set availqty = availqty - l_valuediff
        where part_key = new.part_key and supp_key = new.supp_key;
    else
        signal sqlstate '45000'
        set message_text = 'availqty quantity is not enough';
    end if;
end$$

delimiter ;

-- 2.before insert触发器
delimiter $$

create trigger trl_lineitem_quantity_insert
before insert on lineitem
for each row
begin
    declare l_valuediff integer;
    declare l_availqty integer;
    set l_valuediff = new.quantity;

    select availqty into l_availqty from partsupp
    where part_key = new.part_key and supp_key = new.supp_key;

    if(l_availqty - l_valuediff >= 0) then
        update partsupp set availqty = availqty - l_valuediff
        where part_key = new.part_key and supp_key = new.supp_key;
    else
        signal sqlstate '45000'
        set message_text = 'availqty quantity is not enough';
    end if;
end $$

delimiter ;

-- 3.before delete触发器
delimiter $$

create trigger trl_lineitem_quantity_delete
before update on lineitem
for each row
begin
    declare l_valuediff decimal(15,2);
    declare l_availqty decimal(15,2);
    set l_valuediff = -old.quantity;

    update partsupp set availqty = availqty - l_valuediff
    where part_key = new.part_key and supp_key = new.supp_key;
end $$

delimiter ;

show triggers ;

-- =================
-- 验证触发器trl_lineitem_quanity_update
select l.part_key, l.supp_key, l.quantity, ps.availqty from lineitem l, partsupp ps
where l.part_key = ps.part_key and l.supp_key = ps.supp_key and l.order_key = 2
and l.line_number = 2;

update lineitem set quantity = quantity + 5
    where order_key = 2 and line_number = 2;

select * from lineitem l, partsupp ps
where l.part_key = ps.part_key and l.supp_key = ps.supp_key and l.order_key = 2
and l.line_number = 2;

show triggers ;

-- (6)删除触发器
DROP TRIGGER IF EXISTS trg_lineitem_price_update;

/*
删除触发器
DROP TRIGGER IF EXISTS trl_lineitem_price_insert;
DROP TRIGGER IF EXISTS trl_lineitem_quantity_update;
DROP TRIGGER IF EXISTS trg_lineitem_price_update;
DROP TRIGGER IF EXISTS trl_lineitem_priice_delete;
DROP TRIGGER IF EXISTS trg_check_shipdate_insert;
*/



-- ==================
-- 实验8.1
-- (1).1
delimiter $$

create procedure proc_caltotalprice()
begin
    update orders o
    join (
        select order_key, sum(extended_price * (1 - discount) * (1 + tax)) as total
        from lineitem
        group by order_key
    ) l on o.order_key = l.order_key
    set o.total_price = l.total;
end $$

delimiter ;

-- (1).2


-- (2).1

-- (2).2

-- (3).1

-- (3).2


-- (3).3

-- (4).1

-- (4).2

-- (4).3

-- (5).1

-- (5).2

-- (6)


-- ======================

-- 实验8.2

