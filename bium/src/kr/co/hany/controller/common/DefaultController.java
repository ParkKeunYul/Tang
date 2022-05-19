package kr.co.hany.controller.common;
/*package kr.or.neungin.controller.common;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;
import com.dbkeducation.mmc.common.dao.CommonDao;
import com.dbkeducation.mmc.common.exception.FileUploadException;
import com.dbkeducation.mmc.common.util.CommonKeyValue;
import com.dbkeducation.mmc.common.util.CommonMap;
import com.dbkeducation.mmc.common.util.Const;
import com.dbkeducation.mmc.common.util.FileUpload;
import com.dbkeducation.mmc.common.util.Utils;
import com.dbkeducation.mmc.manager.entity.RelationEntity;
import com.dbkeducation.mmc.manager.entity.RelationInfoEntity;
import com.dbkeducation.mmc.user.dao.UserDao;

public class DefaultController extends MultiActionController implements CommonKeyValue {
	public DefaultDao defaultDao;
	public CommonDao commonDao;
	public UserDao userDao;
	public CommonMap commonMap;
	public Object userInfoObj = null;
	public String nextPage = "";
	public String location = "";
	public String errorPage = "/_common/_template/error.jsp";
	public int manager_cd = 0;

	private final Logger logger = Logger.getLogger(getClass());
	
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			String methodName = super.getMethodNameResolver().getHandlerMethodName(request);
			if(!sessionCheck(request,response)) return new ModelAndView("/login/login.jsp?nextUrl=" + location);  // view 호출
			if(!decrypt(request))return new ModelAndView(errorPage);  // view 호출
			
			return invokeNamedMethod(methodName, request, response);
		}
		catch (NoSuchRequestHandlingMethodException ex) {
			return handleNoSuchRequestHandlingMethod(ex, request, response);
		}
	}

	public boolean sessionCheck(HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		boolean isLogin = true;
		try{
			HttpSession session = request.getSession();
			userInfoObj = session.getAttribute("UserInfo");
			if(userInfoObj == null){
					logger.info("세션 만료.");
					location = Utils.chkNull(request.getParameter("nextUrl"));
					logger.debug("nextUrl=[" + location + "]");
			}else{
				
				UserInfo userInfo = (UserInfo)userInfoObj;
				manager_cd = userInfo.getManager_cd();
				isLogin = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			
		}	
		
		return isLogin;
	}
	
	public boolean decrypt(HttpServletRequest request){
		String msg = "";
		boolean isDecrypt = true;
		try{
			String requestData = Utils.chkNull(request.getParameter("RequestData"));
				commonMap = new CommonMap(request);
			//input 값들이 초기화 돼서 넘어 오므로 복호화 된 값들을 다시 셋팅해줘야 다음페이지에서 꺼내 쓸 수 있다.
			
			request.setAttribute("paramap",commonMap);
		}catch(Exception e){
			e.printStackTrace();
			isDecrypt = false;
			msg = Utils.chkNull(e.getMessage());
			if(msg.equals("")) msg = "처리 중 오류가 발생했습니다. 다시 시도해 주시기 바랍니다.";
		}finally{
			request.setAttribute("location", "/index.jsp");
			request.setAttribute("msg", msg);
		}

		return isDecrypt;
	}
	
	//파일 업로드 함수  
	public String getAttachFiles(HttpServletRequest request, String fileName, String uploadPath, String newFileName) throws FileUploadException, Exception{
		
		String saveFileName = "";
		
		MultipartHttpServletRequest multipartRequest =
			(MultipartHttpServletRequest) request;
		MultipartFile mFile = multipartRequest.getFile(fileName);
		
		if(!mFile.getOriginalFilename().equals("")){
			FileUpload uploadFile = new FileUpload();
			uploadFile.setMultipartFile( mFile );
			uploadFile.setRealUploadPath(uploadPath);
			//String id = newFileName;
			//String saveName = "";			
			//saveName = newFileName + "." + Utils.getSplit(mFile.getOriginalFilename(), ".")[1];
			
			saveFileName = uploadFile.upload(0,'1');
		}
		return saveFileName;
	}
	
	//파일 업로드 함수  
	public String getAttachFiles2(HttpServletRequest request, String fileName, String uploadPath, String newFileName) throws FileUploadException, Exception{
		
		String saveFileName = "";
		
		try{
			MultipartHttpServletRequest multipartRequest =
				(MultipartHttpServletRequest) request;
			MultipartFile mFile = multipartRequest.getFile(fileName);
			
			if(!mFile.getOriginalFilename().equals("")){
				FileUpload uploadFile = new FileUpload();
				uploadFile.setMultipartFile( mFile );
				uploadFile.setRealUploadPath(uploadPath);
				//String id = newFileName;
				//String saveName = "";			
				//saveName = newFileName + "." + Utils.getSplit(mFile.getOriginalFilename(), ".")[1];
				
				saveFileName = uploadFile.upload(0,'2');
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}		
		
		return saveFileName;
	}
	
	//파일 삭제 함수
	public String delAttachFiles(String uploadPath, String fileName) throws Exception{
		String saveFileName = fileName;
		
		File file = new File(uploadPath+fileName);
		boolean res = file.delete();
		return saveFileName;
	}
	
	//디렉토리 안의 파일목록
	public List getFileList(File targetFolder) throws Exception{
		List fileListD = new ArrayList();
		
		//String path= filePath;
		//File dirFile = new File(filePath);
		File []fileList = targetFolder.listFiles();
		for(File tempFile : fileList) {
			if(tempFile.isFile()) {
				String tempPath = tempFile.getParent();
				String tempFileName = tempFile.getName();
				fileListD.add(tempFileName);
				*//*** Do something withd tempPath and temp FileName ^^; ***//*
			}
		}
		return fileListD;
	}
	
	//디렉토리 안의 파일 디렉토시 삭제
	public boolean deleteFolder(File targetFolder){
		File[] childFile = targetFolder.listFiles();
		boolean confirm = false;
		int size = childFile.length;
	 
		if (size > 0) {	 
			for (int i = 0; i < size; i++) {	 
				if (childFile[i].isFile()) {	 
					confirm = childFile[i].delete();	 
				} else {	 
					deleteFolder(childFile[i]);	 
				}	 
			}	 
		}
		targetFolder.delete();	 
		return (!targetFolder.exists());	  	    
	}
	
	//코드리스트 
	public List getCodeList(String group_cd, String group_nm) throws Exception{
		
		List codeList = new ArrayList();
		try{
			commonMap.put(group_cd, group_nm);
			codeList = commonDao.mmcCodeList(commonMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return codeList;
	}
	
	//회원리스트 
	public List getUserAllList() throws Exception{
		
		List userList = new ArrayList();
		HashMap tempMap = new HashMap();
		try{
			userList = userDao.userAllList(tempMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return userList;
	}
	
	//관련정보관리 검색
	public List getRelationInfoNm(){
		//관련항목등록 A_Table_Relation
		//관련정보 코드명 relation_nm 가져오기
		List list = new ArrayList();
		List a_table_list = new ArrayList();
		List hid_list = new ArrayList();
		List index_list = new ArrayList();
		
		a_table_list.add("A_Major");
		a_table_list.add("A_University");
		a_table_list.add("A_Career");
		a_table_list.add("A_Experience_Act");
		a_table_list.add("A_Certify_Act");
		a_table_list.add("A_Read_Act");
		
		hid_list.add("maj_hid_add_val_");
		hid_list.add("uni_hid_add_val_");
		hid_list.add("car_hid_add_val_");
		hid_list.add("exp_hid_add_val_");
		hid_list.add("cer_hid_add_val_");
		hid_list.add("rea_hid_add_val_");
		
		index_list.add("indexres_rel_maj");
		index_list.add("indexres_rel_uni");
		index_list.add("indexres_rel_car");
		index_list.add("indexres_rel_exp");
		index_list.add("indexres_rel_cer");
		index_list.add("indexres_rel_rea");		
		
		list.add(0, a_table_list);
		list.add(1, hid_list);		
		list.add(2, index_list);	
		return list;
	}	

	//관련정보 메소드 추가-----> 2011/07/25
	//relation_nm 가져오기 Object
	public Object relationNm(String a_table_nm, String b_table_nm) throws Exception{
		commonMap.put("a_table", a_table_nm);
		commonMap.put("b_table", b_table_nm);		
		Object objRelInfo = new Object();
		try{
			objRelInfo = (Object)commonDao.searchRelationInfoEnt(commonMap);
		}catch(Exception e){
			e.printStackTrace();
		}		
		return objRelInfo;
	}
	
	//relation_nm 가져오기 List
	public List relationNmList(String tableNm) throws Exception{
		List relationNmList = new ArrayList();
		
		try{
			commonMap.put("table_nm", tableNm);
			relationNmList = (List)commonDao.searchRelationInfoList(commonMap);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return relationNmList;
	}
	
	//관련정보 가져오기1
	public List getRelList(List relationNmList, String tableNm, int experience_cd){
		List relationList = new ArrayList();
		try{
			for(int relI = 0; relI < relationNmList.size(); relI++){
				RelationInfoEntity RelationInfoEnt = (RelationInfoEntity)relationNmList.get(relI);
				String a_table = RelationInfoEnt.getA_table();
				String b_table = RelationInfoEnt.getB_table();
				String a_table_col_nm = RelationInfoEnt.getA_table_col_nm();
				String b_table_col_nm = RelationInfoEnt.getB_table_col_nm();
				String relationNm = RelationInfoEnt.getRelation_nm();
				List relationListRe = new ArrayList();
				relationListRe = getRelationList(tableNm, experience_cd, a_table, b_table, relationNm, a_table_col_nm, b_table_col_nm);
				relationList.add(relationListRe);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return relationList;
	}
	
	//관련정보 가져오기2  List  A_Table_Relation
	public List getRelationList(String standard_table, int standard_table_cd, String a_table, String b_table, String relation_nm, String a_table_col_nm, String b_table_col_nm) throws Exception{
		List list = new ArrayList();
		try{
			int nmFlg = 0;
			String aTableCd = "";
			String aTableNm = "";
			String bTableNm = "";
			String aTableNmVal = "";
			String bTableNmVal = "";
			String a_cdNm = "";
			String b_cdNm = "";
			String a_cdNmVal = "";
			String b_cdNmVal= "";
			if(standard_table.equals(a_table)){
				nmFlg = 1;
				aTableCd = "a_table_cd";
				
			}else if(standard_table.equals(b_table)){
				nmFlg = 2;
				aTableCd = "b_table_cd";
			}
			
			aTableNm = "a_table_nm";
			bTableNm = "b_table_nm";
			aTableNmVal = a_table;
			bTableNmVal = b_table;			
			a_cdNm = "a_cd";
			b_cdNm = "b_cd";
			a_cdNmVal = a_table_col_nm;
			b_cdNmVal = b_table_col_nm;
			
			commonMap.put("name_flg", nmFlg);
			commonMap.put(aTableCd, standard_table_cd);
			commonMap.put("relation_nm", relation_nm);
			commonMap.put(aTableNm, aTableNmVal);
			commonMap.put(bTableNm, bTableNmVal);
			commonMap.put(a_cdNm, a_cdNmVal);
			commonMap.put(b_cdNm, b_cdNmVal);
			list = commonDao.getRelationList(commonMap);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	
	//관련정보 입력
	public void relationInsert(String table_nm1, String table_nm2, String relation_nm, String a_table_nm, String b_table_nm, int indexResListSize, List indexResList, int table_nm1_cd) throws Exception {
		int nmFlg = 0;
		String comNmA = "";
		String comNmB = "";
		if(table_nm1.equals(a_table_nm)){
			nmFlg = 1;
		}else if(table_nm1.equals(b_table_nm)){
			nmFlg = 2;
		}
		
		if(nmFlg == 1){
			comNmA = "a_table_cd";
			comNmB = "b_table_cd";
		}else if(nmFlg == 2){
			comNmA = "b_table_cd";
			comNmB = "a_table_cd";
		}
		
		commonMap.put("relation_nm", relation_nm); //관력정보코드명
		commonMap.put(comNmA, table_nm1_cd); //관력정보코드명
		
		try{
			if(indexResListSize != 0){
				for(int relI = 0; relI < indexResListSize; relI++){
					int table_cd = (Integer)indexResList.get(relI);					
					commonMap.put(comNmB, table_cd); //종테이블
					//등록
					commonDao.relationInsert(commonMap);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	//관련정보 지우기
	public void relationDelete(CommonMap commonMap) throws Exception{
		try{
			commonDao.relationDelete(commonMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	//관련정보 등록하기
	public void relationRegi(String standard_table, int experience_cd, String delFlg)throws Exception{
		List table_list = Utils.getRelationInfoNm();
		List relataionNameList = new ArrayList();
		List table_listRe = (List)table_list.get(0);
		List hid_list = (List)table_list.get(1);
		List flg_list= (List)table_list.get(2);
		
		try{
			for(int ListI = 0; ListI < table_listRe.size(); ListI++){
				String hidStr = ""; //indexres_rel_uni
				String flgNm = "";
				String relName = "";
				String delFlgNm = "";
				
				String nmStr = (String)table_listRe.get(ListI);
				hidStr = (String)hid_list.get(ListI);
				flgNm = (String)flg_list.get(ListI)+"_add_hid_val_tot"; //rea_add_hid_val_tot	
				delFlgNm = (String)flg_list.get(ListI)+"_del_hid_val_tot";
				
				if(!standard_table.equals(nmStr)){
					
					Object objRelInfo = new Object();
					objRelInfo = relationNm(standard_table, nmStr); //a_table이름 b_table이름
					
					if(objRelInfo != null){
						RelationInfoEntity relationEnt = new RelationInfoEntity();
						relationEnt = (RelationInfoEntity)objRelInfo;
						
						String relation_nm = relationEnt.getRelation_nm();
						String a_table_nm = relationEnt.getA_table();
						String b_table_nm = relationEnt.getB_table();
						String kname = relationEnt.getKname();
						
						commonMap.put("relation_nm", relation_nm);	
						
						
						if("1".equals(delFlg)){
							//삭제//
							relationDel(standard_table, a_table_nm, b_table_nm, nmStr, experience_cd, delFlgNm);							
							//삭제//
						}
						
						
						//추가
						//입력값가져오기
						List codeValList = new ArrayList();
						String valStr = commonMap.getString(flgNm, "");
						String valStrArray[] = null;
						if(!"".equals(valStr)){							
							valStrArray = valStr.split(",");
						
							if(valStrArray.length > 0){
								for(int relI = 0; relI < valStrArray.length; relI++){
									String tableCdStr  = valStrArray[relI];
									int table_cd = new Integer(tableCdStr);
									codeValList.add(table_cd);
									//commonMap.put(comNmB, table_cd); //종테이블
								}								
								relationInsert(standard_table, nmStr, relation_nm, a_table_nm, b_table_nm, codeValList.size(), codeValList, experience_cd);
							}
						}
						
					}else{
						System.out.println("[IN DefaultController::relationRegi]관련정보관리가 등록되어있지않습니다.");
					}	
				}
			 
			}
		}catch(Exception e){
			e.printStackTrace();
		}		
		//
	}
	
	//관련정보 삭제
	public void relationDel(String standard_table, String a_table_nm, String b_table_nm, String tableNm, int experience_cd, String delFlgNm) throws Exception{
		try{
						
			List relTbFlgList = new ArrayList();
			String nameFlg = "";
			String anoTbNm = "";
			relTbFlgList = Utils.relationTableFlg(standard_table, a_table_nm, b_table_nm);
			nameFlg = (String)relTbFlgList.get(0);
			anoTbNm = (String)relTbFlgList.get(1);						
			
			String oriRelNm = "";
			String nmNm = "";
			List oriRelList = new ArrayList();
			oriRelList = Utils.relataionViewNm(tableNm);
			nmNm = (String)oriRelList.get(1);
			
			String delFlgNmVal = commonMap.getString(delFlgNm, "");
			if(!"".equals(delFlgNmVal)){
				String delNmVal[] = delFlgNmVal.split(",");
				int code = 0;
				if(delNmVal.length > 0){
					for(int i = 0; i < delNmVal.length; i++){
						code = new Integer(delNmVal[i]);
						if(code != 0){
							if("a".equals(nameFlg)){
								commonMap.put("a_table_cd", experience_cd);
								commonMap.put("b_table_cd", code);
							}else if("b".equals(nameFlg)){
								commonMap.put("b_table_cd", experience_cd);
								commonMap.put("a_table_cd", code);
							}
							relationDelete(commonMap);
						}
					}					
				}
			}			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//활동삭제시 관련정보 삭제
	public void relationDelAct(List relationList)throws Exception {
		try{
			if(relationList != null && relationList.size() > 0){
				for(int delI = 0; delI < relationList.size(); delI++){					
					List list = (ArrayList)relationList.get(delI);
					
					if(list != null && list.size() > 0){
						for(int delI2 = 0; delI2 < list.size(); delI2++){
							RelationEntity relationEnt = new RelationEntity();
							relationEnt = (RelationEntity)list.get(delI2);
							commonMap.put("relation_nm", relationEnt.getRelation_nm());
							commonMap.put("a_table_cd", relationEnt.getA_table_cd());
							commonMap.put("b_table_cd", relationEnt.getB_table_cd());
							relationDelete(commonMap);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}	
	
	
	public void setDefaultDao(DefaultDao defaultDao) {
		this.defaultDao = defaultDao;
	}

	public void setCommonMap(CommonMap commonMap) {
		this.commonMap = commonMap;
	}
	
	public void setCommonDao(CommonDao commonDao) {
		this.commonDao = commonDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	
}
*/