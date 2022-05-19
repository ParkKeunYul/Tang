<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script charset="utf-8">
	var oEditors = [];
	
	
	$(document).ready(function() {
		
	});
	
	function a_board_mod(){
		var ajax_url =  'mod_proc.do';
		a_board_proc(ajax_url);
	}//a_name_mod
	
	function a_board_add(){
		
		var ajax_url =  'add_proc.do';
		a_board_proc(ajax_url);
	}//a_name_mod
	
	
	function a_board_proc(ajax_url){
		
		console.log(ajax_url);
		

		if(!valCheck('title','제목을 입력하세요')) return false;
		
		if( !confirm('저장하시겠습니까?') ){
			return false;			
		}
		
		var queryString = $("form[name=board_frm]").serialize() ;
		
		$('#board_frm').ajaxForm({		        
			url : ajax_url,
	        enctype : "multipart/form-data",
	        beforeSerialize: function(){
	             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
	        },
	        beforeSubmit : function() {
	        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
	        },

	        success : function(data) {		             
	            //console.log("data =  ", data);
	            alert(data.msg);
	            if(data.suc){
	            	 if(ajax_url == 'add_proc.do'){
	            		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
	            		$("#addForm").dialog('close');
	            	}else{
	            		$("#jqGrid").trigger("reloadGrid");
	            		$("#modForm").dialog('close');
	            	}
	            }
	        }		        
	    });	
		$("#board_frm").submit();
	}// a_board_proc
	
	
	function downloadBoard(ori_name 
			              ,rename
			              ,path){
		var url = "/download.do?path="+path+"&filename="+ori_name+"&refilename="+rename;
		location.href=url;
			
	}	
</script>


<form action="" id="board_frm" name="board_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seq"  id="seq"  value="${add_bean.seq }">

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>설명</th>
				<td class="tdL"><input type="text" name="title" id="title" value="${add_bean.title}" style="width: 90%;" /></td>
			</tr>
			<tr>
				<th>링크</th>
				<td class="tdL">
				http://<input type="text" name="link" id="link" value="${add_bean.link}" style="width: 90%;" /></td>
			</tr>
			<tr>
				<th>노출여부</th>
				<td class="tdL">
					<select name="use_yn" id="use_yn" style="width: 50%;">
					<option value="Y" <c:if test="${add_bean.use_yn eq 'Y' }">selected="selected"</c:if>>예</option>
					<option value="N" <c:if test="${add_bean.use_yn eq 'N' }">selected="selected"</c:if>>아니오</option>
				</select>
				</td>
			</tr>
			<tr>
				<th>배너링크 본창 여부</th>
				<td class="tdL">
					<select name=target id="target" style="width: 50%;">
						<option value="Y" <c:if test="${info.target eq 'Y' }">selected="selected"</c:if>>본창이동</option>
						<option value="N" <c:if test="${info.target eq 'N' }">selected="selected"</c:if>>새창이동</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>배너 정렬순위</th>
				<td class="tdL"><input type="text" name="sort_seq" id="sort_seq" value="${add_bean.sort_seq}" style="width: 50px;" /></td>
			</tr>
			<tr>
				<th>배너이미지 240 X 410</th>
				<td class="tdL">
					<input type="file" name="file" size=22 maxlength=80  style="width: 90%;">
					<c:if test="${not empty add_bean.ori_name }">
						  <img src='/upload/banner/${add_bean.re_name }' width='200px;' height='410px;' />
					</c:if>
					<input type="hidden" name="pre_ori_name" value="${add_bean.ori_name }" />
					<input type="hidden" name="pre_re_name" value="${add_bean.re_name }" />
				</td>
			</tr>		
		</tbody>
	</table>
	<%-- <a href="write?ref=${view.REF}&ref_level=${view.REF_LEVEL+1}&ref_step=${view.REF_STEP+1}&board_name=${bean.board_name}&seq=${bean.seq}&page=${bean.page}&pagelistno=${bean.pagelistno}<c:if test="${! empty bean.search_value }">&search_title=${bean.search_title}&search_value=${bean.search_value}</c:if>" class="button">답글쓰기</a> --%>
	
</form>
	
