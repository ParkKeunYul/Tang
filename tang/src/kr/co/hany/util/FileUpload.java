package kr.co.hany.util;

import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Random;
import java.util.UUID;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.plugins.jpeg.JPEGImageWriteParam;
import javax.imageio.stream.ImageOutputStream;

import kr.co.hany.exception.FileUploadException;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.FileCopyUtils;


public class FileUpload {
	Logger log = Logger.getLogger(getClass());

	private MultipartFile multipartFile;
	private String realUploadPath;

	/**
	*조건에 맞는 파일을 업로드 한다.
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param file_extension 파일 학장자 (null : 모든확장자 가능)
	*@param forbid_extension 허가되지 않는 학장자(null : 모든 확장자 가능)
	*@param name_flag 파일명 변경여부 (0:같은파일존재시 덮어씀, 1:같은파일존재시 파일명에 번호붙임, 2:시스탬 랜덤값으로 파일명 변경)
	**@param saveFileName 저장 할 파일 명
	*@return file_name 저장되는 파일명
	*/
	
	
	public String upload(int limitSize, String[] file_extensions, String[] forbid_extension, char name_flag, String saveFileName) throws Exception {
		//String file_name = null;
		// 업로드 파일에 대한 기초정보를 얻는다.
	    // MultipartFile에 대한 API를 보면 얻을 수 있는 정보를 알 수 있다.
		if( multipartFile != null && multipartFile.getSize() > 0){
		    String originalFileName = multipartFile.getOriginalFilename();
		    String contentType = multipartFile.getContentType();
		    long fileSize = multipartFile.getSize();
		    
	     	// 스트림을 설정한다. 결국은 스트림으로 파일을 전송한다.
	     	InputStream inputStream = null;
	     	OutputStream outputStream = null;
	     	
		    //업로드 된 파일이 있다면..
		    if(fileSize > 0 && !originalFileName.equals("")){
				
		    	//파일사이즈 체크
				if(limitSize > 0 && fileSize > limitSize){
					String errorMsg = "제한된 파일용량을 초과하였습니다.[가능파일용량 "+limitSize+"byte]";
					log.info(errorMsg);
					throw new FileUploadException("FU001", errorMsg);
				}
			  
				
				String file_name1 = originalFileName;
				String file_ext = "";
			  
				 
				if(originalFileName.lastIndexOf('.')>-1){
					file_name1 = originalFileName.substring(0, originalFileName.lastIndexOf('.'));
					file_ext = originalFileName.substring(originalFileName.lastIndexOf('.')+1, originalFileName.length());
					file_ext = file_ext.toLowerCase();
				}
			  
				//허용 된 파일 확장자인지 체크
				if(file_extensions != null) {
					String extMsg = "";
					boolean file_isok = false;
					for(int i=0; i<file_extensions.length; i++){
						if(i!=0) extMsg += ", ";
						extMsg += file_extensions[i];
						if(!file_isok){
							if(originalFileName.toUpperCase().endsWith(file_extensions[i].toUpperCase())){
								file_isok = true;
							}
						}
					}
					
					if(!file_isok){
						String errorMsg = "업로드 가능한 파일 확장자가 아닙니다. ["+file_extensions+" 파일 만 가능]";
						log.info(errorMsg);
						throw new FileUploadException("FU002", errorMsg);
					}
				}
				
				//업로드 금지 된 파일 확장자인지 체크
				if(forbid_extension != null){
					for(int i=0; i<forbid_extension.length; i++){
						if(file_ext.equals(forbid_extension[i])){
							String errorMsg = "업로드 가능한 파일 확장자가 아닙니다. [ 확장자 "+forbid_extension[i]+" ]";
							log.info(errorMsg);
							throw new FileUploadException("FU003", errorMsg);
						}
					}
				}
				
				
				try {
			    	//저장 할 파일명이 지정되지 않았다면 원래 파일명 사용
					if(saveFileName.equals("")) saveFileName = originalFileName;
			    	File tempFile = new File(realUploadPath + "/" + saveFileName);
			     	//같은 파일이 있다면 파일명에 "_번호"를 붙인다.
			     	if(name_flag =='1'){
			     		if(tempFile.exists()){
				    		int i = 0;
				    		while(tempFile.exists()){
				    			i++;
				    			saveFileName = file_name1 + "_" + i + "." + file_ext;
				    			tempFile = new File(realUploadPath + "/" + saveFileName);
				    		}
				    	}
			     	}else if(name_flag=='2'){ //임의의 일련번호로 파일명을 만든다.
			    		UUID randomUUID = UUID.randomUUID();
			    		saveFileName = randomUUID + "." + file_ext;
			    		tempFile = new File(realUploadPath + "/" + saveFileName);
			     	}
			     	File realUploadDir = new File(realUploadPath); // 업로드 디렉토리도 받아뒀다.
			     
			     	// 업로드 되는 디렉토리가 없다면, 만들어준다.
			     	if( !realUploadDir.exists() ) realUploadDir.mkdirs();  
			     	
			     	inputStream = multipartFile.getInputStream();
			     	outputStream = new FileOutputStream( tempFile );
			     	FileCopyUtils.copy(inputStream, outputStream);
			     	
			  } catch(Exception e) {
				  e.printStackTrace();
				  String errorMsg = "파일 업로드중 에러가 발생하였습니다.";
				  log.error(errorMsg, e);
				  throw new FileUploadException("FU000", errorMsg);
			  } finally {
			    // 스트림을 반드시 닫는다.
				if(outputStream != null) {
				    outputStream.close();
				    inputStream.close();
				}
			  }
		  }
		}else{
			saveFileName = "";
		}
	  return saveFileName;
	}
	
