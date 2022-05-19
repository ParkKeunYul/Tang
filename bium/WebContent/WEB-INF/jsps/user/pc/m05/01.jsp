<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/assets/common/js/jSignature/jSignature.min.js"></script> 
<!-- <script src="libs/modernizr.js"></script> --> 
<!--[if lt IE 9]> 
	<script type="text/javascript" src="/assets/common/js/jSignature/flashcanvas.js"></script> 
<![endif]-->
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
		
		/* 
		var data = $('#signature').jSignature("getData", "base30");
        var i = new Image()
        i.src = "data:" + data[0] + "," + data[1];
        if(i.src == 'data:image/jsignature;base30,'){
       	 alert('서명이 필요합니다.');
       	 //$('#signature').focus();
       	 return false;
        }
        $('#sign_img').val(i.src);
         */
        
		 
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
			
			if(!valCheck( 'han_tel_1' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_tel_2' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_tel_3' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			
			//if(!valCheck( 'member_file2' ,'사업자등록증을 첨부하세요.') ) return false;
			var ext2 = $('#member_file2').val().split('.').pop().toLowerCase();
			
			if( objToStr(ext2 , '') != '' ){
				if($.inArray(ext2, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					return false;
				}	
			}
		}
		
		/*  
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
		 */
		 
		 if(confirm('수정 하겠습니까?')){
			 $('#frm').submit();
			 return true;	 
		 }
		 return false;
		 
		
	});
	
	$("#set_addr").click(function() {
		console.log($(this).is(":checked"));
		
		if( $(this).is(":checked") ){
			
			var zipcode = $('#zipcode').val();
			var address01 = $('#address01').val();
			var address02 = $('#address02').val();
			if(zipcode != null && zipcode != ''){
				$('#han_zipcode').val(zipcode);
				$('#han_address01').val(address01);
				$('#han_address02').val(address02);
			}else{
				$(this).prop('checked', false);
			}
		}else{
			$('#han_zipcode').val('');
			$('#han_address01').val('');
			$('#han_address02').val('');
		}
	});
	
	$("#signature").jSignature({
		 'UndoButton':false
		,'height'    : 200
		,'width'     : 400
	});
	
	$("#clearBtn").click(function() {
		$('#signature').jSignature('reset');
		return false;
	});
	
	//init_img();
		
});

function init_img(){
	var sign_img = $('#sign_img').val();
	
	
	if(sign_img != null ){
		console.log('sign_img = ', sign_img);
		
		$("#signature").jSignature("importData", sign_img);
	}
	
}
</script>

