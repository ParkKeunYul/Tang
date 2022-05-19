<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
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
		
		
		$("#handphone01,#handphone02,#handphone03,#han_tel_1,#han_tel_2,#han_tel_3,#han_fax_1,#han_fax_2,#han_fax_3").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		    $(this).val( $(this).val().replace(/ /gi, '') );
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
		
		$( '#id , #email1' ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			$(this).val( $(this).val().replace(/ /gi, '') );
		});
		
		
		$("#dupleIdBtn").click(function() {
			if(!valCheck( 'id' ,'아이디를 입력하세요.') ) return  false;
			
			if($('#id').val().length > 12 || $('#id').val().length < 6){
				alert('6~12자리 사이의 아이디를 입력하세요.');
				$('#id').focus();
				return false;
			}
			
			
			$.ajax({
				url : '/m06/duple_id.do',
			    data : {
			    	id : $('#id').val()
			    },        
		        error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	alert(data.msg);
			    	$('#check_id').val(data.check_id);
			    }   
			});
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
		
		$("#memberBtn").click(function() {
			
			if(!valCheck( 'id' ,'아이디를 입력하세요.') ) return  false;
			
			if($('#id').val().length > 12 || $('#id').val().length < 6){
				alert('6~12자리 사이의 아이디를 입력하세요.');
				$('#id').focus();
				return  false;
			}
			
			if( $('#check_id').val == 0 ){
				alert('아이디 중복확인이 필요합니다.');
				return  false;
			}
			
			if(!valCheck( 'password' ,'비밀번호를 입력하세요.') ) return  false;
			if(!valCheck( 're_password' ,'비밀번호를 입력하세요.') ) return  false;
			if(!pwdCheck('password', 're_password') ) return  false;
			if(!valCheck( 'name' ,'이름을 입력하세요.') ) return  false;
			
			
			if(!valCheck( 'zipcode' ,'주소를 입력하세요.') ) return  false;
			if(!valCheck( 'address01' ,'주소를 입력하세요.') ) return  false;
			if(!valCheck( 'address02' ,'주소를 입력하세요.') ) return  false;
			if(!valCheck( 'handphone01' ,'휴대전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'handphone02' ,'휴대전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'handphone03' ,'휴대전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'email1' ,'이메일주소를 입력하세요.') ) return  false;
			if(!valCheck( 'email2' ,'이메일주소를 입력하세요.') ) return  false;
			if(!valCheck( 'han_name' ,'한의원명을 입력하세요.') ) return  false;
			if(!valCheck( 'biz_no_1' ,'사업자번호를 입력하세요.') ) return  false;
			if(!valCheck( 'biz_no_2' ,'사업자번호를 입력하세요.') ) return  false;
			if(!valCheck( 'biz_no_3' ,'사업자번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_zipcode' ,'주소를 입력하세요.') ) return  false;
			if(!valCheck( 'han_address01' ,'주소를 입력하세요.') ) return  false;
			if(!valCheck( 'han_address02' ,'주소를 입력하세요.') ) return  false;
			
			if(!valCheck( 'han_tel_1' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_tel_2' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			if(!valCheck( 'han_tel_3' ,'의료기관 전화번호를 입력하세요.') ) return  false;
			
			
			 
			//if(!valCheck( 'member_file' ,'면허증을 첨부하세요.') ) return  false;
			//if(!valCheck( 'member_file2' ,'사업자등록증을 첨부하세요.') ) return  false;
			
			var ext = $('#member_file').val().split('.').pop().toLowerCase();
			if(ext != '' && ext != null){
				if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					return  false;
				} 
			}
			
			var ext2 = $('#member_file2').val().split('.').pop().toLowerCase();
			if(ext2 != '' && ext2 != null){
				if($.inArray(ext2, ['gif','png','jpg','jpeg']) == -1) {
					alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
					return  false;
				} 
			}
			
			$('#frm').ajaxForm({		        
				url     : "/m06/proc_01_step2_1.do",
		        enctype : "multipart/form-data",
		        beforeSerialize: function(){
		             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
		        },
		        beforeSubmit : function() {
		        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
		        },
		        success : function(data) {		             
		           // console.log('data = ', data);
		           alert(data.msg);
		           if(data.suc){
		        	   location.href='join_end.do';
		           }
		        }		        
		    });
			$("#frm").submit();
			return false;
		});
		
	});
	
</script>

<form action="/m06/proc_01_step2_1.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="part" value="1" />
	<input type="hidden" name="check_value_re" value="1" />
	<input type="hidden" name="check_id" id="check_id" value="0" />
	<input type="hidden" name="member_level" id="member_level" value="0" />

	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	<!-- container -->
	<div class="container sub" id="contents">
		<!-- LNB -->
		<div class="localMenu">
			<p class="tit">회원가입</p>
			<p class="commentbox">
				<strong>의료기관으로 회원가입을 진행합니다.</strong><br/>입력하신 e-mail로 전자세금계산서가 발행되오니 의료기관용 e-mail을 정확하게 입력해 주시기 바랍니다.<br/>의료기관 정보입력에서 면허증과 사업자등록증은 반드시 첨부해주셔야 회원가입이 가능합니다.<br/>자세한 내용은 Tel.054-242-1079로 문의 주시기 바랍니다.
			</p>
		</div>
		<!-- LNB -->
	
		<!-- 본문 -->
		<div class="contents member" id="contents">				
			<p class="contsTit fc01">계정정보</p>
			<div class="innerBoxMem">
				<ul class="memberForm">
					<li>
						<div class="idArea">
							<span><input type="text" name="id" id="id" placeholder="아이디" title="아이디 "></span>
							<button type="button" class="btnTypeBasic" id="dupleIdBtn"><span>중복확인</span></button>
						</div>
						<p class="infoNoti">! 6~12자리의 아이디를 생성해주세요.</p>
					</li>
					<li>
						<input type="password" name="password" id="password" placeholder="비밀번호" title="비밀번호 ">
						<p class="infoNoti">! 아이디에 포함된 문자는 비밀번호사용에 자제하세요.</p>
					</li>
					<li>
						<input type="password"  name="re_password" id="re_password" placeholder="비밀번호 확인" title="비밀번호 확인 ">
						<p class="validationNo">! 비밀번호를 한번 더 입력하세요.</p>
					</li>
					<li>
						<input type="text" placeholder="이름" title="이름" name="name" id="name">
						<p class="validationNo">! 실명을 입력하세요.</p>
					</li>
					<li class="type02 genArea">
						<span class="title">성별</span>
						<div>
							<input type="radio" id="male" name="sex" value="m"> <label for="male">남</label>
							<input type="radio" id="female" name="sex" value="w"> <label for="female">여</label>
						</div>
					</li>
					<li class="type02">
						<label class="title">생년월일</label>
						<div>
							<select name="jumin1" id="jumin1"  style="width:60px;">
								<c:forEach var="i" begin="0" end="${2016-1900}">
								    <c:set var="yearOption" value="${2016-i}" />
								    <option value="${yearOption}"   <c:if test="${yearOption eq 1980 }">selected="selected"</c:if> >${yearOption}</option>
								</c:forEach>
							</select>
							년
							<select name="jumin2" id="jumin2"  style="width:50px;">
								<c:forEach var="i" begin="1" end="12">
									<option value="<c:if test="${i < 10 }">0</c:if>${i}"> <c:if test="${i < 10 }">0</c:if>${i}</option>
								</c:forEach>
							</select>
							월
							<select name="jumin3" id="jumin3"  style="width:50px;">
								<c:forEach var="i" begin="1" end="31">
									<option value="<c:if test="${i < 10 }">0</c:if>${i}"> <c:if test="${i < 10 }">0</c:if>${i}</option>
								</c:forEach>
							</select>
							일
						</div>
					</li>						
					<li class="type02 address">
						<label class="title">주소</label>
						<div>
							<span><input type="text" name="zipcode" id="zipcode" style="width:130px;" readonly></span><button type="button" class="btnTypeBasic" id="findAddrBtn1"><span>주소찾기</span></button>							
							<input type="text" name="address01" style="width:100%;" readonly id="address01">
							<input type="text" name="address02" style="width:100%;" id="address02"> 
							<input type="checkbox" id="set_addr" style="vertical-align: middle;" /><label for="set_addr" class="t01" style="margin-left: 0px;color: #e10505;">(의료기관 주소 입력)</label>
						</div>
					</li>
					<li class="type02">
						<label class="title" for="phone">휴대폰</label>
						<div>
							<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4"> -
							<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4"> -
							<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4">
						</div>
					</li>
					<li class="type02">
						<label class="title" for="mail">이메일</label>
						<div>
							<input type="text" id="email1" name="email1" style="width:50%;"> @ 
							<input type="text" id="email2" name="email2" style="width:40%;"><br/>
							<span class="greent">(전자세금계산서 발행용도)</span>
							<input type="checkbox" name="mailing" id="mailing" value="y" checked> <span><label for="mailing">이메일 수신</label></span>
						</div>
					</li>
				</ul>
			</div>
	
			<p class="contsTit fc02 mt20">의료기관 정보입력</p>
			<p class="Memtit">면허증 및 사업자등록증은 확인가능한 이미지를 올려주시기 바랍니다.</p>
			<div class="innerBoxMemP">
				<ul class="memberForm">
					<li class="type02">
						<label class="title">면허정보</label>
						<div>
							<input type="text" name="license_no" id="license_no" style="width:90%; margin-right:10px;"><br/>
							<input type="file" id="member_file" name="member_file"  style="width:100%;"/>
							<p class="infoNoti">! 면허증 이미지를 첨부해 주세요(형식:jpg, gif)</p>
						</div>
					</li>
					<li class="type02">
						<label class="title">한의원명</label>
						<div>
							<input type="text" name="han_name" id="han_name">
						</div>
					</li>
					<li class="type02">
						<label class="title" for="phone">사업자번호</label>
						<div>
							<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="4"> -
							<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="4"> -
							<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="4">
						</div>
					</li>
					<li class="type02">
						<label class="title">사업자 등록증</label>
						<div>
							<input type="file" id="member_file2" name="member_file2" style="width:100%;"/>
							<p class="infoNoti">! 사업자 등록증 이미지를 첨부해 주세요(형식:jpg, gif)</p>
						</div>
					</li>
					<li class="type02 address">
						<label class="title">한의원 주소</label>
						<div>
							<span><input type="text" name="han_zipcode" id="han_zipcode" style="width:130px;" readonly></span><button id="findAddrBtn2" type="button" class="btnTypeBasic"><span>주소찾기</span></button>
							<input type="text" name="han_address01" style="width:100%;" readonly id="han_address01">
							<input type="text" name="han_address02" style="width:100%;" id="han_address02"> 
						</div>
					</li>
					<li class="type02">
						<label class="title line0" for="tel">전화번호<br/><span class="infoNoti">필수</span></label>
						<div>
							<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4">
						</div>
					</li>
					<li class="type02">
						<label class="title line0" for="fax">팩스번호<br/><span class="greent">선택사항</span></label>
						<div>							
							<input type="text" id="han_fax_1" name="han_fax_1" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_fax_2" name="han_fax_2" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_fax_3" name="han_fax_3" style="width:65px;" maxlength="4">								
						</div>
					</li>
				</ul>
			</div>
	
			<div class="btnArea write">
				<button type="button" onclick="location.href='01_step1_1.do'" class="btnTypeBasic sizeL colorWhite"><span>취소</span></button>
				<button type="button" id="memberBtn" class="btnTypeBasic sizeL colorGreen"><span>회원가입</span></button>
			</div>
		</div>
		<!-- //본문 -->
	
	</div>
	<!-- //container -->
</form>
		