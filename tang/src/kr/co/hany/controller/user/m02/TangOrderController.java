package kr.co.hany.controller.user.m02;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hany.common.Const;
import kr.co.hany.controller.user.UserDefaultController;
import kr.co.hany.dao.admin.order.TangDAO;
import kr.co.hany.dao.user.m02.DictionDAO;
import kr.co.hany.dao.user.m02.ItemDAO;
import kr.co.hany.dao.user.m02.TangOrderDAO;
import kr.co.hany.dao.user.m05.MyPatientDAO;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.PageUtil;
import kr.co.hany.util.StringUtil;
import kr.co.hany.vo.JsonObj;

@Controller
public class TangOrderController extends UserDefaultController{

	@Autowired
	ItemDAO itemDao;
	
	@Autowired
	TangOrderDAO tangOrderDao;
	
	@Autowired
	MyPatientDAO myPationDao;
	
	@Autowired
	DictionDAO dicDao;
	
	@Autowired
	MyPatientDAO myPatientDao;
	
	@Autowired
	TangDAO tangDao;
	
	
	@RequestMapping ("/m02/01.do")
	public String v_01(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
			param.put("today", sdf.format(today));

			param.put("V_USE_ABLE", "y");
			
			List<Map<String, Object>>  box_list   = itemDao.select_box(param); 
			List<Map<String, Object>>  pouch_list = itemDao.select_pouch(param);		
			
			map.put("sty_list"  , itemDao.select_sty(param));
			map.put("joje_list" , itemDao.select_joje(param));
			map.put("bok_list"  , itemDao.select_bokyong(param));
			
			Map<String, Object> setting = itemDao.select_setting(param);
			
			
			if(!"".equals(param.getString("wp_seqno", ""))){
				param.put("seqno", param.get("wp_seqno"));
				
				Map<String, Object> view = myPatientDao.view(param);
				setting.put("w_name"      , view.get("name"));
				setting.put("w_contents"  , view.get("contents"));
				setting.put("wp_seqno"    , view.get("seqno"));
				setting.put("w_sex"       , view.get("sex"));
				setting.put("w_jindan"    , view.get("jindan"));
				
				String birth_year = StringUtil.objToStr(view.get("birth_year"), "");
				int age        = 0;
				if(!"".equals(birth_year) && birth_year.length() == 10) {
					 Calendar current = Calendar.getInstance();
				     int currentYear  = current.get(Calendar.YEAR);
				     age = currentYear - Integer.parseInt(birth_year.substring(0,4));
				}
				
				setting.put("w_age"       , age); // 생년월일 계산
				setting.put("w_birthyear" , birth_year);
				setting.put("w_etc01"     , view.get("etc1"));
				setting.put("w_etc02"     , view.get("etc2"));
				setting.put("w_address01" , view.get("address01"));
				setting.put("w_address02" , view.get("address02"));
				setting.put("w_zipcode"   , view.get("zipcode"));
				setting.put("w_name_sel"  , view.get("name"));
				setting.put("w_cel_sel"   , view.get("handphone"));
			}
			
			if(!"".equals(param.getString("dic_seqno", ""))){
				System.out.println("방제사전");
				param.put("seqno", param.get("dic_seqno"));
				Map<String, Object> view = dicDao.view(param);
				
				setting.put("s_name", view.get("s_name"));
				setting.put("b_name", view.get("b_name"));
			}
			
			String private_yn = StringUtil.objToStr( setting.get("private_yn") , "");
			if("y".equals(private_yn)){
				System.out.println("p_c_pouch_type = "+ setting.get("p_c_pouch_type"));
				System.out.println("p_c_box_type = "+ setting.get("p_c_box_type"));
				
				String p_c_pouch_type = StringUtil.objToStr(setting.get("p_c_pouch_type") , "");
				String p_c_box_type = StringUtil.objToStr(setting.get("p_c_box_type") , "");
				
				/*
				box_list 
				pouch_list
				*/
				
				if(!"".equals(p_c_box_type)) {
					setting.put("c_box_type", p_c_box_type);
					Map<String, Object>  info = itemDao.private_box(setting);
					box_list.add(info);
				}
				
				if(!"".equals(p_c_pouch_type)) {
					setting.put("c_pouch_type", p_c_pouch_type);
					Map<String, Object>  info = itemDao.private_pouch(setting);
					pouch_list.add(info);
				}
			}
			
			map.put("box_list"  , box_list);
			map.put("pouch_list", pouch_list);
			
			
			map.put("setting" , setting);
			map.put("bean"    , param);
			
			map.put("referer", StringUtil.objToStr(request.getHeader("REFERER"), ""));
			
			if("y".equals( StringUtil.objToStr(setting.get("temp_save"), "") )) {
				map.put("temp_cnt", tangOrderDao.check_temp(param));
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/m02/01"+Const.uTiles;
	}
	
	@RequestMapping ("/m02/01_pre_order.do")
	public String v_01_preorder(Map<String, Object> map, HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id"       , userSession.get("id"));
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일");
			param.put("today", sdf.format(today));

			param.put("V_USE_ABLE", "y");
			
			/*map.put("box_list"  , itemDao.select_box(param));
			map.put("pouch_list", itemDao.select_pouch(param));*/
			List<Map<String, Object>>  box_list   = itemDao.select_box(param); 
			List<Map<String, Object>>  pouch_list = itemDao.select_pouch(param);
			
			map.put("sty_list"  , itemDao.select_sty(param));
			map.put("joje_list" , itemDao.select_joje(param));
			map.put("bok_list"  , itemDao.select_bokyong(param));
			
			
			Map<String, Object> setting = tangOrderDao.order_view(param);
			if(setting == null) {
				PageUtil.scripAlertBack(response, "이전 주문건이 아닙니다.");
			}
			
			System.out.println(setting);
			System.out.println(setting);
			System.out.println(setting);
			System.out.println(setting);
			
			
			/**/
			param.put("seqno", setting.get("wp_seqno"));
			Map<String, Object> view = myPatientDao.view(param);
			setting.put("w_name"      , view.get("name"));
			setting.put("w_contents"  , view.get("contents"));
			setting.put("wp_seqno"    , view.get("seqno"));
			setting.put("w_sex"       , view.get("sex"));
			setting.put("w_jindan"    , view.get("jindan"));
			
			String birth_year = StringUtil.objToStr(view.get("birth_year"), "");
			int age        = 0;
			if(!"".equals(birth_year) && birth_year.length() == 10) {
				 Calendar current = Calendar.getInstance();
			     int currentYear  = current.get(Calendar.YEAR);
			     age = currentYear - Integer.parseInt(birth_year.substring(0,4));
			}
			setting.put("w_age"       , age); // 생년월일 계산
			setting.put("w_birthyear" , birth_year);
			setting.put("w_etc01"     , view.get("etc1"));
			setting.put("w_etc02"     , view.get("etc2"));
			setting.put("w_address01" , view.get("address01"));
			setting.put("w_address02" , view.get("address02"));
			setting.put("w_zipcode"   , view.get("zipcode"));
			setting.put("w_name_sel"  , view.get("name"));
			setting.put("w_cel_sel"   , view.get("handphone"));
			
			
			
			String private_yn = StringUtil.objToStr( setting.get("private_yn") , "");
			if("y".equals(private_yn)){
				/*
				System.out.println("p_c_pouch_type = "+ setting.get("p_c_pouch_type"));
				System.out.println("p_c_box_type = "+ setting.get("p_c_box_type"));
				*/
				String p_c_pouch_type = StringUtil.objToStr(setting.get("p_c_pouch_type") , "");
				String p_c_box_type = StringUtil.objToStr(setting.get("p_c_box_type") , "");
				
				/*
				box_list 
				pouch_list
				*/
				
				if(!"".equals(p_c_box_type)) {
					//setting.put("c_box_type", p_c_box_type);
					Map<String, Object>  info = itemDao.private_box(setting);
					box_list.add(info);
				}
				
				if(!"".equals(p_c_pouch_type)) {
					//setting.put("c_pouch_type", p_c_pouch_type);
					Map<String, Object>  info = itemDao.private_pouch(setting);
					pouch_list.add(info);
				}
			}
			
			map.put("box_list"  , box_list);
			map.put("pouch_list", pouch_list);
			
			
			map.put("setting"   , setting);
			map.put("bean"      , param);
			
		}catch (Exception e) {
			e.printStackTrace();
			PageUtil.scripAlertBack(response, Const.errMsg);
		}
		return "/m02/01"+Const.uTiles;
	}
	
	
	@RequestMapping ("/m02/01_cart_update.do")
	public String v_card_update( Map<String, Object> map
								,HttpServletResponse response){
		try {
			param.put("mem_seqno", userSession.get("seqno"));
			param.put("id", userSession.get("id"));
			
			/*장바구니엣 수정 할경우*/
			Map<String, Object> info = tangOrderDao.cart_view(param);
			
			param.put("today", info.get("wdate2"));
			param.put("V_USE_ABLE", "y");
			
			/*
			map.put("box_list"  , itemDao.select_box(param));
			map.put("pouch_list", itemDao.select_pouch(param));
			*/
			List<Map<String, Object>>  box_list   = itemDao.select_box(param); 
			List<Map<String, Object>>  pouch_list = itemDao.select_pouch(param);
			map.put("sty_list"  , itemDao.select_sty(param));
			map.put("joje_list" , itemDao.select_joje(param));
			map.put("bok_list"  , itemDao.select_bokyong(param));
			
			
			param.put("seqno", info.get("wp_seqno"));
			Map<String, Object> view = myPatientDao.view(param);
			info.put("w_name"      , view.get("name"));
			info.put("w_contents"  , view.get("contents"));
			info.put("wp_seqno"    , view.get("seqno"));
			info.put("w_sex"       , view.get("sex_code"));
			info.put("w_jindan"    , view.get("jindan"));
			
			String birth_year = StringUtil.objToStr(view.get("birth_year"), "");
			int age        = 0;
			if(!"".equals(birth_year) && birth_year.length() == 10) {
				 Calendar current = Calendar.getInstance();
			     int currentYear  = current.get(Calendar.YEAR);
			     age = currentYear - Integer.parseInt(birth_year.substring(0,4));
			}
			info.put("w_age"       , age); // 생년월일 계산
			info.put("w_birthyear" , birth_year);
			info.put("w_etc01"     , view.get("etc1"));
			info.put("w_etc02"     , view.get("etc2"));
			info.put("w_address01" , view.get("address01"));
			info.put("w_address02" , view.get("address02"));
			info.put("w_zipcode"   , view.get("zipcode"));
			info.put("w_name_sel"  , view.get("name"));
			info.put("w_cel_sel"   , view.get("handphone"));
			
			
			Map<String, Object> setting_ori = itemDao.select_setting(param);
			String private_yn = StringUtil.objToStr( setting_ori.get("private_yn") , "");
			
			if("y".equals(private_yn)){
				/*
				System.out.println("p_c_pouch_type = "+ setting.get("p_c_pouch_type"));
				System.out.println("p_c_box_type = "+ setting.get("p_c_box_type"));
				*/
				String p_c_pouch_type = StringUtil.objToStr(setting_ori.get("p_c_pouch_type") , "");
				String p_c_box_type = StringUtil.objToStr(setting_ori.get("p_c_box_type") , "");
				
				/*
				box_list 
				pouch_list
				*/
				if(!"".equals(p_c_box_type)) {
				//	info.put("c_box_type", p_c_box_type);
					Map<String, Object>  p_info = itemDao.private_box(setting_ori);
					box_list.add(p_info);
				}
				
				if(!"".equals(p_c_pouch_type)) {
					//info.put("c_pouch_type", p_c_pouch_type);
					Map<String, Object>  p_info = itemDao.private_pouch(setting_ori);
					pouch_list.add(p_info);
				}
			}
			
			map.put("box_list"   , box_list);
			map.put("pouch_list" , pouch_list);
			
			map.put("setting"   , info);
			
			
			map.put("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/m02/01"+Const.uTiles;
	};
	
	
	
	@RequestMapping ("/m02/01_pre_yajkae_list.do")
	public @ResponseBody List<Map<String, Object>>  aj_01_pre_yajkae_list( Map<String, Object> map
																		 , HttpServletResponse response){
		List<Map<String, Object>> list= null;
		try {
			
			list = tangOrderDao.pre_yajkae_list(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping ("/m02/01_duple_patinet.do")
	public @ResponseBody Map<String, Object> aj_01_duple_patinet( Map<String, Object> map
													  			,HttpServletResponse response
													  			,HttpServletRequest requests		
													  			,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id"		  , userSession.get("id"));
			param.put("mem_seqno" , userSession.get("seqno"));
			
			int duple = myPationDao.duple_patient(param);
			
			rtn = PageUtil.procSuc();
			
			rtn.put("duple", duple);
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m02/01_save_cart.do")
	public @ResponseBody Map<String, Object> aj_01_save_cart( Map<String, Object> map
													  		,HttpServletResponse response
													  		,HttpServletRequest requests		
													  		,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id"		     , userSession.get("id"));
			param.put("mem_seqno"    , userSession.get("seqno"));
			param.put("name"	     , userSession.get("name"));
			param.put("han_name"     , userSession.get("han_name"));
			param.put("mem_sub_seqno", userSession.get("mem_sub_seqno"));
			param.put("mem_sub_grade", userSession.get("mem_sub_grade"));

			
			if("0".equals(param.getString("c_chup_ea"))) {
				rtn.put("msg", "0첩은 장바구니에 담을수 없습니다.");
				return rtn;
			}
			
			
			
			param.put("d_to_handphone"   , param.getString("d_to_handphone01")+"-"+param.getString("d_to_handphone02")+"-"+ param.getString("d_to_handphone03"));
			param.put("d_from_handphone"   , param.getString("d_from_handphone01")+"-"+param.getString("d_from_handphone02")+"-"+ param.getString("d_from_handphone03"));
			
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String yyyyMM = sdf.format(today);
			
			int seqno        = tangOrderDao.select_next_seqno();			
			String tempPath  = Const.UPLOAD_ROOT+ "tang/temp/";
			String folder_nm = "tang/"+yyyyMM;			
			
			
			//조제
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "c_joje_file", tempPath, "");
			
			if(file_info1 != null) {
				if( "larger".equals( StringUtil.objToStr(file_info1.get("fail"), "")) ){
					rtn.put("msg", "조제 지시사항은 "+Const.FILE_LIMIT+"MB 이하 파일만 첨부 가능합니다.");
					return rtn;
				}
				param.put("c_joje_folder", yyyyMM);
				param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, seqno, "joje", "c_joje_file",folder_nm);
			}
			
			
			
			// 복용
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "c_bokyong_file", tempPath, "");			
			if(file_info2 != null) {
				if( "larger".equals( StringUtil.objToStr(file_info2.get("fail"), "")) ){
					rtn.put("msg", "복용 지시사항은 "+Const.FILE_LIMIT+"MB 이하 파일만 첨부 가능합니다.");
					return rtn;
				}
				param.put("c_bokyong_folder", yyyyMM);
				param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, seqno, "bokyong", "c_bokyong_file",folder_nm);
			}
			
			
			boolean flag;
			String wp_seqno = param.getString("wp_seqno","");
			if("".equals(wp_seqno)) {// 새로운 환자 신규 등록
				flag = myPationDao.addCartInfo(param);
				if(flag) {
					param.put("wp_seqno", myPationDao.getMaxSeqno(param));
				}else {
					return rtn;
				}
			}
			
			String json_yakjae   = "["+param.getString("json_yakjae","")+"]";
			List<Map<String, Object>> yakjae_list =  StringUtil.jsonToArray(json_yakjae);
			
			param.put("seqno", seqno);
			param.put("order_sale_per", userSession.get("sale_per"));
			
			flag = tangOrderDao.saveCart(param, yakjae_list);
			
			if(flag) {
				rtn = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		
	}// 
	
	@RequestMapping ("/m02/01_update_cart.do")
	public @ResponseBody Map<String, Object> aj_01_update_cart( Map<String, Object> map
													  		,HttpServletResponse response
													  		,HttpServletRequest requests		
													  		,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id"		  , userSession.get("id"));
			param.put("mem_seqno" , userSession.get("seqno"));
			param.put("name"	  , userSession.get("name"));
			param.put("han_name"  , userSession.get("han_name"));
			
			
			if("0".equals(param.getString("c_chup_ea"))) {
				rtn.put("msg", "0첩은 수정 할 수 없습니다.");
				return rtn;
			}
			
			param.put("d_to_handphone"   , param.getString("d_to_handphone01")+"-"+param.getString("d_to_handphone02")+"-"+ param.getString("d_to_handphone03"));
			param.put("d_from_handphone"   , param.getString("d_from_handphone01")+"-"+param.getString("d_from_handphone02")+"-"+ param.getString("d_from_handphone03"));
			
			
			System.out.println(param.getString("c_pouch_type"));
			System.out.println(param.getString("c_pouch_type"));
			System.out.println(param.getString("c_pouch_type"));
			System.out.println(param.getString("c_pouch_type"));
			System.out.println(param.getString("c_pouch_type"));
			
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String yyyyMM = sdf.format(today);
			
			int seqno        = param.getInt("cart_seqno");			
			String tempPath  = Const.UPLOAD_ROOT+ "tang/temp/";
			String folder_nm = "tang/"+yyyyMM;			
			
			
			//조제
			Map<String, Object> file_info1 = FileUploadUtil.getAttachFiles(requests, "c_joje_file", tempPath, "");
			
			if(file_info1 != null) {
				if( "larger".equals( StringUtil.objToStr(file_info1.get("fail"), "")) ){
					rtn.put("msg", "조제 지시사항은 "+Const.FILE_LIMIT+"MB 이하 파일만 첨부 가능합니다.");
					return rtn;
				}
				param.put("c_joje_folder", yyyyMM);
				param  = FileUploadUtil.getAttachFilesDbSet(param, file_info1, tempPath, seqno, "joje", "c_joje_file",folder_nm);
			}
			
			
			// 복용
			Map<String, Object> file_info2 = FileUploadUtil.getAttachFiles(requests, "c_bokyong_file", tempPath, "");			
			if(file_info2 != null) {
				if( "larger".equals( StringUtil.objToStr(file_info2.get("fail"), "")) ){
					rtn.put("msg", "복용 지시사항은 "+Const.FILE_LIMIT+"MB 이하 파일만 첨부 가능합니다.");
					return rtn;
				}
				param.put("c_bokyong_folder", yyyyMM);
				param  = FileUploadUtil.getAttachFilesDbSet(param, file_info2, tempPath, seqno, "bokyong", "c_bokyong_file",folder_nm);
			}
			
			
			boolean flag;
			String wp_seqno = param.getString("wp_seqno","");
			if("".equals(wp_seqno)) {// 새로운 환자 신규 등록
				flag = myPationDao.addCartInfo(param);
				if(flag) {
					param.put("wp_seqno", myPationDao.getMaxSeqno(param));
				}else {
					return rtn;
				}
			}
			
			String json_yakjae   = "["+param.getString("json_yakjae","")+"]";
			List<Map<String, Object>> yakjae_list =  StringUtil.jsonToArray(json_yakjae);
			
			param.put("seqno", seqno);
			param.put("order_sale_per", userSession.get("sale_per"));
			
			flag = tangOrderDao.updateCart(param, yakjae_list);
			
			if(flag) {
				rtn = PageUtil.procSuc();
			}
			
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
		
	}// 
	
	
	@RequestMapping ("/m02/01_cart_yajkae_list.do")
	public @ResponseBody JsonObj  jq_01_cart_yajkae_list( Map<String, Object> map
																		   ,HttpServletResponse response){
		JsonObj jsonObj = new JsonObj();
		try {
			param.put("id", userSession.get("id"));
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			List<Map<String, Object>> list = tangOrderDao.cart_yajkae_list(param);
			
			param = PageUtil.setListInfo(param, list.size()); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("/m02/01_dic_yajkae_list.do")
	public @ResponseBody JsonObj  jq_01_dic_yajkae_list( Map<String, Object> map
														,HttpServletResponse response){
		JsonObj jsonObj = new JsonObj();
		try {
			param.put("id", userSession.get("id"));
			
			
			Map<String, Object> view = dicDao.view(param);
			param.put("s_code", view.get("s_code"));
			param.put("b_code", view.get("b_code"));
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			List<Map<String, Object>> list = tangOrderDao.dic_yajkae_list(param);
			
			param = PageUtil.setListInfo(param, list.size()); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m02/01_update_cart_yakjae.do")
	public @ResponseBody Map<String, Object> aj_update_cart_yakjae( Map<String, Object> map
													  			   ,HttpServletResponse response
													  			   ,HttpServletRequest requests		
													  			   ,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id"		  , userSession.get("id"));
			param.put("mem_seqno" , userSession.get("seqno"));
			
			List<Map<String, Object>> list = tangOrderDao.select_yakjae_change_danga(param);

			tangOrderDao.update_cart_price(param, list);;
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	
	@RequestMapping ("/m02/01_preorder_yajkae_list.do")
	public @ResponseBody JsonObj  jq_01__preorder_yajkae_list( Map<String, Object> map
										 				      ,HttpServletResponse response){
		JsonObj jsonObj = new JsonObj();
		try {
			param.put("id", userSession.get("id"));
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			List<Map<String, Object>> list = tangOrderDao.preorder_yajkae_list(param);
			
			param = PageUtil.setListInfo(param, list.size()); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	@RequestMapping ("/m02/lately.do")
	public String v_lately( Map<String, Object> map
					   	   ,HttpServletResponse response){		
		return "/m02/01_lately"+Const.uuTiles;
	}
	
	
	@RequestMapping ("/m02/select.do")
	public @ResponseBody JsonObj  select( Map<String, Object> map
										 ,HttpServletResponse response
										 ,HttpSession session){
		
		JsonObj jsonObj = new JsonObj();
		try{
			
			param.put("user_mem_seqno"      , userSession.get("seqno"));
			int total = tangDao.select_total(param);
			
			param = PageUtil.setListInfo(param, total); 
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			if( param.getInt("total")  > 0 ) {
				jsonObj.setRows(tangDao.select_order(param));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
	
	
	@RequestMapping ("/m02/01_temp_yakjae.do")
	public @ResponseBody Map<String, Object> aj_temp_yakjae( Map<String, Object> map
														    ,HttpServletResponse response
													  		,HttpServletRequest requests		
													  		,HttpSession session){
		Map<String, Object> rtn = PageUtil.procSet();
		try {
			param.put("id"		  , userSession.get("id"));
			param.put("mem_seqno" , userSession.get("seqno"));
						
			
			String json_yakjae   = "["+param.getString("json_temp_yakjae","")+"]";
			List<Map<String, Object>> yakjae_list =  StringUtil.jsonToArray(json_yakjae);
			
			tangOrderDao.temp_yakjae(param, yakjae_list);
			
			rtn = PageUtil.procSuc();
			return rtn;
		}catch (Exception e) {
			e.printStackTrace();
			return rtn;
		}
	}
	
	@RequestMapping ("/m02/01_select_temp.do")
	public @ResponseBody JsonObj  _select_temp( Map<String, Object> map
									 		   ,HttpServletResponse response){
		JsonObj jsonObj = new JsonObj();
		try {
			param.put("id", userSession.get("id"));
			param.put("mem_seqno" , userSession.get("seqno"));
			
			
			jsonObj.setRecords(param.getInt("total"));    // total
			jsonObj.setTotal(param.getInt("maxPage"));    // 최대페이지
			jsonObj.setPage(param.getInt("page"));        // 현재 페이지
			
			List<Map<String, Object>> list = tangOrderDao.select_temp(param);
			
			param = PageUtil.setListInfo(param, list.size()); 
			
			if(param.getInt("pageSearch") == 1 ){ // 검색시 1페이지 시작
				System.out.println("pageSearch");
				jsonObj.setPage(1);  // 현재 페이지
			}
				
			jsonObj.setRows(list);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}
}
