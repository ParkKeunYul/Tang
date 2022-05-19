<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
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
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">이용안내</p>
		<div class="lnbDepth">
			<ul>
				<li><a href="01.do">공지사항</a></li>
				<li><a href="02.do">이용안내</a></li>
				<li class="sel"><a href="03.do">1:1문의</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<form action="03_proc.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
	<div class="contents" id="contents">
		<div class="boardForminner">
			<ul class="boardForm">
				<li class="type02">
					<label class="title">작성자</label>
					<div>${userInfo.name}</div>
				</li>						
				<li class="type02">
					<label class="title" for="cate_nm" >문의유형</label>
					<div>
						<select name="cate_nm" id="cate_nm"  style="width:90%">
							<option value="배송관련">배송관련</option>
							<option value="취소/교환/반품">취소/교환/반품</option>
							<option value="상품관련">상품관련</option>
							<option value="기타">기타</option>
						</select>
					</div>
				</li>
				<li class="type02">
					<label class="title" for="title">제목</label>
					<div>
						<input type="text" name="title" id="title" style="width:90%;">
					</div>
				</li>
				<li class="type02">
					<label class="title" for="file1">첨부파일</label>
					<div>
						<input type="file" name="file1" id="file1"  style="width:90%;"/>
					</div>
				</li>
				<li class="type02">
					<label class="title" for="content">문의내용</label>
					<div>
						<textarea name="content" id="content" style="width:90%; height:100px;resize:none;"></textarea>
					</div>
				</li>
			</ul>
		</div>

		<div class="btnArea write">
			<button type="button" class="btnTypeBasic colorWhite" id="cancelBtn"><span>취소</span></button>
			<button type="button" id="confrimBtn" class="btnTypeBasic colorGreen"><span>확인</span></button>
		</div>

	</div>
	</form>
	<!-- //본문 -->

</div>
<!-- //container -->