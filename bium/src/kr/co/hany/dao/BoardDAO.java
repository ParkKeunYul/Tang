package kr.co.hany.dao;

import java.util.List;
import java.util.Map;

import kr.co.hany.util.CommonMap;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardDAO {
	
	//본문처리
	public int getMaxSeq();
	public List<Map<String, Object>> noticeList(@Param("param")CommonMap param);
	public List<Map<String, Object>> list(@Param("param")CommonMap param);
	public List<Map<String, Object>> list2(@Param("param")CommonMap param);
	public List<Map<String, Object>> minilist(@Param("board_name")String board_name);
	public int listCount(@Param("param")CommonMap param);
	public int listCount2(@Param("param")CommonMap param);
	public int insert(@Param("param")CommonMap param);
	public void increaseHit(@Param("param")CommonMap param);
	public Map<String, Object> view(@Param("param")CommonMap param);
	public Map<String, Object> rep_view(@Param("rep_seq")int rep_seq);
	public String maxLevel(@Param("param")Map<String, Object> param);
	public void plus_ref_level (@Param("param")CommonMap param);
	
	
	
	public void del(@Param("param")CommonMap param);
	public void update(@Param("param")CommonMap param);
	public void remodify(@Param("param")CommonMap param);
	public List<Map<String, Object>> viewKin(@Param("param")CommonMap param);
	
	
	// 파일처리
	public List<Map<String, Object>> filelist(@Param("param")CommonMap param);
	public void fileinsert(@Param("param")Map<String, Object> param);
	public Map<String, Object> fileView(@Param("param")CommonMap param);
	public void delFileInfo(@Param("param")CommonMap param);
	public void AlldelFileInfo(@Param("param")CommonMap param);
	public List<Map<String, Object>> delfileInfo(@Param("seq")String seq);
	public void deletefile(@Param("seq")String seq);
	public Map<String, Object> filecount(@Param("param")CommonMap param);
	
	
	
	// 댓글처리
	public int getMaxComment_seq();
	public int commentinsert(@Param("param")CommonMap param);
	public void commentdel(@Param("seq") String seq);
	public void commentAlldel(@Param("param")CommonMap param);
	public List<Map<String, Object>> commentlist(@Param("param")CommonMap param);
	public List<Map<String, Object>> commentpagelist(@Param("param")CommonMap param);
	public int clistCount(@Param("param")CommonMap param);
	public void commentModify (@Param("param")CommonMap param);
	public Map<String, Object> commentView(@Param("param")CommonMap param);
	
	
	// 학사일정
	public List<Map<String, Object>> schedule_list(@Param("param")CommonMap param);
	public int schedule_listCount(@Param("param")CommonMap param);
	public void schedule_writePro(@Param("param")CommonMap param);
	public void schedule_delPro(@Param("param")CommonMap param);
	public Map<String, Object> schedule_view(@Param("param")CommonMap param);
	public void schedule_modifyPro(@Param("param")CommonMap param);
	public List<Map<String, Object>> schedule_termList(@Param("param")CommonMap param);
}
