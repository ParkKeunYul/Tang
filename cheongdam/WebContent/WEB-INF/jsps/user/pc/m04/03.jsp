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
		            	$("#frm")[0].reset();
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
<!-- container -->
<div id="container">
	<!-- contents -->
	<div id="contents">

		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>고객센터</span><span>공지사항</span></p>
		</div>

		<ul class="sub_Menu w33">
			<li><a href="01.do">공지사항</a></li>
			<li><a href="02.do">이용안내</a></li>
			<li class="sel"><a href="03.do">1:1문의</a></li>
		</ul>

		<div class="bannerArea mb20">
			<p class="ba03">
				<strong>1:1문의 게시판</strong>입니다. <br/>문의 작성 시 카카오톡 또는 전화로 답변해 드립니다.
			</p>
		</div>

		<form action="03_proc.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
			<!-- 본문내용 -->
			<!-- table -->
			<div class="st01">
				<table class="basic">
					<colgroup>
						<col width="120px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>작성자</th>
							<td>${userInfo.name}</td>
						</tr>
						<tr>
							<th>문의유형</th>
							<td>
								<label><input type="radio" name="cate_nm" checked value="배송관련" /> 배송관련</label>
								<label><input type="radio" name="cate_nm" value="취소/교환/반품"/> 취소/교환/반품</label>
								<label><input type="radio" name="cate_nm" value="상품관련"/> 상품관련</label>
								<label><input type="radio" name="cate_nm" value="기타"/> 기타</label>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" name="title" id="title" style="width:650px;"></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input type="file" name="file1" id="file1" style="width:400px;"/></td>
						</tr>
						<tr>
							<th>문의내용</th>
							<td><textarea name="content" id="content" style="width:650px; height:100px;resize:none;"></textarea></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- //table -->
			<!-- btnarea -->
			<div class="btn_area01">
				<a href="#" id="cancelBtn"><span class="cw h60">취소</span></a>
				<a href="#" id="confrimBtn" ><span class="cg h60">확인</span></a>
			</div>
			<!-- //btnarea -->
			<!-- //본문내용 -->
		</form>
	</div>
	<!-- // contents -->

</div>
<!-- // container -->
		