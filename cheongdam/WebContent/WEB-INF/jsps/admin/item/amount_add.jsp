<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script type="text/javascript" src="/assets/common/smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
function a_box_add(){
	var ajax_url = "/admin/item/amount/add_proc.do";
	a_box_proc(ajax_url);
}

function a_box_mod(){
	var ajax_url = "/admin/item/amount/mod_proc.do";
	a_box_proc(ajax_url);
}

function a_box_proc(ajax_url){
	
	if(! valCheck('title','상품명을 입력하세요.')){
		return;
	}
	
	if(! valCheck('price','가격을 입력하세요.')){
		return;
	}
	
	$("#a_box_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_box_frm = ', $("#a_box_frm").attr("action"));
	
	
	var content = oEditors.getById["detail"].getIR();
	$('#detail').val(content);
	
	$('#a_box_frm').ajaxForm({		        
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
            	if(ajax_url == '/admin/item/amount/add_proc.do'){
            		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
            		$("#addForm").dialog('close');
            	}else{
            		$("#jqGrid").trigger("reloadGrid");
            		$("#modForm").dialog('close');
            	}
            }
        }		        
    });	
	$("#a_box_frm").submit();
}
var oEditors = [];
$(document).ready(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "detail",
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
	
	 $("#price , #sort_seq").keydown(function(e) {
		 var  price = $(this).val();
		 price = price.replaceAll(/\D/g, "");
		 $(this).val(price);		 
	  });
	 $("#price , #sort_seq").keypress(function(){
		 var  price = $(this).val();
		 price = price.replaceAll(/\D/g, "");
		 $(this).val(price);
	  });
	 $("#price , #sort_seq").keyup(function(){
		 var  price = $(this).val();
		 price = price.replaceAll(/\D/g, "");
		 $(this).val(price);
	  });
});
</script>

<form action="" id="a_box_frm" name="a_box_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="seqno" value="${add_param.seqno }" />
	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>상품명</th>
				<td class="tdL"><input type=text name="title" id="title" size=30 maxlength=80 style="width:200px;" value="${add_param.title}" ></td>
			</tr>
			<tr>
				<th>가격</th>
				<td class="tdL">
					<input type=text name="price" id="price" size=30 maxlength=80 style="width:200px;" value="${add_param.price}" > 원
					<input type="hidden" name="pre_price" id="pre_price" size=30 maxlength=80 style="width:200px;" value="${add_param.price}" >
				</td>
			</tr>
			<tr>
				<th>부여포인트</th>
				<td class="tdL">
					<input type=text name="point" id="point" size=30 maxlength=80 style="width:200px;" value="${add_param.point}" >
				</td>
			</tr>
			<tr>
				<th>상세설명</th>
				<td  class="tdL"><textarea name=detail id="detail" style="height:340px;" cols=103>${info.detail}</textarea></td>
			</tr>
			<tr>
				<th>상태</th>
				<td class="tdL">
					<select name="show_yn" style="width:200px;">
						<option value="n"  <c:if test="${add_param.show_yn eq 'n' }">selected="selected"</c:if>>감춤</option>
						<option value="y"  <c:if test="${add_param.show_yn eq 'y' }">selected="selected"</c:if>>노출</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>정렬순서</th>
				<td class="tdL"><input type=text name="sort_seq" id="sort_seq" size=5  style="width:50px;" value="${add_param.sort_seq}" ></td>
			</tr>
			<tr>
				<th>상품사진	</th>
				<td  class="tdL">
					<input type=file name=image id="image" size=40 >
					<c:if test="${not empty add_param.image }">
						<br/><img src="/upload/amount/${add_param.image }" alt="" width="100px;" height="100px;" />
						${add_param.image }
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</form>