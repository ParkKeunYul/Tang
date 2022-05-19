<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
					<b>사업자 : </b><a href="/download.do?path=member_file&filename=${info.member_file2}&refilename=${info.member_file2_re}">${info.member_file2}</a>
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
				<th>실무자아이디</th>
				<td class="tdL">
					<select name="sub_id_confirm" id="sub_id_confirm" onchange="sub_choice();">
						<option value="y"  <c:if test="${info.sub_id_confirm eq 'y' }">selected="selected"</c:if> >승인</option>
						<option value="n"  <c:if test="${info.sub_id_confirm eq 'n' }">selected="selected"</c:if> >미승인</option>
					</select>
				</td>
				<th>가입일</th>
				<td class="tdL">${info.wdate2}</td>
			</tr>
			<tr>
				<th>서류체크</th>
				<td class="tdL" colspan="3">
					면허증<input type="checkbox" name="license_yn"id="license_yn" value="y" <c:if test="${info.license_yn eq 'y' }">checked</c:if> >
					계약서<input type="checkbox" name="bill_yn"   id="bill_yn"    value="y"  <c:if test="${info.bill_yn eq 'y' }">checked</c:if> >
				</td>
			</tr>
			<tr>
				<th>관리자메모</th>
				<td class="tdL" colspan="3"><textarea rows=3 cols=100 name="admin_memo">${info.admin_memo}</textarea></td>
			</tr>
		</tbody>
	</table>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#subGrid").jqGrid({
		  		//caption : '모든 약재정보',
		  		//dataType : 'local', // 로딩시 최초 조회   		
		  		url : 'sub_list.do?mem_seqno=${mod_param.seqno}',
		  		datatype: 'json',
		  		hidegrid: false,
		  		width: "99%",
		  		height: "100%",
		  		rowNum: 2000,				  	
		  		colNames:[
		  			'seqno', '아이디','이름', '등급' ,'비밀번호<span style="color:red;">(수정후 암호화 되어 보여집니다.)</span>',
		  			'생성일', '삭제'
		  		],
		  		colModel:[
		  			{name:'seqno',		index:'seqno',		width:28,	align:"center" ,key: true , hidden:true},
		  			{name:'id',			index:'id',			width:100,	align:"left" ,sortable : false},
		  			{name:'name',		index:'name',		width:120,	align:"left" ,sortable : false
		  				,editable:true
		  			},
		  			{name:'grade',		index:'grade',		width:120,	align:"center" ,sortable : false
		  				,editable:true 
		  				,edittype:"select"
		  				,editoptions:{
		  					value:"1:부원장;2:직원"  					
		  				}
		  				,formatter: 'select' 
		  			},
		  			{name:'password',	index:'password',	width:250,	align:"left" ,sortable : false
		  				,editable:true
		  			},
		  			
		  			{name:'reg_date2',	index:'reg_date2',	width:120,	align:"center" ,sortable : false},
		  			
		  			
		  			{name:'delBtn',		index:'delBtn',	width:80,	align:"center" ,sortable : false},
		  		],
				pager: "#subGridControl",
				multiselect: false,
				viewrecords: true,
				autowidth: true,
				sortname: 'seqno',
				sortorder: "desc",
				viewrecords: true,
				loadtext  : '',
				cellEdit :true,
				cellurl : 'sub_update_col.do',
				emptyrecords  : '',
				loadtext  : '데이터를 불러오는중입니다.',
				beforeSelectRow: function (rowid, e) {
				    var $self = $(this), iCol, cm,
				    $td = $(e.target).closest("tr.jqgrow>td"),
				    $tr = $td.closest("tr.jqgrow"),
				    p = $self.jqGrid("getGridParam");

				    if ($(e.target).is("input[type=checkbox]") && $td.length > 0) {
				       iCol = $.jgrid.getCellIndex($td[0]);
				       cm = p.colModel[iCol];
				       if (cm != null && cm.name === "cb") {
				           // multiselect checkbox is clicked
				           $self.jqGrid("setSelection", $tr.attr("id"), true ,e);
				       }
				    }
				    return false;
				},
				beforeSubmitCell : function(rowid, cellName, cellValue) { 
					return {"seqno":rowid, "cellName":cellName, "cellValue": cellValue}
				},
				afterSaveCell : function(owid, name, val, iRow, iCol){
					/* 
					console.log('owid = ',owid );
					console.log('name = ',name );
					console.log('val = ',val );
					console.log('iRow = ',iRow );
					console.log('iCol = ',iCol );
					 */
					setTimeout(function(){
						$("#subGrid").trigger("reloadGrid");
					},300);

				},
				onCellSelect : function(row,iCol,cellcontent,e){
					var data = $("#subGrid").jqGrid('getRowData', row);
					//console.log(iCol);
					console.log('data = ',data);
					if(iCol == 6){
						if(!confirm('삭제하겠습니까?')){
							return false;
						}
						
						$.ajax({
							url : '01_del_sub_id.do',
						    data : data,        
					        error: function(){
						    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
						    },
						    success: function(data){
						    	alert(data.msg);	
						    	if(data.suc){
						    		$("#subGrid").trigger("reloadGrid");
						    	}
						    }   
						});
						
					}
				},
				loadComplete: function(data) {
					var rows = $("#subGrid").getDataIDs();
					
					for (var i = 0; i < rows.length; i++){
						
						var delBtn = '<span class="cO h25">삭제</span>';
						
						$("#subGrid").setCell(rows[i] , 'delBtn', delBtn ,  {color:'blue',weightfont:'bold',cursor: 'pointer'}); // 특정 cell 색상변경
			    		
					}// for
					
					
				},
			});// cardGrid
		});
		
		
		$('#privateBtn').click(function() {
			var member_level = parseInt( $('#member_level').val() );
			
			console.log('member_level = ', member_level);
			
			if(member_level < 2){
				alert('정회원 등급 이상만 설정 가능합니다.');
				return;
			}
			
			
			var private_yn   = $('#private_yn').val();
			var p_c_pouch_type = $('#p_c_pouch_type').val();
			var p_c_box_type = $('#p_c_box_type').val();
			
			if(private_yn == 'y' && p_c_pouch_type ==  '' && p_c_box_type == ''){
				alert('전용설정이 여부가 설정일경우에는,\n전용파우치 또는 박스를 선택해야 합니다.');
				return;
			}
			
			if(!confirm('전용 포장을 저장하겠습니까?')  ){
				return;
			}
			
			var data = {
				 private_yn     : private_yn
				,p_c_pouch_type : p_c_pouch_type
				,p_c_box_type   : p_c_box_type
				,mem_seqno      : "${mod_param.seqno}"			
			}
			console.log(data);
			$.ajax({
				url : 'private_save.do',
			    data : data,        
		        error: function(){
			    	alert('에러가 발생했습니다.\n관리자에 문의하세요.');
			    },
			    success: function(data){
			    	alert(data.msg);	
			    	if(data.suc){
			    		$("#subGrid").trigger("reloadGrid");
			    	}
			    }   
			});
			
		});
	</script>
	
	<p>
		<span class="viewtit">사용자 전용 포장 설정</span>
		<a href="#" id="privateBtn" class="btn02">설정 저장</a>
	</p>
	<table class="basic01">
		<colgroup>
			<col width="120px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>전용설정 여부</th>
				<td class="tdL">
					<select name="private_yn" id="private_yn" style="width: 120px;">
						<option value="n" <c:if test="${setting.private_yn eq 'n' }">selected="selected"</c:if>>미설정</option>
						<option value="y" <c:if test="${setting.private_yn eq 'y' }">selected="selected"</c:if>>설정</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>전용 파우치 선택</th>
				<td class="tdL">
					<select name="p_c_pouch_type" id="p_c_pouch_type"  style="width:160px;">
						<option value="" attr2="">선택안함</option>
						<c:forEach var="list" items="${p_pouch_list}">
							<option value="${list.seqno}"  attr="/upload/pouch/${list.pouch_image}"  attr2=${list.pouch_price }  <c:if test="${setting.p_c_pouch_type eq list.seqno }">selected="selected"</c:if>  >${list.pouch_name}(+${list.pouch_price})</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>전용 박스 선택</th>
				<td class="tdL">					
					<select name="p_c_box_type" id="p_c_box_type"  style="width:160px;">
						<option value="" attr2="">선택안함</option>
						<c:forEach var="list" items="${p_box_list}">
							<option value="${list.seqno}" attr="/upload/box/${list.box_image}"  attr2=${list.box_price }  <c:if test="${setting.p_c_box_type eq list.seqno }">selected="selected"</c:if> >${list.box_name}(+${list.box_price})</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	
	<p><span class="viewtit">부계정</span></p>
	<table id="subGrid" class="cart_list"></table>
	
	
	
</form>