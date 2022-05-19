-- --------------------------------------------------------
-- 호스트:                          211.47.74.38
-- 서버 버전:                        8.0.20 - Source distribution
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  9.5.0.5278
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 테이블 dbbium.adminmember 구조 내보내기
CREATE TABLE IF NOT EXISTS `adminmember` (
  `a_id` varchar(50) DEFAULT NULL,
  `a_name` varchar(50) DEFAULT NULL,
  `a_email` varchar(50) DEFAULT NULL,
  `a_hp` varchar(50) DEFAULT NULL,
  `a_contents` text,
  `a_seqno` int NOT NULL AUTO_INCREMENT,
  `a_date` datetime DEFAULT NULL,
  `a_pass` varchar(50) DEFAULT NULL,
  `a_level` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`a_seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.adminmember:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `adminmember` DISABLE KEYS */;
INSERT INTO `adminmember` (`a_id`, `a_name`, `a_email`, `a_hp`, `a_contents`, `a_seqno`, `a_date`, `a_pass`, `a_level`) VALUES
	('admin', '관리자', 'ceter5555@aver.com', '010-8633-1506', '관리자용아이디', 1, '2017-08-28 00:00:00', 'gdyb21LQTcIANtvYMT7QVQ==', '2');
/*!40000 ALTER TABLE `adminmember` ENABLE KEYS */;

-- 테이블 dbbium.banner 구조 내보내기
CREATE TABLE IF NOT EXISTS `banner` (
  `seq` int DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `ori_name` varchar(500) DEFAULT NULL,
  `re_name` varchar(500) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `target` varchar(1) DEFAULT NULL,
  `use_yn` varchar(1) DEFAULT NULL,
  `del_yn` varchar(1) DEFAULT 'N',
  `sort_seq` varchar(1) DEFAULT NULL,
  `reg_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='배너관리';

-- 테이블 데이터 dbbium.banner:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;

-- 테이블 dbbium.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `seq` int NOT NULL COMMENT '순번',
  `board_name` varchar(20) DEFAULT NULL COMMENT '게시판구분',
  `id` varchar(20) DEFAULT NULL COMMENT '아이디',
  `name` varchar(20) DEFAULT NULL COMMENT '이름',
  `member_seq` varchar(20) DEFAULT NULL COMMENT '회원순번',
  `title` varchar(200) DEFAULT NULL COMMENT '제목',
  `reg_date` datetime DEFAULT NULL COMMENT '등록일',
  `upt_date` datetime DEFAULT NULL COMMENT '수정일',
  `del_date` datetime DEFAULT NULL COMMENT '삭제일',
  `notice_yn` varchar(1) DEFAULT NULL COMMENT '공지여부',
  `del_yn` varchar(1) DEFAULT 'N' COMMENT '삭제여부',
  `main_yn` varchar(1) DEFAULT NULL COMMENT '메인여부',
  `ref` int DEFAULT NULL COMMENT '답글순번',
  `ref_step` int DEFAULT '0' COMMENT '답글 단계',
  `ref_level` int DEFAULT '0' COMMENT '답글레벨',
  `content` longtext COMMENT '내용',
  `hit` int DEFAULT '0' COMMENT '조회수',
  `upt_id` varchar(100) DEFAULT NULL COMMENT '삭제수정',
  `pwd` varchar(100) DEFAULT NULL COMMENT '비밀번호',
  `thum_img` varchar(100) DEFAULT NULL,
  `ori_name1` varchar(100) DEFAULT NULL,
  `re_name1` varchar(100) DEFAULT NULL,
  `ori_name2` varchar(100) DEFAULT NULL,
  `re_name2` varchar(100) DEFAULT NULL,
  `ori_name3` varchar(100) DEFAULT NULL,
  `re_name3` varchar(100) DEFAULT NULL,
  `re_content` longtext,
  `re_com` char(1) DEFAULT 'n',
  `email_send` char(1) DEFAULT NULL,
  `sms_send` char(1) DEFAULT NULL,
  `cate_nm` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.board:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 dbbium.board_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_comment` (
  `SEQ` int NOT NULL AUTO_INCREMENT COMMENT '순번',
  `ID` varchar(20) DEFAULT NULL COMMENT '아이디',
  `NAME` varchar(20) DEFAULT NULL COMMENT '이름',
  `MEMBER_SEQ` varchar(20) DEFAULT NULL COMMENT '회원순번',
  `CONTENTS` varchar(4000) DEFAULT NULL COMMENT '내용',
  `REG_DATE` datetime DEFAULT NULL COMMENT '등록일',
  `IP` datetime DEFAULT NULL COMMENT '아이피',
  `UPT_DATE` datetime DEFAULT NULL COMMENT '수정일',
  `DEL_DATE` datetime DEFAULT NULL COMMENT '삭제일',
  `DEL_YN` varchar(1) DEFAULT NULL COMMENT '삭제여부',
  `BOARD_SEQ` int NOT NULL COMMENT '보드순번',
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.board_comment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_comment` ENABLE KEYS */;

-- 테이블 dbbium.bokyong_table 구조 내보내기
CREATE TABLE IF NOT EXISTS `bokyong_table` (
  `name` varchar(100) DEFAULT NULL,
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `wdate` datetime DEFAULT NULL,
  `contents` text,
  `id` varchar(100) DEFAULT NULL,
  `base_yn` char(1) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.bokyong_table:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `bokyong_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `bokyong_table` ENABLE KEYS */;

-- 테이블 dbbium.box_table 구조 내보내기
CREATE TABLE IF NOT EXISTS `box_table` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `box_name` varchar(100) DEFAULT NULL,
  `box_image` varchar(200) DEFAULT NULL,
  `box_image2` varchar(200) DEFAULT NULL,
  `box_image3` varchar(200) DEFAULT NULL,
  `box_size` varchar(100) DEFAULT NULL,
  `box_price` varchar(50) DEFAULT '0',
  `box_contents` text,
  `wdate` datetime DEFAULT NULL,
  `box_status` varchar(5) DEFAULT NULL,
  `del_yn` varchar(1) DEFAULT 'n',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.box_table:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `box_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `box_table` ENABLE KEYS */;

-- 테이블 dbbium.b_dictionary 구조 내보내기
CREATE TABLE IF NOT EXISTS `b_dictionary` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `b_code` varchar(50) DEFAULT NULL,
  `b_name` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.b_dictionary:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `b_dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `b_dictionary` ENABLE KEYS */;

-- 테이블 dbbium.common_setup 구조 내보내기
CREATE TABLE IF NOT EXISTS `common_setup` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL DEFAULT '0',
  `id` varchar(60) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `c_tang_type` char(1) DEFAULT NULL,
  `c_chup_ea` varchar(50) DEFAULT NULL,
  `c_pack_ml` varchar(50) DEFAULT NULL,
  `c_pack_ea` varchar(50) DEFAULT NULL,
  `c_pouch_type` char(1) DEFAULT NULL,
  `c_pouch_text` varchar(100) DEFAULT NULL,
  `pouch_seqno` int DEFAULT NULL,
  `c_box_type` char(1) DEFAULT NULL,
  `c_box_text` varchar(100) DEFAULT NULL,
  `box_seqno` int DEFAULT NULL,
  `c_stpom_type` char(1) DEFAULT NULL,
  `c_stpom_text` varchar(100) DEFAULT NULL,
  `stpom_seqno` int DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.common_setup:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `common_setup` DISABLE KEYS */;
/*!40000 ALTER TABLE `common_setup` ENABLE KEYS */;

-- 테이블 dbbium.community 구조 내보내기
CREATE TABLE IF NOT EXISTS `community` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `part` varchar(50) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `handphone` varchar(20) DEFAULT NULL,
  `wdate` varchar(50) DEFAULT NULL,
  `contents` text,
  `hits` int DEFAULT NULL,
  `id` varchar(60) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `ref` int DEFAULT NULL,
  `re_step` int DEFAULT NULL,
  `re_level` int DEFAULT NULL,
  `passcheck` varchar(50) DEFAULT NULL,
  `contents2` text,
  `notice` char(1) DEFAULT NULL,
  `han_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.community:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `community` DISABLE KEYS */;
/*!40000 ALTER TABLE `community` ENABLE KEYS */;

-- 테이블 dbbium.counsel_open 구조 내보내기
CREATE TABLE IF NOT EXISTS `counsel_open` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `meet_time` varchar(255) DEFAULT NULL,
  `upfile` varchar(255) DEFAULT NULL,
  `wdate` varchar(70) DEFAULT NULL,
  `handphone` varchar(100) DEFAULT NULL,
  `contents` text,
  `recontents` char(1) DEFAULT NULL,
  `mail_check` char(1) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.counsel_open:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `counsel_open` DISABLE KEYS */;
/*!40000 ALTER TABLE `counsel_open` ENABLE KEYS */;

-- 테이블 dbbium.counsel_qna 구조 내보내기
CREATE TABLE IF NOT EXISTS `counsel_qna` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `part` varchar(50) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `upfile` varchar(255) DEFAULT NULL,
  `wdate` varchar(70) DEFAULT NULL,
  `handphone` varchar(100) DEFAULT NULL,
  `contents` text,
  `recontents` char(1) DEFAULT NULL,
  `mail_check` char(1) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.counsel_qna:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `counsel_qna` DISABLE KEYS */;
/*!40000 ALTER TABLE `counsel_qna` ENABLE KEYS */;

-- 테이블 dbbium.delivery_insert_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `delivery_insert_info` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `admin_id` varchar(50) DEFAULT NULL,
  `wdate` varchar(50) DEFAULT NULL,
  `row_i` int DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.delivery_insert_info:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `delivery_insert_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery_insert_info` ENABLE KEYS */;

-- 테이블 dbbium.dic_yakjae 구조 내보내기
CREATE TABLE IF NOT EXISTS `dic_yakjae` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `dy_name` varchar(50) DEFAULT NULL,
  `dy_from` varchar(50) DEFAULT NULL,
  `dy_standard` varchar(10) DEFAULT NULL,
  `dy_danga` varchar(10) DEFAULT NULL,
  `b_code` varchar(50) DEFAULT NULL,
  `s_code` varchar(50) DEFAULT NULL,
  `dy_gdanga` varchar(10) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `dy_code` varchar(50) DEFAULT NULL,
  `complete` char(1) DEFAULT NULL,
  `hap_name` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`seqno`),
  KEY `인덱스 2` (`b_code`,`s_code`),
  KEY `인덱스 3` (`dy_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.dic_yakjae:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `dic_yakjae` DISABLE KEYS */;
/*!40000 ALTER TABLE `dic_yakjae` ENABLE KEYS */;

-- 테이블 dbbium.dic_yakjae_temp 구조 내보내기
CREATE TABLE IF NOT EXISTS `dic_yakjae_temp` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `dy_name` varchar(50) DEFAULT NULL,
  `dy_from` varchar(50) DEFAULT NULL,
  `dy_standard` varchar(10) DEFAULT NULL,
  `dy_danga` varchar(10) DEFAULT NULL,
  `b_code` varchar(50) DEFAULT NULL,
  `s_code` varchar(50) DEFAULT NULL,
  `dy_gdanga` varchar(10) DEFAULT NULL,
  `wdate` char(10) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.dic_yakjae_temp:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `dic_yakjae_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dic_yakjae_temp` ENABLE KEYS */;

-- 테이블 dbbium.goods 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods` (
  `p_seq` int NOT NULL,
  `p_code` varchar(50) NOT NULL,
  `p_name` varchar(100) DEFAULT NULL,
  `p_bigpart` varchar(50) DEFAULT NULL,
  `p_smallpart` varchar(50) DEFAULT NULL,
  `p_ea` varchar(50) DEFAULT NULL,
  `image2` varchar(100) DEFAULT NULL,
  `image3` varchar(100) DEFAULT NULL,
  `main_yn` varchar(1) NOT NULL DEFAULT 'n',
  `p_mileage` int DEFAULT NULL,
  `p_size` varchar(18) DEFAULT NULL,
  `p_front` char(1) DEFAULT NULL,
  `p_contents` text,
  `p_date` datetime DEFAULT NULL,
  `p_price` int DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `etc1` varchar(50) DEFAULT NULL,
  `etc2` varchar(50) DEFAULT NULL,
  `p_point` varchar(10) DEFAULT NULL,
  `p_from` varchar(50) DEFAULT NULL,
  `p_bigo` varchar(255) DEFAULT NULL,
  `p_print` int DEFAULT NULL,
  `po_unit` varchar(50) DEFAULT NULL,
  `jo_complete` int DEFAULT '0',
  `jo_ing` int DEFAULT '0',
  `set_period` int DEFAULT NULL,
  `delivery_price` int DEFAULT '0',
  `jo_from` varchar(50) DEFAULT NULL,
  `set_design` text,
  `yak_design1` varchar(50) DEFAULT NULL,
  `yak_design2` varchar(50) DEFAULT NULL,
  `yak_design3` varchar(50) DEFAULT NULL,
  `yak_design4` varchar(50) DEFAULT NULL,
  `yak_design5` varchar(50) DEFAULT NULL,
  `yak_design6` varchar(50) DEFAULT NULL,
  `yak_design7` varchar(50) DEFAULT NULL,
  `yak_design8` varchar(50) DEFAULT NULL,
  `yak_design9` varchar(50) DEFAULT NULL,
  `yak_design10` varchar(50) DEFAULT NULL,
  `yak_design11` varchar(50) DEFAULT NULL,
  `yak_design12` varchar(50) DEFAULT NULL,
  `yak_design13` varchar(50) DEFAULT NULL,
  `yak_design14` varchar(50) DEFAULT NULL,
  `yak_design15` varchar(50) DEFAULT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `view_yn` char(1) DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `sort_seq` int DEFAULT NULL COMMENT '정렬순위',
  PRIMARY KEY (`p_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.goods:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- 테이블 dbbium.goods_box_option 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods_box_option` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `goods_seqno` int NOT NULL,
  `sort_seq` int NOT NULL,
  `box_nm` varchar(50) NOT NULL COMMENT '박스명',
  `use_yn` varchar(1) NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `box_price` int NOT NULL,
  `wdate` datetime NOT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='약속처방 포장 옵션';

-- 테이블 데이터 dbbium.goods_box_option:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods_box_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_box_option` ENABLE KEYS */;

-- 테이블 dbbium.goods_pre_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods_pre_order` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `goods_seqno` int NOT NULL,
  `ea` int NOT NULL COMMENT '남은수량',
  `upt_date` datetime NOT NULL,
  `sing_img` longtext NOT NULL COMMENT '사인이미지',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사전조제지시서 현황';

-- 테이블 데이터 dbbium.goods_pre_order:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods_pre_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_pre_order` ENABLE KEYS */;

-- 테이블 dbbium.goods_pre_order_his 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods_pre_order_his` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `goods_seqno` int NOT NULL,
  `ea` int NOT NULL COMMENT '남은수량',
  `upt_date` datetime NOT NULL,
  `sing_img` longtext,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사전조제지시서 현황 기록';

-- 테이블 데이터 dbbium.goods_pre_order_his:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods_pre_order_his` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_pre_order_his` ENABLE KEYS */;

-- 테이블 dbbium.goods_pre_order_print 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods_pre_order_print` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `goods_name` varchar(50) NOT NULL,
  `month` varchar(50) NOT NULL,
  `print_ea` int NOT NULL,
  `goods_seq` int NOT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사전조제지시서 출력 수량 저장';

-- 테이블 데이터 dbbium.goods_pre_order_print:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods_pre_order_print` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_pre_order_print` ENABLE KEYS */;

-- 테이블 dbbium.goods_sub_group 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods_sub_group` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `p_seq` int NOT NULL,
  `sub_group_code` int NOT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='서브그룹 저장';

-- 테이블 데이터 dbbium.goods_sub_group:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods_sub_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods_sub_group` ENABLE KEYS */;

-- 테이블 dbbium.joje_before 구조 내보내기
CREATE TABLE IF NOT EXISTS `joje_before` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `ea` int DEFAULT NULL,
  `wdate` varchar(60) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `id` varchar(60) DEFAULT NULL,
  `han_name` varchar(60) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `ods` varchar(50) DEFAULT NULL,
  `juso` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.joje_before:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `joje_before` DISABLE KEYS */;
/*!40000 ALTER TABLE `joje_before` ENABLE KEYS */;

-- 테이블 dbbium.joje_table 구조 내보내기
CREATE TABLE IF NOT EXISTS `joje_table` (
  `name` varchar(100) DEFAULT NULL,
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `wdate` datetime DEFAULT NULL,
  `contents` text,
  `base_yn` char(1) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.joje_table:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `joje_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `joje_table` ENABLE KEYS */;

-- 테이블 dbbium.log_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `log_info` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `han_name` varchar(50) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `ldate` varchar(80) DEFAULT NULL,
  `user_ip` varchar(100) DEFAULT NULL,
  `user_br` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.log_info:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `log_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_info` ENABLE KEYS */;

-- 테이블 dbbium.manage_delivery 구조 내보내기
CREATE TABLE IF NOT EXISTS `manage_delivery` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL DEFAULT '0' COMMENT '택배사코드',
  `delivery_nm` varchar(50) NOT NULL DEFAULT '0' COMMENT '택배사명',
  `temple_no` varchar(50) NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0' COMMENT '가격',
  `use_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '사용여부',
  `del_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '삭제여부',
  `sel_yn` char(1) NOT NULL DEFAULT 'n' COMMENT '기본',
  `wdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일',
  `udate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '마지막업데이트',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.manage_delivery:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `manage_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `manage_delivery` ENABLE KEYS */;

-- 테이블 dbbium.manage_delivery_free 구조 내보내기
CREATE TABLE IF NOT EXISTS `manage_delivery_free` (
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품가격 무료배송';

-- 테이블 데이터 dbbium.manage_delivery_free:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `manage_delivery_free` DISABLE KEYS */;
/*!40000 ALTER TABLE `manage_delivery_free` ENABLE KEYS */;

-- 테이블 dbbium.manage_member_grade 구조 내보내기
CREATE TABLE IF NOT EXISTS `manage_member_grade` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `del_yn` char(1) NOT NULL DEFAULT 'n',
  `per` int NOT NULL DEFAULT '0' COMMENT '할인률',
  `yak_per` int NOT NULL DEFAULT '0',
  `tang_price` int NOT NULL DEFAULT '0' COMMENT '탕전가격',
  `jusu_price` int NOT NULL DEFAULT '0' COMMENT '탕전 주수상반',
  `jeung_price` int NOT NULL DEFAULT '0' COMMENT '탕전 증류탕전',
  `yak_price` int NOT NULL DEFAULT '0' COMMENT '첩약가격',
  `member_nm` varchar(50) DEFAULT NULL COMMENT '멤버등급명',
  `wdate` datetime DEFAULT NULL COMMENT '등록일',
  `mile_per` int DEFAULT '0' COMMENT '마일리지 적립율',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='회원등급 설정';

-- 테이블 데이터 dbbium.manage_member_grade:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `manage_member_grade` DISABLE KEYS */;
/*!40000 ALTER TABLE `manage_member_grade` ENABLE KEYS */;

-- 테이블 dbbium.manage_member_group 구조 내보내기
CREATE TABLE IF NOT EXISTS `manage_member_group` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `group_nm` varchar(500) NOT NULL,
  `sale_per` int NOT NULL DEFAULT '0',
  `upt_user` varchar(50) NOT NULL,
  `del_yn` varchar(1) NOT NULL,
  `upt_date` datetime NOT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='회원그룹 관리';

-- 테이블 데이터 dbbium.manage_member_group:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `manage_member_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `manage_member_group` ENABLE KEYS */;

-- 테이블 dbbium.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `jumin` varchar(50) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `handphone` varchar(20) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `address01` varchar(300) DEFAULT NULL,
  `address02` varchar(300) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `member_level` varchar(5) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `part` char(1) DEFAULT NULL,
  `license_no` varchar(50) DEFAULT NULL,
  `from_school` varchar(50) DEFAULT NULL,
  `han_name` varchar(100) DEFAULT NULL,
  `school_no` varchar(50) DEFAULT NULL,
  `biz_no` varchar(50) DEFAULT NULL,
  `han_zipcode` varchar(50) DEFAULT NULL,
  `han_address01` varchar(300) DEFAULT NULL,
  `han_address02` varchar(300) DEFAULT NULL,
  `han_tel` varchar(50) DEFAULT NULL,
  `han_fax` varchar(50) DEFAULT NULL,
  `sub_id` varchar(50) DEFAULT NULL,
  `sub_password` varchar(50) DEFAULT NULL,
  `sub_id_confirm` char(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `han_level` varchar(50) DEFAULT NULL,
  `mailing` char(1) DEFAULT NULL,
  `point` int DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `class_name` varchar(100) DEFAULT NULL,
  `admin_view` char(1) DEFAULT NULL,
  `member_file` varchar(100) DEFAULT NULL,
  `member_file_re` varchar(100) DEFAULT NULL,
  `member_file2` varchar(100) DEFAULT NULL,
  `member_file2_re` varchar(100) DEFAULT NULL,
  `license_yn` char(1) DEFAULT NULL,
  `bill_yn` char(1) DEFAULT NULL,
  `admin_memo` text,
  `info_fix` varchar(1) DEFAULT 'Y',
  `out_yn` varchar(50) DEFAULT 'N',
  `sign_img` longtext,
  PRIMARY KEY (`seqno`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.member:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

-- 테이블 dbbium.my_dictionary 구조 내보내기
CREATE TABLE IF NOT EXISTS `my_dictionary` (
  `seqno` int NOT NULL,
  `dic_seqno` int DEFAULT NULL,
  `s_name` varchar(100) DEFAULT NULL,
  `s_jomun` text,
  `s_jukeung` varchar(300) DEFAULT NULL,
  `b_name` varchar(100) DEFAULT NULL,
  `s_chamgo` varchar(300) DEFAULT NULL,
  `wdate` varchar(70) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `complete` char(1) DEFAULT NULL,
  `b_name1` varchar(200) DEFAULT NULL,
  `b_name2` varchar(200) DEFAULT NULL,
  `b_name3` varchar(200) DEFAULT NULL,
  `b_name4` varchar(200) DEFAULT NULL,
  `b_name5` varchar(200) DEFAULT NULL,
  `s_name1` varchar(200) DEFAULT NULL,
  `s_name2` varchar(200) DEFAULT NULL,
  `s_name3` varchar(200) DEFAULT NULL,
  `s_name4` varchar(200) DEFAULT NULL,
  `s_name5` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.my_dictionary:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `my_dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_dictionary` ENABLE KEYS */;

-- 테이블 dbbium.my_dictionary_yakjae 구조 내보내기
CREATE TABLE IF NOT EXISTS `my_dictionary_yakjae` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `my_seqno` int DEFAULT NULL,
  `my_standard` float DEFAULT '0',
  `my_joje` float DEFAULT NULL,
  `yak_code` varchar(50) DEFAULT NULL,
  `complete` char(1) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `ea` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.my_dictionary_yakjae:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `my_dictionary_yakjae` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_dictionary_yakjae` ENABLE KEYS */;

-- 테이블 dbbium.patient 구조 내보내기
CREATE TABLE IF NOT EXISTS `patient` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `age` varchar(5) DEFAULT NULL,
  `birth_year` varchar(50) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `edate` datetime DEFAULT NULL,
  `jindan` varchar(1000) DEFAULT NULL,
  `size` varchar(1000) DEFAULT NULL,
  `etc1` varchar(1000) DEFAULT NULL,
  `etc2` varchar(1000) DEFAULT NULL,
  `contents` text,
  `zipcode` varchar(50) DEFAULT NULL,
  `address01` varchar(300) DEFAULT NULL,
  `address02` varchar(300) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `handphone` varchar(50) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `mem_seq` varchar(50) DEFAULT NULL,
  `chart_num` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.patient:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;

-- 테이블 dbbium.personal_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `personal_order` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `han_name` varchar(50) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `view_yn` varchar(1) NOT NULL COMMENT '활성화여부',
  `content` longtext NOT NULL,
  `price` int NOT NULL,
  `upt_user` varchar(50) NOT NULL,
  `upt_date` datetime NOT NULL,
  `pay_yn` varchar(1) NOT NULL COMMENT '결제여부',
  `del_yn` varchar(1) NOT NULL,
  `admin_confirm` varchar(1) NOT NULL DEFAULT 'n',
  `admin_id` varchar(50) DEFAULT NULL,
  `admin_name` varchar(50) DEFAULT NULL,
  `admin_seqno` varchar(50) DEFAULT NULL,
  `admin_date` datetime NOT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='개인결제';

-- 테이블 데이터 dbbium.personal_order:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `personal_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_order` ENABLE KEYS */;

-- 테이블 dbbium.personal_order_detail 구조 내보내기
CREATE TABLE IF NOT EXISTS `personal_order_detail` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `personal_seqno` int NOT NULL,
  `mem_seqno` int NOT NULL,
  `pay_gbn` int DEFAULT '1' COMMENT '1카드',
  `card_gu_no` varchar(50) DEFAULT NULL,
  `card_ju_no` varchar(50) DEFAULT NULL,
  `card_su_no` varchar(50) DEFAULT NULL,
  `card_nm` varchar(50) DEFAULT NULL,
  `card_code` varchar(50) DEFAULT NULL,
  `card_quota` varchar(50) DEFAULT NULL,
  `card_amt` varchar(50) DEFAULT NULL,
  `card_cancel_id` varchar(50) DEFAULT NULL,
  `card_cancel_date` varchar(50) DEFAULT NULL,
  `wdate` datetime NOT NULL,
  `del_yn` varchar(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='개인결제 결제 정보';

-- 테이블 데이터 dbbium.personal_order_detail:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `personal_order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_order_detail` ENABLE KEYS */;

-- 테이블 dbbium.popup_data 구조 내보내기
CREATE TABLE IF NOT EXISTS `popup_data` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `upfile` varchar(100) DEFAULT NULL,
  `w_size` varchar(20) DEFAULT NULL,
  `h_size` varchar(20) DEFAULT NULL,
  `start_date` char(10) DEFAULT NULL,
  `end_date` char(10) DEFAULT NULL,
  `top_size` varchar(10) DEFAULT NULL,
  `left_size` varchar(10) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `view_yn` char(1) DEFAULT NULL,
  `yn_link` text,
  `yn_win` varchar(10) DEFAULT NULL,
  `part` varchar(50) DEFAULT NULL,
  `pop_type` varchar(50) DEFAULT NULL COMMENT '팝업 종류',
  `wdate` datetime DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL COMMENT '대상아이디',
  `name` varchar(50) DEFAULT NULL COMMENT '대상성명',
  `han_name` varchar(50) DEFAULT NULL COMMENT '대상한의원명',
  `content` longtext COMMENT '내용',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.popup_data:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `popup_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `popup_data` ENABLE KEYS */;

-- 테이블 dbbium.pouch_table 구조 내보내기
CREATE TABLE IF NOT EXISTS `pouch_table` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `pouch_name` varchar(100) DEFAULT NULL,
  `pouch_status` varchar(50) DEFAULT NULL,
  `pouch_image` varchar(100) DEFAULT NULL,
  `pouch_image2` varchar(100) DEFAULT NULL,
  `pouch_image3` varchar(100) DEFAULT NULL,
  `pouch_size` varchar(100) DEFAULT NULL,
  `pouch_price` varchar(50) DEFAULT '0',
  `pouch_contents` text,
  `wdate` datetime DEFAULT NULL,
  `del_yn` varchar(50) DEFAULT 'n',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.pouch_table:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pouch_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `pouch_table` ENABLE KEYS */;

-- 테이블 dbbium.pp_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `pp_order` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `cart_seqno` int NOT NULL COMMENT '카드 seqno',
  `mem_seqno` int NOT NULL,
  `goods_seq` int NOT NULL COMMENT 'goods seqno',
  `goods_code` varchar(20) DEFAULT NULL,
  `goods_name` varchar(400) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `o_handphone` varchar(50) DEFAULT NULL,
  `o_email` varchar(70) DEFAULT NULL,
  `o_name` varchar(50) DEFAULT NULL,
  `o_zipcode` char(7) DEFAULT NULL,
  `o_address` varchar(200) DEFAULT NULL,
  `o_tel` varchar(20) DEFAULT NULL,
  `o_memo` text,
  `o_paypart` char(1) DEFAULT NULL,
  `o_bank` varchar(70) DEFAULT NULL,
  `order_num` varchar(20) DEFAULT NULL,
  `ea` varchar(10) DEFAULT NULL,
  `pay_ing` char(1) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `price` int DEFAULT NULL,
  `goods_price` int DEFAULT NULL COMMENT '당시 판매가',
  `box_option_price` int DEFAULT NULL COMMENT '박스옵션가격',
  `box_option_nm` varchar(100) DEFAULT NULL COMMENT '박스옵션 네임',
  `box_option_seqno` varchar(100) DEFAULT NULL COMMENT '박스옵션시퀀스',
  `order_ing` char(1) DEFAULT NULL,
  `r_name` varchar(50) DEFAULT NULL,
  `r_email` varchar(70) DEFAULT NULL,
  `r_handphone` varchar(50) DEFAULT NULL,
  `r_tel` varchar(50) DEFAULT NULL,
  `r_zipcode` char(7) DEFAULT NULL,
  `r_address` varchar(200) DEFAULT NULL,
  `deliveryno` varchar(50) DEFAULT NULL,
  `income_name` varchar(50) DEFAULT NULL,
  `deliverydate` varchar(50) DEFAULT NULL,
  `realprice` int DEFAULT NULL,
  `sale_price` int DEFAULT NULL,
  `sale_per` int DEFAULT NULL,
  `admin_memo` text,
  `realprice_memo` text,
  `handphone_call` varchar(50) DEFAULT NULL,
  `marry_date` varchar(100) DEFAULT NULL,
  `delivery_date` varchar(50) DEFAULT NULL,
  `r_class` varchar(50) DEFAULT NULL,
  `payment` varchar(50) DEFAULT NULL,
  `bank_name` varchar(50) DEFAULT NULL,
  `bank_no` varchar(50) DEFAULT NULL,
  `tak_sel` varchar(2) DEFAULT NULL,
  `d_type` varchar(50) DEFAULT NULL,
  `ship_type_from` varchar(50) DEFAULT NULL,
  `ship_type_to` varchar(50) DEFAULT NULL,
  `member_sale` int DEFAULT '0',
  `delivery_price` int DEFAULT NULL,
  `card_gu_no` varchar(50) DEFAULT NULL,
  `card_ju_no` varchar(50) DEFAULT NULL,
  `card_su_no` varchar(50) DEFAULT NULL,
  `card_nm` varchar(50) DEFAULT NULL COMMENT '결제카드사',
  `card_code` varchar(50) DEFAULT NULL COMMENT '결제카드사코드',
  `card_quota` varchar(50) DEFAULT NULL COMMENT '할부개월',
  `card_amt` varchar(50) DEFAULT NULL COMMENT '결제금액',
  `card_cancel_id` varchar(50) DEFAULT NULL COMMENT '카드취소ID',
  `card_cancel_date` datetime DEFAULT NULL,
  `admin_view` char(1) DEFAULT 'n',
  `admin_view_id` varchar(50) DEFAULT 'n',
  `cancel_ing` char(1) DEFAULT 'n',
  `c_email` varchar(100) DEFAULT NULL,
  `c_biz_no` varchar(50) DEFAULT NULL,
  `c_han_name` varchar(100) DEFAULT NULL,
  `order_name` varchar(100) DEFAULT NULL,
  `order_handphone` varchar(50) DEFAULT NULL,
  `o_memo2` text,
  `bill_part` char(1) DEFAULT NULL,
  `bill_name` varchar(50) DEFAULT NULL,
  `bill_handphone` varchar(30) DEFAULT NULL,
  `bill_email` varchar(150) DEFAULT NULL,
  `han_name` varchar(50) DEFAULT NULL,
  `cash_receipts` varchar(50) DEFAULT NULL,
  `talk_yn` varchar(1) DEFAULT 'n',
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.pp_order:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pp_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_order` ENABLE KEYS */;

-- 테이블 dbbium.pp_order_cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `pp_order_cart` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `mem_seqno` int NOT NULL,
  `goods_seq` int NOT NULL COMMENT 'goods seqno',
  `goods_code` varchar(20) DEFAULT NULL,
  `goods_name` varchar(400) DEFAULT NULL,
  `ea` varchar(10) DEFAULT NULL,
  `box_option_price` int DEFAULT NULL,
  `box_option_nm` varchar(100) DEFAULT NULL,
  `box_option_seqno` varchar(10) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.pp_order_cart:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pp_order_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_order_cart` ENABLE KEYS */;

-- 테이블 dbbium.pp_order_del 구조 내보내기
CREATE TABLE IF NOT EXISTS `pp_order_del` (
  `seqno` int NOT NULL,
  `cart_seqno` int NOT NULL COMMENT '카드 seqno',
  `mem_seqno` int NOT NULL,
  `goods_seq` int NOT NULL COMMENT 'goods seqno',
  `goods_code` varchar(20) DEFAULT NULL,
  `goods_name` varchar(400) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `o_handphone` varchar(50) DEFAULT NULL,
  `o_email` varchar(70) DEFAULT NULL,
  `o_name` varchar(50) DEFAULT NULL,
  `o_zipcode` char(7) DEFAULT NULL,
  `o_address` varchar(200) DEFAULT NULL,
  `o_tel` varchar(20) DEFAULT NULL,
  `o_memo` text,
  `o_paypart` char(1) DEFAULT NULL,
  `o_bank` varchar(70) DEFAULT NULL,
  `order_num` varchar(20) DEFAULT NULL,
  `ea` varchar(10) DEFAULT NULL,
  `pay_ing` char(1) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `price` int DEFAULT NULL,
  `goods_price` int DEFAULT NULL COMMENT '당시 판매가',
  `box_option_price` int DEFAULT NULL,
  `box_option_nm` varchar(50) DEFAULT NULL,
  `box_option_seqno` varchar(50) DEFAULT NULL,
  `order_ing` char(1) DEFAULT NULL,
  `r_name` varchar(50) DEFAULT NULL,
  `r_email` varchar(70) DEFAULT NULL,
  `r_handphone` varchar(50) DEFAULT NULL,
  `r_tel` varchar(50) DEFAULT NULL,
  `r_zipcode` char(7) DEFAULT NULL,
  `r_address` varchar(200) DEFAULT NULL,
  `deliveryno` varchar(50) DEFAULT NULL,
  `income_name` varchar(50) DEFAULT NULL,
  `deliverydate` varchar(50) DEFAULT NULL,
  `realprice` int DEFAULT NULL,
  `sale_price` int DEFAULT NULL,
  `sale_per` int DEFAULT NULL,
  `admin_memo` text,
  `realprice_memo` text,
  `handphone_call` varchar(50) DEFAULT NULL,
  `marry_date` varchar(100) DEFAULT NULL,
  `delivery_date` varchar(50) DEFAULT NULL,
  `r_class` varchar(50) DEFAULT NULL,
  `payment` varchar(50) DEFAULT NULL,
  `bank_name` varchar(50) DEFAULT NULL,
  `bank_no` varchar(50) DEFAULT NULL,
  `tak_sel` varchar(2) DEFAULT NULL,
  `d_type` varchar(50) DEFAULT NULL,
  `ship_type_from` varchar(50) DEFAULT NULL,
  `ship_type_to` varchar(50) DEFAULT NULL,
  `member_sale` int DEFAULT '0',
  `delivery_price` int DEFAULT NULL,
  `card_gu_no` varchar(50) DEFAULT NULL,
  `card_ju_no` varchar(50) DEFAULT NULL,
  `card_su_no` varchar(50) DEFAULT NULL,
  `card_nm` varchar(50) DEFAULT NULL COMMENT '결제카드사',
  `card_code` varchar(50) DEFAULT NULL COMMENT '결제카드사코드',
  `card_quota` varchar(50) DEFAULT NULL COMMENT '할부개월',
  `card_amt` varchar(50) DEFAULT NULL COMMENT '결제금액',
  `card_cancel_id` varchar(50) DEFAULT NULL COMMENT '카드취소ID',
  `card_cancel_date` datetime DEFAULT NULL,
  `admin_view` char(1) DEFAULT 'n',
  `admin_view_id` varchar(50) DEFAULT 'n',
  `cancel_ing` char(1) DEFAULT 'n',
  `c_email` varchar(100) DEFAULT NULL,
  `c_biz_no` varchar(50) DEFAULT NULL,
  `c_han_name` varchar(100) DEFAULT NULL,
  `order_name` varchar(100) DEFAULT NULL,
  `order_handphone` varchar(50) DEFAULT NULL,
  `o_memo2` text,
  `bill_part` char(1) DEFAULT NULL,
  `bill_name` varchar(50) DEFAULT NULL,
  `bill_handphone` varchar(30) DEFAULT NULL,
  `bill_email` varchar(150) DEFAULT NULL,
  `han_name` varchar(50) DEFAULT NULL,
  `cash_receipts` varchar(50) DEFAULT NULL,
  `talk_yn` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.pp_order_del:0 rows 내보내기
/*!40000 ALTER TABLE `pp_order_del` DISABLE KEYS */;
/*!40000 ALTER TABLE `pp_order_del` ENABLE KEYS */;

-- 테이블 dbbium.p_order 구조 내보내기
CREATE TABLE IF NOT EXISTS `p_order` (
  `seqno` int NOT NULL,
  `cart_seqno` int NOT NULL COMMENT '카트seqno 신',
  `id` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `mem_seqno` int DEFAULT NULL,
  `cash_bill` char(1) DEFAULT NULL,
  `payment` char(1) DEFAULT NULL,
  `order_ing` char(1) DEFAULT NULL,
  `delivery_no` varchar(50) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `han_name` varchar(100) DEFAULT NULL,
  `wp_seqno` int DEFAULT NULL COMMENT ' 환자시퀀스',
  `w_jindan` varchar(200) DEFAULT NULL,
  `w_name` varchar(100) DEFAULT NULL,
  `w_age` varchar(50) DEFAULT NULL,
  `w_birthyear` varchar(50) DEFAULT NULL,
  `w_etc01` varchar(50) DEFAULT NULL,
  `w_etc02` varchar(50) DEFAULT NULL,
  `w_contents` text,
  `s_name` varchar(200) DEFAULT NULL,
  `b_name` varchar(200) DEFAULT NULL,
  `c_chup_ea_price` varchar(50) DEFAULT NULL,
  `c_chup_ea` varchar(10) DEFAULT NULL,
  `c_chup_price` varchar(50) DEFAULT NULL,
  `c_chup_ea_g` varchar(50) DEFAULT NULL,
  `c_chup_ea_1` varchar(10) DEFAULT NULL,
  `c_chup_g` varchar(50) DEFAULT NULL,
  `c_pack_ml` varchar(50) DEFAULT NULL,
  `c_pack_ea` varchar(50) DEFAULT NULL,
  `c_more_tang` char(1) DEFAULT NULL,
  `c_more_ea` varchar(50) DEFAULT NULL,
  `c_box_type` char(1) DEFAULT NULL,
  `c_box_price` varchar(50) DEFAULT NULL,
  `c_box_text` varchar(100) DEFAULT NULL,
  `c_pouch_type` char(1) DEFAULT NULL,
  `c_pouch_text` varchar(100) DEFAULT NULL,
  `c_pouch_price` varchar(50) DEFAULT NULL,
  `c_joje_contents` text,
  `c_joje_file` varchar(100) DEFAULT NULL,
  `c_joje_folder` varchar(100) DEFAULT NULL,
  `c_bokyong_contents` text,
  `c_bokyong_file` varchar(100) DEFAULT NULL,
  `c_bokyong_folder` varchar(100) DEFAULT NULL,
  `d_type` char(1) DEFAULT NULL,
  `d_from_sel` char(1) DEFAULT NULL,
  `d_from_name` varchar(50) DEFAULT NULL,
  `d_from_zipcode` varchar(50) DEFAULT NULL,
  `d_from_address01` varchar(255) DEFAULT NULL,
  `d_from_address02` varchar(255) DEFAULT NULL,
  `d_from_handphone` varchar(50) DEFAULT NULL,
  `d_from_tel` varchar(50) DEFAULT NULL,
  `d_to_sel` char(1) DEFAULT NULL,
  `d_to_name` varchar(50) DEFAULT NULL,
  `d_to_wdate` varchar(50) DEFAULT NULL,
  `d_to_zipcode` varchar(50) DEFAULT NULL,
  `d_to_address01` varchar(255) DEFAULT NULL,
  `d_to_address02` varchar(255) DEFAULT NULL,
  `d_to_handphone` varchar(50) DEFAULT NULL,
  `d_to_tel` varchar(50) DEFAULT NULL,
  `d_to_contents` text,
  `order_yakjae_price` varchar(50) DEFAULT NULL,
  `order_tang_price` varchar(50) DEFAULT NULL,
  `order_package_price` varchar(50) DEFAULT NULL,
  `order_suju_price` varchar(50) DEFAULT NULL,
  `order_jeunglyu_price` varchar(50) DEFAULT NULL,
  `order_delivery_price` varchar(50) DEFAULT NULL,
  `order_delivery_price_check` char(1) DEFAULT NULL,
  `order_pojang_price` varchar(50) DEFAULT NULL,
  `order_total_price` int DEFAULT NULL,
  `order_sale_per` int DEFAULT NULL,
  `c_tang_type` char(1) DEFAULT NULL,
  `c_tang_check13` varchar(50) DEFAULT NULL,
  `cart_complete` char(1) DEFAULT NULL,
  `w_sex` char(1) DEFAULT NULL,
  `w_size` varchar(255) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `delivery_date` varchar(50) DEFAULT NULL,
  `cash_bill_yn` varchar(50) DEFAULT NULL,
  `realprice_memo` text,
  `area` varchar(50) DEFAULT NULL,
  `tak_sel` varchar(2) DEFAULT NULL,
  `member_sale` varchar(50) DEFAULT NULL,
  `view_yn` char(1) DEFAULT NULL,
  `bunch` varchar(50) DEFAULT NULL,
  `bunch_num` int DEFAULT NULL,
  `c_stpom_type` char(1) DEFAULT NULL,
  `c_stpom_text` varchar(100) DEFAULT NULL,
  `payment_kind` varchar(50) DEFAULT NULL,
  `card_gu_no` varchar(50) DEFAULT NULL,
  `card_ju_no` varchar(50) DEFAULT NULL,
  `card_su_no` varchar(50) DEFAULT NULL,
  `card_nm` varchar(50) DEFAULT NULL COMMENT '카드명',
  `card_code` varchar(50) DEFAULT NULL COMMENT '카드사코드',
  `card_quota` varchar(50) DEFAULT NULL COMMENT '할부정보',
  `card_amt` varchar(50) DEFAULT NULL COMMENT '카드결제금액',
  `card_cancel_id` varchar(50) DEFAULT NULL,
  `card_cancel_tid` varchar(50) DEFAULT NULL,
  `card_cancel_date` datetime DEFAULT NULL,
  `admin_view` char(1) DEFAULT NULL,
  `admin_view_id` varchar(50) DEFAULT NULL,
  `cancel_ing` char(1) DEFAULT NULL,
  `d_to_contents2` text,
  `bill_part` char(1) DEFAULT NULL,
  `bill_name` varchar(50) DEFAULT NULL,
  `bill_handphone` varchar(30) DEFAULT NULL,
  `bill_email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.p_order:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `p_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `p_order` ENABLE KEYS */;

-- 테이블 dbbium.p_order_cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `p_order_cart` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `id` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `mem_seqno` int DEFAULT NULL,
  `cash_bill` char(1) DEFAULT NULL,
  `payment` char(1) DEFAULT NULL,
  `order_ing` char(1) DEFAULT NULL,
  `delivery_no` varchar(50) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `han_name` varchar(100) DEFAULT NULL,
  `wp_seqno` int DEFAULT NULL,
  `w_jindan` varchar(200) DEFAULT NULL,
  `w_name` varchar(100) DEFAULT NULL,
  `w_age` varchar(50) DEFAULT NULL,
  `w_birthyear` varchar(50) DEFAULT NULL,
  `w_etc01` varchar(50) DEFAULT NULL,
  `w_etc02` varchar(50) DEFAULT NULL,
  `w_contents` text,
  `s_name` varchar(200) DEFAULT NULL,
  `b_name` varchar(200) DEFAULT NULL,
  `c_chup_ea_price` varchar(50) DEFAULT NULL,
  `c_chup_ea` varchar(10) DEFAULT NULL,
  `c_chup_price` varchar(50) DEFAULT NULL,
  `c_chup_ea_g` varchar(50) DEFAULT NULL,
  `c_chup_ea_1` varchar(10) DEFAULT NULL,
  `c_chup_g` varchar(50) DEFAULT NULL,
  `c_pack_ml` varchar(50) DEFAULT NULL,
  `c_pack_ea` varchar(50) DEFAULT NULL,
  `c_more_tang` char(1) DEFAULT NULL,
  `c_more_ea` varchar(50) DEFAULT NULL,
  `c_box_type` char(1) DEFAULT NULL,
  `c_box_price` varchar(50) DEFAULT NULL,
  `c_box_text` varchar(100) DEFAULT NULL,
  `c_pouch_type` char(1) DEFAULT NULL,
  `c_pouch_text` varchar(100) DEFAULT NULL,
  `c_pouch_price` varchar(50) DEFAULT NULL,
  `c_joje_contents` text,
  `c_joje_file` varchar(100) DEFAULT NULL,
  `c_joje_folder` varchar(100) DEFAULT NULL,
  `c_bokyong_contents` text,
  `c_bokyong_file` varchar(100) DEFAULT NULL,
  `c_bokyong_folder` varchar(100) DEFAULT NULL,
  `d_type` char(1) DEFAULT NULL,
  `d_from_sel` char(1) DEFAULT NULL,
  `d_from_name` varchar(50) DEFAULT NULL,
  `d_from_zipcode` varchar(50) DEFAULT NULL,
  `d_from_address01` varchar(255) DEFAULT NULL,
  `d_from_address02` varchar(255) DEFAULT NULL,
  `d_from_handphone` varchar(50) DEFAULT NULL,
  `d_from_tel` varchar(50) DEFAULT NULL,
  `d_to_sel` char(1) DEFAULT NULL,
  `d_to_name` varchar(50) DEFAULT NULL,
  `d_to_wdate` varchar(50) DEFAULT NULL,
  `d_to_zipcode` varchar(50) DEFAULT NULL,
  `d_to_address01` varchar(255) DEFAULT NULL,
  `d_to_address02` varchar(255) DEFAULT NULL,
  `d_to_handphone` varchar(50) DEFAULT NULL,
  `d_to_tel` varchar(50) DEFAULT NULL,
  `d_to_contents` text,
  `order_yakjae_price` varchar(50) DEFAULT NULL,
  `order_tang_price` varchar(50) DEFAULT NULL,
  `order_package_price` varchar(50) DEFAULT NULL,
  `order_suju_price` varchar(50) DEFAULT NULL,
  `order_jeunglyu_price` varchar(50) DEFAULT NULL,
  `order_delivery_price` varchar(50) DEFAULT NULL,
  `order_delivery_price_check` char(1) DEFAULT 'n',
  `order_pojang_price` varchar(50) DEFAULT NULL,
  `order_total_price` int DEFAULT NULL,
  `order_sale_per` int DEFAULT NULL,
  `c_tang_type` char(1) DEFAULT NULL,
  `c_tang_check12` varchar(50) DEFAULT NULL,
  `c_tang_check11` varchar(50) DEFAULT NULL,
  `c_tang_check10` varchar(50) DEFAULT NULL,
  `c_tang_check09` varchar(50) DEFAULT NULL,
  `c_tang_check08` varchar(50) DEFAULT NULL,
  `c_tang_check07` varchar(50) DEFAULT NULL,
  `c_tang_check06` varchar(50) DEFAULT NULL,
  `c_tang_check05` varchar(50) DEFAULT NULL,
  `c_tang_check04` varchar(50) DEFAULT NULL,
  `c_tang_check03` varchar(50) DEFAULT NULL,
  `c_tang_check02` varchar(50) DEFAULT NULL,
  `c_tang_check01` varchar(50) DEFAULT NULL,
  `c_tang_check13` varchar(50) DEFAULT NULL,
  `c_tang_check14` varchar(50) DEFAULT NULL,
  `cart_complete` char(1) DEFAULT 'n',
  `w_sex` char(1) DEFAULT NULL,
  `w_size` varchar(255) DEFAULT NULL,
  `order_date` varchar(70) DEFAULT NULL,
  `delivery_date` varchar(50) DEFAULT NULL,
  `cash_bill_yn` varchar(50) DEFAULT NULL,
  `realprice_memo` text,
  `area` varchar(50) DEFAULT NULL,
  `idx` int DEFAULT NULL,
  `tak_sel` char(1) DEFAULT NULL,
  `member_sale` varchar(50) DEFAULT NULL,
  `view_yn` char(1) DEFAULT 'n',
  `bunch` varchar(50) DEFAULT 'n',
  `c_stpom_type` char(1) DEFAULT NULL,
  `c_stpom_text` varchar(100) DEFAULT NULL,
  `payment_kind` varchar(50) DEFAULT NULL,
  `card_gu_no` varchar(50) DEFAULT NULL,
  `card_ju_no` varchar(50) DEFAULT NULL,
  `card_su_no` varchar(50) DEFAULT NULL,
  `admin_view` char(1) DEFAULT NULL,
  `admin_view_id` varchar(50) DEFAULT NULL,
  `cancel_ing` char(1) DEFAULT NULL,
  `d_to_contents2` text,
  `bill_part` char(1) DEFAULT NULL,
  `bill_name` varchar(50) DEFAULT NULL,
  `bill_handphone` varchar(30) DEFAULT NULL,
  `bill_email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`seqno`),
  KEY `인덱스 2` (`bunch`),
  KEY `인덱스 3` (`d_to_address01`,`d_to_address02`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- 테이블 데이터 dbbium.p_order_cart:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `p_order_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `p_order_cart` ENABLE KEYS */;

-- 테이블 dbbium.p_order_del 구조 내보내기
CREATE TABLE IF NOT EXISTS `p_order_del` (
  `seqno` int NOT NULL,
  `cart_seqno` int NOT NULL COMMENT '카트seqno 신',
  `id` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `mem_seqno` int DEFAULT NULL,
  `cash_bill` char(1) DEFAULT NULL,
  `payment` char(1) DEFAULT NULL,
  `order_ing` char(1) DEFAULT NULL,
  `delivery_no` varchar(50) DEFAULT NULL,
  `order_no` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `han_name` varchar(100) DEFAULT NULL,
  `wp_seqno` int DEFAULT NULL COMMENT ' 환자시퀀스',
  `w_jindan` varchar(200) DEFAULT NULL,
  `w_name` varchar(100) DEFAULT NULL,
  `w_age` varchar(50) DEFAULT NULL,
  `w_birthyear` varchar(50) DEFAULT NULL,
  `w_etc01` varchar(50) DEFAULT NULL,
  `w_etc02` varchar(50) DEFAULT NULL,
  `w_contents` text,
  `s_name` varchar(200) DEFAULT NULL,
  `b_name` varchar(200) DEFAULT NULL,
  `c_chup_ea_price` varchar(50) DEFAULT NULL,
  `c_chup_ea` varchar(10) DEFAULT NULL,
  `c_chup_price` varchar(50) DEFAULT NULL,
  `c_chup_ea_g` varchar(50) DEFAULT NULL,
  `c_chup_ea_1` varchar(10) DEFAULT NULL,
  `c_chup_g` varchar(50) DEFAULT NULL,
  `c_pack_ml` varchar(50) DEFAULT NULL,
  `c_pack_ea` varchar(50) DEFAULT NULL,
  `c_more_tang` char(1) DEFAULT NULL,
  `c_more_ea` varchar(50) DEFAULT NULL,
  `c_box_type` char(1) DEFAULT NULL,
  `c_box_price` varchar(50) DEFAULT NULL,
  `c_box_text` varchar(100) DEFAULT NULL,
  `c_pouch_type` char(1) DEFAULT NULL,
  `c_pouch_text` varchar(100) DEFAULT NULL,
  `c_pouch_price` varchar(50) DEFAULT NULL,
  `c_joje_contents` text,
  `c_joje_file` varchar(100) DEFAULT NULL,
  `c_joje_folder` varchar(100) DEFAULT NULL,
  `c_bokyong_contents` text,
  `c_bokyong_file` varchar(100) DEFAULT NULL,
  `c_bokyong_folder` varchar(100) DEFAULT NULL,
  `d_type` char(1) DEFAULT NULL,
  `d_from_sel` char(1) DEFAULT NULL,
  `d_from_name` varchar(50) DEFAULT NULL,
  `d_from_zipcode` varchar(50) DEFAULT NULL,
  `d_from_address01` varchar(255) DEFAULT NULL,
  `d_from_address02` varchar(255) DEFAULT NULL,
  `d_from_handphone` varchar(50) DEFAULT NULL,
  `d_from_tel` varchar(50) DEFAULT NULL,
  `d_to_sel` char(1) DEFAULT NULL,
  `d_to_name` varchar(50) DEFAULT NULL,
  `d_to_wdate` varchar(50) DEFAULT NULL,
  `d_to_zipcode` varchar(50) DEFAULT NULL,
  `d_to_address01` varchar(255) DEFAULT NULL,
  `d_to_address02` varchar(255) DEFAULT NULL,
  `d_to_handphone` varchar(50) DEFAULT NULL,
  `d_to_tel` varchar(50) DEFAULT NULL,
  `d_to_contents` text,
  `order_yakjae_price` varchar(50) DEFAULT NULL,
  `order_tang_price` varchar(50) DEFAULT NULL,
  `order_package_price` varchar(50) DEFAULT NULL,
  `order_suju_price` varchar(50) DEFAULT NULL,
  `order_jeunglyu_price` varchar(50) DEFAULT NULL,
  `order_delivery_price` varchar(50) DEFAULT NULL,
  `order_delivery_price_check` char(1) DEFAULT NULL,
  `order_pojang_price` varchar(50) DEFAULT NULL,
  `order_total_price` int DEFAULT NULL,
  `c_tang_type` char(1) DEFAULT NULL,
  `c_tang_check13` varchar(50) DEFAULT NULL,
  `cart_complete` char(1) DEFAULT NULL,
  `w_sex` char(1) DEFAULT NULL,
  `w_size` varchar(255) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `delivery_date` varchar(50) DEFAULT NULL,
  `cash_bill_yn` varchar(50) DEFAULT NULL,
  `realprice_memo` text,
  `area` varchar(50) DEFAULT NULL,
  `tak_sel` varchar(2) DEFAULT NULL,
  `member_sale` varchar(50) DEFAULT NULL,
  `view_yn` char(1) DEFAULT NULL,
  `bunch` varchar(50) DEFAULT NULL,
  `bunch_num` int DEFAULT NULL,
  `c_stpom_type` char(1) DEFAULT NULL,
  `c_stpom_text` varchar(100) DEFAULT NULL,
  `payment_kind` varchar(50) DEFAULT NULL,
  `card_gu_no` varchar(50) DEFAULT NULL,
  `card_ju_no` varchar(50) DEFAULT NULL,
  `card_su_no` varchar(50) DEFAULT NULL,
  `card_nm` varchar(50) DEFAULT NULL COMMENT '카드명',
  `card_code` varchar(50) DEFAULT NULL COMMENT '카드사코드',
  `card_quota` varchar(50) DEFAULT NULL COMMENT '할부정보',
  `card_amt` varchar(50) DEFAULT NULL COMMENT '카드결제금액',
  `card_cancel_id` varchar(50) DEFAULT NULL,
  `card_cancel_tid` varchar(50) DEFAULT NULL,
  `card_cancel_date` datetime DEFAULT NULL,
  `admin_view` char(1) DEFAULT NULL,
  `admin_view_id` varchar(50) DEFAULT NULL,
  `cancel_ing` char(1) DEFAULT NULL,
  `d_to_contents2` text,
  `bill_part` char(1) DEFAULT NULL,
  `bill_name` varchar(50) DEFAULT NULL,
  `bill_handphone` varchar(30) DEFAULT NULL,
  `bill_email` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.p_order_del:0 rows 내보내기
/*!40000 ALTER TABLE `p_order_del` DISABLE KEYS */;
/*!40000 ALTER TABLE `p_order_del` ENABLE KEYS */;

-- 테이블 dbbium.p_order_yakjae 구조 내보내기
CREATE TABLE IF NOT EXISTS `p_order_yakjae` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `p_seqno` int DEFAULT NULL,
  `mem_seqno` int DEFAULT NULL COMMENT '신규 멤버 seqno',
  `p_standard` float DEFAULT NULL,
  `p_joje` float DEFAULT NULL,
  `yak_code` varchar(50) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  `wdate` date DEFAULT NULL,
  `ea` varchar(50) DEFAULT NULL,
  `total_yakjae` float DEFAULT NULL,
  `yak_price` varchar(50) DEFAULT NULL,
  `p_danga` varchar(50) DEFAULT NULL,
  `p_from` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seqno`),
  KEY `yak_code` (`yak_code`,`wdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.p_order_yakjae:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `p_order_yakjae` DISABLE KEYS */;
/*!40000 ALTER TABLE `p_order_yakjae` ENABLE KEYS */;

-- 테이블 dbbium.p_order_yakjae_cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `p_order_yakjae_cart` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `p_seqno` int DEFAULT NULL COMMENT 'p_order seqno',
  `mem_seqno` int DEFAULT NULL COMMENT '주문자seqno',
  `p_standard` float DEFAULT NULL COMMENT 'x',
  `p_joje` float DEFAULT NULL COMMENT '조제량',
  `yak_code` varchar(50) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  `wdate` char(10) DEFAULT NULL,
  `ea` varchar(50) DEFAULT NULL COMMENT 'x',
  `total_yakjae` float DEFAULT NULL COMMENT '1첩당 약재가격',
  `yak_price` varchar(50) DEFAULT NULL COMMENT '1g단가',
  `p_danga` varchar(50) DEFAULT NULL COMMENT '조제 곱 약재단가',
  `p_from` varchar(50) DEFAULT NULL COMMENT '당시 원산지',
  `order_yn` char(1) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- 테이블 데이터 dbbium.p_order_yakjae_cart:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `p_order_yakjae_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `p_order_yakjae_cart` ENABLE KEYS */;

-- 테이블 dbbium.qna 구조 내보내기
CREATE TABLE IF NOT EXISTS `qna` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `han_name` varchar(50) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `upfile` varchar(255) DEFAULT NULL,
  `wdate` varchar(70) DEFAULT NULL,
  `id` varchar(100) DEFAULT NULL,
  `contents` text,
  `recontents` text,
  `mail_check` char(1) DEFAULT NULL,
  `admin_view` char(1) DEFAULT NULL,
  `admin_view_id` varchar(50) DEFAULT NULL,
  `sms_check` char(1) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.qna:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;

-- 테이블 dbbium.shop_group 구조 내보내기
CREATE TABLE IF NOT EXISTS `shop_group` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) DEFAULT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `use_yn` char(1) DEFAULT NULL,
  `del_yn` char(1) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `memo` text,
  `sort_seq` int DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.shop_group:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `shop_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_group` ENABLE KEYS */;

-- 테이블 dbbium.shop_subgroup 구조 내보내기
CREATE TABLE IF NOT EXISTS `shop_subgroup` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) DEFAULT NULL,
  `use_yn` char(1) DEFAULT NULL,
  `del_yn` char(1) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `memo` text,
  `sort_seq` int DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.shop_subgroup:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `shop_subgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_subgroup` ENABLE KEYS */;

-- 테이블 dbbium.sty_table 구조 내보내기
CREATE TABLE IF NOT EXISTS `sty_table` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `sty_name` varchar(50) DEFAULT NULL,
  `sty_size` varchar(50) DEFAULT NULL,
  `contents` longtext,
  `image1` varchar(50) DEFAULT NULL,
  `image2` varchar(50) DEFAULT NULL,
  `image3` varchar(50) DEFAULT NULL,
  `price` int DEFAULT '0',
  `status` char(1) DEFAULT NULL,
  `del_yn` char(1) DEFAULT 'n',
  `wdate` datetime DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='스티로폼';

-- 테이블 데이터 dbbium.sty_table:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `sty_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `sty_table` ENABLE KEYS */;

-- 테이블 dbbium.s_dictionary 구조 내보내기
CREATE TABLE IF NOT EXISTS `s_dictionary` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `s_code` varchar(50) DEFAULT NULL,
  `b_code` varchar(50) DEFAULT NULL,
  `b_name` varchar(100) DEFAULT NULL,
  `s_name` varchar(100) DEFAULT NULL,
  `s_jomun` text,
  `s_jukeung` text,
  `s_chamgo` text,
  `wdate` datetime DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.s_dictionary:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `s_dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `s_dictionary` ENABLE KEYS */;

-- 뷰 dbbium.view_pp_order_cart 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `view_pp_order_cart` (
	`seqno` INT NOT NULL,
	`mem_seqno` INT NOT NULL,
	`goods_seq` INT NOT NULL COMMENT 'goods seqno',
	`goods_code` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`goods_name` VARCHAR(400) NULL COLLATE 'utf8_general_ci',
	`ea` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`box_option_price` INT NULL,
	`box_option_nm` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`box_option_seqno` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`order_date` DATETIME NULL
) ENGINE=MyISAM;

-- 뷰 dbbium.view_p_order 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `view_p_order` (
	`seqno` INT NOT NULL,
	`cart_seqno` INT NOT NULL COMMENT '카트seqno 신',
	`id` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`wdate` DATETIME NULL,
	`mem_seqno` INT NULL,
	`cash_bill` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`payment` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`order_ing` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`delivery_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`han_name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`wp_seqno` INT NULL COMMENT ' 환자시퀀스',
	`w_jindan` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`w_name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`w_age` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_birthyear` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_etc01` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_etc02` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`s_name` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`b_name` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`c_chup_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea_g` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea_1` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`c_chup_g` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_pack_ml` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_pack_ea` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_more_tang` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_more_ea` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_box_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_box_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_box_text` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_pouch_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_pouch_text` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_pouch_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_joje_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`c_joje_file` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_joje_folder` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_bokyong_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`c_bokyong_file` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_bokyong_folder` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`d_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_from_sel` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_from_name` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_from_zipcode` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_from_address01` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_from_address02` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_from_handphone` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_from_tel` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_sel` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_to_name` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_wdate` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_zipcode` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_address01` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_to_address02` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_to_handphone` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_tel` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`order_yakjae_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_tang_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_package_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_suju_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_jeunglyu_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_delivery_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_delivery_price_check` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`order_pojang_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_total_price` INT NULL,
	`order_sale_per` INT NULL,
	`c_tang_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_tang_check13` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cart_complete` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`w_sex` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`w_size` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`order_date` DATETIME NULL,
	`delivery_date` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cash_bill_yn` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`realprice_memo` TEXT NULL COLLATE 'utf8_general_ci',
	`area` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`tak_sel` VARCHAR(2) NULL COLLATE 'utf8_general_ci',
	`member_sale` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`view_yn` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`bunch` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`bunch_num` INT NULL,
	`c_stpom_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_stpom_text` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`payment_kind` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_gu_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_ju_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_su_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_nm` VARCHAR(50) NULL COMMENT '카드명' COLLATE 'utf8_general_ci',
	`card_code` VARCHAR(50) NULL COMMENT '카드사코드' COLLATE 'utf8_general_ci',
	`card_quota` VARCHAR(50) NULL COMMENT '할부정보' COLLATE 'utf8_general_ci',
	`card_amt` VARCHAR(50) NULL COMMENT '카드결제금액' COLLATE 'utf8_general_ci',
	`card_cancel_id` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_cancel_tid` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_cancel_date` DATETIME NULL,
	`admin_view` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`admin_view_id` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cancel_ing` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_to_contents2` TEXT NULL COLLATE 'utf8_general_ci',
	`bill_part` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`bill_name` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`bill_handphone` VARCHAR(30) NULL COLLATE 'utf8_general_ci',
	`bill_email` VARCHAR(150) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- 뷰 dbbium.view_p_order_cart 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `view_p_order_cart` (
	`seqno` INT NOT NULL,
	`id` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`wdate` DATETIME NULL,
	`mem_seqno` INT NULL,
	`cash_bill` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`payment` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`order_ing` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`delivery_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`han_name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`wp_seqno` INT NULL,
	`w_jindan` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`w_name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`w_age` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_birthyear` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_etc01` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_etc02` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`w_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`s_name` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`b_name` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`c_chup_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea_g` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_chup_ea_1` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`c_chup_g` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_pack_ml` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_pack_ea` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_more_tang` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_more_ea` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_box_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_box_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_box_text` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_pouch_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_pouch_text` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_pouch_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_joje_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`c_joje_file` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`c_bokyong_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`c_bokyong_file` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`d_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_from_sel` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_from_name` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_from_zipcode` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_from_address01` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_from_address02` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_from_handphone` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_from_tel` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_sel` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_to_name` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_wdate` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_zipcode` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_address01` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_to_address02` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`d_to_handphone` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_tel` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`d_to_contents` TEXT NULL COLLATE 'utf8_general_ci',
	`order_yakjae_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_tang_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_package_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_suju_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_jeunglyu_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_delivery_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_delivery_price_check` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`order_pojang_price` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`order_total_price` INT NULL,
	`c_tang_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_tang_check12` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check11` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check10` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check09` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check08` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check07` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check06` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check05` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check04` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check03` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check02` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check01` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check13` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_tang_check14` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cart_complete` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`w_sex` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`w_size` VARCHAR(255) NULL COLLATE 'utf8_general_ci',
	`order_date` VARCHAR(70) NULL COLLATE 'utf8_general_ci',
	`delivery_date` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cash_bill_yn` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`realprice_memo` TEXT NULL COLLATE 'utf8_general_ci',
	`area` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`idx` INT NULL,
	`tak_sel` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`member_sale` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`view_yn` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`bunch` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`c_stpom_type` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`c_stpom_text` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`payment_kind` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_gu_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_ju_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`card_su_no` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`admin_view` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`admin_view_id` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`cancel_ing` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`d_to_contents2` TEXT NULL COLLATE 'utf8_general_ci',
	`bill_part` CHAR(1) NULL COLLATE 'utf8_general_ci',
	`bill_name` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`bill_handphone` VARCHAR(30) NULL COLLATE 'utf8_general_ci',
	`bill_email` VARCHAR(150) NULL COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;

-- 뷰 dbbium.view_shop_sum 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `view_shop_sum` (
	`m_oder_num` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`tot_cnt` BIGINT NOT NULL,
	`tot_price` DECIMAL(32,0) NULL,
	`tot_seqno` INT NULL
) ENGINE=MyISAM;

-- 뷰 dbbium.view_shop_sum2 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `view_shop_sum2` (
	`m_oder_num` VARCHAR(20) NULL COLLATE 'utf8_general_ci',
	`tot_cnt` BIGINT NOT NULL,
	`tot_price` DECIMAL(32,0) NULL,
	`tot_seqno` INT NULL,
	`tot_sale_price` DECIMAL(32,0) NULL,
	`tot_realprice` DECIMAL(32,0) NULL
) ENGINE=MyISAM;

-- 뷰 dbbium.view_tot_yak 구조 내보내기
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `view_tot_yak` (
	`group_name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`group_code` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`yak_name` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`yak_from` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`yak_danga` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`yak_code` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`seqno` INT NOT NULL
) ENGINE=MyISAM;

-- 테이블 dbbium.yakcho 구조 내보내기
CREATE TABLE IF NOT EXISTS `yakcho` (
  `seqno` int NOT NULL,
  `wdate` varchar(50) DEFAULT NULL,
  `hits` int DEFAULT NULL,
  `contents` text,
  `name` varchar(50) DEFAULT NULL,
  `upfile` varchar(100) DEFAULT NULL,
  `main_check` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yakcho:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `yakcho` DISABLE KEYS */;
/*!40000 ALTER TABLE `yakcho` ENABLE KEYS */;

-- 테이블 dbbium.yakjae 구조 내보내기
CREATE TABLE IF NOT EXISTS `yakjae` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `yak_code` varchar(50) DEFAULT NULL,
  `yak_name` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `group_name` varchar(50) DEFAULT NULL,
  `yak_from` varchar(50) DEFAULT NULL,
  `yak_made` varchar(50) DEFAULT NULL,
  `yak_price` varchar(50) DEFAULT NULL,
  `yak_unit` varchar(50) DEFAULT NULL,
  `yak_danga` varchar(50) DEFAULT NULL,
  `yak_image` varchar(100) DEFAULT NULL,
  `yak_contents` text,
  `yak_status` varchar(50) DEFAULT NULL,
  `yak_place` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seqno`),
  KEY `yak_code` (`yak_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yakjae:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `yakjae` DISABLE KEYS */;
/*!40000 ALTER TABLE `yakjae` ENABLE KEYS */;

-- 테이블 dbbium.yakjae_del 구조 내보내기
CREATE TABLE IF NOT EXISTS `yakjae_del` (
  `seqno` int NOT NULL,
  `yak_code` varchar(50) DEFAULT NULL,
  `yak_name` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  `group_code` varchar(50) DEFAULT NULL,
  `group_name` varchar(50) DEFAULT NULL,
  `yak_from` varchar(50) DEFAULT NULL,
  `yak_made` varchar(50) DEFAULT NULL,
  `yak_price` varchar(50) DEFAULT NULL,
  `yak_unit` varchar(50) DEFAULT NULL,
  `yak_danga` varchar(50) DEFAULT NULL,
  `yak_image` varchar(100) DEFAULT NULL,
  `yak_contents` text,
  `yak_status` varchar(50) DEFAULT NULL,
  `yak_place` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`seqno`),
  KEY `yak_code` (`yak_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yakjae_del:0 rows 내보내기
/*!40000 ALTER TABLE `yakjae_del` DISABLE KEYS */;
/*!40000 ALTER TABLE `yakjae_del` ENABLE KEYS */;

-- 테이블 dbbium.yakjae_his 구조 내보내기
CREATE TABLE IF NOT EXISTS `yakjae_his` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `yak_seqno` int NOT NULL COMMENT '약재 시퀀스',
  `yak_code` varchar(50) NOT NULL COMMENT '그룹코드',
  `add_date` date DEFAULT NULL COMMENT '입고일',
  `ea` int DEFAULT NULL COMMENT '입고수량',
  `a_id` varchar(50) DEFAULT NULL COMMENT '등록자',
  `wdate` datetime DEFAULT NULL COMMENT '등록일',
  `u_id` varchar(50) DEFAULT NULL COMMENT '수정',
  `u_date` varchar(50) DEFAULT NULL COMMENT '수정일',
  PRIMARY KEY (`seqno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yakjae_his:0 rows 내보내기
/*!40000 ALTER TABLE `yakjae_his` DISABLE KEYS */;
/*!40000 ALTER TABLE `yakjae_his` ENABLE KEYS */;

-- 테이블 dbbium.yakjae_setup 구조 내보내기
CREATE TABLE IF NOT EXISTS `yakjae_setup` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `wdate` varchar(50) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `complete` char(1) DEFAULT NULL,
  `yak_code` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yakjae_setup:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `yakjae_setup` DISABLE KEYS */;
/*!40000 ALTER TABLE `yakjae_setup` ENABLE KEYS */;

-- 테이블 dbbium.yak_group 구조 내보내기
CREATE TABLE IF NOT EXISTS `yak_group` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `group_code` varchar(50) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yak_group:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `yak_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `yak_group` ENABLE KEYS */;

-- 테이블 dbbium.yak_group_del 구조 내보내기
CREATE TABLE IF NOT EXISTS `yak_group_del` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `group_code` varchar(50) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `wdate` datetime DEFAULT NULL,
  PRIMARY KEY (`seqno`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yak_group_del:0 rows 내보내기
/*!40000 ALTER TABLE `yak_group_del` DISABLE KEYS */;
/*!40000 ALTER TABLE `yak_group_del` ENABLE KEYS */;

-- 테이블 dbbium.yak_ip 구조 내보내기
CREATE TABLE IF NOT EXISTS `yak_ip` (
  `seqno` int NOT NULL AUTO_INCREMENT,
  `wdate` varchar(50) DEFAULT NULL,
  `ip_wdate` varchar(50) DEFAULT NULL,
  `yak_name` varchar(100) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `ea` varchar(50) DEFAULT NULL,
  `danga` varchar(50) DEFAULT NULL,
  `from_company` varchar(50) DEFAULT NULL,
  `contents` text,
  PRIMARY KEY (`seqno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 dbbium.yak_ip:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `yak_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `yak_ip` ENABLE KEYS */;

-- 뷰 dbbium.view_pp_order_cart 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `view_pp_order_cart`;
CREATE ALGORITHM=UNDEFINED DEFINER=`bium`@`%` SQL SECURITY DEFINER VIEW `view_pp_order_cart` AS select `pp_order_cart`.`seqno` AS `seqno`,`pp_order_cart`.`mem_seqno` AS `mem_seqno`,`pp_order_cart`.`goods_seq` AS `goods_seq`,`pp_order_cart`.`goods_code` AS `goods_code`,`pp_order_cart`.`goods_name` AS `goods_name`,`pp_order_cart`.`ea` AS `ea`,`pp_order_cart`.`box_option_price` AS `box_option_price`,`pp_order_cart`.`box_option_nm` AS `box_option_nm`,`pp_order_cart`.`box_option_seqno` AS `box_option_seqno`,`pp_order_cart`.`order_date` AS `order_date` from `pp_order_cart` where ((`pp_order_cart`.`order_date` >= (now() - interval 1 day)) and `pp_order_cart`.`seqno` in (select `pp_order`.`cart_seqno` from `pp_order` where (`pp_order`.`order_date` >= (now() - interval 2 day))) is false);

-- 뷰 dbbium.view_p_order 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `view_p_order`;
CREATE ALGORITHM=UNDEFINED DEFINER=`bium`@`%` SQL SECURITY DEFINER VIEW `view_p_order` AS select `p_order`.`seqno` AS `seqno`,`p_order`.`cart_seqno` AS `cart_seqno`,`p_order`.`id` AS `id`,`p_order`.`wdate` AS `wdate`,`p_order`.`mem_seqno` AS `mem_seqno`,`p_order`.`cash_bill` AS `cash_bill`,`p_order`.`payment` AS `payment`,`p_order`.`order_ing` AS `order_ing`,`p_order`.`delivery_no` AS `delivery_no`,`p_order`.`order_no` AS `order_no`,`p_order`.`name` AS `name`,`p_order`.`han_name` AS `han_name`,`p_order`.`wp_seqno` AS `wp_seqno`,`p_order`.`w_jindan` AS `w_jindan`,`p_order`.`w_name` AS `w_name`,`p_order`.`w_age` AS `w_age`,`p_order`.`w_birthyear` AS `w_birthyear`,`p_order`.`w_etc01` AS `w_etc01`,`p_order`.`w_etc02` AS `w_etc02`,`p_order`.`w_contents` AS `w_contents`,`p_order`.`s_name` AS `s_name`,`p_order`.`b_name` AS `b_name`,`p_order`.`c_chup_ea_price` AS `c_chup_ea_price`,`p_order`.`c_chup_ea` AS `c_chup_ea`,`p_order`.`c_chup_price` AS `c_chup_price`,`p_order`.`c_chup_ea_g` AS `c_chup_ea_g`,`p_order`.`c_chup_ea_1` AS `c_chup_ea_1`,`p_order`.`c_chup_g` AS `c_chup_g`,`p_order`.`c_pack_ml` AS `c_pack_ml`,`p_order`.`c_pack_ea` AS `c_pack_ea`,`p_order`.`c_more_tang` AS `c_more_tang`,`p_order`.`c_more_ea` AS `c_more_ea`,`p_order`.`c_box_type` AS `c_box_type`,`p_order`.`c_box_price` AS `c_box_price`,`p_order`.`c_box_text` AS `c_box_text`,`p_order`.`c_pouch_type` AS `c_pouch_type`,`p_order`.`c_pouch_text` AS `c_pouch_text`,`p_order`.`c_pouch_price` AS `c_pouch_price`,`p_order`.`c_joje_contents` AS `c_joje_contents`,`p_order`.`c_joje_file` AS `c_joje_file`,`p_order`.`c_joje_folder` AS `c_joje_folder`,`p_order`.`c_bokyong_contents` AS `c_bokyong_contents`,`p_order`.`c_bokyong_file` AS `c_bokyong_file`,`p_order`.`c_bokyong_folder` AS `c_bokyong_folder`,`p_order`.`d_type` AS `d_type`,`p_order`.`d_from_sel` AS `d_from_sel`,`p_order`.`d_from_name` AS `d_from_name`,`p_order`.`d_from_zipcode` AS `d_from_zipcode`,`p_order`.`d_from_address01` AS `d_from_address01`,`p_order`.`d_from_address02` AS `d_from_address02`,`p_order`.`d_from_handphone` AS `d_from_handphone`,`p_order`.`d_from_tel` AS `d_from_tel`,`p_order`.`d_to_sel` AS `d_to_sel`,`p_order`.`d_to_name` AS `d_to_name`,`p_order`.`d_to_wdate` AS `d_to_wdate`,`p_order`.`d_to_zipcode` AS `d_to_zipcode`,`p_order`.`d_to_address01` AS `d_to_address01`,`p_order`.`d_to_address02` AS `d_to_address02`,`p_order`.`d_to_handphone` AS `d_to_handphone`,`p_order`.`d_to_tel` AS `d_to_tel`,`p_order`.`d_to_contents` AS `d_to_contents`,`p_order`.`order_yakjae_price` AS `order_yakjae_price`,`p_order`.`order_tang_price` AS `order_tang_price`,`p_order`.`order_package_price` AS `order_package_price`,`p_order`.`order_suju_price` AS `order_suju_price`,`p_order`.`order_jeunglyu_price` AS `order_jeunglyu_price`,`p_order`.`order_delivery_price` AS `order_delivery_price`,`p_order`.`order_delivery_price_check` AS `order_delivery_price_check`,`p_order`.`order_pojang_price` AS `order_pojang_price`,`p_order`.`order_total_price` AS `order_total_price`,`p_order`.`order_sale_per` AS `order_sale_per`,`p_order`.`c_tang_type` AS `c_tang_type`,`p_order`.`c_tang_check13` AS `c_tang_check13`,`p_order`.`cart_complete` AS `cart_complete`,`p_order`.`w_sex` AS `w_sex`,`p_order`.`w_size` AS `w_size`,`p_order`.`order_date` AS `order_date`,`p_order`.`delivery_date` AS `delivery_date`,`p_order`.`cash_bill_yn` AS `cash_bill_yn`,`p_order`.`realprice_memo` AS `realprice_memo`,`p_order`.`area` AS `area`,`p_order`.`tak_sel` AS `tak_sel`,`p_order`.`member_sale` AS `member_sale`,`p_order`.`view_yn` AS `view_yn`,`p_order`.`bunch` AS `bunch`,`p_order`.`bunch_num` AS `bunch_num`,`p_order`.`c_stpom_type` AS `c_stpom_type`,`p_order`.`c_stpom_text` AS `c_stpom_text`,`p_order`.`payment_kind` AS `payment_kind`,`p_order`.`card_gu_no` AS `card_gu_no`,`p_order`.`card_ju_no` AS `card_ju_no`,`p_order`.`card_su_no` AS `card_su_no`,`p_order`.`card_nm` AS `card_nm`,`p_order`.`card_code` AS `card_code`,`p_order`.`card_quota` AS `card_quota`,`p_order`.`card_amt` AS `card_amt`,`p_order`.`card_cancel_id` AS `card_cancel_id`,`p_order`.`card_cancel_tid` AS `card_cancel_tid`,`p_order`.`card_cancel_date` AS `card_cancel_date`,`p_order`.`admin_view` AS `admin_view`,`p_order`.`admin_view_id` AS `admin_view_id`,`p_order`.`cancel_ing` AS `cancel_ing`,`p_order`.`d_to_contents2` AS `d_to_contents2`,`p_order`.`bill_part` AS `bill_part`,`p_order`.`bill_name` AS `bill_name`,`p_order`.`bill_handphone` AS `bill_handphone`,`p_order`.`bill_email` AS `bill_email` from `p_order` where (`p_order`.`order_date` >= (now() - interval 3 month));

-- 뷰 dbbium.view_p_order_cart 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `view_p_order_cart`;
CREATE ALGORITHM=UNDEFINED DEFINER=`bium`@`%` SQL SECURITY DEFINER VIEW `view_p_order_cart` AS select `p_order_cart`.`seqno` AS `seqno`,`p_order_cart`.`id` AS `id`,`p_order_cart`.`wdate` AS `wdate`,`p_order_cart`.`mem_seqno` AS `mem_seqno`,`p_order_cart`.`cash_bill` AS `cash_bill`,`p_order_cart`.`payment` AS `payment`,`p_order_cart`.`order_ing` AS `order_ing`,`p_order_cart`.`delivery_no` AS `delivery_no`,`p_order_cart`.`order_no` AS `order_no`,`p_order_cart`.`name` AS `name`,`p_order_cart`.`han_name` AS `han_name`,`p_order_cart`.`wp_seqno` AS `wp_seqno`,`p_order_cart`.`w_jindan` AS `w_jindan`,`p_order_cart`.`w_name` AS `w_name`,`p_order_cart`.`w_age` AS `w_age`,`p_order_cart`.`w_birthyear` AS `w_birthyear`,`p_order_cart`.`w_etc01` AS `w_etc01`,`p_order_cart`.`w_etc02` AS `w_etc02`,`p_order_cart`.`w_contents` AS `w_contents`,`p_order_cart`.`s_name` AS `s_name`,`p_order_cart`.`b_name` AS `b_name`,`p_order_cart`.`c_chup_ea_price` AS `c_chup_ea_price`,`p_order_cart`.`c_chup_ea` AS `c_chup_ea`,`p_order_cart`.`c_chup_price` AS `c_chup_price`,`p_order_cart`.`c_chup_ea_g` AS `c_chup_ea_g`,`p_order_cart`.`c_chup_ea_1` AS `c_chup_ea_1`,`p_order_cart`.`c_chup_g` AS `c_chup_g`,`p_order_cart`.`c_pack_ml` AS `c_pack_ml`,`p_order_cart`.`c_pack_ea` AS `c_pack_ea`,`p_order_cart`.`c_more_tang` AS `c_more_tang`,`p_order_cart`.`c_more_ea` AS `c_more_ea`,`p_order_cart`.`c_box_type` AS `c_box_type`,`p_order_cart`.`c_box_price` AS `c_box_price`,`p_order_cart`.`c_box_text` AS `c_box_text`,`p_order_cart`.`c_pouch_type` AS `c_pouch_type`,`p_order_cart`.`c_pouch_text` AS `c_pouch_text`,`p_order_cart`.`c_pouch_price` AS `c_pouch_price`,`p_order_cart`.`c_joje_contents` AS `c_joje_contents`,`p_order_cart`.`c_joje_file` AS `c_joje_file`,`p_order_cart`.`c_bokyong_contents` AS `c_bokyong_contents`,`p_order_cart`.`c_bokyong_file` AS `c_bokyong_file`,`p_order_cart`.`d_type` AS `d_type`,`p_order_cart`.`d_from_sel` AS `d_from_sel`,`p_order_cart`.`d_from_name` AS `d_from_name`,`p_order_cart`.`d_from_zipcode` AS `d_from_zipcode`,`p_order_cart`.`d_from_address01` AS `d_from_address01`,`p_order_cart`.`d_from_address02` AS `d_from_address02`,`p_order_cart`.`d_from_handphone` AS `d_from_handphone`,`p_order_cart`.`d_from_tel` AS `d_from_tel`,`p_order_cart`.`d_to_sel` AS `d_to_sel`,`p_order_cart`.`d_to_name` AS `d_to_name`,`p_order_cart`.`d_to_wdate` AS `d_to_wdate`,`p_order_cart`.`d_to_zipcode` AS `d_to_zipcode`,`p_order_cart`.`d_to_address01` AS `d_to_address01`,`p_order_cart`.`d_to_address02` AS `d_to_address02`,`p_order_cart`.`d_to_handphone` AS `d_to_handphone`,`p_order_cart`.`d_to_tel` AS `d_to_tel`,`p_order_cart`.`d_to_contents` AS `d_to_contents`,`p_order_cart`.`order_yakjae_price` AS `order_yakjae_price`,`p_order_cart`.`order_tang_price` AS `order_tang_price`,`p_order_cart`.`order_package_price` AS `order_package_price`,`p_order_cart`.`order_suju_price` AS `order_suju_price`,`p_order_cart`.`order_jeunglyu_price` AS `order_jeunglyu_price`,`p_order_cart`.`order_delivery_price` AS `order_delivery_price`,`p_order_cart`.`order_delivery_price_check` AS `order_delivery_price_check`,`p_order_cart`.`order_pojang_price` AS `order_pojang_price`,`p_order_cart`.`order_total_price` AS `order_total_price`,`p_order_cart`.`c_tang_type` AS `c_tang_type`,`p_order_cart`.`c_tang_check12` AS `c_tang_check12`,`p_order_cart`.`c_tang_check11` AS `c_tang_check11`,`p_order_cart`.`c_tang_check10` AS `c_tang_check10`,`p_order_cart`.`c_tang_check09` AS `c_tang_check09`,`p_order_cart`.`c_tang_check08` AS `c_tang_check08`,`p_order_cart`.`c_tang_check07` AS `c_tang_check07`,`p_order_cart`.`c_tang_check06` AS `c_tang_check06`,`p_order_cart`.`c_tang_check05` AS `c_tang_check05`,`p_order_cart`.`c_tang_check04` AS `c_tang_check04`,`p_order_cart`.`c_tang_check03` AS `c_tang_check03`,`p_order_cart`.`c_tang_check02` AS `c_tang_check02`,`p_order_cart`.`c_tang_check01` AS `c_tang_check01`,`p_order_cart`.`c_tang_check13` AS `c_tang_check13`,`p_order_cart`.`c_tang_check14` AS `c_tang_check14`,`p_order_cart`.`cart_complete` AS `cart_complete`,`p_order_cart`.`w_sex` AS `w_sex`,`p_order_cart`.`w_size` AS `w_size`,`p_order_cart`.`order_date` AS `order_date`,`p_order_cart`.`delivery_date` AS `delivery_date`,`p_order_cart`.`cash_bill_yn` AS `cash_bill_yn`,`p_order_cart`.`realprice_memo` AS `realprice_memo`,`p_order_cart`.`area` AS `area`,`p_order_cart`.`idx` AS `idx`,`p_order_cart`.`tak_sel` AS `tak_sel`,`p_order_cart`.`member_sale` AS `member_sale`,`p_order_cart`.`view_yn` AS `view_yn`,`p_order_cart`.`bunch` AS `bunch`,`p_order_cart`.`c_stpom_type` AS `c_stpom_type`,`p_order_cart`.`c_stpom_text` AS `c_stpom_text`,`p_order_cart`.`payment_kind` AS `payment_kind`,`p_order_cart`.`card_gu_no` AS `card_gu_no`,`p_order_cart`.`card_ju_no` AS `card_ju_no`,`p_order_cart`.`card_su_no` AS `card_su_no`,`p_order_cart`.`admin_view` AS `admin_view`,`p_order_cart`.`admin_view_id` AS `admin_view_id`,`p_order_cart`.`cancel_ing` AS `cancel_ing`,`p_order_cart`.`d_to_contents2` AS `d_to_contents2`,`p_order_cart`.`bill_part` AS `bill_part`,`p_order_cart`.`bill_name` AS `bill_name`,`p_order_cart`.`bill_handphone` AS `bill_handphone`,`p_order_cart`.`bill_email` AS `bill_email` from `p_order_cart` where ((`p_order_cart`.`wdate` >= (now() - interval 1 day)) and `p_order_cart`.`seqno` in (select `p_order`.`cart_seqno` from `p_order` where (`p_order`.`wdate` >= (now() - interval 2 day))) is false);

-- 뷰 dbbium.view_shop_sum 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `view_shop_sum`;
CREATE ALGORITHM=UNDEFINED DEFINER=`bium`@`%` SQL SECURITY DEFINER VIEW `view_shop_sum` AS select max(`pp_order`.`order_num`) AS `m_oder_num`,count(`pp_order`.`order_no`) AS `tot_cnt`,sum(`pp_order`.`price`) AS `tot_price`,max(`pp_order`.`seqno`) AS `tot_seqno` from `pp_order` where (`pp_order`.`goods_code` <> '') group by `pp_order`.`order_no` order by `pp_order`.`seqno` desc;

-- 뷰 dbbium.view_shop_sum2 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `view_shop_sum2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`bium`@`%` SQL SECURITY DEFINER VIEW `view_shop_sum2` AS select min(`pp_order`.`order_num`) AS `m_oder_num`,count(`pp_order`.`order_no`) AS `tot_cnt`,sum(`pp_order`.`price`) AS `tot_price`,min(`pp_order`.`seqno`) AS `tot_seqno`,sum(ifnull(`pp_order`.`sale_price`,0)) AS `tot_sale_price`,sum(ifnull(`pp_order`.`realprice`,0)) AS `tot_realprice` from `pp_order` where (`pp_order`.`goods_code` <> '') group by `pp_order`.`order_no` order by `pp_order`.`seqno` desc;

-- 뷰 dbbium.view_tot_yak 구조 내보내기
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `view_tot_yak`;
CREATE ALGORITHM=UNDEFINED DEFINER=`bium`@`%` SQL SECURITY DEFINER VIEW `view_tot_yak` AS select `subt1`.`group_name` AS `group_name`,`subt1`.`group_code` AS `group_code`,`subt2`.`yak_name` AS `yak_name`,`subt2`.`yak_from` AS `yak_from`,`subt2`.`yak_danga` AS `yak_danga`,`subt2`.`yak_code` AS `yak_code`,`subt2`.`seqno` AS `seqno` from (`yak_group` `subt1` join `yakjae` `subt2` on((`subt1`.`group_code` = `subt2`.`group_code`)));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
