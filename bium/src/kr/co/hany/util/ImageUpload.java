package kr.co.hany.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import kr.co.hany.common.Const;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class ImageUpload {

	public Map<String, String> editUpload( HttpServletRequest request
														  ,String temp_dir
														  ,String temp_url
														  ,String replaceDir){
		
		Map<String, String> map  = new HashMap<String, String>();
		AttachFileUtil afu = new AttachFileUtil();
		String fileName    = null;
		
		try{
			String dir = temp_dir;
			
			
			Date temp_today = new Date();
			SimpleDateFormat temp_formater = new SimpleDateFormat("yyyyMMdd");
			String today_temp = "/"+temp_formater.format(temp_today);
			
			
			dir  = temp_dir+today_temp;
			map.put("today_temp", today_temp);
			
			
			map.put("replaceDir", replaceDir+today_temp+"/");
			
			File dir_check = new File(dir);
			if(!dir_check.exists()) {
				File[] del_temp = new File(temp_dir).listFiles();
				afu.delDir(del_temp);
				
				dir_check.mkdirs();
			}
			MultipartRequest muti = new MultipartRequest(request, dir, Const.IMAGE_FILE_SIZE*1024*1024, "utf-8", new DefaultFileRenamePolicy());
			
			
			map.put("CKEditorFuncNum", muti.getParameter("CKEditorFuncNum"));
			map.put("CKEditor", muti.getParameter("CKEditor"));
			map.put("langCode", muti.getParameter("langCode "));
			
			
			
			Enumeration file = muti.getFileNames();
			while(file.hasMoreElements()){
				String get_file = (String)file.nextElement();
				fileName       = muti.getFilesystemName(get_file);
				
				String file_type = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase().trim();
				
				Date today = new Date();
				SimpleDateFormat formater = new SimpleDateFormat("HHmmss");
				String reName = formater.format(today)+System.currentTimeMillis()+"."+file_type;
				
				copyTransfer(dir+"/"+fileName, dir+"/"+reName);
				delFile(dir+"/"+fileName);
				
				map.put("file_name", reName);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	public static int  copyTransfer(String srcFile, String destFile) throws Exception{
		int check = 1;
		
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		
		try{
		
			fis = new FileInputStream(srcFile);
			bis = new BufferedInputStream(fis);
			fos = new FileOutputStream(destFile);
			bos = new BufferedOutputStream(fos);
			int i = 0;
			byte buffer[] = new byte[4096];
			
			while ((i = fis.read(buffer)) != -1){
				bos.write(buffer,0,i);
			}
			bos.flush();
		}catch (Exception e){
			check = -1;
			System.out.println("지정된 파일이 없다. 둘중에 하나 ");
			System.out.println("srcFile = "+ srcFile);
			System.out.println("destFile = "+ destFile);
		}finally{
			if(fis != null) try{fis.close();}catch(Exception e){}
			if(bis != null) try{bis.close();}catch(Exception e){}
			if(fos != null) try{fos.close();}catch(Exception e){}
			if(bos != null) try{bos.close();}catch(Exception e){}
		}
		return check;
	}
		
	public static  boolean delFile(String file_name){
		boolean vReturn = false;
		try{
			File f = new File(file_name);

			vReturn = f.delete();
		}catch(SecurityException e){
			System.err.println(e.getMessage());
		}
		return vReturn;
	}
	
	public static int moveImageFile(String tempFile, String saveFile){
		int check= 0;
		try{
			check = copyTransfer(tempFile, saveFile);
			System.out.println("tempFile = "+tempFile);
			System.out.println("tempFile = "+tempFile);
			System.out.println("tempFile = "+tempFile);
			delFile(tempFile);
		}catch (Exception e) {
			e.printStackTrace();
			check = -1;
		}
		return check;
	}
	
	public static Map<String, Object> ImageProcess(Map<String, Object>  map){
		
		Map<String, Object> param = map;
		
		ArrayList<String> iList = null;  
		
		String imgFiles = param.get("img_file")+"";	
		if(imgFiles != null && !imgFiles.equals("")){
			imgFiles = imgFiles.substring(1, imgFiles.length());
			StringTokenizer st = new StringTokenizer(imgFiles,"|");
			
			iList = new ArrayList<String>();
			while (st.hasMoreElements()) {
				iList.add(st.nextToken());
			}
		}
		
		if(param.get("contents").toString() != null && !param.get("contents").toString().equals("")){
			String contents = param.get("contents").toString().replaceAll(Const.IMAGE_REPLACE_DIR+param.get("today_temp"), "");
			param.put("contents", contents);
		}
	
	//	String today_temp = null; // 임시폴더 
		String img_name   = null; // 변경된 이미지 파일이름
		
		if(iList != null){
			for(int i = 0; i<iList.size(); i++){
			//	today_temp = iList.get(i).substring(0, iList.get(i).indexOf("/"));
				img_name   = iList.get(i).substring(iList.get(i).indexOf("/")+1, iList.get(i).length());
				
				ImageUpload.moveImageFile(Const.IMAGE_ORI_DIR+param.get("replaceDir").toString().trim()+img_name,
										  Const.IMAGE_ORI_DIR+img_name);
			}
		}
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		param.put("reg_date",sdf.format(today));
			
		return param;
	}
}
