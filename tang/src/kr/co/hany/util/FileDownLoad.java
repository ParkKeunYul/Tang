package kr.co.hany.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class FileDownLoad {
	
	public static void downLoad( String rename 
			                                ,String ori_name
											,String url
											,HttpServletRequest request
											,HttpServletResponse response){
		FileInputStream fin = null;
		OutputStream os 	  = null;
		File file 			      = null;
		boolean skip 		  = true;
		try{
		
			String file_name = rename;
			
			try{
				file = new File (url+file_name);
				fin = new FileInputStream(file);	
			}catch(Exception e){
				skip = false;
			}
			
			if(skip){
				String agentType = request.getHeader("User-Agent");
				if (agentType.indexOf("MSIE 5.5") != -1){
					response.setContentType("doesn/matter; charset=utf-8");
					response.setHeader("Content-Disposition", "attachment; filename=" + ori_name+";");
				}else{
					response.setContentType("application/smnet");
					response.setHeader("Content-Type", "application/x-msdownload; charset=utf-8;");
					response.setHeader("Content-Disposition","attachment; filename=" +new String(ori_name.getBytes("EUC-KR"),"ISO-8859-1") + ";");
				}
				
				response.setHeader("Content-Transfer-Encoding","binary;");
				response.setHeader("Content-Length",""+file.length());
				response.setHeader("Pragma","no-cache;");
				response.setHeader("Expires","-1;");
				
				
				
				os = response.getOutputStream();
				byte[] abStream = new byte[4096];
				int leng = 0;
				while((leng = fin.read(abStream)) > 0){
					os.write(abStream, 0, leng);
					os.flush();
				}
			}else{
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().println("<script language='javascript'>");
				response.getWriter().println("		alert('파일이 존재하지 않습니다');");
				response.getWriter().println("		history.back(-1);");
				response.getWriter().println("</script>");
			}
		}catch (Exception e) {
			if(e.getClass().getName().equals("org.apache.catalina.connector.ClientAbortException")){
				System.out.println("사용자 파일다운로드 취소");
			}else{
				e.printStackTrace();
			}
		}finally{
			if(fin != null)try {fin.close();} catch (IOException e) {e.printStackTrace();}
			if(os != null)try {os.close();} catch (IOException e) {e.printStackTrace();}
		}
	}
	
	
	public static void downLoad( String filename 
											,String url
											,HttpServletRequest request
											,HttpServletResponse response){
		FileInputStream fin = null;
		OutputStream os 	  = null;
		File file 			      = null;
		boolean skip 		  = true;
		try{
			
			String file_name = filename;
			
			try{
				file = new File (url+file_name);
		    	fin = new FileInputStream(file);	
			}catch(Exception e){
				skip = false;
			}
			
		  if(skip){
			    String agentType = request.getHeader("User-Agent");
			    if (agentType.indexOf("MSIE 5.5") != -1){
			        response.setContentType("doesn/matter; charset=utf-8");
			        response.setHeader("Content-Disposition", "attachment; filename=" + file_name+";");
			    }else{
					response.setContentType("application/smnet");
					response.setHeader("Content-Type", "application/x-msdownload; charset=utf-8;");
				    response.setHeader("Content-Disposition","attachment; filename=" +new String(file_name.getBytes("EUC-KR"),"ISO-8859-1") + ";");
			    }

			    response.setHeader("Content-Transfer-Encoding","binary;");
			    response.setHeader("Content-Length",""+file.length());
			    response.setHeader("Pragma","no-cache;");
			    response.setHeader("Expires","-1;");
			    
			    
			    os = response.getOutputStream();
			    byte[] abStream = new byte[4096];
			    int leng = 0;
			    while((leng = fin.read(abStream)) > 0){
			        os.write(abStream, 0, leng);
			        os.flush();
			    }
		    }else{
		    	response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html;charset=UTF-8");
		    	response.getWriter().println("<script language='javascript'>");
		    	response.getWriter().println("		alert('파일이 존재하지 않습니다');");
		    	response.getWriter().println("		history.back(-1);");
		    	response.getWriter().println("</script>");
		    }
		}catch (Exception e) {
			if(e.getClass().getName().equals("org.apache.catalina.connector.ClientAbortException")){
				System.out.println("사용자 파일다운로드 취소");
			}else{
				e.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			if(fin != null)
				try {fin.close();} catch (IOException e) {e.printStackTrace();}
		 	if(os != null)
				try {os.close();} catch (IOException e) {e.printStackTrace();}
		}
	}
}
