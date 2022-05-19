<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
function a_group_add(){
	var ajax_url = "/admin/item/goodsGroup/add_proc.do";
	a_group_proc(ajax_url);
}

function a_group_mod(){
	var ajax_url = "/admin/item/goodsGroup/mod_proc.do";
	a_group_proc(ajax_url);
}

function a_group_proc(ajax_url){
	
	if(! valCheck('group_name','제품명을 입력하세요.')){
		return;
	}
	
	if(! valCheck('sort_seq','정렬순서를 입력하세요.')){
		return;
	}
	
	$("#a_group_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_group_frm = ', $("#a_group_frm").attr("action"));
	
	$('#a_group_frm').ajaxForm({		        
		url : ajax_url,
        enctype : "multipart/form-data",
        beforeSerialize: function(){
             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
        },
        beforeSubmit : function() {
        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
        },

        success : function(data) {		             
            console.log("data =  ", data);
            alert(data.msg);
            if(data.suc){
            	if(ajax_url == '/admin/item/goodsGroup/add_proc.do'){
            		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
            		$("#addForm").dialog('close');
            	}else{
            		$("#jqGrid").trigger("reloadGrid");
            		$("#modForm").dialog('close');
            	}
            }
        }		        
    });	
	$("#a_group_frm").submit();
}

function a_sub_group_add(){
	if(! valCheck('group_name','그룹명을 입력하세요.')){
		return;
	}
	
	if(! valCheck('sort_seq','정렬순서를 입력하세요.')){
		return;
	}
	
	$("#a_group_frm").attr("action", "/admin/item/goodsGroup/sub_add_proc.do");
	$('#a_group_frm').ajaxForm({		        
		url : "/admin/item/goodsGroup/sub_add_proc.do",
        enctype : "multipart/form-data",
        beforeSerialize: function(){
             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
        },
        beforeSubmit : function() {
        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
        },

        success : function(data) {		             
            console.log("data =  ", data);
            alert(data.msg);
            if(data.suc){
           		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
           		$("#addForm").dialog('close');            	
            }
        }		        
    });	
	$("#a_group_frm").submit();
}

function a_sub_group_mod(){
	if(! valCheck('group_name','그룹명을 입력하세요.')){
		return;
	}
	
	if(! valCheck('sort_seq','정렬순서를 입력하세요.')){
		return;
	}
	
	$("#a_group_frm").attr("action", "/admin/item/goodsGroup/sub_mod_proc.do");
	$('#a_group_frm').ajaxForm({		        
		url : "/admin/item/goodsGroup/sub_mod_proc.do",
        enctype : "multipart/form-data",
        beforeSerialize: function(){
             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
        },
        beforeSubmit : function() {
        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
        },

        success : function(data) {		             
            console.log("data =  ", data);
            alert(data.msg);
            if(data.suc){
            	$("#jqGrid").trigger("reloadGrid");
        		$("#modForm").dialog('close');            	
            }
        }		        
    });	
	$("#a_group_frm").submit();
}



$(document).ready(function() {
	$("#sort_seq").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	}).on("focusout", function() {
	    var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        $(this).val(x);
	    }
	}).on("focus", function() {
		var x = $(this).val();
	    if(x && x.length > 0) {
	        if(!$.isNumeric(x)) {
	            x = x.replace(/[^0-9]/g,"");
	        }
	        $(this).val(x);
	    }
	});
});
</script>

<form action="" id="a_group_frm" name="a_group_frm"  enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>그룹명</th>
				<td class="tdL"><input type=text name="group_name" id="group_name" size=30 maxlength=80 style="width:200px;" value="${add_param.group_name}" ></td>
			</tr>
			<tr>
				<th>정렬순서</th>
				<td class="tdL"><input type=text name="sort_seq" id="sort_seq" size=30 maxlength=80 style="width:200px;" value="${add_param.sort_seq}" ></td>
			</tr>
			<tr>
				<th>노출여부</th>
				<td class="tdL">
					<select name="use_yn" id="use_yn" style="width:200px;">
						<option value="y"  <c:if test="${add_param.use_yn eq 'y' }">selected="selected"</c:if>>노출</option>
						<option value="n"  <c:if test="${add_param.use_yn eq 'n' }">selected="selected"</c:if>>미노출</option>
					</select>
				</td>
			</tr>					
		</tbody>
	</table>
</form>