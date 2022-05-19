<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<script>
	function manage_add(){			
		//$("#jqGrid").trigger("reloadGrid");
		
		if(! valCheck('group_nm','그룹명을 입력해 주세요')){
			return;
		}
	
		var queryString = $("form[name=frm]").serialize() ;
		
		$.ajax({
			url: 'add_proc.do',
			type : "POST",
			data : queryString,
			dataType : 'json',
			error: function(){
				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			},
			success: function(data){
				alert(data.msg);
				
				if(data.suc){
					$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
					$("#add_form").dialog('close');
				}				
			}
		});
		return;
	}
</script>

<form name=frm method=post id="frm">
	<table class="basic01">
		<colgroup>
			<col width="20%" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>그룹명</th>
				<td class="tdL"><input type=text name="group_nm" id="group_nm" size=20 maxlength=80 style="width:250px;"></td>
			</tr>
			<tr>
				<th>할인율(%)</th>
				<td class="tdL">
					<select name="sale_per" id="sale_per">
						 <c:forEach var="i" begin="0" end="99" varStatus="st">
						 	<option value="${i}">${i}</option>
						 </c:forEach>
					</select>				
				</td>
			</tr>						
		</tbody>
	</table>
</form>

