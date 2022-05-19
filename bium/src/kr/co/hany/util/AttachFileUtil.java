package kr.co.hany.util;


import java.io.*;

public class AttachFileUtil
{
	public AttachFileUtil()
   	{
        fileName = "";
        ismove =true;
   	}

    FileUtil fu = new FileUtil();

    private String fileName;
    private boolean ismove = false;

    
	public String writeFile(String oldPath,String fname,String path,String cp)
    {
        File file;
        try
        {
            if(fname.length() < 1) return "";

            if(fu.existFile(oldPath,fname))
            {
                fileName = fname;
                file = new File(oldPath,fname);

                writeFile(file,path,cp);
            }
            else
            {
                fileName = "";
            }
        }
        catch(Exception e)
        {
        }

        return fileName;
    }

	public String writeFile(File file,String path,String cp)
    {

        try
        {
             if(file == null) return "";

             fileName = fu.getFileName(file);

             if(cp.equals("mv"))
             {
                 moveFile(file,path);
             }
             else
             {
                 copyFile(file,path,cp);
             }
        }
        catch(Exception e)
        {

        }
        return fileName;
    }


    public boolean delDir(String path)
    {
        String newDirectory = "";
        int i = 0;
        try
        {
            if(fu.existDirectory(path))
            {
                File f = new File(path);
                
                delDir(f.listFiles());
                
                if(ismove)
                {
                    ismove = f.delete();
                }
            }
        }
        catch(Exception e)
        {
            ismove = false;
        }
        return ismove;
    }

    public void delDir(File fl[]) throws Exception
    {
        String currentName = "";
        String newp = "";
        int idx = 0;
        try
        {
            for(int j=0; ismove && j < fl.length; j++)
            {
                if(fl[j].isDirectory())
                {
                    delDir(fl[j].listFiles());
                    ismove = fl[j].delete();                
                }
                else
                { 
                    ismove = fl[j].delete();
                }
                
            }
            ismove = true;
            
        }
        catch(Exception e)
        {
            ismove =false;
        }
    }


    public boolean moveDir(String oldPath, String newPath, String cp)
    {
        String newDirectory = "";
        int i = 0;
        try
        {
            if(fu.existDirectory(oldPath))
            {
                i = oldPath.lastIndexOf(File.separator);
                newDirectory = oldPath.substring(i+1);

                File oldFile = new File(oldPath);
                newPath = chkSeparator(newPath);
                newPath = newPath + newDirectory; 

                fu.createDirectory(newPath);
                mvDir(oldFile.listFiles(),newPath,newDirectory,cp);

                if(cp.equals("mv"))
                {
                    fu.delDirectory(oldPath);
                }
            }
        }
        catch(Exception e)
        {
            ismove = false;
        }
        return ismove;
    }
    
    public void copyDriectory(File source , File target)throws IOException{
    	if(source.isDirectory()){
    		if(!target.exists()){
    			target.mkdir();
    		}
    	
	    	String[] child = source.list();
	    	for(int i = 0; i<child.length;i++){
	    		copyDriectory(new File(source, child[i]),new File(target, child[i]) );
	    	}
    	}
    	else{
    		InputStream in = new FileInputStream(source);
    		OutputStream out = new FileOutputStream(target);
    		
    		byte[] buf = new byte[1024];
    		
    		int len;
    		
    		while ((len = in.read(buf)) > 0) {
    			out.write(buf, 0, len);
			}
    		in.close();
    		out.close();
    	}
    }
    
    public void mvDir(File fl[],String target,String root,String cp)
    {
        String currentName = "";
        String newp = "";
        int idx = 0;
        try
        {
            for(int j=0; j < fl.length; j++)
            {
                if(fl[j].isDirectory())
                {
                    currentName = fl[j].getAbsolutePath();
                    idx = currentName.indexOf(root);
                    currentName = currentName.substring(idx+root.length()+1);

                    target = chkSeparator(target);
                    newp = target + currentName; 
                    ismove = fu.createDirectory(newp);

                    mvDir(fl[j].listFiles(),target,root,cp);
                    if(cp.equals("mv"))
                    {
                        fl[j].delete();
                    }
                }
                else
                {
                    fileName = fl[j].getName();
                    idx =  fl[j].getAbsolutePath().indexOf(root);
                    String temppath = fl[j].getAbsolutePath().substring(idx+root.length(),fl[j].getAbsolutePath().length()-(fileName.length()+1));
                    
                    if(cp.equals("cp"))
                    {
                        copyFile(fl[j],target + temppath,cp);
                    }
                    else
                    {
                        moveFile(fl[j],target + temppath);
                    }
                }
                
            }
            ismove = true;
        }
        catch(Exception e)
        {
            ismove =false;
        }
    }


