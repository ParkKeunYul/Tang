<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script type="text/javascript" src="/assets/common/smart/js/HuskyEZCreator.js" charset="utf-8"></script>
<style>
 			.tbv th, .tbv td{
 				border-right: 1px solid #c9c9c9;
 			}
 		</style>
<script>
function a_goods_add(){
	var ajax_url = "add_proc.do";
	a_goods_proc(ajax_url);
}

function a_goods_mod(){
	var ajax_url = "mod_proc.do";
	a_goods_proc(ajax_url);
}

function a_goods_proc(ajax_url){
	
	if(! valCheck('p_name','처방명을 입력해 주세요.')){
		return;
	} 
	/* if(! valCheck('p_code','상품코드를 입력해 주세요')){
		return;
	} */
	if(! valCheck('p_price','처방비용을 입력해 주세요.')){
		return;
	}
	if(! valCheck('p_size','용량을 입력해 주세요.')){
		return;
	}
	if(! valCheck('jo_complete','조제완료된 수량을 입력해 주세요.')){
		return;
	}
	if(! valCheck('jo_ing','조제중인 수량을 입력해 주세요.')){
		return;
	}
	if(! valCheck('set_period','준비기간을 입력해 주세요.')){
		return;
	}
	if(! valCheck('delivery_price','배송비를 입력해 주세요.')){
		return;
	}
	if(! valCheck('yak_name1','처방구성을 등록해 주세요.')){
		return;
	}
	if(! valCheck('yak_from1','처방구성을 등록해 주세요.')){
		return;
	}
	if(! valCheck('yak_g1','처방구성을 등록해 주세요.')){
		return;
	}
	
	$("#a_goods_frm").attr("action", ajax_url);
	
	console.log('ajax_url = ', ajax_url);
	console.log('a_goods_frm = ', $("#a_goods_frm").attr("action"));
	
	var content = oEditors.getById["p_contents"].getIR();
	$('#p_contents').val(content);
	
	
	$('#a_goods_frm').ajaxForm({		        
		url : ajax_url,
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
            	if(ajax_url == 'add_proc.do'){
            		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
            		$("#addForm").dialog('close');
            	}else{
            		$("#jqGrid").trigger("reloadGrid");
            		//$("#modForm").dialog('close');
            	}
            }
        }		        
    });	
	$("#a_goods_frm").submit();
}

var oEditors = [];
$(document).ready(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "p_contents",
		sSkinURI: "/assets/common/smart/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	$('#p_name').focus();
});
</script>

