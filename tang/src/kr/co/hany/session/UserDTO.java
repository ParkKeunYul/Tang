package kr.co.hany.session;

import java.util.Map;
import java.lang.reflect.Field;

public class UserDTO {
	private int idx;
	private String id;
	private String name;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	/*public UserDTO(Map<String, Object> adminInfo) {
		this.idx = Integer.parseInt(adminInfo.get("IDX").toString());
		this.id = adminInfo.get("ID").toString();
		this.name = adminInfo.get("NAME").toString();
		
		Class<?> cls = this.getClass();    //testDto�?class??주입?�킵?�다.
		Field[] fields;
		fields = cls.getFields();
		System.out.println("length="+fields.length);
		for ( int i = 0; i < fields.length; ++i ) {
			Object value = adminInfo.get(fields[i].getName().toUpperCase());
			System.out.println("value="+value+";field="+fields[i].toString());
			if(value!=null)
				try {
					fields[i].set(this,value.toString());
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
		}
	}*/
	
	
}
