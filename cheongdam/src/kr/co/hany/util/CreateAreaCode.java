package kr.co.hany.util;

public class CreateAreaCode {
	public static String getAreaCode(String area){
		
		if(area.indexOf("강원도") != -1 || area.indexOf("강원") != -1|| area.indexOf("강원도도") != -1){
			return "3109";
		}else if(area.indexOf("세종특별자치시") != -1  || area.indexOf("세종시") != -1 || area.indexOf("세종") != -1){	
			return "3208";
		}else if(area.indexOf("경기도") != -1 || area.indexOf("경경기") != -1|| area.indexOf("경기") != -1|| area.indexOf("경기도도") != -1|| area.indexOf("경수원시") != -1|| area.indexOf("경용인시") != -1){
			return "3307";
		}else if(area.indexOf("경상남도") != -1 || area.indexOf("경남") != -1){
			return "3406";
		}else if(area.indexOf("경상북도") != -1 || area.indexOf("경북") != -1|| area.indexOf("경상북동") != -1){ // || area.indexOf("") != -1
			return "3505";
		}else if(area.indexOf("광주광역시") != -1|| area.indexOf("광주직할시") != -1|| area.indexOf("광주시") != -1|| area.indexOf("광주") != -1|| area.indexOf("광주광역시광역시") != -1){  //|| area.indexOf("") != -1
			return "3604";
		}else if(area.indexOf("부산광역시") != -1 || area.indexOf("부산시") != -1|| area.indexOf("부산직할시") != -1|| area.indexOf("부부산") != -1|| area.indexOf("부산") != -1){
			return "3703";
		}else if( (area.indexOf("대구광역시") != -1 || area.indexOf("대구") != -1)  ){
			return "3802";
		}else if(   area.indexOf("대전") != -1 ||area.indexOf("대전 중구") != -1 || area.indexOf("대전동구") != -1 || area.indexOf("대전광역시") != -1 || area.indexOf("댄전시") != -1 || area.indexOf("대전직할시") != -1 || area.indexOf("대전시") != -1|| area.indexOf("대전지") != -1  || area.indexOf("대전 서구") != -1 || area.indexOf("대전 동구") != -1  )  {
			return "3901";
		}else if(area.indexOf("서울특별시") != -1 || area.indexOf("서월시") != -1|| area.indexOf("서을") != -1|| area.indexOf("서울기") != -1|| area.indexOf("서울시") != -1|| area.indexOf("서울") != -1){			
			return "4009";
		}else if(area.indexOf("울산광역시") != -1 || area.indexOf("울산광영시") != -1 || area.indexOf("울산군") != -1 || area.indexOf("울산광영시") != -1 || area.indexOf("울상") != -1|| area.indexOf("울산시") != -1  || area.indexOf("울산") != -1){
			return "4108";
		}else if(area.indexOf("인천광역시") != -1 || area.indexOf("인천작할시") != -1|| area.indexOf("인천직할시") != -1|| area.indexOf("인처시") != -1|| area.indexOf("인천시") != -1|| area.indexOf("인천") != -1|| area.indexOf("인청시") != -1|| area.indexOf("인천광역시광역시") != -1){
			return "4207";
		}else if(area.indexOf("전라남도") != -1 || area.indexOf("전남") != -1 || area.indexOf("전만") != -1){
			return "4306";
		}else if(area.indexOf("전라북도") != -1 || area.indexOf("전북") != -1){
			return "4405";
		}else if(area.indexOf("제주 제주시") != -1 || area.indexOf("제주특별자치도") != -1 || area.indexOf("제주") != -1 ||area.indexOf("제주특별자치도") != -1 || area.indexOf("제주도") != -1|| area.indexOf("제주시") != -1){ // || area.indexOf("") != -1
			return "4504";
		}else if(area.indexOf("충청남도") != -1 || area.indexOf("충남") != -1){
			return "4603";
		}else if(area.indexOf("충청북도") != -1 ||area.indexOf("충청북동") != -1 ||area.indexOf("충무") != -1 ||area.indexOf("충북") != -1 ||area.indexOf("충청북동") != -1  ){
			return "4702";
		}else{
			return "4801";
		}
	}
}