<form action="" id="a_goods_frm" name="a_goods_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="p_seq" value="${info.p_seq }" />
	<%-- ${info } --%>
	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>처방명</th>
				<td class="tdL"><input type=text size=30 name=p_name id="p_name" size=50 value="${info.p_name}" style="width:90%;" ></td>
				<th>분류</th>
				<td class="tdL">
					<select name="p_bigpart" id="p_bigpart">
						<c:forEach var="list" items="${shop_code}">
							<option value="${list.group_code }" <c:if test="${list.group_code eq info.p_bigpart }">selected="selected"</c:if>  >${list.group_name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>처방상태</th>
				<td class="tdL">
					<select name="p_ea" id="p_ea" style="width:90%;">
						<option value="처방가능" <c:if test="${info.p_ea eq '처방가능' }">selected="selected"</c:if>>처방가능</option>
						<option value="처방불가" <c:if test="${info.p_ea eq '처방불가' }">selected="selected"</c:if>>처방불가</option>
					</select>
				</td>
				<th>처방비용</th>
				<td class="tdL"><input type=text name=p_price id="p_price" size=10 value="${info.p_price }" style="width:90%;"></td>
			</tr>
			<tr>
				<th>출전</th>
				<td class="tdL"><input type=text name=jo_from size=30 id="jo_from" value="${info.jo_from }" style="width:90%;"></td>
				<th>용량</th>
				<td class="tdL"><input type=text name=p_size size=30  id="p_size" value="${info.p_size}" style="width:90%;"></td>
			</tr>
			<tr>
				<th>조제완료</th>
				<td class="tdL"><input type=text name=jo_complete size=10 id="jo_complete" value="${info.jo_complete}" style="width:90%;"></td>
				<th>조제중</th>
				<td class="tdL"><input type=text name=jo_ing size=10  id="jo_ing" value="${info.jo_ing}"  style="width:90%;"></td>
			</tr>
			<tr>
				<th>준비기간</th>
				<td class="tdL"><input type=text name=set_period size=30  id="set_period" value="${info.set_period}" style="width:150px;" ></td>
				<th>배송비</th>
				<td class="tdL"><input type=text name=delivery_price size=10  id="delivery_price" value="${info.delivery_price}" style="width:150px;" > 원</td>
			</tr>
			<tr>
				<th>활성</th>
				<td class="tdL" style="width:90%;">
					<select name="view_yn" id="view_yn">
						<option value="y" <c:if test="${info.view_yn eq 'y' }">selected="selected"</c:if>>활성</option>
						<option value="n" <c:if test="${info.view_yn eq 'n' }">selected="selected"</c:if>>비활성</option>
					</select>
				</td>
				<th>포장단위</th>
				<td class="tdL">
					<input type=text name=set_design size=20 id="set_design" value="${info.set_design}"  style="width:90%;" >
					<!-- 
					<input type=text name="group_code" readonly size=10  >
					<input type=text name="etc1" readonly size=10  >
					<input type=text name="etc2" readonly size=10  >
					<input type=button value="찾기" onclick="search_id()">
					 -->
				</td>
			</tr>
			<tr>
				<th>코드</th>
				<td colspan="3" class="tdL">${info.p_code}</td>
			</tr>
			<tr>
				<th>처방구성</th>
				<td colspan="3" class="tdL">
					<c:set var="yak_design1"  value="${fn:split(info.yak_design1, '|')}" />
					<c:set var="yak_design2"  value="${fn:split(info.yak_design2, '|')}" />
					<c:set var="yak_design3"  value="${fn:split(info.yak_design3, '|')}" />
					<c:set var="yak_design4"  value="${fn:split(info.yak_design4, '|')}" />
					<c:set var="yak_design5"  value="${fn:split(info.yak_design5, '|')}" />
					<c:set var="yak_design6"  value="${fn:split(info.yak_design6, '|')}" />
					<c:set var="yak_design7"  value="${fn:split(info.yak_design7, '|')}" />
					<c:set var="yak_design8"  value="${fn:split(info.yak_design8, '|')}" />
					<c:set var="yak_design9"  value="${fn:split(info.yak_design9, '|')}" />
					<c:set var="yak_design10" value="${fn:split(info.yak_design10, '|')}" />
					<c:set var="yak_design11" value="${fn:split(info.yak_design11, '|')}" />
					<c:set var="yak_design12" value="${fn:split(info.yak_design12, '|')}" />
					<c:set var="yak_design13" value="${fn:split(info.yak_design13, '|')}" />
					<c:set var="yak_design14" value="${fn:split(info.yak_design14, '|')}" />
					<c:set var="yak_design15" value="${fn:split(info.yak_design15, '|')}" />
								   
					<table class="basic03">
						<colgroup>
							<col width="50px" />
							<col width="150px" />
							<col width="150px" />
							<col width="150px" />
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>약재명</th>
								<th>원산지</th>
								<th>용량(g)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td><input type=text name=yak_name1 id="yak_name1" size=14  value="${yak_design1[0]}" ></td>
								<td><input type=text name=yak_from1 id="yak_from1" size=15  value="${yak_design1[1]}"></td>
								<td class="tdL"><input type=text name=yak_g1 id="yak_g1" size=6 style="text-align:right;" value="${yak_design1[2]}"> g</td>
							</tr>
							
							<tr>
								<td>2</td>
								<td><input type=text name=yak_name2 size=14  value="${yak_design2[0]}"></td>
								<td><input type=text name=yak_from2 size=15  value="${yak_design2[1]}"></td>
								<td class="tdL"><input type=text name=yak_g2 size=6 style="text-align:right;" value="${yak_design1[2]}"> g</td>
							</tr>
							
							<tr>
								<td>3</td>
								<td><input type=text name=yak_name3 size=14  value="${yak_design3[0]}"></td>
								<td><input type=text name=yak_from3 size=15  value="${yak_design3[1]}"></td>
								<td class="tdL"><input type=text name=yak_g3 size=6 style="text-align:right;" value="${yak_design1[2]}"> g</td>
							</tr>
							
							<tr>
								<td>4</td>
								<td><input type=text name=yak_name4 size=14  value="${yak_design4[0]}"></td>
								<td><input type=text name=yak_from4 size=15  value="${yak_design4[1]}"></td>
								<td class="tdL"><input type=text name=yak_g4 size=6 style="text-align:right;" value="${yak_design4[2]}"> g</td>
							</tr>
							
							<tr>
								<td>5</td>
								<td><input type=text name=yak_name5 size=14  value="${yak_design5[0]}"></td>
								<td><input type=text name=yak_from5 size=15  value="${yak_design5[1]}"></td>
								<td class="tdL"><input type=text name=yak_g5 size=6 style="text-align:right;" value="${yak_design5[2]}"> g</td>
							</tr>
							
							<tr>
								<td>6</td>
								<td><input type=text name=yak_name6 size=14  value="${yak_design6[0]}"></td>
								<td><input type=text name=yak_from6 size=15  value="${yak_design6[1]}"></td>
								<td class="tdL"><input type=text name=yak_g6 size=6 style="text-align:right;" value="${yak_design6[2]}"> g</td>
							</tr>
							
							<tr>
								<td>7</td>
								<td><input type=text name=yak_name7 size=14  value="${yak_design7[0]}"></td>
								<td><input type=text name=yak_from7 size=15  value="${yak_design7[1]}"></td>
								<td class="tdL"><input type=text name=yak_g7 size=6 style="text-align:right;" value="${yak_design7[2]}"> g</td>
							</tr>
							
							<tr>
								<td>8</td>
								<td><input type=text name=yak_name8 size=14  value="${yak_design8[0]}"></td>
								<td><input type=text name=yak_from8 size=15  value="${yak_design8[1]}"></td>
								<td class="tdL"><input type=text name=yak_g8 size=6 style="text-align:right;" value="${yak_design8[2]}"> g</td>
							</tr>
							
							<tr>
								<td>9</td>
								<td><input type=text name=yak_name9 size=14  value="${yak_design9[0]}"></td>
								<td><input type=text name=yak_from9 size=15  value="${yak_design9[1]}"></td>
								<td class="tdL"><input type=text name=yak_g9 size=6 style="text-align:right;" value="${yak_design9[2]}"> g</td>
							</tr>
							
							<tr>
								<td>10</td>
								<td><input type=text name=yak_name10 size=14  value="${yak_design10[0]}"></td>
								<td><input type=text name=yak_from10 size=15  value="${yak_design10[1]}"></td>
								<td class="tdL"><input type=text name=yak_g10 size=6 style="text-align:right;" value="${yak_design10[2]}"> g</td>
							</tr>
							
							<tr>
								<td>11</td>
								<td><input type=text name=yak_name11 size=14  value="${yak_design11[0]}"></td>
								<td><input type=text name=yak_from11 size=15  value="${yak_design11[1]}"></td>
								<td class="tdL"><input type=text name=yak_g11 size=6 style="text-align:right;" value="${yak_design12[2]}"> g</td>
							</tr>
							
							<tr>
								<td>12</td>
								<td><input type=text name=yak_name12 size=14  value="${yak_design12[0]}" ></td>
								<td><input type=text name=yak_from12 size=15  value="${yak_design12[1]}"></td>
								<td class="tdL"><input type=text name=yak_g12 size=6 style="text-align:right;" value="${yak_design12[2]}"> g</td>
							</tr>
							
							<tr>
								<td>13</td>
								<td><input type=text name=yak_name13 size=14  value="${yak_design13[0]}"></td>
								<td><input type=text name=yak_from13 size=15  value="${yak_design13[1]}"></td>
								<td class="tdL"><input type=text name=yak_g13 size=6 style="text-align:right;" value="${yak_design13[2]}"> g</td>
							</tr>
							
							<tr>
								<td>14</td>
								<td><input type=text name=yak_name14 size=14  value="${yak_design14[0]}"></td>
								<td><input type=text name=yak_from14 size=15  value="${yak_design14[1]}"></td>
								<td class="tdL"><input type=text name=yak_g14 size=6 style="text-align:right;" value="${yak_design14[2]}"> g</td>
							</tr>
							
							<tr>
								<td>15</td>
								<td><input type=text name=yak_name15 size=14  value="${yak_design15[0]}"></td>
								<td><input type=text name=yak_from15 size=15  value="${yak_design15[1]}"></td>
								<td class="tdL"><input type=text name=yak_g15 size=6 style="text-align:right;" value="${yak_design15[2]}"> g</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<th>상품상세</th>
				<td colspan="3" class="tdL"><textarea name=p_contents id="p_contents" rows=5 cols=103>${info.p_contents}</textarea></td>
			</tr>
			<tr>
				<th>목록설명</th>
				<td colspan="3" class="tdL"><input type=text name=p_bigo size=80  id="p_bigo" value="${info.p_bigo}" style="width:90%;" ></td>
			</tr>
			<tr>
				<th>상품사진1	</th>
				<td colspan="3" class="tdL">
					<input type=file name=image id="image" size=40 >
					<c:if test="${not empty info.image }">
						<br/><img src="/upload/goods/${info.image }" alt="" width="100px;" height="100px;" />
					</c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>상품사진2</th>
				<td colspan="3" class="tdL">
					<input type=file name=image2 id="image2" size=40 >
					<c:if test="${not empty info.image2 }">
						<br/><img src="/upload/goods/${info.image2 }" alt=""  width="100px;" height="100px;"/>
					</c:if>
				</td>
			</tr>
			<tr style="display:none;">
				<th>상품사진3</th>
				<td colspan="3" class="tdL">
					<input type=file name=image3 id="image3" size=40 >
					<c:if test="${not empty info.image3 }">
						<br/><img src="/upload/goods/${info.image3 }" alt=""  width="100px;" height="100px;"/>
					</c:if>
				</td>
			</tr>

		</tbody>
	</table>
</form>