    public boolean copyDir(String oldPath, String newPath, String cp)
    {
        boolean ismove = true;
        int i = 0;

        try
        {

            if(fu.existDirectory(oldPath))
            {
                File oldFile = new File(oldPath);

                File f2[] = oldFile.listFiles();

                fu.createDirectory(newPath);

                if(f2 != null && f2.length > 0)
                {
                    for(int j=0; j < f2.length; j++)
                    {
                        
                        copyFile(f2[j],newPath,cp);
                    }
                }
            }
        }
        catch(Exception e)
        {
            ismove = false;
        }
        return ismove;
    }

    public void moveFile(File file,String path) throws Exception
    {
        String fileName2 = "";
        try
        {
            path = chkSeparator(path);

       		if(!fu.existDirectory(path))
        	{
                fu.createDirectory(path);
        	}

            if(fu.existFile(path,fileName)) 
            {
                 fileName2 = makeFileName(path,fileName);
              
                while(fu.existFile(path,fileName2))
                {
                     fileName2 = makeFileName(path,fileName2);
                }
            }
            else
            {
                 fileName2 = fileName;    
            }

            File file2 = new File(path,fileName2);

            file.renameTo(file2);  

        }
        catch(Exception e)
        {

        }
    }

   	public void copyFile(File file,String path,String cp)
   	{
        boolean imsi = true;
  		String fileName2 = "";

      	try 
        {
            fileName = file.getName();

            //�����н� �ڿ� separator�� �ִ��� Ȯ���Ѵ�.
            path = chkSeparator(path);
            


       		if(!fu.existDirectory(path))
        	{
                fu.createDirectory(path);
        	}

            if(fu.existFile(path,fileName)) 
            {
                fileName2 = makeFileName(path,fileName);
                while(fu.existFile(path,fileName2))
                {
                     fileName2 = makeFileName(path,fileName2);
                }
            }
            else
            {
                 fileName2 = fileName;    
            }


         	FileInputStream filestream = new FileInputStream(file);
            FileOutputStream outStream = new FileOutputStream(path + fileName2);

            byte [] b = new byte[1024];
            int numRead = filestream.read(b);
            
            while(numRead  != -1 ){
                outStream.write(b, 0, numRead);
                numRead = filestream.read(b);
            }
            
            outStream.flush();
            outStream.close();
            if(filestream != null) filestream.close(); 

            if(cp.equals("mv"))
            {
                file.delete();
            }
        }
        catch(Exception e)
        {
        }
       	finally 
        {
	    }
    }

   	public String makeFileName(String path,String fname)
   	{
        String newName = "";
        String tt = "000";
        int i = 0;
        int j = 0;

        try
        {

            i = fname.lastIndexOf("_");
            j = fname.lastIndexOf(".");

            if(fname.lastIndexOf("_") < 0)
            {
                newName = fname.substring(0,j) + "_002" + fname.substring(j);
            }
            else
            {
                int k = Integer.parseInt(fname.substring(i+1,j));
                k += 1;  
                tt = tt + Integer.toString(k); 
                tt = "_" +tt.substring(tt.length()-3);  

                newName = fname.substring(0,i) + tt + fname.substring(j);
            }

        }
        catch(Exception e)
        {
            try
            {
                newName = fname.substring(0,j) + "_002" + fname.substring(j);
            }
            catch(Exception ee)
            {
                newName = fname;
            }

            
        }
        return newName;
    }

    public String chkSeparator(String path)
    {
        String tempp = "";
        try
        {
            tempp = path;
            if(!tempp.substring(tempp.length()-1,tempp.length()).equals(File.separator))
            {
                tempp = tempp + File.separator;
            }
        }
        catch(Exception e)
        {

        }
        return tempp;
    }
   
    public   static void copyTransfer(String srcFile, String destFile) throws Exception{
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
			System.err.println(e.getMessage());
		}finally{
			fis.close();
			bis.close();
			fos.close();
			bos.close();
		}
		
		
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
    
}
