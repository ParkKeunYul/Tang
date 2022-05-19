<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script>
function a_popup_add(){
	var ajax_url = "add_proc.do";
	a_box_proc(ajax_url);
}

function a_popup_mod(){
	var ajax_url = "mod_proc.do";
	a_box_proc(ajax_url);
}

function a_box_proc(ajax_url){
	
	if(! valCheck('title','제목을 입력하세요.')){
		return;
	}
	
	if(! valCheck('start_date','등재 시작일을 입력하세요.')){
		return;
	}
	
	if(! valCheck('end_date','등재 종료일을 입력하세요.')){
		return;
	}
	
	if( new Number( $('#start_date').val() )  > new Number( $('#end_date').val() )){
		alert('등재 시작일은 종료일보다 클수 없습니다.');
		return;
	}
	
	
	if(! valCheck('w_size','가로크기를 입력하세요.')){
		return;
	}
	
	if(! valCheck('h_size','세로크기를 입력하세요.')){
		return;
	}
	
	if(! valCheck('top_size','Top 여백을 입력하세요.')){
		return;
	}
	
	if(! valCheck('left_size','Left 여백을 입력하세요.')){
		return;
	}
	
	
	$("#a_popup_frm").attr("action", ajax_url);
	
	$('#a_popup_frm').ajaxForm({		        
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
	$("#a_popup_frm").submit();
}



$(document).ready(function() {
	$(".date").datepicker({
		dateFormat: 'yymmdd'
	});	
});


</script>

<form action="" id="a_popup_frm" name="a_popup_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />
	<input type="hidden" name="pop_type" value="${add_param.pop_type }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>팝업제목</th>
				<td class="tdL"><input type=text name="title" id="title" size=50 value="${add_param.title }" maxlength=80 style="width:700px;" ></td>
			</tr>
			<tr>
				<th>등재기간 </th>
				<td class="tdL">
					<input type=text name=start_date id="start_date" class="date"  value="${add_param.start_date }"  maxlength=10  readonly style="width: 80px;cursor: pointer;">&nbsp;&nbsp; - &nbsp;&nbsp;
					<input type=text name=end_date id="end_date" class="date"     value="${add_param.end_date }"  size=15 maxlength=10 readonly style="width: 80px;cursor: pointer;" >
				</td>
			</tr>
			<tr>
				<th>사이즈 </th>
				<td class="tdL">
					가로&nbsp; <input type=text name=w_size id="w_size" size=10 maxlength=10  value="${add_param.w_size }" style="width:80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;세로&nbsp;
					<input type=text name=h_size id="h_size" size=10 maxlength=10  value="${add_param.h_size }" style="width:80px;">
				</td>
			</tr>
			<tr>
				<th>여백 </th>
				<td class="tdL">
					Top&nbsp;&nbsp; <input type=text name="top_size" id="top_size" size=10   value="${add_param.top_size }" maxlength=10 style="width:80px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Left&nbsp; <input type=text name="left_size" id="left_size" size=10 value="${add_param.left_size }"  maxlength=10 style="width:80px;">
				</td>
			</tr>
			<tr>
				<th>활성화 </th>
				<td class="tdL">
					<select id="view_yn" name="view_yn" style="width:300px;">
						<option value="n"  <c:if test="${add_param.view_yn eq 'n' }">selected="selected"</c:if> >비활성화</option>
						<option value="y"  <c:if test="${add_param.view_yn eq 'y' }">selected="selected"</c:if>>활성화</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>타겟 </th>
				<td class="tdL">
					<select id="yn_win" name="yn_win" style="width:300px;">
						<option value="y"  <c:if test="${add_param.yn_win eq 'y' }">selected="selected"</c:if> >새창</option>
						<option value="n"  <c:if test="${add_param.yn_win eq 'n' }">selected="selected"</c:if> >본문</option>					
					</select>
				</td>
			</tr>
			<tr>
				<th>링크주소</th>
				<td class="tdL"><input size=40  style="width:700px;" type=text name="yn_link" id="yn_link" value="${add_param.yn_link }"  ></td>
			</tr>
			<tr style="display:none;">
				<th rowspan="2">이미지</th>
				<td class="tdL">
					<input type=file name=upfile size=40 style="width:350px;">
				</td>
			</tr>
			<tr style="display:none;">
				<td class="tdL">
					<c:if test="${not empty add_param.upfile }">
						${add_param.upfile}
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</form>