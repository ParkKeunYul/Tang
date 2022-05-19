 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- container -->
<div id="container">	
	<!-- //submenuArea -->
	<script>
	$(document).ready(function() {
		set_select();
		
		$('#c_chup_ea_sel').click(function() {
			$('#c_chup_ea').val( $(this).val() )
		});
		
		$('#c_pack_ml_sel').click(function() {
			$('#c_pack_ml').val( $(this).val() )
		});
		
		$('#c_pack_ea').click(function() {
			$('#c_pack_ea').val( $(this).val() )
		});
		
		$('#setBtn').click(function() {
			
			$.ajax({
				url : '/m02/04_setPorc.do',
				data : $("#frm").serialize(),
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					alert(data.msg);
					//console.log('data = ', data);
				}
			});
			
			return false;
		});
		
		$('#setCanBtn').click(function() {
			$('#frm').each(function(){
			    this.reset();
			 });
			set_select();
			return false;
		});
		
		$('#joje_name').change(function() {
			$('#joje_contents').val( $('#joje_name option:selected').attr('attr') );
			
			if($('#joje_name option:selected').attr('attr2') == 'y'){
				$('#joje_base_yn').prop("checked", true);	
			}else{
				$('#joje_base_yn').prop("checked", false);
			}
		});
		
		$('#c_pack_ea_sel').change(function() {
			$('#c_pack_ea').val( $(this).val() );
		});
		
		
		
		$('#jojeBaseBtn').click(function() {
			var seqno = $('#joje_name').val();
			
			$.ajax({
				url : '/m02/04_base_joje_proc.do',
				type: 'POST',
				data : {
					seqno : seqno
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					alert(data.msg);
					if(data.suc){
						$("#joje_name option").each(function(){
						  if ($(this).val() == seqno){
							  $(this).attr("attr2", 'y')
						  }else{
							  $(this).attr("attr2", 'n')
						  }
						});
						$('#joje_base_yn').prop("checked", true);
					}
				}
			});
			return false;
		});
		
		$('#addJojeBtn').click(function() {
			var seqno = $('#joje_name').val();
			
			$.ajax({
				url : '/m02/04_pop_joje.do',
				 data : {
					 action: 'add'
					,seqno : seqno				   
				}, 
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(res) {
					//console.log(res);
					$('#popup8').html( res );
					$('#popup8').bPopup();
				}
			});
			return false;
		});
		
		$('#updateJojeBtn').click(function() {
			var seqno = objToStr($('#joje_name').val(), '');
			if(seqno == ''){
				alert('조제 지시 설명을 선택후 수정가능합니다.');
				$('#joje_name').focus();
				return false;
			}
			
			$.ajax({
				url : '/m02/04_pop_joje.do',
				 data : {
					 action: 'update'
					,seqno : seqno				   
				}, 
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(res) {
					//console.log(res);
					$('#popup8').html( res );
					$('#popup8').bPopup();
				}
			});
			 return false;
		});
		
		$('#delJojelBtn').click(function() {
			var seqno = objToStr($('#joje_name').val(), '');
			if(seqno == ''){
				alert('조제 지시 설명을 선택후 삭제 가능합니다.');
				$('#joje_name').focus();
				return false;
			}
			
			$.ajax({
				url : '/m02/04_pop_joje_del.do',
				 data : {
					seqno : seqno				   
				}, 
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(res) {
					alert(res.msg);
					if(res.suc){
						$("#joje_name option:selected").remove();
						$('#joje_name').val("");
						$('#joje_contents').val("");
					}
				}
			});
			return false;
		});
		
		
		
		$('#bok_name').change(function() {
			$('#bok_contents').val( $('#bok_name option:selected').attr('attr') );
			if($('#bok_name option:selected').attr('attr2') == 'y'){
				$('#bok_base_yn').prop("checked", true);	
			}else{
				$('#bok_base_yn').prop("checked", false);
			}
		});
		
		
		$('#bokBaseBtn').click(function() {
			var seqno = $('#bok_name').val();
			
			$.ajax({
				url : '/m02/04_base_bok_proc.do',
				type: 'POST',
				data : {
					seqno : seqno
				},
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(data) {
					alert(data.msg);
					if(data.suc){
						$("#bok_name option").each(function(){
						  if ($(this).val() == seqno){
							  $(this).attr("attr2", 'y')
						  }else{
							  $(this).attr("attr2", 'n')
						  }
						});
						$('#bok_base_yn').prop("checked", true);
					}
				}
			});
			return false;
		});
		
		$('#addBokBtn').click(function() {
			var seqno = $('#joje_name').val();
			
			$.ajax({
				url : '/m02/04_pop_bok.do',
				 data : {
					 action: 'add'
					,seqno : seqno				   
				}, 
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(res) {
					//console.log(res);
					$('#popup7').html( res );
					$('#popup7').bPopup();
				}
			});
			return false;
		});
		
		$('#updateBokBtn').click(function() {
			var seqno = objToStr($('#bok_name').val(), '');
			if(seqno == ''){
				alert('복용법 설명을 선택후 수정가능합니다.');
				$('#bok_name').focus();
				return false;
			}
			
			$.ajax({
				url : '/m02/04_pop_bok.do',
				 data : {
					 action: 'update'
					,seqno : seqno				   
				}, 
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(res) {
					//console.log(res);
					$('#popup7').html( res );
					$('#popup7').bPopup();
				}
			});
			 return false;
		});
		
		
		$('#delBokBtn').click(function() {
			var seqno = objToStr($('#bok_name').val(), '');
			if(seqno == ''){
				alert('복용법 설명을 선택후 삭제 가능합니다.');
				$('#bok_name').focus();
				return false;
			}
			
			$.ajax({
				url : '/m02/04_pop_bok_del.do',
				 data : {
					seqno : seqno				   
				}, 
				type: 'POST',
				error : function() {
					alert('에러가 발생했습니다.\n관리자에 문의하세요.');
				},
				success : function(res) {
					alert(res.msg);
					if(res.suc){
						$("#bok_name option:selected").remove();
						$('#bok_name').val("");
						$('#bok_contents').val("");
						
					}
				}
			});
			return false;
		});
		
		$('input[name="c_tang_type"]').change(function() {
			var c_tang_type = $(this).val();
			
			if(c_tang_type == 1){
				tangTypeOne();
			}else{
				$('#c_pack_ml_sel').attr('disabled', false);
				$('#c_pack_ea_sel').attr('disabled', false);
				$('#c_box_type').attr('disabled', false);
				$('#c_pouch_type').attr('disabled', false);
				$('#c_stpom_type').attr('disabled', false);
			}
		});
		
		if($(":input:radio[name=c_tang_type]:checked").val() == 1){
			tangTypeOne();
		}
		
	});
	
	function tangTypeOne(){
		$('#c_pack_ml_sel').val(0);
		$('#c_pack_ml').val(0);
		$('#c_pack_ea_sel').val(0);
		$('#c_pack_ea').val(0);
		
		$('#c_box_type').val('');
		$('#c_pouch_type').val('');
		$('#c_stpom_type').val('-1');
		
		$('#c_pack_ml_sel').attr('disabled', true);
		$('#c_pack_ea_sel').attr('disabled', true);
		$('#c_box_type').attr('disabled', true);
		$('#c_pouch_type').attr('disabled', true);
		$('#c_stpom_type').attr('disabled', true);
	}
	
	function set_select(){
		$('#c_chup_ea').val( $('#c_chup_ea_sel').val() );
		$('#c_pack_ml').val( $('#c_pack_ml_sel').val() );
		$('#c_pack_ea').val( $('#c_pack_ea_sel').val() );
		
		if(objToStr($('#joje_name').val() ,'') != ''){
			$('#joje_base_yn').prop("checked", true);
		}
	}
	</script>
	<!-- contents -->
	<div id="contents">
		<div class="sub_gnb">
			<p class="sname">CHEONGDAM HERB</p>
			<p class="sg"><span>탕전처방</span><span>방제사전</span></p>
		</div>

		<ul class="sub_Menu w16">
			<li><a href="01.do">처방하기</a></li>
			<li><a href="06.do">실속처방</a></li>
			<li><a href="02.do">방제사전</a></li>
			<li><a href="03.do">포장보기</a></li>
			<li class="sel"><a href="04.do">환경설정</a></li>
			<li><a href="05.do">사용 설명서</a></li>
		</ul>
	
	
		<!-- 서브타이틀 -->
		<div class="titArea">
			<p class="Ltit" style="width: 160px;">환경설정</p>
			<p>· <strong>탕전 설정</strong>에 평소 자주 처방하는 첩수, 파우치용량, 파우치 팩수, 포장 등을 저장하시면 처방할 때 자동으로 입력되어 편리합니다.<br/>
			· <strong>복용법관리와 조제지시</strong>들을 등록 및 수정하여 처방할 때 바로 불러올 수 있습니다.</p>
		</div>
		<!-- // 서브타이틀 -->
		<!-- 내용 -->
		<div class="conArea">
			<!-- 탕전설정 -->
			<div class="div_tit" style="margin-top: 40px;">상품정보</div>
			<form action="/m02/04_setPorc.do" name="frm" id="frm" method="post">
				<table class="setuplist">
					<colgroup>
						<col width="130px" />
						<col width="*" />
						<col width="130px" />
						<col width="180px" />
						<col width="130px" />
						<col width="180px" />
					</colgroup>
					<tbody>
						<tr>
							<th>탕전방식 선택</th>
							<td class="L" colspan="3">
								<label><input type="radio" name="c_tang_type" value="1"  <c:if test="${setting.c_tang_type eq '1' }">checked="checked"</c:if>  /> 첩약</label>
								<label><input type="radio" name="c_tang_type" value="2"  <c:if test="${setting.c_tang_type eq '2' }">checked="checked"</c:if>/> 무압력탕전</label>
								<label><input type="radio" name="c_tang_type" value="3"  <c:if test="${setting.c_tang_type eq '3' }">checked="checked"</c:if>/> 압력탕전</label>
							</td>
							<th>약재 임시저장</th>
							<td class="L instyle">
								<select name="temp_save" id="temp_save"  style="width:153px;">
									<option value="y" <c:if test="${setting.temp_save eq 'y' }">selected="selected"</c:if>>사용함</option>
									<option value="n" <c:if test="${setting.temp_save eq 'n' }">selected="selected"</c:if>>사용안함</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>첩수</th>
							<td class="L instyle">
								<input type="text" style="width:60px;" name="c_chup_ea" id="c_chup_ea" readonly="readonly" />
								<select name="" id="c_chup_ea_sel"  style="width:80px;">
									<c:forEach var="i" step="1" begin="0" end="50">
										<option value="${i}" <c:if test="${setting.c_chup_ea eq i }">selected="selected"</c:if> >${i}</option>
									</c:forEach>
								</select>
							</td>
							<th>파우치 용량</th>
							<td class="L instyle">
								<input type="text" style="width:60px;"  name="c_pack_ml" id="c_pack_ml" readonly="readonly"/>
								<select name="" id="c_pack_ml_sel"  style="width:80px;">
									<option value="0">0</option>
									<c:forEach var="i" step="10" begin="50" end="140">
										<option value="${i}"  <c:if test="${setting.c_pack_ml eq i }">selected="selected"</c:if>  >${i}</option>
									</c:forEach>
								</select>
							</td>
							<th>파우치 팩수</th>
							<td class="L instyle">
								<input type="text" name="c_pack_ea"  id="c_pack_ea"  style="width:60px;" readonly="readonly" />
								<select name="" id="c_pack_ea_sel"  style="width:80px;">
									<c:forEach var="i" step="1" begin="0" end="120">
										<option value="${i}"  <c:if test="${setting.c_pack_ea eq i }">selected="selected"</c:if>  >${i}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>박스선택</th>
							<td class="L instyle">								
								<select name="c_box_type" id="c_box_type"  style="width:153px;">
									<option value="">포장안함</option>
									<c:forEach var="list" items="${box_list}">
										<option value="${list.seqno}" <c:if test="${setting.c_box_type eq list.seqno }">selected="selected"</c:if> >${list.box_name}</option>
									</c:forEach>
								</select>
							</td>
							<th>일반 파우치 선택</th>
							<td class="L instyle">								
								<select name="c_pouch_type" id="c_pouch_type"  style="width:153px;">
									<option value="">포장안함</option>
									<c:forEach var="list" items="${pouch_list}">
										<option value="${list.seqno}"  <c:if test="${setting.c_pouch_type eq list.seqno }">selected="selected"</c:if>  >${list.pouch_name}</option>
									</c:forEach>
								</select>
							</td>
							<th>일반 박스선택</th>
							<td class="L instyle">								
								<select name="c_stpom_type" id="c_stpom_type"  style="width:153px;">
									<option value="-1">포장안함</option>
									<c:forEach var="list" items="${sty_list}">
										<option value="${list.seqno}"  <c:if test="${setting.c_stpom_type eq list.seqno }">selected="selected"</c:if>  >${list.sty_name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						
						<tr <c:if test="${setting.private_yn ne 'y' }">style="display: none;"</c:if>>
							<th>전용 포장 설정 여부</th>
							<td class="L instyle">								
								<c:if test="${setting.private_yn eq 'y'}" >설정중</c:if>
								<c:if test="${setting.private_yn ne 'y'}" >아니오</c:if>
							</td>
							<th>전용 파우치 선택</th>
							<td class="L instyle">${setting.p_box_nm}</td>
							<th>전용 박스 선택</th>
							<td class="L instyle">${setting.p_pouch_nm}</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_area03">
					<a href="#" id="setBtn"><span class="cg h40">저장</span></a>
					<a href="#" id="setCanBtn"><span class="cglay h40">취소</span></a>
				</div>
			</form>
			<p class="bbline"></p>
			<!-- // 탕전설정 -->

			<!-- 조제 지시 사항 -->
			<div class="div_tit">조제 지시 사항</div>
			<table class="setuplist">
				<colgroup>
					<col width="160px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>조제 지시 설명</th>
						<td class="L instyle">
							<select name="" id="joje_name"  style="width:360px;">
								<option value="" attr="" >선택하세요.</option>
								<c:forEach var="list" items="${joje_list}">
									<option value="${list.seqno}" attr="${list.contents}" attr2="${list.base_yn}"   >${list.name}</option>
								</c:forEach>
							</select>
							<label><input type="checkbox"  name="base_yn" id="joje_base_yn" readonly="readonly" /><a href="#" id="jojeBaseBtn"> <span class="cBB h30" style="font-weight: 700;">기본설정으로 등록</span></a></label>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="L instyle">
							<textarea name="" readonly="readonly" id="joje_contents" style="width:750px; height:80px;resize:none;"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_area03">
				<a href="#" id="updateJojeBtn"><span class="cblue h40">수정하기</span></a>
				<a href="#" id="addJojeBtn"><span class="cg h40">추가하기</span></a>
				<a href="#" id="delJojelBtn"><span class="cglay h40">삭제</span></a>
			</div>
			<p class="bbline"></p>
			
			<!-- layer_popup 조제지시사항 불러오기 -->
			<div id="popup8" class="Pstyle2"></div>
			<!-- //layer_popup 조제지시사항 불러오기 -->
			
			<!-- // 조제 지시 사항 -->

			<!-- 복용법 관리 -->
			<div class="div_tit">복용법 관리</div>
			<table class="setuplist">
				<colgroup>
					<col width="160px" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>복용법 설명</th>
						<td class="L instyle">
							<select name="" id="bok_name"  style="width:360px;">
								<option value="" attr="">선택하세요.</option>
								<c:forEach var="list" items="${bok_list}">
									<option value="${list.seqno}" attr="${list.contents}" attr2="${list.base_yn}"   >${list.name}</option>
								</c:forEach>
							</select>
							<label><input type="checkbox" id="bok_base_yn" /><a href="#" id="bokBaseBtn"> <span class="cBB h30" style="font-weight: 700;">기본설정으로 등록</span></a></label>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="L instyle">
							<textarea name="" id="bok_contents" style="width:750px; height:80px;resize:none;" readonly="readonly"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_area03">
				<a href="#" id="updateBokBtn"><span class="cblue h40">수정하기</span></a>
				<a href="#" id="addBokBtn"><span class="cg h40">추가하기</span></a>
				<a href="#" id="delBokBtn"><span class="cglay h40">삭제</span></a>
			</div>
			<!-- // 복용법 관리 -->
			
			<!-- layer_popup 복용법 및 주의사항 불러오기 -->
			<div id="popup7" class="Pstyle2"></div>
			<!-- //layer_popup 복용법 및 주의사항 불러오기 -->
		</div>
		<!-- //내용 -->
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	