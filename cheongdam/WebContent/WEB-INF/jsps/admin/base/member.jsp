<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>


<META http-equiv="Expires" content="-1"> 
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="No-Cache">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	var a_mem_code  = "0:가입신청;${mem_code}";
	var a_group_code = "${group_code}";
</script>
<!-- <script type="text/javascript" src="/assets/admin/js/jsp/base/member.js"> </script> -->
<script>
$(document).ready(function() {
	
  	$("#jqGrid").jqGrid({
  		//caption : '회원관리',
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : '/admin/base/member/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 20,
  		rowList: [20,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'일련번호', '멤버번호', '아이디', '이름', '한의원명','휴대폰' ,'등급', 
  			'라이센스','이메일','실무자','회원구분','그룹', 
  			'가입일'  ,'사용자로그인'
  		],
  		colModel:[
  			{name:'a_num',			index:'a_num',		width:78,	align:"center"  ,sortable : false  },
  			{name:'seqno',			index:'a_seqno',		width:78,	align:"center"  ,sortable : true ,key: true , hidden:true},
  			{name:'id',				index:'id',				width:120,	align:"left"    ,sortable : true},
  			{name:'name',			index:'name',			width:120,	align:"center"  ,sortable : true
  				,editable:true
  			},
  			{name:'han_name',		index:'han_name',		width:200,	align:"left"    ,sortable : true
  				,editable:true
  			},
  			{name:'handphone',		index:'handphone',		width:100,	align:"center"    ,sortable : true
  				,editable:false
  			},
  			{name:'member_level',	index:'member_level',	width:200,	align:"center"  ,sortable : true
  				,editable:true
  				,edittype:'select'
  				,formatter: 'select'
  				,editoptions:{
  					 value:a_mem_code	
  				} 		  				
  			},
  			{name:'license_no',		index:'license_no',		width:80,	align:"center"    ,sortable : true
  				,editable:true
  			},
  			{name:'email',		index:'email',		width:180,	align:"left"    ,sortable : true
  				,editable:true
  			},
  			{name:'sub_id_confirm',		index:'sub_id_confirm',		width:80,	align:"center"    ,sortable : true
  				,editable:true
  				,edittype:'select'
  				,formatter: 'select'
  				,editoptions:{
  					 value:"y:승인;n:미승인"	
  				}
  			},
  			{name:'part',		index:'part',		width:130,	align:"center"    ,sortable : true
  				,editable:true
  				,edittype:'select'
  				,formatter: 'select'
  				,editoptions:{
  					 value:"1:한의원(개원의);2:한의사(미개원의);3:한의대생"	
  				}
  			},		  			
  			{name:'group_code',		index:'group_code',		width:150,	align:"center"  ,sortable : true
  				,editable:true
  				,edittype:'select'
  				,formatter: 'select'
  				,editoptions:{
  					value: a_group_code	
  				}
  			},
  			{name:'wdate2',			index:'wdate',			width:200,	align:"center"  ,sortable : true},
  			{name:'userLogin',		index:'userLogin',			width:150,	align:"left"  ,sortable : false}
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		sortname: 'seqno',
		sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		multiselect: true,
		cellEdit : true,
		editurl : '/admin/base/member/select.do',
		cellurl : '/admin/base/member/update_col.do',
		beforeSubmitCell : function(rowid, cellName, cellValue) {   // submit 전
			console.log(  "@@@@@@ rowid = " +rowid + " , cellName = " + cellName + " , cellValue = " + cellValue );
			return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
		},
		loadComplete: function(data) {
			console.log("2222 =  " ,data);
			var rows = $("#jqGrid").getDataIDs();
			
			var records = data.records;
			var page    = data.page;
			var cnt     = data.cnt;
			records = records -((page-1) * cnt);
		    for (var i = 0; i < rows.length; i++){
		    	var member_level = new Number($("#jqGrid").getCell(rows[i],"member_level"));
		    	
		    	$("#jqGrid").setCell(rows[i] , 'a_num', records-- , {});
		    	
		    	$("#jqGrid").setCell(rows[i] , 'id', "" ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    	
				var id = $("#jqGrid").getCell(rows[i],"id");
		    	
		    	var userLogin = '[ '+id+' 로그인 ]';
		    	
		    	$("#jqGrid").setCell(rows[i] , 'userLogin', userLogin ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
		    }//
		},
		beforeSelectRow: function (rowid, e) {
		    var $self = $(this), iCol, cm,
		    $td = $(e.target).closest("tr.jqgrow>td"),
		    $tr = $td.closest("tr.jqgrow"),
		    p = $self.jqGrid("getGridParam");

		    if ($(e.target).is("input[type=checkbox]") && $td.length > 0) {
		       iCol = $.jgrid.getCellIndex($td[0]);
		       cm = p.colModel[iCol];
		       if (cm != null && cm.name === "cb") {
		           // multiselect checkbox is clicked
		           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
		       }
		    }
		    return false;
		},
		onCellSelect : function(row,iCol,cellcontent,e){
			console.log('iCol= ', iCol);
			var data = $("#jqGrid").jqGrid('getRowData', row);
			if(iCol == 3){
				var ret = $("#jqGrid").getRowData(row)
				 $.ajax({
				    url   : "/admin/base/member/mod.do",		    
				    type  : 'POST',
				    data  : ret,
			        error: function(){
				    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				    },
				    success: function(data){
				        $("#modForm").html(data);
				        $("#modForm" ).dialog( "open" );
				    }   
				});	
			}
			else if(iCol == 14){
				window.open('user.do?id='+data.id, "사용자새창", "width="+screen.width +", height="+screen.height+",fullscreen=yes,menubar=yes,location=yes,scrollbars=yes,status=yes,toolbar=yes" );
			}
		}
	});
  	
  	//페이지 넘 
  	$("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	$("#modForm").dialog({
  		autoOpen: false,
        resizable: true,
        height: 800,
        width: 1200,
       // position: 'center',
        modal: true,
        title: '회원정보관리',
        beforeClose: function(event, ui) { 
           console.log('beforeClose');
        },
        close : function(){            
           	$('#modForm').html("");
        },
        open: function(event, ui) { 
        	$('.ui-widget-overlay').bind('click', function(){
        		$("#modForm").dialog('close'); 
        	});
        },
        buttons: {
            "수정": function () {
            	a_member_proc();
            },
            "닫기": function () {
                $(this).dialog("close");
            }
        }		
  	});
  	
  	
  	
  	$('#search_btn').click(function() {
  		var search_value = $('#search_value').val();
		var search_title = $('#search_title').val();
		var search_group = $('#search_group').val();
			
		var param = { 
			 search_value : search_value
			,search_title : search_title
			,search_group : search_group
			,pageSearch   : 1
		};
		
		$("#jqGrid").setGridParam({"postData": param }).trigger("reloadGrid",[{page : 1}]);
		
		return false;
	});
  	
  	$('#out_btn').click(function() {
  		var all_seqno= '';
  		var row = $("#jqGrid").jqGrid('getGridParam','selarrrow');
  		if( row.length <= 0 ){
  			alert('1개 이상 선택하세요.');
  			return false;
  		}
  		
  		for(var i = 0 ; i <row.length ; i++){
			var data =$("#jqGrid").jqGrid('getRowData', row[i]);
			if(i == 0){
				all_seqno  = data.seqno
			}else{
				all_seqno += ','+data.seqno	
			}
		}// for
		
		console.log('all_seqno =', all_seqno);
		
		
		if(!confirm('탈퇴 처리 하겠습니까?')){
  			return false;
  		}
		
		$.ajax({
  			url  : 'out_member.do',
  			type : 'POST',
  			data : {
  				all_seqno : all_seqno,		  				
  			},
  			error : function() {
  				alert('에러가 발생했습니다.\n관리자에 문의하세요.');
  			},
  			success : function(data) {
  				alert(data.msg);
  				
  				if(data.suc){
  					$("#jqGrid").trigger("reloadGrid");
  				}
  			}
  		});
  	});
	  	
});
function initLayerPosition(element_layer){
	var width = 1000; 
    var height = 600; 
    var borderWidth = 5; 

    // 위에서 선언한 값들을 실제 element에 넣는다.
    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    element_layer.style.left  = '210px';
    element_layer.style.top  = '100px';
   // element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
   // element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
}

function closeDaumPostcode(){
	$('.find_addr_layer_pop').hide();
}  
</script>
	
	<div class="con_tit">기본관리 &gt; 회원관리</div>
	
	<div class="conBox">
		<div class="inputArea disB">
			그룹 : 
			<select name="search_group" id="search_group">
				<option value="">전체</option>
				<c:forEach  items="${group_list}" var="list">
					<option value="${list.seqno }">${list.group_nm}</option>
				</c:forEach>
			</select>
		
			
			<select name="search_title" id="search_title">
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="han_name">한의원명</option>
				<option value="handphone">휴대전화번호</option>
				<option value="tel">전화번호</option>		
			</select>
			<input type="text" id="search_value" value="">
			<a href="#" id="search_btn" class="btn01">검색 </a>
			<a href="#" id="out_btn" class="btn03" style="color: red !important;">회원탈퇴</a>
		</div>
		
		<div id="modForm"></div>
		<table id="jqGrid"></table>
		<div id="jqGridControl"></div>
	</div>

</html>