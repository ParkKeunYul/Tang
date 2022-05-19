<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
function a_member_proc(grid_nm){
	
	$("#a_member_frm").attr("action", "/admin/base/member/mod_proc.do");
	
	$('#a_member_frm').ajaxForm({		        
		url :  "/admin/base/member/mod_proc.do",
        enctype : "multipart/form-data",
        beforeSerialize: function(){
             // form을 직렬화하기전 엘레먼트의 속성을 수정할 수도 있다.            
        },
        beforeSubmit : function() {
        	//action에 걸어주었던 링크로 가기전에 실행 ex)로딩중 표시를 넣을수도 있다.
        },

        success : function(data) {		             
            console.log("data =  ", data);
            alert(data.msg);
            if(data.suc){
            	if(grid_nm != undefined){
            		$("#memberGrid").trigger("reloadGrid");
            	}else{
            		$("#jqGrid").trigger("reloadGrid");	
            	}
           		
           		//$("#modForm").dialog('close');
            }
        }		        
    });	
    $("#a_member_frm").submit();
}
$(document).ready(function() {
	$('#a_addrBtn').click(function() {
		var element_layer = document.getElementById('layerSin001');
		
		 new daum.Postcode({
	        oncomplete: function(data) {

	            var fullAddr = data.address; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            if(data.userSelectedType === 'R'){
	            	
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                fullAddr = data.roadAddress;
	                
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }
	            
	            fullAddr = fullAddr;
	            
	            //document.getElementById(txt_addr1).value = fullAddr;
	            //me.lookupReference(txt_addr1).setExValue(fullAddr);
	            
	            var addrNm =  "(" + data.bname;
	            if(data.buildingName != '' && data.buildingName != null && data.buildingName != undefined){
	            	addrNm = addrNm + ","+data.buildingName
	            }
	            addrNm = addrNm + ")";
	            
	        	 $('#zipcode').val(data.zonecode);
	        	 $('#address01').val(fullAddr);
	        	 $('#address02').focus();
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%',
	        maxSuggestItems : 5
	    }).embed(element_layer);

	    // iframe을 넣은 element를 보이게 한다.
	    element_layer.style.display = 'block';

	    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	    initLayerPosition(element_layer);
    });
	
	$('#a_addrHanBtn').click(function() {
		var element_layer = document.getElementById('layerSin001');
		
		 new daum.Postcode({
	        oncomplete: function(data) {

	            var fullAddr = data.address; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            if(data.userSelectedType === 'R'){
	            	
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                fullAddr = data.roadAddress;
	                
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }
	            
	            fullAddr = fullAddr;
	            
	            //document.getElementById(txt_addr1).value = fullAddr;
	            //me.lookupReference(txt_addr1).setExValue(fullAddr);
	            
	            var addrNm =  "(" + data.bname;
	            if(data.buildingName != '' && data.buildingName != null && data.buildingName != undefined){
	            	addrNm = addrNm + ","+data.buildingName
	            }
	            addrNm = addrNm + ")";
	            
	        	 $('#han_zipcode').val(data.zonecode);
	        	 $('#han_address01').val(fullAddr);
	        	 $('#han_address02').focus();
	            element_layer.style.display = 'none';
	        },
	        width : '100%',
	        height : '100%',
	        maxSuggestItems : 5
	    }).embed(element_layer);

	    // iframe을 넣은 element를 보이게 한다.
	    element_layer.style.display = 'block';

	    // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	    initLayerPosition(element_layer);
    });
	
	
	
});

function part_choice()

{
  <%-- // document.form.action = "part_choice.asp
  // document.form.submit(); --%>

}



function level_choice()

{
  <%-- // document.form.action = "level_choice.asp?
  // document.form.submit(); --%>

}

function group_choice()

{
  <%-- // document.form.action = "group_choice.asp?
  // document.form.submit(); --%>

}


function sub_choice()

{
   <%-- //document.form.action = "sub_choice.asp
  // document.form.submit(); --%>

}

</script>

<form action="" id="a_member_frm" name="a_member_frm" enctype="multipart/form-data" method="post" >

	<div id="layerSin001" class="find_addr_layer_pop" style="display:none;position:fixed;overflow:hidden;z-index:3;-webkit-overflow-scrolling:touch;"><img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼"></div>

	<input type="hidden" name="seqno" value="${mod_param.seqno }" />
	<input type="hidden" name="id" value="${info.id}" />
	<p><span class="viewtit">기본정보</span></p>
	<table class="basic01">
		<colgroup>
			<col width="120px" />
			<col width="350px" />
			<col width="120px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>회원명</th>
				<td class="tdL"><input type="text" name="name" id="name" value="${info.name}" /></td>
				<th>아이디</th>
				<td class="tdL">
					${info.id}
					<select name="sex" id="sex" style="width: 120px;">
						<option value="m" <c:if test="${info.sex eq 'm' }">selected="selected"</c:if>>남자</option>
						<option value="w" <c:if test="${info.sex eq 'w' }">selected="selected"</c:if>>여자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td class="tdL">${info.jumin}</td>
				<th>비밀번호</th>
				<td class="tdL"><input type="text" name="password" id="password" style="width:180px;" /></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td class="tdL">
					<c:set var="tel" value="${fn:split(info.tel,'-')}" />
					 <input type=text name="tel_1"   id="tel_1" value="${tel[0]}" size="4">
					- <input type=text name="tel_2"  id="tel_2" value="${tel[1]}" size="4">
					- <input type=text name="tel_3"  id="tel_3" value="${tel[2]}" size="4">
				</td>
				<th>휴대전화</th>
				<td class="tdL">
					<c:set var="handphone" value="${fn:split(info.handphone,'-')}" />
					<input type=text name="handphone_1"  id="handphone_1" size=3 value="${handphone[0]}">
					- <input type=text name="handphone_2" id="handphone_2"  size=4  value="${handphone[1]}">
					- <input type=text name="handphone_3" id="handphone_3" size=4  value="${handphone[2]}">
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td class="tdL" colspan="3">
					<input type=text name="zipcode"   id="zipcode" size=5 readonly value="${info.zipcode }"> <a href="#" id="a_addrBtn" class="btn03">우편번호</a><br/>				
					<input type=text name="address01" id="address01" size=40  value="${info.address01 }" style="width:500px;">
					<input type=text name="address02" id="address02" size=30  value="${info.address02 }" style="width:200px;">
				</td>
			</tr>
			<tr>
				<th>E-mail</th>
				<td class="tdL"><input type=text name="email" id="email" value="${info.email}"  style="width:250px;" size=25></td>
				<th>등급</th>
				<td class="tdL">
					<select name="member_level" id="member_level" onchange="level_choice();"  style="width: 150px;">
						<option value="0">가입신청</option>
						<c:forEach var="list" items="${mem_list}">							
							<option value="${list.seqno}" <c:if test="${info.member_level eq list.seqno }">selected="selected"</c:if>  >${list.member_nm}</option>
						</c:forEach>
					</select> 
					<font color="red">정회원이상 권한 부여시 탕전처방 기본값이 셋팅됩니다.</font>
				</td>
			</tr>
			
			<tr>
				<th>그룹명(할인율%)</th>
				<td class="tdL" >
					<select name="group_code" id="group_code" style="width: 300px;">
						<option value="">선택</option>
						<c:forEach  items="${group_list}" var="list">
							<option value="${list.seqno }" <c:if test="${info.group_code eq list.seqno }">selected="selected"</c:if>  >${list.group_nm} (${list.sale_per}%)</option>
						</c:forEach>
					</select>
				</td>
				<th>정보수정가능여부</th>
				<td class="tdL" >
					<select name="info_fix" id="info_fix">
						<option value="N" <c:if test="${info.info_fix eq 'N' }">selected="selected"</c:if>>수정불가</option>
						<option value="Y" <c:if test="${info.info_fix eq 'Y' }">selected="selected"</c:if>>수정가능</option>
					</select>
				</td>
				
			</tr>
			
			<tr>
				<th>사용가능한 포인트</th>
				<td class="tdL" colspan="3" >
					<span style="color: blue;"><fmt:formatNumber value="${mem_point.tot_point}" pattern="#,###" /></span>
					
				</td>
			</tr>
			
		</tbody>
	</table>

	<p><span class="viewtit">추가정보</span></p>
	<table class="basic01">
		<colgroup>
			<col width="120px" />
			<col width="350px" />
			<col width="120px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>회원구분</th>
				<td class="tdL">
					<!--준회원-가입회원&nbsp;&nbsp; 정회원-주문가능한회원&nbsp;&nbsp; 협력회원-1000원할인&nbsp;&nbsp; 우수회원-1500원할인&nbsp;&nbsp; 스페셜-2000원할인-->
					<select name="part" id="part" onchange="part_choice();" style="width:300px;">
						<option value="1" <c:if test="${info.part eq 1 }">selected="selected"</c:if> >한의원(개원의)</option>
						<option value="2" <c:if test="${info.part eq 2 }">selected="selected"</c:if> >한의사(미개원의)</option>
						<option value="3" <c:if test="${info.part eq 3 }">selected="selected"</c:if> >한의대생</option>
					</select>
				</td>
				<th>첨부파일</th>
				<td class="tdL">
					<b>면허증 : </b><a href="/download.do?path=member_file&filename=${info.member_file}&refilename=${info.member_file_re}">${info.member_file}</a><br/>
					<input type="file" name="member_file" id="member_file" style="width:200px;"/><br/>
					<b>사업자 : </b><a href="/download.do?path=member_file&filename=${info.member_file2}&refilename=${info.member_file2_re}">${info.member_file2}</a><br/>
					<input type="file" id="member_file2"  name="member_file2" style="width:265px;"/><br/>
				</td>
			</tr>
			<tr>
				<th>면허번호</th>
				<td class="tdL"><input type=text name="license_no"  id="license_no" value="${info.license_no}" style="width:200px;"></td>
				<th>출신학교</th>
				<td class="tdL">${info.from_school}</td>
			</tr>
			<tr>
				<th>한의원명</th>
				<td class="tdL"><input type=text name="han_name" id="han_name" value="${info.han_name}" style="width:200px;"> </td>
				<th>학번</th>
				<td class="tdL">${info.school_no}</td>
			</tr>
			<tr>
				<th>사업자번호</th>
				<td class="tdL">
					<c:set var="biz_no" value="${fn:split(info.biz_no,'-')}" />	
					<input type=text name="biz_no_1" id="biz_no_1" value="${biz_no[0]}" size=2>
					-<input type=text name="biz_no_2" id="biz_no_2" value="${biz_no[1]}" size=2>
					-<input type=text name="biz_no_3" id="biz_no_3" value="${biz_no[2]}" size=3>
				</td>
				<th>직책</th>
				<td class="tdL">${info.han_level}</td>
			</tr>
			<tr>
				<th>한의원주소</th>
				<td class="tdL" colspan="3">
					<input type=text name="han_zipcode"   id="han_zipcode" size=5 readonly value="${info.han_zipcode }"> <a href="#" id="a_addrHanBtn" class="btn03">우편번호</a><br/>				
					<input type=text name="han_address01" id="han_address01" size=40  value="${info.han_address01 }" style="width:500px;">
					<input type=text name="han_address02" id="han_address02" size=30  value="${info.han_address02 }" style="width:200px;">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td class="tdL">
					<c:set var="han_tel" value="${fn:split(info.han_tel,'-')}" />				
					<input type=text name="han_tel_1"  id="han_tel_1" value="${han_tel[0]}" size=2>
					- <input type=text name="han_tel_2" id="han_tel_2" value="${han_tel[1]}" size=3>
					- <input type=text name="han_tel_3" id="han_tel_3" value="${han_tel[2]}" size=3>
				</td>
				<th>팩스번호</th>
				<td class="tdL">
					<c:set var="han_fax" value="${fn:split(info.han_fax,'-')}" />
					<input type=text name="han_fax_1"  id="han_fax_1" value="${han_fax[0]}" size=2>
					- <input type=text name="han_fax_2" id="han_fax_2" value="${han_fax[1]}" size=3>
					- <input type=text name="han_fax_3" id="han_fax_3" value="${han_fax[2]}" size=3>
				</td>
			</tr>
			<tr>
				<%-- <th>실무자아이디</th>
				<td class="tdL">
					
				</td> --%>
			</tr>
			<tr>
				<th>서류체크</th>
				<td class="tdL">
					면허증<input type="checkbox" name="license_yn"id="license_yn" value="y" <c:if test="${info.license_yn eq 'y' }">checked</c:if> >
					계약서<input type="checkbox" name="bill_yn"   id="bill_yn"    value="y"  <c:if test="${info.bill_yn eq 'y' }">checked</c:if> >
				</td>
				<th>가입일</th>
				<td class="tdL">
					${info.wdate2}
					<select name="sub_id_confirm" id="sub_id_confirm" onchange="sub_choice();" style="display: none;">
						<option value="y"  <c:if test="${info.sub_id_confirm eq 'y' }">selected="selected"</c:if> >승인</option>
						<option value="n"  <c:if test="${info.sub_id_confirm eq 'n' }">selected="selected"</c:if> >미승인</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>관리자메모</th>
				<td class="tdL" colspan="3"><textarea rows=3 cols=100 name="admin_memo">${info.admin_memo}</textarea></td>
			</tr>
		</tbody>
	</table>				
</form>