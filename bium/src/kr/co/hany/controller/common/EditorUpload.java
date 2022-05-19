package kr.co.hany.controller.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.hany.common.Const;
import kr.co.hany.controller.admin.AdminDefaultController;
import kr.co.hany.util.CommonMap;
import kr.co.hany.util.FileUpload;
import kr.co.hany.util.FileUploadUtil;
import kr.co.hany.util.MsgUtil;
import kr.co.hany.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EditorUpload extends AdminDefaultController {

	@RequestMapping(value = "/editUpload/image")
	public String uploadImgEditFile(Map<String, Object> map,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try{
			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
			Date currentDay = new Date ( );
			
			String YYYYMMDD = mSimpleDateFormat.format ( currentDay );
			String path = Const.UPLOAD_ROOT;
			
			String type =  StringUtil.StringNull(param.getString("type"));
			if(!"".equals(type) && type != null){
				type = type+"/"+YYYYMMDD;
				path = path+type;
			}
			
			
			Map<String, Object> info   = FileUploadUtil.getAttachImgFiles(request, "file_name", path, "");
			if(StringUtil.StringNull(info.get("fail")).equals("larger") ){
				return MsgUtil.Back(response, map,"최대 "+Const.FILE_LIMIT+"메가까지만 파일첨부할수 있습니다. ");
			}
			String fileName = StringUtil.StringNull( info.get("fileName") );
			
			if(info != null && !fileName.equals("")){
				info.put("img_path", type+"/");
				info.put("fileNameRe", FileUpload.renameFile(path, StringUtil.StringNull((info.get("fileName"))) , path));
				param.putAll(info);
			}
				
			
			request.setAttribute("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	    return "/img_uploader.daum";
	}
	
	@RequestMapping(value = "/editUpload/file")
	public String uploadFileEditFile(Map<String, Object> map,HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
			Date currentDay = new Date ( );
			
			String YYYYMMDD = mSimpleDateFormat.format ( currentDay );
			String path = Const.UPLOAD_ROOT;
			
			String type =  StringUtil.StringNull(param.getString("type"));
			
			if(!"".equals(type) && type != null){
				type = type+"/"+YYYYMMDD;
				path = path+type;
			}
			
			
			Map<String, Object> info   = FileUploadUtil.getAttachFiles(request, "file_name", path, "");
			
			if(StringUtil.StringNull(info.get("fail")).equals("larger") ){
				return MsgUtil.Back(response, map,"최대 "+Const.FILE_LIMIT+"메가까지만 파일첨부할수 있습니다. ");
			}
			
			String fileName = StringUtil.StringNull( info.get("fileName") );
			if(info != null && !fileName.equals("")){
				info.put("file_path", type+"/");
				info.put("fileNameRe", FileUpload.renameFile(path, StringUtil.StringNull((info.get("fileName"))) , path));
				param.putAll(info);
			}
		//	System.out.println("file = "+ param);
			request.setAttribute("bean", param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "/file_uploader.daum";
	}
	
}
