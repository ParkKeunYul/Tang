<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
function a_base_add(){
	var ajax_url = "add_proc.do";
	a_base_proc(ajax_url);
}

function a_base_mod(){
	var ajax_url = "mod_proc.do";
	a_base_proc(ajax_url);
}

function a_base_proc(ajax_url){
	
	if(! valCheck('delivery_nm','택배사 이름을 입력하세요.')){
		return;
	}
	
	$("#a_base_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_base_frm = ', $("#a_base_frm").attr("action"));
	
	$('#a_base_frm').ajaxForm({		        
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
	$("#a_base_frm").submit();
}
</script>

<form action="" id="a_base_frm" name="a_base_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />
	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>택배사명</th>
				<td class="tdL"><input type=text name="delivery_nm" id="delivery_nm" size=30 maxlength=80 style="width:200px;" value="${add_param.delivery_nm}" ></td>
			</tr>
			<tr>
				<th>가격</th>
				<td class="tdL"><input type=text name="price" id="price"  size=30 maxlength=80 style="width:200px;" value="0" > 원</td>
			</tr>
			<tr>
				<th>사용여부</th>
				<td class="tdL">
					<select name="use_yn" style="width:200px;">
						<option value="y"  <c:if test="${add_param.use_yn eq 'y' }">selected="selected"</c:if>>사용중</option>
						<option value="n"  <c:if test="${add_param.use_yn eq 'n' }">selected="selected"</c:if>>미사용</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</form>