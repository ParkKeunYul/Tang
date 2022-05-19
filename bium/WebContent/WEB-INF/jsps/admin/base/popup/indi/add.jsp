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
  		datatype: 'json',
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
			}
		}
	});
  	
  	//페이지 넘 
  	jQuery("#jqGridPop").jqGrid('navGrid','#jqGridControlPop',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	$('#a_search_btn').click(function() {
  		var search_value = $('#a_search_value').val();
		var search_title = $('#a_search_title').val();
			
		var param = { 
			 search_value : search_value
			,search_title : search_title
			,pageSearch   : 1
		};
		
		$("#jqGridPop").setGridParam({"postData": param }).trigger("reloadGrid",[{page : 1}]);
		
		return false;
	});
});

</script>

<form action="" id="a_popup_frm" name="a_popup_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />
	<input type="hidden" name="pop_type" value="${add_param.pop_type }" />

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="550px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>아이디</th>
				<td class="tdL"><input type=text name="id" id="id" size=50 value="${add_param.id }" readonly="readonly" maxlength=80 style="width:300px;"></td>
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
				<td class="tdL"><input type=text name="name" id="name" size=50 value="${add_param.name }" readonly="readonly"  maxlength=80 style="width:300px;"></td>
			</tr>
			<tr>
				<th>한의원명 </th>
				<td class="tdL"><input type=text name="han_name" id="han_name" size=50 value="${add_param.han_name }" readonly="readonly"  maxlength=80 style="width:300px;"></td>
			</tr>
			<tr>
				<th>팝업제목 </th>
				<td class="tdL"><input type=text name="title" id="title" size=50 value="${add_param.title }" maxlength=80 style="width:480px;"></td>
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
				<th rowspan="2">내용</th>
				<td class="tdL" colspan="2"><textarea name="content" id="content" style="width:960px; height:312px; display:none;">${add_param.CONTENT}</textarea></td>
			</tr>
			<c:if test="${not empty add_param.upfile }">
			<tr>
				<td colspan="2">${add_param.upfile}</td>
			</tr>
			</c:if>	
		</tbody>
	</table>
</form>