	public void upload() throws Exception {
		upload(0,null,null,'0',"");
	}
	
	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize) throws FileNotFoundException, Exception {
		return upload(limitSize, null, null, '0', "");
	}
	
	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param file_name 저장되는 파일명
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize, String file_name) throws FileNotFoundException, Exception {
		return upload(limitSize, null, null, '0', file_name);
	}
	
	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param name_flag 파일명 변경여부 (0:같은파일존재시 덮어씀, 1:같은파일존재시 파일명에 번호붙임, 2:시스탬 랜덤값으로 파일명 변경)
	*@param file_name 저장되는 파일명
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize, char name_flag, String file_name) throws FileNotFoundException, Exception {
		return upload(limitSize, null, null, name_flag, file_name);
	}

	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param name_flag 파일명 변경여부 (0:같은파일존재시 덮어씀, 1:같은파일존재시 파일명에 번호붙임, 2:시스탬 랜덤값으로 파일명 변경)
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize, char name_flag) throws FileNotFoundException, Exception {
		return upload(limitSize, null, null, name_flag, "");
	}
	
	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param name_flag 파일명 변경여부 (0:같은파일존재시 덮어씀, 1:같은파일존재시 파일명에 번호붙임, 2:시스탬 랜덤값으로 파일명 변경)
	*@return file_name 저장되는 파일명
	*/
	public String upload(char name_flag) throws FileNotFoundException, Exception {
		return upload(0, null, null, name_flag, "");
	}
	
	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param name_flag 파일명 변경여부 (0:같은파일존재시 덮어씀, 1:같은파일존재시 파일명에 번호붙임, 2:시스탬 랜덤값으로 파일명 변경)
	*@return file_name 저장되는 파일명
	*/
	public String upload(char name_flag, String[] file_extensions) throws FileNotFoundException, Exception {
		return upload(0, file_extensions, null, name_flag, "");
	}	
	
	/**
	*조건에 맞는 파일을 업로드 한다.(같은 파일명이 있을 시 덮어 씀)
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param file_extension 파일 학장자 (null : 모든확장자 가능)
	*@param forbid_extension 허가되지 않는 학장자
	*@param file_name 저장되는 파일명
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize, String[] file_extensions, String[] forbid_extension, String file_name) throws FileNotFoundException, Exception {
		return upload(limitSize, file_extensions, forbid_extension, '0', file_name);
	}

	/**
	*조건에 맞는 파일을 업로드 한다.
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param file_extension 파일 학장자 (null : 모든확장자 가능)
	*@param file_name 저장되는 파일명
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize, String[] file_extensions, String file_name) throws FileNotFoundException, Exception {
		return upload(limitSize, file_extensions, null, '0', file_name);
	}

	/**
	*조건에 맞는 파일을 업로드 한다.
	*@param limitSize 파일제한 사이즈 (0:제한없음)
	*@param file_extension 파일 학장자 (null : 모든확장자 가능)
	*@param forbid_extension 허가되지 않는 학장자
	*@param name_flag 파일명 변경여부 (0:같은파일존재시 덮어씀, 1:같은파일존재시 파일명에 번호붙임, 2:시스탬 랜덤값으로 파일명 변경)
	*@return file_name 저장되는 파일명
	*/
	public String upload(int limitSize, String[] file_extensions, String[] forbid_extension, char name_flag) throws FileNotFoundException, Exception {
		return upload(limitSize, file_extensions, forbid_extension, name_flag, "");
	}

	public void fileDelete(String file_name){
		 File tempFile = new File(file_name);
		 try{
			 if(tempFile.exists()){
				 tempFile.delete();
			 }
		 }catch(Exception e){

		 }
	}

	public void setMultipartFile(MultipartFile multipartFile) {
		this.multipartFile = multipartFile;
	}
	public void setRealUploadPath(String realUploadPath) {
		this.realUploadPath = realUploadPath;
	}
	
	
	public static String renameFile(String filePath, String fileName, String tempfilePath){
		String reName = "";
		try{
			String file_type = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase().trim();
			
			StringBuffer cnumber = new StringBuffer();
			Random random = new Random();
			String chars[] = "1,2,3,4,5,6,7,8,9".split(",");
			for ( int i=0 ; i<5 ; i++ ) {            
				cnumber.append(chars[random.nextInt(chars.length)]);
			}
			
			Date today = new Date();
			SimpleDateFormat formater = new SimpleDateFormat("yyyyMMddHHmmss");
			reName = cnumber.toString()+""+formater.format(today)+System.currentTimeMillis()+"."+file_type;
			
			
			
			
			copyTransfer(tempfilePath+"/"+fileName, filePath+"/"+reName);
			
			// 썸네일 생성
			// filePath+"/thum/
			File dir_check = new File(filePath+"/thum/");
			if(!dir_check.exists()) {
				dir_check.mkdirs();
			}
			
			cropThumbnail(filePath+"/"+reName, filePath+"/thum/"+reName, 100, 75);
			//makeThumbnail(filePath+"/"+reName, filePath+"/thum/"+reName, 100, 75);
			
			DeleteFile(tempfilePath+"/"+fileName);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return reName;
	}
	
	public static boolean cropThumbnail(String inputPath, String outputPath, int width, int height){
		
		boolean result = false;
		
		//썸네일 자르기
		System.out.println("*************썸네일 CROP 시작***************");
		System.out.println("파일경로****************************"+inputPath);
		System.out.println("썸네일파일경로****************************"+outputPath);

		try {
			Thumbnails.of(inputPath).crop(Positions.CENTER).size(width,height).toFile(new File(outputPath));
			result = true;
			System.out.println("*************썸네일 CROP 성공***************");
		} catch (Exception e) {
			System.out.println("오류현상="+e.toString());
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public static  void DeleteFile(String file_name){
		 File tempFile = new File(file_name);
		 try{
			 if(tempFile.exists()){
				 tempFile.delete();
			 }
		 }catch(Exception e){

		 }
	}
	
	
	public  static void copyTransfer(String srcFile, String destFile) throws Exception{
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
		}catch(SecurityException e){
			e.printStackTrace();
		}finally{
			fis.close();
			bis.close();
			fos.close();
			bos.close();
		}
	}
	
	
	public static boolean makeThumbnail( String inputPath, String outputPath, int width, int height )
	{
		boolean result = false;
        try
        {
            BufferedImage inBi = ImageIO.read( new File( inputPath ) );

            if( inBi != null ){ 	// BMP 포맷 중 일부가 읽기 실패함.
	            int    srcWidth    = inBi.getWidth();
	            int    srcHeight   = inBi.getHeight();
	            double scaleWidth  = 1;
	            double scaleHeight = 1;

	            if(srcWidth>width||srcHeight>height){
	            	
	            	if( srcWidth > srcHeight ){
		                scaleWidth  = ( double )width / ( double )srcWidth;
		                scaleHeight = scaleWidth;
		                height      = ( int )( Math.floor( ( double )srcHeight * scaleWidth ) );
		            }
		            else{
		                scaleHeight = ( double )width / ( double )srcHeight;
		                scaleWidth  = scaleHeight;
		                height      = width;
		                width       = ( int )( Math.floor( ( double )srcWidth * scaleHeight ) );
		            }

		            AffineTransform atf = new AffineTransform();
		            atf.setToScale( scaleWidth, scaleHeight );
		
		            float quality = 1;
		
		            // 변환 후 파일
		            BufferedImage outBi = new BufferedImage( width, height, BufferedImage.TYPE_INT_RGB );
		            outBi.createGraphics().drawImage( inBi, atf, null );
		
		            ImageWriter imageWriter = null;
		            Iterator imageWriterIterator = ImageIO.getImageWritersByFormatName( "jpg" );
		            
		            if( imageWriterIterator.hasNext() ){
		                imageWriter = ( ImageWriter )imageWriterIterator.next();
		            }
		            
		            if( imageWriter == null ) {
		                System.err.println( "JPEGImageWriter not found." );
		            }
		            ImageOutputStream ios = ImageIO.createImageOutputStream( new File( outputPath ) );
		            imageWriter.setOutput( ios );
		            IIOImage iioImage = new IIOImage( outBi, null, null );
		            ImageWriteParam iwp = new JPEGImageWriteParam( null );
		            iwp.setCompressionMode( ImageWriteParam.MODE_EXPLICIT );
		            iwp.setCompressionQuality( quality );
		            imageWriter.write( null, iioImage, iwp );
		            
		            ios.close();    
		            imageWriter.dispose();
	            }else{
	            	copyTransfer(inputPath,outputPath);
	            }	            
	            result = true;
            }
        }catch( Exception e ){
            e.printStackTrace();
        }finally{
        }
        return result;
    }
	
}
