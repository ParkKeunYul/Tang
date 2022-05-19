<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script type="text/javascript" src="/assets/common/smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
function a_popup_add(){
	var ajax_url = "add_proc.do";
	a_popup_proc(ajax_url);
}

function a_popup_mod(){
	var ajax_url = "mod_proc.do";
	a_popup_proc(ajax_url);
}

function a_popup_proc(ajax_url){
	
	if(! valCheck('id','아이디를 선택하세요.')){
		return;
	}
	
	if(! valCheck('title','제목을 입력하세요.')){
		return;
	}
	
	if(! valCheck('price','가격을 입력하세요.')){
		return;
	}
	
	
	var content = oEditors.getById["content"].getIR();
	$('#content').val(content);
	
	
	
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


var oEditors = [];
$(document).ready(function() {
	$(".date").datepicker({
		dateFormat: 'yymmdd'
	});	
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "/assets/common/smart/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	$('#title').focus();
	
	$("#jqGridPop").jqGrid({
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : '/admin/base/member/select.do',
  		//datatype: 'json',
  		datatype: 'local',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 15,
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
  	
  	$("#price").on("keyup", function() {
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
});

</script>

<form action="" id="a_popup_frm" name="a_popup_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${view.seqno }" />	
	<input type="hidden" name="mem_seqno" id="mem_seqno" value="${view.mem_seqno }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="550px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<c:if test="${view.pay_yn eq 'y' }">
				<tr>
					<th>결제정보</th>
					<td class="tdL" colspan="2" valign="top">
						<ul>
							<c:forEach var="list" items="${detail_list}">
								<li>
									<ul>
										<li>거래번호 : ${list.card_gu_no}</li>
										<li>주문번호 : ${list.card_ju_no }</li>
										<li>결제금액 : ${list.card_amt}</li>
										<li>결제일   : ${list.wdate}</li>
									</ul>
								</li>
							</c:forEach>
						</ul>
					</td>
				</tr>
				<tr>
					<th>최초 확인 관리자 정보</th>
					<td class="tdL" colspan="2" valign="top">
						${view.admin_id } / ${view.admin_name } / ${view.admin_date }
					</td>
				</tr>
			</c:if>
		
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
					<a href="#" id="a_search_btn" class="btn01">검색</a>
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
				<th>제목 </th>
				<td class="tdL"><input type=text name="title" id="title" size=50 value="${view.title }" maxlength=80 style="width:480px;"></td>
			</tr>
			<tr>
				<th>결제금액 </th>
				<td class="tdL"><input type=text name="price" id="price" size=50 value="${view.price }" maxlength=80 style="width:180px;text-align: right;"> 원</td>
			</tr>	
			<tr>
				<th>활성화 </th>
				<td class="tdL">
					<select id="view_yn" name="view_yn" style="width:300px;">
						<option value="n"  <c:if test="${view.view_yn eq 'n' }">selected="selected"</c:if> >비활성화</option>
						<option value="y"  <c:if test="${view.view_yn eq 'y' }">selected="selected"</c:if>>활성화</option>
					</select>
				</td>
			</tr>			
			<tr>
				<th rowspan="2">내용</th>
				<td class="tdL" colspan="2"><textarea name="content" id="content" style="width:750px; height:312px; display:none;">${view.CONTENT}</textarea></td>
			</tr>			
		</tbody>
	</table>
</form>