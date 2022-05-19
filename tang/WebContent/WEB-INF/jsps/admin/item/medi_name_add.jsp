<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>약재명 등록</title>	
	<script>
		function a_name_add(){	
			var ajax_url = "/admin/item/medi/name_add_proc.do";	
			a_item_proc(ajax_url);
		}
		
		function a_name_mod(){
			var ajax_url = "/admin/item/medi/name_mod_proc.do";
			a_item_proc(ajax_url);
		}
		
		function a_item_proc(ajax_url){
			if(! valCheck('group_code','약재그룹을 선택해 주세요.')){
				return;
			}
			
			if(! valCheck('yak_name','약재명을 입력해 주세요.')){
				return;
			}
			
			if(! valCheck('yak_danga','g당 단가를 입력해 주세요.')){
				return;
			}
			
			$('#name_frm').ajaxForm({		        
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
		            	if(ajax_url == '/admin/item/medi/name_add_proc.do'){
		            		$("#nameGrid").trigger("reloadGrid",[{page : 1}]);	
		            		
		            		setTimeout(function(){
		            			$("#allGrid").trigger("reloadGrid",[{page : 1}]);
		                   	},800);
		            		
		            	}else{
		            		$("#nameGrid").trigger("reloadGrid");
		            		
		            		setTimeout(function(){
		            			$("#allGrid").trigger("reloadGrid");
		                   	},800);
		            	}
			    		$("#name_Form").dialog('close');
		            }
		        }		        
		    });	
			$("#name_frm").submit();
		}
		
		$(document).ready(function() {
			$('#group_name').change(function() {
				
				$('#group_name').val( $("#group_name option:selected").text() );
			});
		});
	</script>
</head>
<body>
	
<form name="name_frm" method="post" id="name_frm" enctype="multipart/form-data" >
	<input type="hidden" name="seqno" id="seqno" value="${info.seqno }" />
	<input type="hidden" name="yak_code" id="yak_code" value="${info.yak_code }" />
	<input type="hidden" name="group_name" id="group_name" value="${param.search_group_name}" />
	<input type="hidden" name="pre_yak_danga"  value="${info.yak_danga}" />
	
	
	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>약재그룹</th>
				<td class="tdL">
					<select name="group_code" id="group_code" style="width:200px;">
						<c:forEach var="list" items="${group}">
							<option value="${list.group_code}" <c:if test="${list.group_code eq param.search_group_code }">selected="selected"</c:if>  >${list.group_name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>약재명</th>
				<td class="tdL"><input type=text name="yak_name" id="yak_name"size=30 maxlength=80 style="width:200px;" value="${info.yak_name }" ></td>
			</tr>
			<tr>
				<th>원산지</th>
				<td class="tdL"><input type=text name="yak_from" id="yak_from"size=30 maxlength=80 style="width:200px;" value="${info.yak_from }" ></td>
			</tr>
			<tr>
				<th>기본값</th>
				<td class="tdL"><input type=text name="yak_made" id="yak_made" size=3 maxlength=80 style="width:200px;" value="${info.yak_made }" > 소문자 'y'</td>
			</tr>
			<tr>
				<th>g/당 단가</th>
				<td class="tdL">
					<input type=text name="yak_danga" id="yak_danga" size=20 maxlength=80 style="width:200px;" value="${info.yak_danga }">&nbsp;<!--<a href="javascript:g_sum();">[계산]</a>-->
					[ 마지막 가격수정일${info.price_update} ]
				</td>
			</tr>
			<tr>
				<th>위치</th>
				<td class="tdL"><input type=text name="yak_place" id="yak_place"  size=20 maxlength=60 style="width:200px;" value="${info.yak_place }"></td>
			</tr>
			<tr>
				<th>상태</th>
				<td class="tdL">
					<select name="yak_status" id="yak_status" style="width:200px;">
						<option value="y" <c:if test="${info.yak_status eq 'y' }">selected="selected"</c:if>>처방가능</option>
						<option value="n" <c:if test="${info.yak_status eq 'n' }">selected="selected"</c:if>>약재품절</option>
						<option value="c" <c:if test="${info.yak_status eq 'c' }">selected="selected"</c:if>>처방불가</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>약재사진</th>
				<td class="tdL">
					<input type="file" name="yak_image" id="yak_image" size=22 maxlength=80 style="width:350px;" >
					
					<c:if test="${not empty info.yak_image  }">
						<br/><img src='/upload/item/${info.yak_image}' width="300px;" height="300px;" />
					</c:if>
				</td>
			</tr>
			<tr>
				<th>약재설명</th>
				<td class="tdL"><textarea name="yak_contents" id="yak_contents" rows=10 cols=80 wrap=hard >${info.yak_contents}</textarea></td>
			</tr>
		</tbody>
	</table>
</form>
</body>
</html>

