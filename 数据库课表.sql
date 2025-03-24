CREATE TABLE Student(
	Sno INT PRIMARY KEY COMMENT '学号',
	Sname VARCHAR(20) COMMENT '姓名',
	Ssex VARCHAR(1) COMMENT '性别',
	Sage INT COMMENT '年龄',
	Sdept VARCHAR(20) COMMENT '专业'
)COMMENT '学生表';

INSERT INTO Student VALUES(95001,'李勇','M',20,'CS'),
(95002,'刘晨','F',19,'IS'),
(95003,'王名','M',18,'MA'),
(95004,'张立','F',18,'IS');


CREATE TABLE Course(
	Cno INT PRIMARY KEY COMMENT '课程号',
	Cname VARCHAR(20) COMMENT '课程名',
	Cpno VARCHAR(20) COMMENT '先修课',
	Ccredit INT COMMENT '学分'
)COMMENT '课程表';

INSERT INTO Course VALUES(1,'数据库',5,4),
(2,'数学',NULL,2),
(3,'信息系统',1,4),
(4,'操作系统',6,3),
(5,'数据结构',7,4),
(6,'数据处理',NULL,2),
(7,'C语言',6,4);


CREATE TABLE SC(
	Sno INT NOT NULL COMMENT '选课学生学号',
	Cno INT NOT NULL COMMENT '课程号',
	Grade DECIMAL(5,2) COMMENT '成绩'
)COMMENT '学生选课表';

INSERT INTO SC VALUES(95001,1,92.0),(95001,2,85.0),(95001,3,88.0),(95002,2,90.0),(95002,3,80.0);
