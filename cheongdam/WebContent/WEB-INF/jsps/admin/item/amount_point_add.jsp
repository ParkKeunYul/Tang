<%@page import="kr.co.hany.common.Const"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(document).ready(function() {
	$("#jqGridPop").jqGrid({
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : '/admin/base/member/select.do',
  		//datatype: 'json',
  		datatype: 'local',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 8,
  		rowList: [8,15,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'번호', '아이디', '이름', '한의원명' , '선택'
  		],
  		colModel:[
  			{name:'seqno',			index:'a_seqno',		width:48,	align:"center"  ,sortable : false ,key: true ,hidden :true },
  			{name:'id',				index:'id',				width:80,	align:"left"    ,sortable : false},
  			{name:'name',			index:'name',			width:80,	align:"left"  	,sortable : false},
  			{name:'han_name',		index:'han_name',		width:150,	align:"left"    ,sortable : false},
  			{name:'btn',			index:'btn',			width:60,	align:"center"  ,sortable : false}
  		],
		pager: "#jqGridControlPop",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		//cellEdit : true,
		loadComplete: function(data) {
			var rows = $("#jqGridPop").getDataIDs(); 				
		    for (var i = 0; i < rows.length; i++){
		    	
		    	$("#jqGridPop").setCell(rows[i] , 'btn', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	$("#jqGridPop").jqGrid('setCell', rows[i], 'btn', '[ 선택 ]');

		    }//
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol= ', iCol);
			if(iCol == 4){
				var data = $("#jqGridPop").jqGrid('getRowData', row);					
				var ret = $("#jqGridPop").getRowData(row)
				$('#id').val(data.id);
				$('#name').val(data.name);
				$('#han_name').val(data.han_name);
				$('#mem_seqno').val(data.seqno);
			}
		}
	});
  	
  	//페이지 넘 
  	jQuery("#jqGridPop").jqGrid('navGrid','#jqGridControlPop',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
	
	
	$('#a_search_btn').click(function() {
			search();
		return false;
	});
		
	$("#a_search_value").keydown(function(key) {
		if (key.keyCode == 13) {
			search();
		}
	});
	
	$("#point").on("keyup", function() {
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

function search(){
		var search_value = $('#a_search_value').val();
	var search_title = $('#a_search_title').val();
		
	var param = { 
		 search_value : search_value
		,search_title : search_title
		,pageSearch   : 1
	};
	
	$("#jqGridPop").setGridParam({"postData": param ,datatype: "json", mtype: 'POST'}).trigger("reloadGrid",[{page : 1}]);
}

function a_point_proc(){
	
	var colNm = 'pp_seqno';
	
	if($("#mem_seqno").val() == null || $("#mem_seqno").val() ==''){
		alert('포인트를 부여-차감할 회원을 선택하십시오');
		return;
	}
	
	if($("#point").val() == null || $("#point").val() ==''){
		alert('포인트 수량을 입력하세요');
		$("#point").focus();
		return;
	}
	
	if($("#reason").val() == null || $("#reason").val() ==''){
		alert('사유를 입력하세요');
		$("#reason").focus();
		return;
	}
 	
 	if($("#tabel_name").val() == 'amount_point_add'){
 		colNm = 'amount_seqno';
 	}
 	
 	
 	
 	if(confirm("저장하시겠습니가?")){
 		$.ajax({
 			url  : 'point_add_proc.do',
 			type : 'POST',
 			data : {
 				 mem_seqno  : $("#mem_seqno").val()
 				,tabel_name : $("#tabel_name").val()
 				,point      : $("#point").val()
 				,reason     : $("#reason").val()
 				,colNm      : colNm
 			},
 			error : function() {
 				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
 			},
 			success : function(data) {
 				console.log(data);
 				if(data.suc){				
 			   		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
 			   		alert(data.msg);
 			   		$("#addForm").dialog('close');
 			    }else{
 			    	alert(data.msg);
 			    }
 			}
 		});
 	}
 	
	
	
	
}
</script>

<form action="" id="a_popup_frm" name="a_popup_frm" method="post" >
	<input type="hidden" name="mem_seqno" id="mem_seqno" value="${view.mem_seqno }" />
	<table class="basic01">
		<colgroup>
			<col width="12%" />
			<col width="43%" />
			<col width="*%" />
		</colgroup>
		<tbody>	
			<tr>
				<th>아이디</th>
				<td class="tdL"><input type=text name="id" id="id" size=50 value="${view.id }" readonly="readonly" maxlength=80 style="width:300px;"></td>
				<td class="tdL" rowspan="8" valign="top">
					<select name="a_search_title" id="a_search_title" style="width: 120px;">
						<option value="id">아이디</option>
						<option value="name">이름</option>
						<option value="han_name">한의원명</option>		
					</select>
					<input type="text" id="a_search_value" value="" style="width:150px;">
					<a href="#" id="a_search_btn" class="btn01" style="color: white;">검색</a>
					<table id="jqGridPop"></table>
					<div id="jqGridControlPop" style="vertical-align:middle;"></div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td class="tdL"><input type=text name="name" id="name" size=50 value="${view.name }" readonly="readonly"  maxlength=80 style="width:300px;"></td>
			</tr>
			<tr>
				<th>한의원명 </th>
				<td class="tdL"><input type=text name="han_name" id="han_name" size=50 value="${view.han_name }" readonly="readonly"  maxlength=80 style="width:300px;"></td>
			</tr>
			
			<tr>
				<th>충전/차감 </th>
				<td class="tdL">
					<select name="tabel_name" id="tabel_name">
						<option value="amount_point_add">충전</option>
						<option value="amount_point_use">차감</option>
					</select>
					<input type=text name="point" id="point" size=50 value=""   maxlength=80 style="width:237px;"> 포인트
				</td>
			</tr>
			
			<tr>
				<th>사유 </th>
				<td class="tdL"><input type=text name="reason" id="reason" size=50 value=""   maxlength=80 style="width:300px;"></td>
			</tr>
		
		</tbody>
		
	</table>
</form>