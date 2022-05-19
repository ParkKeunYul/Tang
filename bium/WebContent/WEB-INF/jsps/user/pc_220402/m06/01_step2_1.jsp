<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

	<%@include file="../layout_mem/top.jsp" %>
	
	
	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script src="/assets/common/js/jSignature/jSignature.min.js"></script> 
	<!-- <script src="libs/modernizr.js"></script> --> 
	<!--[if lt IE 9]> 
		<script type="text/javascript" src="/assets/common/js/jSignature/flashcanvas.js"></script> 
	<![endif]-->	
	<script type="text/javascript">
		$(document).ready(function() {
			/* $("#memberBtn").click(function() {
				$('#popup2').bPopup();
				return false;
			}); */
			
			
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
					url : 'duple_id.do',
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
		
			$("#signature").jSignature({
				 'UndoButton':false
				,'height'    : 200
				,'width'     : 400
			});
			
			$("#clearBtn").click(function() {
				$('#signature').jSignature('reset');
				return false;
			});
			
		});
		
	</script>
		
	<div class="banner">
		<h3>회원가입</h3>
		<p class="txtarea">
			<strong>의료기관으로 회원가입을 진행합니다.</strong><br/>
			입력하신 e-mail로 전자세금계산서가 발행되오니 의료기관용 e-mail을 정확하게 입력해 주시기 바랍니다.<br/>의료기관 정보입력에서 면허증과 사업자등록증은 반드시 첨부해주셔야 회원가입이 가능합니다.<br/>
			자세한 내용은 Tel. 051-892-5100로 문의 주시기 바랍니다.
		</p>
	</div>
	
	<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
	
	<!-- 본문내용 -->
	<!-- join_form01 -->
	<form action="/m06/proc_01_step2_1.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
		<input type="hidden" name="part" value="1" />
		<input type="hidden" name="check_value_re" value="1" />
		<input type="hidden" name="check_id" id="check_id" value="0" />
		<input type="hidden" name="member_level" id="member_level" value="0" />
	
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
						<td>
							<input type="text" name="id" id="id" style="width:220px;">
							<a href="#" id="dupleIdBtn"><span class="h35 cp">중복확인</span></a>
							<span class="t01">! 6~12자리의 아이디를 생성해주세요. </span>
						</td>
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
							<input type="text" name="name" id="name" style="width:200px;">
							<span class="t01">! 반드시 실명을 기재해 주세요.</span>
						</td>
					</tr>
					<tr>
						<th>성별/생년월일</th>
						<td>
							<select name="sex" id="sex"  style="width:70px;">
								<option value="m">남자</option>
								<option value="w">여자</option>
							</select>
							<select name="jumin1" id="jumin1"  style="width:70px;">
								<c:forEach var="i" begin="0" end="${2016-1900}">
								    <c:set var="yearOption" value="${2016-i}" />
								    <option value="${yearOption}"   <c:if test="${yearOption eq 1980 }">selected="selected"</c:if> >${yearOption}</option>
								</c:forEach>
							</select>
							년
							<select name="jumin2" id="jumin2"  style="width:60px;">
								<c:forEach var="i" begin="1" end="12">
									<option value="<c:if test="${i < 10 }">0</c:if>${i}"> <c:if test="${i < 10 }">0</c:if>${i}</option>
								</c:forEach>						
							</select>
							월
							<select name="jumin3" id="jumin3"  style="width:60px;">
								<c:forEach var="i" begin="1" end="31">
									<option value="<c:if test="${i < 10 }">0</c:if>${i}"> <c:if test="${i < 10 }">0</c:if>${i}</option>
								</c:forEach>
							</select>
							일
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<span class="dI H40">
								<input type="text" name="zipcode" id="zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn1"><span id="addrBtn1" class="h35 cp">주소찾기</span></a>
							</span>
							<span class="dI">
								<input type="text" name="address01" style="width:400px;" readonly id="address01">
								<input type="text" name="address02" style="width:250px;" id="address02">
							</span>
						</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							<input type="text" id="handphone01" name="handphone01" style="width:65px;" maxlength="4"> -
							<input type="text" id="handphone02" name="handphone02" style="width:65px;" maxlength="4"> -
							<input type="text" id="handphone03" name="handphone03" style="width:65px;" maxlength="4">
						</td>
					</tr>
					<tr>
						<th>이메일 주소</th>
						<td>
							<input type="text" id="email1" name="email1" style="width:130px;"> @ 
							<input type="text" id="email2" name="email2" style="width:100px;">
							<select name="email3" id="email3" style="width:133px;">
								<option value="" selected>직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="yahoo.co.kr">yahoo.co.kr</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.net">daum.net</option>
							</select>
							<span class="t02">(전자세금계산서 발행용도)</span>
							<input type="checkbox" name="mailing" id="mailing" value="y" style="vertical-align: middle;" > <span class="f13"><label for="mailing">이메일 수신</label></span>
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
					<col width="100px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>면허번호</th>
						<td colspan="3">
							<input type="text" name="license_no" id="license_no" style="width:180px; margin-right:10px;">
							<input type="file" name="member_file" id="member_file" style="width:200px;"/>
							<span class="t01">! 면허증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
						</td>
					</tr>
					<tr>
						<th>한의원명</th>
						<td>
							<input type="text" name="han_name" id="han_name" style="width:265px;">
						</td>
						<th>사업자번호</th>
						<td>
							<input type="text" id="biz_no_1" name="biz_no_1" style="width:65px;" maxlength="3"> -
							<input type="text" id="biz_no_2" name="biz_no_2" style="width:65px;" maxlength="2"> -
							<input type="text" id="biz_no_3" name="biz_no_3" style="width:65px;" maxlength="5">
						</td>
					</tr>
					<tr>
						<th>사업자등록증</th>
						<td colspan="3">
							<input type="file" id="member_file2"  name="member_file2" style="width:265px;"/>
							<span class="t01">! 사업자 등록증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
						</td>
					</tr>
					<tr>
						<th>한의원주소</th>
						<td colspan="3">
							<span class="dI H40">
								<input type="text" name="han_zipcode" id="han_zipcode" style="width:180px;" readonly>
								<a href="#" id="findAddrBtn2"><span  class="h35 cB">주소찾기</span></a>
							</span>
							<span class="dI">
								<input type="text" name="han_address01" style="width:400px;" readonly id="han_address01">
								<input type="text" name="han_address02" style="width:250px;" id="han_address02"> 
							</span>
						</td>
					</tr>
					<tr>
						<th>전화번호<span class="t01">(필수)</span></th>
						<td>
							<input type="text" id="han_tel_1" name="han_tel_1" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_tel_2" name="han_tel_2" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_tel_3" name="han_tel_3" style="width:65px;" maxlength="4">
						</td>
						<th>팩스번호<span class="t03">(선택)</span></th>
						<td>
							<input type="text" id="han_fax_1" name="han_fax_1" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_fax_2" name="han_fax_2" style="width:65px;" maxlength="4"> -
							<input type="text" id="han_fax_3" name="han_fax_3" style="width:65px;" maxlength="4">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	<!-- //join_form01 -->
	
	<!-- btnarea -->
	<div class="btn_area01">
		<a href="#"><span class="cw h50">취소</span></a>
		<a href="#" id="memberBtn"><span class="cp h50">회원가입</span></a>
	</div>
	<!-- //btnarea -->
	<!-- //본문내용 -->
	
		
	<!-- footer -->
	<%@include file="../layout_mem/footer.jsp" %>
	<!-- //footer -->
</div>
</body>
</html>
		