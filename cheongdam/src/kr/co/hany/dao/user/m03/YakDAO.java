package kr.co.hany.dao.user.m03;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import kr.co.hany.dao.DefaultDAO;
import kr.co.hany.util.CommonMap;

@Repository
public class YakDAO  extends DefaultDAO{
	public String NAMEPSACE = "YakDAO.";
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> list(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"list", param);
	}
	
	public int listCount(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"listCount", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> goods_view(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"goods_view", param);
	}
	
	@SuppressWarnings("unchecked")
	public boolean add_cart(Map<String, Object> view) {
		try {
			Map<String, Object> cart_view = (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"cart_view", view);
			
			if(cart_view ==  null) {
				sqlSession.insert(NAMEPSACE+"add_cart", view);
			}else {
				view.put("seqno", cart_view.get("seqno"));
				sqlSession.update(NAMEPSACE+"mod_cart", view);
			}
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public int duple_cart(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"duple_cart", param);
	}
	
	public int unuse_goods(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"unuse_goods", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> goods_pay_view(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"goods_pay_view", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> select_option(CommonMap param)throws Exception{
		return sqlSession.selectList(NAMEPSACE+"select_option", param);
	}
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> select_pre_order(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"select_pre_order", param);
	}
	
	public boolean add_preorder(CommonMap param)throws Exception{
		try {
			sqlSession.update(NAMEPSACE+"add_preorder", param);
			sqlSession.insert(NAMEPSACE+"add_preorder_his", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}		
	}
	
	public boolean mod_preorder(CommonMap param)throws Exception{
		try {
			sqlSession.update(NAMEPSACE+"mod_preorder", param);
			sqlSession.insert(NAMEPSACE+"add_preorder_his", param);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}		
	}
	
	
	public int cart_cnt(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"cart_cnt", param);
	}
	
	public int order_cnt(CommonMap param)throws Exception{
		return (Integer)sqlSession.selectOne(NAMEPSACE+"order_cnt", param);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> select_point(CommonMap param)throws Exception{
		return (Map<String, Object>)sqlSession.selectOne(NAMEPSACE+"select_point", param);
	}
	
}
