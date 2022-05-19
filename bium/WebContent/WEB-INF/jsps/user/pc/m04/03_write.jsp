<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script charset="utf-8">
	$(document).ready(function() {
		
		$('#confrimBtn').click(function() {
			
			if(!valCheck( 'title'   ,'제목을 입력하세요.') ) return false;
			if(!valCheck( 'content' ,'내용을 입력하세요.') ) return false;
			
			var ext = $('#file1').val().split('.').pop().toLowerCase();
			if( objToStr(ext , '') != '' ){
				if($.inArray(ext, ['php','asp','java','sql','js','html','css','dll','exe','msi','jsp']) != -1) {
					alert('첨부할수 없는 확장자 입니다.');
					return  false;
				}
			}
			
			$('#frm').ajaxForm({		        
				url : '03_proc.do',
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
		            	location.href='/m04/03.do';
		            }
		        }		        
		    });	
			$("#frm").submit();
			
			return false;
		});
	
		$('#cancelBtn').click(function() {
			$("#frm")[0].reset();
			return false;
		});
		
	});
</script>
	<!-- contents -->
	<div class="contents">

		<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>1:1문의</span></p>
		<ul class="submenu w33">
			<li><a href="/m04/01.do" class="">공지사항</a></li>
			<li><a href="/m04/02.do" class="">이용안내</a></li>
			<li><a href="/m04/03.do" class="sel">1:1문의</a></li>
		</ul>

		<form action="03_proc.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
			<!-- 본문내용 -->
			<!-- table -->
			<span class="t01">* 1:1문의는 타인에게 내용이 공개되지 않습니다.</span>
			<table class="basic_write">
				<colgroup>
					<col width="180px" />
					<col width="*" />
					<col width="180px" />
					<col width="360px" />
				</colgroup>
				<tbody>
					<tr>
						<th>작성자</th>
						<td>${userInfo.name}</td>
						<th>한의원명</th>
						<td>${userInfo.han_name }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3"><input type="text" name="title" id="title" style="width:750px;"></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3"><input type="file" name="file1" id="file1" style="width:400px;"/></td>
					</tr>
					<tr>
						<th>문의내용</th>
						<td colspan="3"><textarea name="content" id="content" style="width:750px; height:160px;resize:none;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<!-- //table -->
			<!-- btnarea -->
			<div class="btn_area01">
				<a href="#" id="confrimBtn"><span class="cp h40">확인</span></a>
				<a href="#" id="cancelBtn"><span class="cw h40">취소</span></a>
			</div>
			<!-- //btnarea -->
			<!-- //본문내용 -->
		</form>
	</div>
	<!-- // contents -->
		