package kr.co.hany.util;


import java.io.*;

import kr.co.hany.common.Const;



public class FileUtil
{
	public static String[] extImage = {"jpg","gif","png"};
	public static String[] extDoc = {"hwp","doc","docx","ppt","pptx","xls","xlsx","pdf"};
	public static String[] extMovie = {"avi","mov","mp4"};
	public static String[] extSound = {"wav","mp3"};
	public static String[] ext = combineExt();
	
	public static String[] combineExt() {
		
		int extSize = extImage.length + extDoc.length + extMovie.length + extSound.length;
		 
		String[] arr = new String[extSize];
 
		System.arraycopy(extImage, 0, arr, 0, extImage.length); 
		System.arraycopy(extDoc, 0, arr, extImage.length, extDoc.length);
		System.arraycopy(extMovie, 0, arr, extImage.length+extDoc.length, extMovie.length);
		System.arraycopy(extSound, 0, arr, extImage.length+extDoc.length+extMovie.length, extSound.length);
 
		return arr;
	}

    public FileUtil()
    {
    }

    public File getFile(String path,String fname)
    {
        try
        {
            if (existFile(path,fname))
            {
                File f = new File(path,fname);

                return f;
            }
            else 
            {
                return null;
            }
        }
        catch(Exception e)
        {
            return null;
        }
    }

    public boolean existDirectory(String path)
    {
        boolean i = false;

        try
        {
            File f = new File(path);
            i = f.exists();
        }
        catch(Exception e)
        {
            i = false;
        }
        return i;
	   }
	
    public static boolean existFile(String path, String filename)
    {
        boolean i =false;
       
        try
        {
            File f = new File(path, filename);
            i = f.exists();
        }
        catch(Exception e)
        {
            i = false;
        }
        return i;
    }
	
    public void mkdir(String dir){
    	File dir_check = new File(dir);
		if(!dir_check.exists()) {
			dir_check.mkdirs();
		}
    }
    
    public boolean createDirectory(String path)
    {
        boolean i = false;

        try
        {
            File f = new File(path);
      	    i = f.mkdir();
        }
        catch(Exception e)
        {
            i =false;
        }
        return i;
    }

    public static boolean delFile(String path,String name)
    {
        boolean i = false; 
        try
        {
            File f = new File(path+name);

            if(existFile(path,name))
            {
                f.delete();
                i = true;
            }
        }
        catch(Exception e)
        {
            i = false;
        }
        return i;
    }
    
    
     public static boolean delFile(String fileName)
     {
    	 String path = null;
    	
    	 boolean i = false; 
         try
         {
         		path = Const.Dir;
        	 
             File f = new File(path+fileName);

             if(existFile(path,fileName))
             {
                 f.delete();
                 i = true;
             }
         }
         catch(Exception e)
         {
             i = false;
         }
         return i;
     }
    
    

    public boolean delDirectory(String path)
    {
        boolean i = false;
        try
        {
        	File f = new File(path);

            if(existDirectory(path))
            {
                f.delete();
                i = true;
            }
        }
        catch(Exception e)
        {
            i = false;
        }
        return i;
    }

    public long getFileSize(String path,String name)
    {
         long i=0;
         if(name.equals("") || name == null || name.toUpperCase().equals("NULL")) return 0;

         try
         {
             File f = new File(path+name);

             if(existFile(path,name))
             {
                 i = f.length();
             }
             else
             {
                 i = 0;
             }      
         }
         catch(Exception e)
         {
             i = 0;
         }

         return i;
    }

    public String getFileName(File file)
    {
         String FName = "";
         try
         {
             if(file == null) return "";

             if(file.exists())
             {
                 FName = file.getName();
             }
             else
             {
                 FName= "";
             }
         }
         catch(Exception e)
         {
             FName = "";
         }      
         return FName;
    }
    
    
    public static boolean isValidFileExtension( String fileName ,String[] extensions) throws Exception{
        boolean result = false;
        if( fileName != null && !"".equals( fileName ) && !isContainFileExtension(fileName, extensions)) {
            result = false;
        }
        else {
            result = true;
        }
        return result;
    }
	
    private static boolean isContainFileExtension( String fileName, String[] extensions ) throws Exception{
        boolean result = false;
        String fileExtension = getFileExtension( fileName );
        for( String ex : extensions ) {
            if( fileExtension.equals( ex ) ) {
                result = true;
                break;
            }
        }
        return result;
    }
    
    public static String getFileExtension( String fileName ) throws Exception{
        String fileExtension = "";
        if( fileName != null && !"".equals( fileName )) {
            if( fileName.lastIndexOf( "." ) != -1){
                fileExtension = fileName.toLowerCase().substring( fileName.lastIndexOf( "." ) + 1, fileName.length() );
            }
            else {
                fileExtension = "";
            }
        }else{
            fileExtension = "";
        }
        
        return fileExtension;
    }
    
    public static String getFileNameWithoutExtension(String fileName) {
    	int index = fileName.lastIndexOf('.');
    	if (index>0&& index <= fileName.length() - 2 ) {
    		return fileName.substring(0, index);
    	}  
    	
    	return "";
    }

}
