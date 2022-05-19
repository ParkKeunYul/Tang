package kr.co.hany.handler;


import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;


public class CustomTypeHandler implements TypeHandler<Boolean>{


	public Boolean getResult(ResultSet rs, String columnName) throws SQLException {
        String s = rs.getString(columnName);
     //   System.out.println("getResult1  = "+s);
        return parseBoolean(s);
    }

    public Boolean getResult(ResultSet rs, int columnIndex) throws SQLException {
        String s = rs.getString(columnIndex);
      //  System.out.println("getResult2  = "+s);
        return parseBoolean(s);
    }

    public Boolean getResult(CallableStatement cs, int columnIndex)
        throws SQLException {
    	    	
        String s = cs.getString(columnIndex);

        return parseBoolean(s);
    }

    public void setParameter(PreparedStatement ps, int i, Boolean bool,
        JdbcType jdbcType) throws SQLException {

    //	System.out.println("setParameter  = "+bool);
    	
        ps.setString(i, parseString(bool));
    }

    private boolean parseBoolean(String s) {
    	
    //	System.out.println("parseBoolean = " + s);
    	
        if (s == null) {
            return false;
        }

        s = s.trim().toUpperCase();

        if (s.length() == 0) {
            return false;
        }

        return "T".equals(s);
    }

    private String parseString(Boolean bool) {
    	
    	String rtn = (bool != null && bool == true) ? "T" : "F";
    	
    	System.out.println("rtn = "+ rtn);
    	
        return rtn;
    }



}
