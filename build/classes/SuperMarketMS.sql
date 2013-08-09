DROP TABLE viapro_bill;
DROP TABLE viapro_provider;
DROP TABLE viapro_user;

CREATE TABLE viapro_user(
  ID NUMBER PRIMARY KEY NOT NULL,
  username VARCHAR2(20) NOT NULL UNIQUE,
  PASSWORD VARCHAR2(20) NOT NULL,
  gender NUMBER(1) CHECK(gender=0 OR gender=1),
  yob NUMBER(4),--year of born
  mobile VARCHAR2(20),
  address VARCHAR2(50),
  privilege INTEGER NOT NULL CHECK(privilege=0 OR privilege=1)
)

INSERT INTO viapro_user VALUES(1,'admin','orcl',0,1990,'13666668888','中国北京',0);
INSERT INTO viapro_user VALUES(2,'kirito','orcl',1,1996,'13656668889','日本东京',0);
INSERT INTO viapro_user VALUES(3,'asuna','orcl',0,1995,'13666678881','日本东京',0);
INSERT INTO viapro_user VALUES(4,'Angela','orcl',0,1995,'13666678881','US',1);
INSERT INTO viapro_user VALUES(5,'Astrid','orcl',0,1995,'13666678881','L.A.',1);
INSERT INTO viapro_user VALUES(6,'Bess','orcl',0,1995,'13666678881','New York',1);
INSERT INTO viapro_user VALUES(7,'Betty','orcl',0,1995,'13666678881','Tokyo',1);
INSERT INTO viapro_user VALUES(8,'Cara','orcl',0,1995,'13666678881','杭州',1);
INSERT INTO viapro_user VALUES(9,'Cathy','orcl',0,1995,'13666678881','悉尼',1);
INSERT INTO viapro_user VALUES(10,'Clara','orcl',0,1995,'13666678881','河内',1);
INSERT INTO viapro_user VALUES(11,'Dale','orcl',0,1995,'13666678881','美奈',1);
INSERT INTO viapro_user VALUES(12,'Eileen','orcl',0,1995,'13666678881','象山',1);
INSERT INTO viapro_user VALUES(13,'Emily','orcl',0,1995,'13666678881','Mex',1);
INSERT INTO viapro_user VALUES(14,'Emma','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(15,'Fay','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(16,'Gladys','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(17,'Hannah','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(18,'Ida','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(19,'Irene','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(20,'Ivy','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(21,'Jenny','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(22,'Joy','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(23,'Julia','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(24,'Lee','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(25,'Maria','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(26,'Olive','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(27,'Penny','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(28,'Rose','orcl',0,1995,'13666678881','日本东京',1);
INSERT INTO viapro_user VALUES(29,'Sara','orcl',0,1995,'13666678881','希腊',1);
INSERT INTO viapro_user VALUES(30,'Thera','orcl',0,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(31,'Alex','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(32,'Brian','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(33,'Dats','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(34,'Edward','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(35,'Fred','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(36,'Gary','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(37,'Ivan','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(38,'Jason','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(39,'Ken','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(40,'Neil','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(41,'Philip','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(42,'Steven','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(43,'Tony','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(44,'Vincent','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(45,'Lance','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(46,'Kevin','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(47,'Joe','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(48,'David','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(49,'Sideny','orcl',1,1995,'13666678881','英国',1);
INSERT INTO viapro_user VALUES(50,'Richard','orcl',1,1995,'13666678881','英国',1);

create table viapro_PROVIDER(
  ID          NUMBER PRIMARY KEY not null,
  proName     VARCHAR2(20),
  proDesc     VARCHAR2(50),
  CONTACT     VARCHAR2(50),
  TEL         VARCHAR2(20),
  FAX         VARCHAR2(20),
  ADDRESS     VARCHAR2(50)
)

INSERT INTO viapro_PROVIDER VALUES(1,'Google','互联网','Page','16502530000','16502530001','美国加州');
INSERT INTO viapro_PROVIDER VALUES(2,'Apple','电子产品','Tom Cook','4006668800','165025300010','美国加州');
INSERT INTO viapro_PROVIDER VALUES(3,'Microsoft','软件','Steve','4006668800','16502530001','美国西雅图');
INSERT INTO viapro_PROVIDER VALUES(4,'SAMSUNG','电子产品','Tom Cook','4006668800','16502530001','韩国');
INSERT INTO viapro_PROVIDER VALUES(5,'SONY','电子产品','Tom Cook','4006668800','16502530001','日本');
INSERT INTO viapro_PROVIDER VALUES(6,'LG','电子产品','Tom Cook','4006668800','16502530001','韩国');
INSERT INTO viapro_PROVIDER VALUES(7,'NOKIA','电子产品','Tom Cook','4006668800','16502530001','芬兰');
INSERT INTO viapro_PROVIDER VALUES(8,'BlackBerry','电子产品','Tom Cook','4006668800','16502530001','加拿大');
INSERT INTO viapro_PROVIDER VALUES(9,'Intel','半导体芯片','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(10,'AMD','信息产业','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(11,'Ford','汽车企业','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(12,'GE','技术和服务业务','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(13,'AT'||'&'||'T','电信运营商','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(14,'IBM','技术和业务','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(15,'Amazon','网上商店','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(16,'HP','信息产业','Lynn','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(17,'Facebook','互联网','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(18,'Polaroid','光学技术','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(19,'Nintendo','游戏制作公司','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(20,'Motorola','手机','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(21,'Xerox','数字化、彩色、和文件','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(22,'AOL','因特网服务','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(23,'Palm','PDA','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(24,'Cisco','互联网解决方案','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(25,'Netscape','信息产业','Tom Cook','4006668800','16502530001','美国');
INSERT INTO viapro_PROVIDER VALUES(26,'toyota','汽车企业','Tom Cook','4006668800','16502530001','日本');

create TABLE viapro_bill(
  ID           NUMBER PRIMARY KEY NOT NULL,
  PRODUCT_NAME VARCHAR2(30) NOT NULL,
  AMOUNT       NUMBER NOT NULL,
  MONEY        NUMBER NOT NULL,
  PAYSTATE     NUMBER(1) CHECK(paystate=0 OR paystate=1) NOT NULL,
  PROVIDER_ID  NUMBER REFERENCES viapro_PROVIDER(ID) NOT NULL,
  PRODUCT_DESC VARCHAR2(50),
  BILLDATE   DATE
)

INSERT INTO viapro_bill VALUES(1,'iphone6',100,500000,1,1,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(2,'iPad5',100,400000,1,1,'平板',SYSDATE);
INSERT INTO viapro_bill VALUES(3,'iMac',100,5000000,0,1,'一体机',SYSDATE);
INSERT INTO viapro_bill VALUES(4,'GalaxyS4',100,500000,1,2,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(5,'GalaxyNote3',100,500000,0,2,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(6,'VAIO',100,800000,0,3,'笔记本',SYSDATE);
INSERT INTO viapro_bill VALUES(7,'Surface',100,800000,1,3,'跨界',SYSDATE);
INSERT INTO viapro_bill VALUES(8,'Nexus4',100,800000,1,1,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(9,'Nexus7',100,800000,1,1,'平板',SYSDATE);
INSERT INTO viapro_bill VALUES(10,'Nexus10',100,800000,1,1,'平板',SYSDATE);
INSERT INTO viapro_bill VALUES(11,'Lumia',100,800000,1,7,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(12,'MacMini',100,800000,1,2,'电脑主机',SYSDATE);
INSERT INTO viapro_bill VALUES(13,'MacPro',100,800000,1,2,'电脑主机',SYSDATE);
INSERT INTO viapro_bill VALUES(14,'Z10',100,800000,0,8,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(15,'Q10',100,800000,1,8,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(16,'L36h',100,800000,1,5,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(17,'Xbox720',100,800000,0,3,'游戏机',SYSDATE);
INSERT INTO viapro_bill VALUES(18,'iPad maga',100,800000,1,2,'平板',SYSDATE);
INSERT INTO viapro_bill VALUES(19,'iPad mini',100,800000,0,2,'平板',SYSDATE);
INSERT INTO viapro_bill VALUES(20,'i7',100,800000,1,9,'CPU',SYSDATE);
INSERT INTO viapro_bill VALUES(21,'推土机',100,800000,1,10,'CPU',SYSDATE);
INSERT INTO viapro_bill VALUES(22,'XL39H',100,800000,1,5,'智能机',SYSDATE);
INSERT INTO viapro_bill VALUES(23,'Glass',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(24,'GWatch',100,800000,0,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(25,'GoogleX',1,8000000,1,1,'Personal Lab',SYSDATE);
INSERT INTO viapro_bill VALUES(26,'Service',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(27,'Chrome',10,800000,1,1,'笔记本电脑',SYSDATE);
INSERT INTO viapro_bill VALUES(28,'Neddle',100,800000,0,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(29,'Mouse',100,800000,1,1,'外设',SYSDATE);
INSERT INTO viapro_bill VALUES(30,'Swatch',100,800000,1,5,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(31,'Glasses',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(32,'Glasses',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(33,'Hdex',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(34,'ALLX',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(35,'GTX',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(36,'Gooer',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(37,'GoHa',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(38,'GoNi',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(39,'GoGi',100,800000,1,1,'穿戴式智能设备',SYSDATE);
INSERT INTO viapro_bill VALUES(40,'GoXR',100,800000,1,1,'穿戴式智能设备',SYSDATE);

SELECT * FROM viapro_user;
SELECT * FROM viapro_PROVIDER;
SELECT * FROM viapro_bill;