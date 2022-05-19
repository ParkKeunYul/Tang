<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- container -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#findAddrBtn1").click(function() {
		find_addr('zipcode','address01', 'address02');
		return false;
	});
	
	$("#findAddrBtn2").click(function() {
		find_addr('han_zipcode','han_address01', 'han_address02');
		return false;
	});
	
	$('#email1' ).on("blur keyup", function() {
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	});
	
	$("#handphone01,#handphone02,#handphone03,#han_tel_1,#han_tel_2,#han_tel_3,#han_fax_1,#han_fax_2,#han_fax_3").on("keyup", function() {
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
	
	$("#email3").change(function() {		
		if( objToStr($(this).val()) == '' ){			
			$('#email2').removeAttr("readonly");
			$('#email2').val('');
			$('#email2').focus();
		}else{
			$('#email2').val($(this).val());
			$('#email2').attr("readonly",true); 
		}
	});
	
	
	$("#memberBtn").click(function() {
		
		if( objToStr($('#password').val() , '') != '' ){
			if(!valCheck( 're_password' ,'비밀번호를 입력하세요.') ) return false;
			if(!pwdCheck('password', 're_password') ) return false;
		}
		
		//if(!valCheck( 'password' ,'비밀번호를 입력하세요.') ) return false;
		

		if(!valCheck( 'zipcode' ,'주소를 입력하세요.') ) return false;
		if(!valCheck( 'address01' ,'주소를 입력하세요.') ) return false;
		if(!valCheck( 'address02' ,'주소를 입력하세요.') ) return false;
		if(!valCheck( 'handphone01' ,'휴대전화번호를 입력하세요.') ) return false;
		if(!valCheck( 'handphone02' ,'휴대전화번호를 입력하세요.') ) return false;
		if(!valCheck( 'handphone03' ,'휴대전화번호를 입력하세요.') ) return false;
		if(!valCheck( 'email1' ,'이메일주소를 입력하세요.') ) return false;
		if(!valCheck( 'email2' ,'이메일주소를 입력하세요.') ) return false;
		
		 
		//if(!valCheck( 'member_file' ,'면허증을 첨부하세요.') ) return false;
		var ext = $('#member_file').val().split('.').pop().toLowerCase();
		if( objToStr(ext , '') != '' ){
			if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				return false;
			}	
		}
		
		
		
		
		if($('#part').val() == '1'){
			if(!valCheck( 'han_name' ,'한의원명을 입력하세요.') ) return false;
			if(!valCheck( 'biz_no_1' ,'사업자번호를 입력하세요.') ) return false;
			if(!valCheck( 'biz_no_2' ,'사업자번호를 입력하세요.') ) return false;
			if(!valCheck( 'biz_no_3' ,'사업자번호를 입력하세요.') ) return false;
			if(!valCheck( 'han_zipcode' ,'주소를 입력하세요.') ) return false;
			if(!valCheck( 'han_address01' ,'주소를 입력하세요.') ) return false;
			if(!valCheck( 'han_address02' ,'주소를 입력하세요.') ) return false;
			//if(!valCheck( 'member_file2' ,'사업자등록증을 첨부하세요.') ) return false;
			var ext2 = $('#member_file2').val().split('.').pop().toLowerCase();
			
			if( objToStr(ext2 , '') != '' ){
				if($.inArray(ext2, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					return false;
				}	
			}
			
			
		}
		
		
		 
		$('#frm').ajaxForm({		        
			url     : '/m05/01_mypage.do',
	        enctype : "multipart/form-data",
	        beforeSerialize: function(){
	             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
	        },
	        beforeSubmit : function() {
	        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
	        },
	        success : function(data) {		             
	            console.log('data = ', data);
	           alert(data.msg);
	        }		        
	    });
		$("#frm").submit();
		return false;
	});
	
	
	$("#cancelBtn").click(function() {
		$('#frm').each(function(){
		    this.reset();
		});
		
		return false;
	});
	
});
</script>

