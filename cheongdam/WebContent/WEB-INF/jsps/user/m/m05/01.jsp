<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="/assets/common/js/jquery.form.min.js"></script>
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
			
			if(!valCheck( 'han_tel_1' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_tel_2' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_tel_3' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			
			var ext2 = $('#member_file2').val().split('.').pop().toLowerCase();
			
			if( objToStr(ext2 , '') != '' ){
				if($.inArray(ext2, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					return false;
				}	
			}
		}
		
		 
		$('#frm').ajaxForm({		        
			url     : '/m/m05/01_mypage.do',
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
	
});
</script>
<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
<!-- container -->
<div class="container sub" id="contents">
	<!-- LNB -->
	<div class="localMenu">
		<p class="tit">내 정보수정</p>
		<div class="lnbDepth lnbDepth4">
			<ul>
				<li class="sel"><a href="01.do">내 정보수정</a></li>
				<li><a href="03.do">주문내역</a></li>
				<li ><a href="04.do" style="letter-spacing: -3px;">탕전공동사용계약서</a></li>
				<li ><a href="99.do" style="letter-spacing: -3px;">포인트사용내역</a></li>
			</ul>
		</div>
	</div>
	<!-- LNB -->

	<!-- 본문 -->
	<form action="#" id="frm" name="frm" enctype="multipart/form-data" method="post" >
	<div class="contents member" id="contents">				
		<p class="contsTit fc01">계정정보</p>
		<div class="innerBoxMem">
			<ul class="memberForm">
				<li class="type02">
					<span class="title">아이디</span>
					<div>${userInfo.id}</div>
				</li>
				<li>
					<input type="password" name="password" id="password"  placeholder="비밀번호" title="비밀번호 ">
					<p class="infoNoti">! 아이디에 포함된 문자는 비밀번호사용에 자제하세요.</p>
				</li>
				<li>
					<input type="password" name="re_password" id="re_password" placeholder="비밀번호 확인" title="비밀번호 확인 ">
					<p class="validationNo">! 비밀번호를 한번 더 입력하세요.</p>
				</li>
				<li class="type02">
					<span class="title">이름</span>
					<div>${userInfo.name}</div>
				</li>
				<li class="type02 genArea">
					<span class="title">성별</span>
					<div  style="<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>">
						<input type="radio" id="male" name="sex" value="m" <c:if test="${info.sex eq 'm' }">checked="checked"</c:if>  > <label for="male">남</label>
						<input type="radio" id="female" name="sex" value="w"  <c:if test="${info.sex eq 'w' }">checked="checked"</c:if>> <label for="female">여</label>
					</div>
					<div style="<c:if test="${info.info_fix eq 'Y'}">display:none;</c:if>" >
						<c:if test="${info.sex eq 'm' }">남</c:if>
						<c:if test="${info.sex eq 'w' }">여</c:if>
					</div>
				</li>
				<li class="type02">
					<label class="title" for="jumin1">생년월일</label>
					<div  style="<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>">
						<c:set var="jumin" value="${fn:split(info.jumin,'-')}" />
						<select name="jumin1" id="jumin1"  style="width:60px;">
							<c:forEach var="i" begin="0" end="${2016-1900}">
							    <c:set var="yearOption" value="${2016-i}" />
							    <option value="${yearOption}"   <c:if test="${yearOption eq jumin[0] }">selected="selected"</c:if> >${yearOption}</option>
							</c:forEach>
						</select>
						년
						<select name="jumin2" id="jumin2"  style="width:50px;">
							<c:forEach var="i" begin="1" end="12">
								<option value="<c:if test="${i < 10 }">0</c:if>${i}" <c:if test="${i eq jumin[1] }">selected="selected"</c:if> > <c:if test="${i < 10 }">0</c:if>${i}</option>
							</c:forEach>
						</select>
						월
						<select name="jumin3" id="jumin3"  style="width:50px;">
							<c:forEach var="i" begin="1" end="31">
								<option value="<c:if test="${i < 10 }">0</c:if>${i}"  <c:if test="${i eq jumin[2] }">selected="selected"</c:if>  > <c:if test="${i < 10 }">0</c:if>${i}</option>
							</c:forEach>
						</select>
						일
					</div>
					<c:if test="${info.info_fix ne 'Y'}">
						<div>
							${info.jumin}
						</div>
					</c:if>
				</li>						
				<li class="type02 address">
					<label class="title" for="findAddrBtn1" >주소</label>
					<div>
						<span><input type="text" name="zipcode" id="zipcode"  value="${info.zipcode }" style="width:130px;" readonly></span>
						<c:if test="${info.info_fix eq 'Y'}">
							<button type="button" class="btnTypeBasic" id="findAddrBtn1"><span>주소찾기</span></button>
						</c:if>
						<input type="text" value="${info.address01 }" name="address01" style="width:100%;" readonly id="address01">
						<input type="text" value="${info.address02 }" name="address02" style="width:100%;" id="address02" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> 
					</div>
				</li>
				<li class="type02">
					<label class="title" for="handphone01">휴대폰</label>
					<div>
						<c:set var="handphone" value="${fn:split(info.handphone,'-')}" />
						<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4" value="${handphone[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4" value="${handphone[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4" value="${handphone[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
					</div>
				</li>
				<li class="type02">
					<label class="title" for="email1">이메일</label>
					<div  style="<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>">
						<c:set var="email" value="${fn:split(info.email,'@')}" />
						<input type="text" id="email1" name="email1" style="width:50%;" value="${email[0]}"> @ 
						<input type="text" id="email2" name="email2" style="width:40%;" value="${email[1]}"><br/>
						<span class="greent">(전자세금계산서 발행용도)</span>
						<input type="checkbox" name="mailing" id="mailing" value="y" <c:if test="${info.mailing eq 'y' }">checked="checked"</c:if>  > <span><label for="mailing">이메일 수신</label> </span>
					</div>
					<c:if test="${info.info_fix ne 'Y'}">
						<div>
							${info.email}
							<span class="greent">(전자세금계산서 발행용도)</span>
							<label for="mailing">
							이메일 수신여부 : 
							</label>
							<c:if test="${info.mailing eq 'y' }">예</c:if>
							<c:if test="${info.mailing ne 'y' }">아니오</c:if>
						</div>
					</c:if>
				</li>
			</ul>
		</div>
		
		<p class="contsTit fc02 mt20">
			<c:if test="${userInfo.part eq 1}">의료기관 정보입력</c:if>
			<c:if test="${userInfo.part eq 2}">한의사 정보입력</c:if>
		</p>
		<p class="Memtit">면허증 및 사업자등록증은 확인가능한 이미지를 올려주시기 바랍니다.</p>
		<div class="innerBoxMemP">
			<ul class="memberForm">
				<li class="type02">
					<label class="title" for="license_no">면허정보</label>
					<div>
						<input type="text" value="${info.license_no}" name="license_no" id="license_no"  style="width:100%; margin-right:10px;" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
						<input type="file" name="member_file"  id="member_file" style="width:100%;<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>"/><br/>
						<p class="infoNoti">! 면허증 이미지를 첨부해 주세요(형식:jpg, gif)</p>
						<c:if test="${!empty info.member_file }">
							<p><a style="color: blue;" href="/download.do?path=member_file&filename=${info.member_file}&refilename=${info.member_file_re}">[기존 첨부된 면허증 다운로드]</a></p>
						</c:if>
					</div>
				</li>
				<c:if test="${userInfo.part eq 1}">
					<li class="type02">
						<label class="title" for="han_name">한의원명</label>
						<div>
							<input type="text" name="han_name" id="han_name" value="${info.han_name}">
						</div>
					</li>
					<li class="type02">
						<label class="title" for="biz_no_1">사업자번호</label>
						<div>
							<c:set var="biz_no" value="${fn:split(info.biz_no,'-')}" />
							<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="4" value="${biz_no[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
							<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="4" value="${biz_no[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
							<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="4" value="${biz_no[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if> >
						</div>
					</li>
					<li class="type02">
						<label class="title" for="member_file2">사업자 등록증</label>
						<div>
							<input type="file" id="member_file2" name="member_file2" style="width:100%;"/>
							<p class="infoNoti">! 사업자 등록증 이미지를 첨부해 주세요(형식:jpg, gif)</p>
							<c:if test="${!empty info.member_file2 }">
								<p><a style="color: blue;" href="/download.do?path=member_file&filename=${info.member_file2}&refilename=${info.member_file2_re}">[기존 첨부된 사업자등록증 다운로드]</a></p>
							</c:if>
						</div>
					</li>
					<li class="type02 address">
						<label class="title" for="findAddrBtn2">한의원 주소</label>
						<div>
							<span><input type="text" value="${info.han_zipcode }" name="han_zipcode" id="han_zipcode" style="width:130px;" readonly></span>
							<c:if test="${info.info_fix eq 'Y'}">
								<button type="button" class="btnTypeBasic" id="findAddrBtn2"><span>주소찾기</span></button>
							</c:if>
							<input type="text"  value="${info.han_address01 }" name="han_address01"  style="width:100%;" id="han_address01" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
							<input type="text"  value="${info.han_address02 }" name="han_address02"  style="width:100%;" id="han_address02" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> 
						</div>
					</li>
					<li class="type02">
						<label class="title line0" for="han_tel_1">전화번호<br/><span class="infoNoti">필수</span></label>
						<div>
							<c:set var="han_tel" value="${fn:split(info.han_tel,'-')}" />
							<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4" value="${han_tel[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
							<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4" value="${han_tel[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
							<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4" value="${han_tel[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
						</div>
					</li>
					<li class="type02">
						<label class="title line0" for="han_fax_1">팩스번호<br/><span class="greent">선택사항</span></label>
						<div>
							<c:set var="han_fax" value="${fn:split(info.han_fax,'-')}" />
							<input type="text" id="han_fax_1" name="han_fax_1" style="width:65px;" maxlength="4" value="${han_fax[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
							<input type="text" id="han_fax_2" name="han_fax_2" style="width:65px;" maxlength="4" value="${han_fax[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
							<input type="text" id="han_fax_3" name="han_fax_3" style="width:65px;" maxlength="4" value="${han_fax[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>								
						</div>
					</li>
				</c:if>
			</ul>
		</div>

		<div class="btnArea write">
			<!-- <button type="button" class="btnTypeBasic colorWhite"><span>취소</span></button> -->
			<p style="text-align:center; padding:0 0 10px 0; font-weight:600;">면허증 사업자 등록증 첨부 시 고객센터로 연락부탁드립니다.</p>
			<button type="button" id="memberBtn" class="btnTypeBasic colorGreen"><span>수정하기</span></button><br/>
			<c:if test="${info.info_fix ne 'Y'}">
				<span class="t01" style="font-size: 15px;color: red;">비밀번호만 수정가능한 상태입니다<br/>정보 수정이 필요한경우<br/> 원외탕전 고객센터로 연락하세요.</span>
			</c:if>
		</div>
	</div>
	<!-- //본문 -->
	</form>

</div>
<!-- //container -->
		