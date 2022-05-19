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
			
			
			$("#popupButton1").click(function() {
				$('#login_popup1').bPopup();
				return false;
			});
			
			$("#findAddrBtn1").click(function() {
				find_addr('zipcode','address01', 'address02');
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
			
			$("#handphone01,#handphone02,#handphone03").on("keyup", function() {
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
				if(!valCheck( 'id' ,'아이디를 입력하세요.') ) return false;
				
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
				    	return false;
				    }   
				});
				return false;
			});
			
			
			$("#memberBtn").click(function() {
				
				if(!valCheck( 'id' ,'아이디를 입력하세요.') ) return;
				
				if($('#id').val().length > 12 || $('#id').val().length < 6){
					alert('6~12자리 사이의 아이디를 입력하세요.');
					$('#id').focus();
					return;
				}
				
				if( $('#check_id').val == 0 ){
					alert('아이디 중복확인이 필요합니다.');
					return;
				}
				if(!valCheck( 'password' ,'비밀번호를 입력하세요.') ) return;
				if(!valCheck( 're_password' ,'비밀번호를 입력하세요.') ) return;
				if(!pwdCheck('password', 're_password') ) return;
				if(!valCheck( 'name' ,'이름을 입력하세요.') ) return;
				
				if(!valCheck( 'zipcode' ,'주소를 입력하세요.') ) return;
				if(!valCheck( 'address01' ,'주소를 입력하세요.') ) return;
				if(!valCheck( 'address02' ,'주소를 입력하세요.') ) return;
				if(!valCheck( 'handphone01' ,'휴대전화번호를 입력하세요.') ) return;
				if(!valCheck( 'handphone02' ,'휴대전화번호를 입력하세요.') ) return;
				if(!valCheck( 'handphone03' ,'휴대전화번호를 입력하세요.') ) return;
				if(!valCheck( 'email1' ,'이메일주소를 입력하세요.') ) return;
				if(!valCheck( 'email2' ,'이메일주소를 입력하세요.') ) return;
				
				var data = $('#signature').jSignature("getData", "base30");
		        var i = new Image()
		        i.src = "data:" + data[0] + "," + data[1];
		        if(i.src == 'data:image/jsignature;base30,'){
		       	 alert('서명이 필요합니다.');
		       	 //$('#signature').focus();
		       	 return false;
		        }
		        $('#sign_img').val(i.src);
				
				 
				if(!valCheck( 'member_file' ,'면허증을 첨부하세요.') ) return;
				
				var ext = $('#member_file').val().split('.').pop().toLowerCase();
				if(ext != '' && ext != null){
					if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
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
			
		})
		</script>
		<div id="layerFindAddr" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>
		
		<div class="banner">
			<h3>회원가입</h3>
			<p class="txtarea">
				<strong>한의사(일반) 으로 회원가입을 진행합니다.</strong><br/>
				공동탕전실은 의료기관의 부설시설로 의료기관에 소속된 한의사만이 처방을 의뢰할 수 있으며 의약품의 도매 및 소매는 한방의료기관 및 <br/>
				약국개설자와 그 외 법에서 인정하는 경우에만 허용이 됩니다. 한의사 면허증을 보내주셔야 회원가입이 완료됩니다.<br/>자세한 내용은 Tel.054-242-1079로 문의 주시기 바랍니다.
			</p>
		</div>
		
		<form action="/m06/proc_01_step2_1.do" id="frm" name="frm" enctype="multipart/form-data" method="post" >
			<input type="hidden" name="part" value="2" />
			<input type="hidden" name="check_value_re" value="1" />
			<input type="hidden" name="check_id" id="check_id" value="0" />
			<input type="hidden" name="member_level" id="member_level" value="0" />
			
			<!-- 본문내용 -->
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
							<td>
								<input type="text" name="id" id="id" style="width:220px;">
								<a href="#" id="dupleIdBtn"><span class="h35 cB">중복확인</span></a>
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
									<input type="text" name="zipcode" id="zipcode" style="width:180px;" readonly><a href="#" id="findAddrBtn1"><span id="addrBtn1" class="h35 cB">주소찾기</span></a>
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
						<tr>
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
			
			<!-- join_form02 -->
			<div class="join_form02">
				<p class="tit">*  한의사 정보입력</p>
				<table class="formT">
					<colgroup>
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>면허번호</th>
							<td colspan="3">
								<input type="text" name="license_no" id="license_no" style="width:180px; margin-right:10px;"><input type="file" id="member_file" name="member_file" style="width:200px;"/>
								<span class="t01">! 면허증 이미지를 첨부해 주세요 (형식:jpg, gif)</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- //join_form02 -->
			
			<!-- btnarea -->
			<div class="btn_area01">
				<a href="/m06/01_step1_1.do"><span class="cw h60">취소</span></a>
				<a href="#" id="memberBtn"><span class="cg h60">회원가입</span></a>
			</div>
			<!-- //btnarea -->
			<!-- //본문내용 -->
		</form>		

	</div>
	<!-- // joinArea -->
	<!-- footer -->
	<%@include file="../layout_mem/footer.jsp" %>
	<!-- //footer -->
</div>
</body>
</html>
		