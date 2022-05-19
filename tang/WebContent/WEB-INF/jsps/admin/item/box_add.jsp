<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
function a_box_add(){
	var ajax_url = "/admin/item/box/add_proc.do";
	a_box_proc(ajax_url);
}

function a_box_mod(){
	var ajax_url = "/admin/item/box/mod_proc.do";
	a_box_proc(ajax_url);
}

function a_box_proc(ajax_url){
	
	if(! valCheck('box_name','제품명을 입력하세요.')){
		return;
	}
	
	$("#a_box_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_box_frm = ', $("#a_box_frm").attr("action"));
	
	$('#a_box_frm').ajaxForm({		        
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
            	if(ajax_url == '/admin/item/box/add_proc.do'){
            		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
            		$("#addForm").dialog('close');
            	}else{
            		$("#jqGrid").trigger("reloadGrid");
            		$("#modForm").dialog('close');
            	}
            }
        }		        
    });	
	$("#a_box_frm").submit();
}
</script>

<form action="" id="a_box_frm" name="a_box_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>제품명</th>
				<td class="tdL"><input type=text name="box_name" id="box_name" size=30 maxlength=80 style="width:200px;" value="${add_param.box_name}" ></td>
			</tr>
			<tr>
				<th>규격</th>
				<td class="tdL"><input type=text name="box_size" size=30 maxlength=80 style="width:200px;" value="${add_param.box_size}" > 가로*세로*높이</td>
			</tr>
			<tr>
				<th>가격</th>
				<td class="tdL"><input type=text name="box_price" size=30 maxlength=80 style="width:200px;" value="${add_param.box_price}" > 원</td>
			</tr>
			<tr>
				<th>상태</th>
				<td class="tdL">
					<select name="box_status" style="width:200px;">
						<option value="y"  <c:if test="${add_param.box_status eq 'y' }">selected="selected"</c:if>>재고충분</option>
						<option value="n"  <c:if test="${add_param.box_status eq 'n' }">selected="selected"</c:if>>재고부족</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>전용여부</th>
				<td class="tdL">
					<select name="private_yn" style="width:200px;">
						<option value="y"  <c:if test="${add_param.private_yn eq 'y' }">selected="selected"</c:if>>예</option>
						<option value="n"  <c:if test="${add_param.private_yn eq 'n' }">selected="selected"</c:if>>아니오</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>설명</th>
				<td class="tdL"><textarea name="box_contents" rows=3 cols=80 wrap=hard >${add_param.contents}</textarea></td>
			</tr>
			<tr>
				<th>이미지1	</th>
				<td class="tdL">
					<input type="file" name="box_image" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.box_image }"><br/>${add_param.box_image} </c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>이미지2</th>
				<td class="tdL">
					<input type="file" name="box_image2" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.box_image2 }"><br/>${add_param.box_image2} </c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>이미지3</th>
				<td class="tdL">
					<input type="file" name="box_image3" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.box_image3 }"><br/>${add_param.box_image3} </c:if>
				</td>
			</tr>
		</tbody>
	</table>
</form>