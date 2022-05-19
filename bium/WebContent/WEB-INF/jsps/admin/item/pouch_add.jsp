<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
function a_pouch_add(){
	var ajax_url = "/admin/item/pouch/add_proc.do";
	a_pouch_proc(ajax_url);
}

function a_pouch_mod(){
	var ajax_url = "/admin/item/pouch/mod_proc.do";
	a_pouch_proc(ajax_url);
}

function a_pouch_proc(ajax_url){
	
	if(! valCheck('pouch_name','제품명을 입력하세요.')){
		return;
	}
	
	$("#a_pouch_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_pouch_frm = ', $("#a_pouch_frm").attr("action"));
	
	$('#a_pouch_frm').ajaxForm({		        
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
            setTimeout(function(){
            	alert(data.msg);
                $('#jqGrid').jqGrid('clearGridData');
                if(data.suc){
                	if(ajax_url == '/admin/item/pouch/add_proc.do'){
                		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
                		$("#addForm").dialog('close');
                	}else{
                		$("#jqGrid").trigger("reloadGrid");
                		$("#modForm").dialog('close');
                	}
                }
       		},50);
            
        }		        
    });	
	$("#a_pouch_frm").submit();
}
</script>

<form action="" id="a_pouch_frm" name="a_pouch_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>제품명</th>
				<td class="tdL"><input type=text name="pouch_name" id="pouch_name" size=30 maxlength=80 style="width:200px;" value="${add_param.pouch_name}" ></td>
			</tr>
			<tr>
				<th>규격</th>
				<td class="tdL"><input type=text name="pouch_size" size=30 maxlength=80 style="width:200px;" value="${add_param.pouch_size}" > ml</td>
			</tr>
			<tr>
				<th>가격</th>
				<td class="tdL"><input type=text name="pouch_price" size=30 maxlength=80 style="width:200px;" value="${add_param.pouch_price}" > 원</td>
			</tr>
			<tr>
				<th>상태</th>
				<td class="tdL">
					<select name="pouch_status" style="width:200px;">
						<option value="y"  <c:if test="${add_param.pouch_status eq 'y' }">selected="selected"</c:if>>재고충분</option>
						<option value="n"  <c:if test="${add_param.pouch_status eq 'n' }">selected="selected"</c:if>>재고부족</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>설명</th>
				<td class="tdL"><textarea name="pouch_contents" rows=3 cols=80 wrap=hard >${add_param.pouch_contents}</textarea></td>
			</tr>
			<tr>
				<th>이미지1	</th>
				<td class="tdL">
					<input type="file" name="pouch_image" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.pouch_image }"><br/>${add_param.pouch_image} </c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>이미지2</th>
				<td class="tdL">
					<input type="file" name="pouch_image2" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.pouch_image2 }"><br/>${add_param.pouch_image2} </c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>이미지3</th>
				<td class="tdL">
					<input type="file" name="pouch_image3" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.pouch_image3 }"><br/>${add_param.pouch_image3} </c:if>
				</td>
			</tr>
		</tbody>
	</table>
</form>