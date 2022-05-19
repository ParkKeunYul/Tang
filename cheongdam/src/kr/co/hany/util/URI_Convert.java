package kr.co.hany.util;

import kr.co.hany.common.Const;


public class URI_Convert {
	
	public static String Converting(String uri){
		String tiles = uri.replaceAll(".do", ""); 
		if(uri.indexOf("/admin") == 0){
			tiles += Const.aTiles;
		}
		else{
			tiles += Const.uTiles;
		}
		
		return tiles;
	}
	
	
	public static String ConvertingTest(String uri){
		String tiles = uri.replaceAll(".do", ""); 
		return tiles;
	}
}
