<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<script>
	function manage_add(){			
		//$("#jqGrid").trigger("reloadGrid");
		
		if(! valCheck('a_name','관리자 이름을 입력해 주세요')){
			return;
		}
		
		if(! valCheck('a_id','아이디를 입력해 주세요.')){
			return;
		}
		
		if(! valCheck('a_pass','비밀번호를 입력해 주세요.')){
			return;
		}
		
		if(! valCheck('a_email','이메일을 입력해 주세요.')){
			return;
		}
		
		var queryString = $("form[name=frm]").serialize() ;
		
		$.ajax({
			url: '/admin/base/manage/add_proc.do',
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
				<th>이름</th>
				<td class="tdL"><input type=text name=a_name id="a_name" size=20 maxlength=80 style="width:250px;"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td class="tdL"><input type=text name=a_id id="a_id" size=20 maxlength=80 style="width:250px;"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td class="tdL"><input type=password name=a_pass id="a_pass" size=20 maxlength=80 style="width:250px;" ></td>
			</tr>
			<tr>
				<th>핸드폰</th>
				<td class="tdL">
					<select name="a_hp01" id="a_hp01" style="width: 80px;">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select> - 
					<input type=text name=a_hp02 size=6 maxlength=80>- 
					<input type=text name=a_hp03 size=6 maxlength=80>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td class="tdL"><input type=text name=a_email id="a_email" size=30 maxlength=80 style="width:350px;"></td>
			</tr>
			<tr>
				<th>등급</th>
				<td class="tdL">
					<select name="a_level" id="a_level">
						<option value="">등급선택</option>
						<option value="1">레벨1</option>
						<option value="2">레벨2</option>
						<option value="3">레벨3</option>
						<option value="4">레벨4</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>메모</th>
				<td class="tdL"><textarea name=a_contents id="a_contents" rows=5 cols=65 wrap=hard style="border:1 solid BABBBA;"></textarea></td>
			</tr>
			<%-- <tr>
				<td  align=center colspan=2>
					<a href="javascript:write_check();">등록</a>	
					&nbsp;<a href='javascript:history.back();'>닫기</a>
				</td>
			</tr> --%>
		</tbody>
	</table>
</form>