<!-- contents -->
<div class="contents">
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>회원 정보수정</span></p>
	<ul class="submenu w50">
		<li><a href="/m05/01.do" class="sel">회원 정보수정</a></li>
		<li><a href="/m05/03.do" class="">주문내역</a></li>
	</ul>
	
	<!-- 본문내용 -->
	<!-- join_form01 -->
	<form action="/m05/01_mypage.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
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
						<span class="t01">! 아이디에 포함된 문자는 비밀번호사용에 자제하세요. </span>
					</td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td>
						<input type="password" name="re_password" id="re_password" style="width:310px;">
						<span class="t01">! 비밀번호를 한번 더 입력하세요. </span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						${userInfo.name}
						<!-- <span class="t02">(! 반드시 실명을 기재해 주세요.)</span> -->
					</td>
				</tr>
				<tr>
					<th>성별/생년월일</th>
					<td>
						<div style="<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>">
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
						</div>
						<c:if test="${info.info_fix ne 'Y'}">
							<c:if test="${info.sex eq 'm' }">남</c:if>
							<c:if test="${info.sex eq 'w' }">여</c:if>
							${info.jumin}
						</c:if>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<span class="dI H40">
							<input type="text" value="${info.zipcode }" name="zipcode" id="zipcode" style="width:180px;" readonly>
							<c:if test="${info.info_fix eq 'Y'}">
								<a href="#" id="findAddrBtn1"><span id="addrBtn1" class="h35 cB">주소찾기</span></a>
								<div style="display: none;">
									<c:if test="${userInfo.part eq 1}">
										<input type="checkbox" id="set_addr" style="vertical-align: middle;" />
										<label for="set_addr" class="t01" style="margin-left: 0px;">(한의원 주소 정보 저장)</label>
									</c:if>
								</div>
							</c:if>
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
						<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4" value="${handphone[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4" value="${handphone[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4" value="${handphone[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
					</td>
				</tr>
				<tr>
					<th>이메일 주소</th>
					<td>
						<c:set var="email" value="${fn:split(info.email,'@')}" />
							
							
						<div style="<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>">
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
							<input type="checkbox" name="mailing" id="mailing" value="y" <c:if test="${info.mailing eq 'y' }">checked="checked"</c:if> style="vertical-align: middle;" > <span class="f13"><label for="mailing">이메일 수신</label> </span>
						</div>
						<c:if test="${info.info_fix ne 'Y'}">
							${info.email}
							<span class="t02">(전자세금계산서 발행용도)</span>
							이메일 수신여부 : 
							<c:if test="${info.mailing eq 'y' }">예</c:if>
							<c:if test="${info.mailing ne 'y' }">아니오</c:if>
						</c:if>
						
					</td>
				</tr>
				<tr style="display:none;">
					<th>서명</th>
					<td>
						<div class="bbline" style="height:200px;width: 400px;" id="signature"></div>
						<br/>
						(위 영역에서 마우스 왼쪽버튼을 누른채 드래그하시면 됩니다.)
						<a href="#" id="clearBtn"><span class="h25 cBl">서명지우기</span></a>
						<input type="hidden" id="sign_img"      name="sign_img" value="${info.sign_img }" />
					</td>
				</tr>
					
			</tbody>
		</table>
	</div>
	<!-- //join_form01 -->
	
	<!-- join_form01 -->
	<div class="join_form01">
		<p class="tit">* 의료기관 정보입력</p>
		<table class="formT">
			<colgroup>
				<col width="140px" />
				<col width="330px" />
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>면허번호</th>
					<td colspan="3">
						<input type="text" value="${info.license_no}" name="license_no" id="license_no" style="width:180px; margin-right:10px;"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if> >
						<input type="file" name="member_file"  id="member_file" style="width:200px;<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>"/>
						
						<span class="t01">! 면허증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
						<c:if test="${!empty info.member_file }">
							<div><a style="color: blue;" href="/download.do?path=member_file&filename=${info.member_file}&refilename=${info.member_file_re}">[기존 첨부된 면허증 다운로드]</a></div>
						</c:if>
						
					</td>
				</tr>
				<tr>
					<th>한의원명</th>
					<td>
						<input type="text" name="han_name" id="han_name" style="width:265px;" value="${info.han_name}"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
					</td>
					<th>사업자번호</th>
					<td>
						<c:set var="biz_no" value="${fn:split(info.biz_no,'-')}" />
						<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="3" value="${biz_no[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="2" value="${biz_no[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="5" value="${biz_no[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
					</td>
				</tr>
				<tr>
					<th>사업자등록증</th>
					<td colspan="3">
						<input type="file" style="width:265px;<c:if test="${info.info_fix ne 'Y'}">display:none;</c:if>" id="member_file2" name="member_file2"   />
						<span class="t01">! 사업자 등록증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
						<c:if test="${!empty info.member_file2 }">
							<div><a style="color: blue;" href="/download.do?path=member_file&filename=${info.member_file2}&refilename=${info.member_file2_re}">[기존 첨부된 사업자등록증 다운로드]</a></div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>한의원주소</th>
					<td colspan="3">
						<span class="dI H40">
							<input type="text" value="${info.han_zipcode }" name="han_zipcode" id="han_zipcode" style="width:180px;" readonly>
							 <c:if test="${info.info_fix eq 'Y'}"><a href="#" id="findAddrBtn2"><span id="addrBtn1" class="h35 cB">주소찾기</span></a></c:if>
						</span>
						<span class="dI">
							<input type="text" value="${info.han_address01 }" name="han_address01" style="width:400px;" readonly id="han_address01"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
							<input type="text" value="${info.han_address02 }" name="han_address02" style="width:250px;" id="han_address02"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> 
						</span>
					</td>
				</tr>
				<tr>
					<th>전화번호<span class="t01">(필수)</span></th>
					<td>
						<c:set var="han_tel" value="${fn:split(info.han_tel,'-')}" />
						<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4" value="${han_tel[0]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4" value="${han_tel[1]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4" value="${han_tel[2]}" <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
					</td>
					<th>팩스번호<span class="t03">(선택)</span></th>
					<td>
						<c:set var="han_fax" value="${fn:split(info.han_fax,'-')}" />
						<input type="text" id="han_fax_1" name="han_fax_1" style="width:65px;" maxlength="4" value="${han_fax[0]}"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="han_fax_2" name="han_fax_2" style="width:65px;" maxlength="4" value="${han_fax[1]}"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>> -
						<input type="text" id="han_fax_3" name="han_fax_3" style="width:65px;" maxlength="4" value="${han_fax[2]}"  <c:if test="${info.info_fix ne 'Y'}">readonly="readonly"</c:if>>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- //join_form01 -->
	</form>
	
	<!-- btnarea -->
	<div class="btn_area01">
		<a href="#" id="memberBtn"><span class="cp h50">수정하기</span></a>
	</div>
	<!-- //btnarea -->
	<!-- //본문내용 -->
</div>
<!-- //contents -->
		