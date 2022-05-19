<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>처방명 등록</title>	
	<script>
		function a_name_mod(){
			var ajax_url =  '/admin/item/dic/name_mod_proc.do';
			a_dic_proc(ajax_url);
		}//a_name_mod
		
		function a_name_add(){
			var ajax_url =  '/admin/item/dic/name_add_proc.do';
			a_dic_proc(ajax_url);
		}//a_name_mod
		
		
		function a_dic_proc(ajax_url){
			if(! valCheck('s_name','처방명을 입력하세요.')){
				return;
			}
			
			var queryString = $("form[name=name_frm]").serialize() ;
			$.ajax({
			    url: ajax_url,
			    type : "POST",
			    data : queryString,
	            dataType : 'json',
			    error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	alert(data.msg);
			    	
			    	if(data.suc){
			    		if(ajax_url == '/admin/item/dic/name_add_proc.do'){
			    			$("#nameGrid").trigger("reloadGrid",[{page : 1}]);
			    			$("#name_Form").dialog('close');
			    		}else{
			    			$("#nameGrid").trigger("reloadGrid");
			    			$("#name_mod_Form").dialog('close');
			    		}
			    		
			    		
			    	}
			    	
			    }
			});
		}// a_dic_proc
		
		
		$(document).ready(function() {
			$('#b_code').change(function() {
				$('#b_name').val( $("#b_code option:selected").text() );
			});
		});
		
	</script>
</head>
<body>
	
	<form name="name_frm" method="post" id="name_frm" >
		<input type="hidden" name="seqno"  id="seqno" value="${info.seqno }" />
		<input type="hidden" name="s_code" id="s_code" value="${info.s_code }" />
		<input type="hidden" name="b_name" id="b_name" value="${param.search_b_name}" />

		<table class="basic01">
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>출전</th>
					<td class="tdL">
						<select name="b_code" id="b_code" style="width:90%;">
							<c:forEach var="list" items="${group}">
								<option value="${list.b_code}" <c:if test="${list.b_code eq param.search_b_code }">selected="selected"</c:if>  >${list.b_name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>처방명</th>
					<td class="tdL"><input type=text name="s_name" id="s_name" size=40 maxlength=80 value="${info.s_name}" style="width:90%;"></td>
				</tr>
				<tr >
					<th>관련조문</th>
					<td class="tdL"><textarea name="s_jomun" id="s_jomun" rows=5 cols=85 wrap=hard >${info.s_jomun}</textarea></td>
				</tr>
				<tr>
					<th>적응증</th>
					<td class="tdL"><textarea name="s_jukeung" id="s_jukeung" rows=3 cols=85 wrap=hard >${info.s_jukeung}</textarea></td>
				</tr>
				<tr>
					<th>참고사항</th>
					<td class="tdL"><textarea name="s_chamgo" id="s_chamgo" rows=3 cols=85 wrap=hard >${info.s_chamgo}</textarea></td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>

