<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
function a_sty_add(){
	var ajax_url = "add_proc.do";
	a_sty_proc(ajax_url);
}

function a_sty_mod(){
	var ajax_url = "mod_proc.do";
	a_sty_proc(ajax_url);
}

function a_sty_proc(ajax_url){
	
	if(! valCheck('sty_name','제품명을 입력하세요.')){
		return;
	}
	
	$("#a_sty_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_sty_frm = ', $("#a_sty_frm").attr("action"));
	
	$('#a_sty_frm').ajaxForm({		        
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
	$("#a_sty_frm").submit();
}
</script>

<form action="" id="a_sty_frm" name="a_sty_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>제품명</th>
				<td class="tdL"><input type=text name="sty_name" id="sty_name" size=30 maxlength=80 style="width:200px;" value="${add_param.sty_name}" ></td>
			</tr>
			<tr>
				<th>규격</th>
				<td class="tdL"><input type=text name="sty_size" size=30 maxlength=80 style="width:200px;" value="${add_param.sty_size}" > </td>
			</tr>
			<tr>
				<th>가격</th>
				<td class="tdL"><input type=text name="price" size=30 maxlength=80 style="width:200px;" value="${add_param.price}" > 원</td>
			</tr>
			<tr>
				<th>상태</th>
				<td class="tdL">
					<select name="status" style="width:200px;">
						<option value="y"  <c:if test="${add_param.status eq 'y' }">selected="selected"</c:if>>재고충분</option>
						<option value="n"  <c:if test="${add_param.status eq 'n' }">selected="selected"</c:if>>재고부족</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>설명</th>
				<td class="tdL"><textarea name="contents" rows=3 cols=80 wrap=hard >${add_param.sty_contents}</textarea></td>
			</tr>
			<tr>
				<th>이미지1	</th>
				<td class="tdL">
					<input type="file" name="image1" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.image }"><br/>${add_param.image} </c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>이미지2</th>
				<td class="tdL">
					<input type="file" name="image2" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.image2 }"><br/>${add_param.image2} </c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>이미지3</th>
				<td class="tdL">
					<input type="file" name="image3" size=22 maxlength=80 style="width:350px;">
					<c:if test="${not empty add_param.image3 }"><br/>${add_param.image3} </c:if>
				</td>
			</tr>
		</tbody>
	</table>
</form>