<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "마이페이지";
		String sec_nm = "마이페이지";
		String thr_nm = "내정보수정";
		int fir_n = 5;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>
	<!-- //submenuArea -->
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	
	<!-- contents -->
	<div id="contents">
		<!-- 내용 -->
		
		<style>
			.conArea .thr_area{
				margin: 0 auto;
				width:1000px;
			}
			.conArea ul.thr_menu{
			 
			}
			
			.conArea ul.thr_menu li{
				float: left; 
				width: 150px;
				height: 30px;
				line-height: 30px;
				border: 1px solid #d1d1d1;
				border-left : none;		
				border-bottom: none;
				text-align: center;
			}
			
			.conArea ul.thr_menu li:first-child{
				
			}
			.conArea ul.thr_menu li.on{
				background: #26995d;
				color: #fff;						
			}
			
			.conArea ul.thr_menu li a{				
				display: block;
				font-weight: 700;				
			}
			
			.conArea ul.thr_menu li.on a{
				color: #fff;
			}
		
		</style>
		
		<div class="conArea">
			<c:if test="${userInfo.mem_sub_seqno eq 0}">
				<div  class="thr_area" >
					<ul class="thr_menu">
						<li class="on"><a href="/m05/01.do">내정보수정</a></li>
						<li><a href="/m05/01_sub.do">서브계정관리</a></li>
					</ul>
					<div style="clear: both;"></div>
				</div>
			</c:if>
					
			<form action="/m05/01_mypage.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
				<input type="hidden" name="part" id="part" value="${info.part}" />
				<!-- join_form01 -->
				<div class="join_form01">
					<p class="tit">* 계정정보</p>
					<table class="formT">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>아이디</th>
								<td>${userInfo.id}</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type="password" name="password" id="password"  style="width:310px;">
									<span class="t01">! 새로운 비밀번호로 변경할 분만 입력하세요.</span>
								</td>
							</tr>
							<tr>
								<th>비밀번호확인</th>
								<td>
									<input type="password" name="re_password" id="re_password" style="width:310px;">
									<span class="t01">! 변경할 비밀번호를 한번 더 입력하세요.</span>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>${userInfo.name}</td>
							</tr>
							<tr>
								<th>성별/생년월일</th>
								<td>
									<select name="sex" id="sex"  style="width:70px;">
										<option value="m" <c:if test="${info.sex eq 'm' }">selected="selected"</c:if>>남자</option>
										<option value="w" <c:if test="${info.sex eq 'w' }">selected="selected"</c:if>>여자</option>
									</select>
									<c:set var="jumin" value="${fn:split(info.jumin,'-')}" />
									<select name="jumin1" id="jumin1"  style="width:70px;">
										<c:forEach var="i" begin="0" end="${2016-1900}">
										    <c:set var="yearOption" value="${2016-i}" />
										    <option value="${yearOption}"   <c:if test="${yearOption eq jumin[0] }">selected="selected"</c:if> >${yearOption}</option>
										</c:forEach>
									</select>
									년
									<select name="jumin2" id="jumin2"  style="width:60px;">
										<c:forEach var="i" begin="1" end="12">
											<option value="<c:if test="${i < 10 }">0</c:if>${i}" <c:if test="${i eq jumin[1] }">selected="selected"</c:if> > <c:if test="${i < 10 }">0</c:if>${i}</option>
										</c:forEach>						
									</select>
									월
									<select name="jumin3" id="jumin3"  style="width:60px;">
										<c:forEach var="i" begin="1" end="31">
											<option value="<c:if test="${i < 10 }">0</c:if>${i}"  <c:if test="${i eq jumin[2] }">selected="selected"</c:if>  > <c:if test="${i < 10 }">0</c:if>${i}</option>
										</c:forEach>
									</select>
									일
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>
									<span class="dI H40">
										<input type="text" value="${info.zipcode }" name="zipcode" id="zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn1"><span id="addrBtn1" class="h35 cB">주소찾기</span></a>
									</span>
									<span class="dI">
										<input type="text" value="${info.address01 }" name="address01" style="width:400px;" readonly id="address01">
										<input type="text" value="${info.address02 }" name="address02" style="width:250px;" id="address02"> 
									</span>
								</td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td>
									<c:set var="handphone" value="${fn:split(info.handphone,'-')}" />
									<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4" value="${handphone[0]}"> -
									<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4" value="${handphone[1]}"> -
									<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4" value="${handphone[2]}">
								</td>
							</tr>
							<tr>
								<th>이메일 주소</th>
								<td>
									<c:set var="email" value="${fn:split(info.email,'@')}" />
								
									<input type="text" id="email1" name="email1" style="width:130px;" value="${email[0]}"> @ 
									<input type="text" id="email2" name="email2" style="width:100px;" value="${email[1]}">
									<select name="email3" id="email3" style="width:133px;">
										<option value=""  <c:if test="${email[1] eq '' }">selected="selected"</c:if>>직접입력</option>
										<option value="naver.com"   <c:if test="${email[1] eq 'naver.com' }">selected="selected"</c:if>>naver.com</option>
										<option value="hanmail.net" <c:if test="${email[1] eq 'hanmail.net' }">selected="selected"</c:if>>hanmail.net</option>
										<option value="yahoo.co.kr" <c:if test="${email[1] eq 'yahoo.co.kr' }">selected="selected"</c:if>>yahoo.co.kr</option>
										<option value="gmail.com"   <c:if test="${email[1] eq 'gmail.com' }">selected="selected"</c:if>>gmail.com</option>
										<option value="daum.net"    <c:if test="${email[1] eq 'daum.net' }">selected="selected"</c:if>>daum.net</option>
									</select>
									<span class="t02">(전자세금계산서 발행용도)</span>
									<input type="checkbox" name="mailing" id="mailing" value="y" checked="checked"> <span class="f13">이메일 수신 </span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //join_form01 -->
				<!-- a_yakjae_price -->
				<!-- join_form02 -->
				<div class="join_form02">
					<c:if test="${userInfo.part eq 1}">
						<p class="tit">* 의료기관 정보입력</p>
					</c:if>
					<c:if test="${userInfo.part eq 2}">
						<p class="tit">*  한의사 정보입력</p>
					</c:if>
					<table class="formT">
						<colgroup>
							<col width="140px" />
							<col width="290px" />
							<col width="100px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>면허번호</th>
								<td colspan="3">
									<input type="text" value="${info.license_no}" name="license_no" id="license_no" style="width:180px; margin-right:10px;"><input type="file" name="member_file"  id="member_file" style="width:200px;"/>
									<span class="t01">! 면허증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
								</td>
							</tr>
							<c:if test="${userInfo.part eq 1}">
								<tr>
									<th>한의원명</th>
									<td>
										<input type="text" name="han_name" id="han_name" style="width:265px;" value="${info.han_name}">
									</td>
									<th>사업자번호</th>
									<td>
										<c:set var="biz_no" value="${fn:split(info.biz_no,'-')}" />
										<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="3" value="${biz_no[0]}"> -
										<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="2" value="${biz_no[1]}"> -
										<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="5" value="${biz_no[2]}">
									</td>
								</tr>
								<tr>
									<th>사업자등록증</th>
									<td colspan="3">
										<input type="file" style="width:265px;" id="member_file2" name="member_file2"/>
										<span class="t01">! 사업자 등록증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
									</td>
								</tr>
								<tr>
									<th>한의원주소</th>
									<td colspan="3">
										<span class="dI H40">
											<input type="text" value="${info.han_zipcode }" name="han_zipcode" id="han_zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn2"><span id="addrBtn1" class="h35 cB">주소찾기</span></a>
										</span>
										<span class="dI">
											<input type="text" value="${info.han_address01 }" name="han_address01" style="width:400px;" readonly id="han_address01">
											<input type="text" value="${info.han_address02 }" name="han_address02" style="width:250px;" id="han_address02"> 
										</span>
									</td>
								</tr>
								<tr>
									<th>전화번호<span class="t03">(선택)</span></th>
									<td>
										<c:set var="han_tel" value="${fn:split(info.han_tel,'-')}" />
										<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4" value="${han_tel[0]}"> -
										<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4" value="${han_tel[1]}"> -
										<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4" value="${han_tel[2]}">
									</td>
									<th>팩스번호<span class="t03">(선택)</span></th>
									<td>
										<c:set var="han_fax" value="${fn:split(info.han_fax,'-')}" />
										<input type="text" id="han_fax_1" name="han_fax_1" style="width:65px;" maxlength="4" value="${han_fax[0]}"> -
										<input type="text" id="han_fax_2" name="han_fax_2" style="width:65px;" maxlength="4" value="${han_fax[1]}"> -
										<input type="text" id="han_fax_3" name="han_fax_3" style="width:65px;" maxlength="4" value="${han_fax[2]}">
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					
				</div>
				<!-- //join_form02 -->
				<!-- btnarea -->
				<div class="btn_area01">
					<a href="#" id="cancelBtn" ><span class="cw h60">취소</span></a>
					<a href="#" id="memberBtn"><span class="cg h60">수정하기</span></a>
				</div>
				<!-- //btnarea -->
			</form>

		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	