<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script type="text/javascript" src="/assets/common/smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<script charset="utf-8">
	var oEditors = [];
	
	
	$(document).ready(function() {
		
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
	});
	
	function a_board_mod(){
		var ajax_url =  'mod_proc.do';
		a_board_proc(ajax_url);
	}//a_name_mod
	
	function a_board_add(){
		
		var ajax_url =  'add_proc.do';
		a_board_proc(ajax_url);
	}//a_name_mod
	
	
	function a_board_proc(ajax_url){
		
		var content = oEditors.getById["content"].getIR();
		$('#content').val(content);
		
		console.log(ajax_url);
		

		if(!valCheck('title','제목을 입력하세요')) return false;
		
		if( !confirm('저장하시겠습니까?') ){
			return false;			
		}
		
		var queryString = $("form[name=board_frm]").serialize() ;
		
		$('#board_frm').ajaxForm({		        
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
		$("#board_frm").submit();
	}// a_board_proc
	
	
function downloadBoard(ori_name 
		              ,rename
		              ,path){
	var url = "/download.do?path="+path+"&filename="+ori_name+"&refilename="+rename;
	location.href=url;
		
}	
</script>


<form action="" id="board_frm" name="board_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="board_name" id="board_name" 	   value="${add_bean.board_name}" />
	<input type="hidden" name="ref"        id="ref"        	   value="${add_bean.ref }">
	<input type="hidden" name="ref_step"   id="ref_step"   	   value="${add_bean.ref_step }">
	<input type="hidden" name="ref_level"  id="ref_level"  value="${add_bean.ref_level }">
	<input type="hidden" name="seq"  id="seq"  value="${add_bean.seq }">

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>글제목</th>
				<td class="tdL"><input type="text" name="title" id="title" value="${add_bean.title}" style="width: 90%;" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="tdL"><textarea name="content" id="content" style="width:100%; height:412px; display:none;">${add_bean.content}</textarea></td>
			</tr>
			<tr>
				<th>첨부파일1</th>
				<td class="tdL">
					<input type="file" name="file1" size=22 maxlength=80 style="width: 90%;">
					<c:if test="${not empty add_bean.ori_name1 }">
						<br/><a onclick="downloadBoard('${add_bean.ori_name1}', '${add_bean.re_name1}', '${add_bean.board_name}')"  href="#">${add_bean.ori_name1}</a>
						<label for="file_check1">기족파일 삭제</label>
						<input type="checkbox" name="file_check1" id="file_check1" value="Y" />					
						<input type="hidden" name="pre_re_name1" value="${add_bean.re_name1}" />
						<input type="hidden" name="pre_ori_name1" value="${add_bean.ori_name1}" />  
					</c:if>
				</td>
			</tr>
			<tr>
				<th>첨부파일2</th>
				<td class="tdL">
					<input type="file" name="file2" size=22 maxlength=80 style="width: 90%;">
					<c:if test="${not empty add_bean.ori_name2 }">
						<br/><a href="/download.do?path=notice&filename=${add_bean.ori_name2}&refilename=${add_bean.re_name2}">${add_bean.ori_name2}</a>
						<label for="file_check2">기족파일 삭제</label>
						<input type="checkbox" name="file_check2" id="file_check2" value="Y" />
						<input type="hidden" name="pre_re_name2" value="${add_bean.re_name2}" />
						<input type="hidden" name="pre_ori_name2" value="${add_bean.ori_name2}" />
					</c:if> 
				</td>
			</tr>
			<tr>
				<th>첨부파일3</th>
				<td class="tdL">
					<input type="file" name="file3" size=22 maxlength=80 style="width: 90%;">
					<c:if test="${not empty add_bean.ori_name3 }">
						<br/><a href="/download.do?path=notice&filename=${add_bean.ori_name3}&refilename=${add_bean.re_name3}">${add_bean.ori_name3}</a>
						<label for="file_check3">기족파일 삭제</label>
						<input type="checkbox" name="file_check3" id="file_check3" value="Y" /> 
						<input type="hidden" name="pre_re_name3" value="${add_bean.re_name3}" />
						<input type="hidden" name="pre_ori_name3" value="${add_bean.ori_name3}" />
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	<%-- <a href="write?ref=${view.REF}&ref_level=${view.REF_LEVEL+1}&ref_step=${view.REF_STEP+1}&board_name=${bean.board_name}&seq=${bean.seq}&page=${bean.page}&pagelistno=${bean.pagelistno}<c:if test="${! empty bean.search_value }">&search_title=${bean.search_title}&search_value=${bean.search_value}</c:if>" class="button">답글쓰기</a> --%>
</form>
	
