<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<script charset="utf-8">
	
	
	$(document).ready(function() {
		
		$('#title').focus();
		
		
		$('#re_content').keyup(function() { 
			getByte($(this));
			cut_2000($('#re_content'));
		});
		
		getByte($('#re_content'));
		cut_2000($('#re_content'));
		
	});
	
	function cut_2000(obj){
        var text = $(obj).val();
        var leng = text.length;
        while(getTextLength(text) > 1000){
            leng--;
            text = text.substring(0, leng);
        }
        //console.log('cut_2000');
       $(obj).val(text);
    }
	function getTextLength(str) {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            if (escape(str.charAt(i)).length == 6) {
                len++;
            }
            len++;
        }
        return len;
    }
	
	function getByte(el){
		var codeByte = 0;
	    for (var idx = 0; idx < el.val().length; idx++) {
	        var oneChar = escape(el.val().charAt(idx));
	        if ( oneChar.length == 1 ) {
	            codeByte ++;
	        } else if (oneChar.indexOf("%u") != -1) {
	            codeByte += 2;
	        } else if (oneChar.indexOf("%") != -1) {
	            codeByte ++;
	        }
	    }// for
	   // console.log('codeByte = ', codeByte);
	    
	    $('#sms_length').val(codeByte);
	}
	
	
	function a_board_mod(){
		var ajax_url =  '/admin/board/qna/mod_proc.do';
		a_board_proc(ajax_url);
	}//a_name_mod
	
	function a_board_add(){
		
		var ajax_url =  '/admin/board/qna/add_proc.do';
		a_board_proc(ajax_url);
	}//a_name_mod
	
	
	function a_board_proc(ajax_url){
		
		
		//if(!valCheck('title','제목을 입력하세요')) return false;
		if(!valCheck('re_content','답변 내용을 입력하세요')) return false;
		
		
		var queryString = $("form[name=board_frm]").serialize() ;
		
		
		if($("#sms_send").is(":checked") && $('#re_com').val() == 'y' && $('#handphone').val() != ''){
			send_sms_ajax();
		}
		
		$('#board_frm').ajaxForm({		        
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
	            	 if(ajax_url == '/admin/board/qna/add_proc.do'){
	            		$("#jqGrid").trigger("reloadGrid",[{page : 1}]);
	            		$("#addForm").dialog('close');
	            	}else{
	            		$("#jqGrid").trigger("reloadGrid");
	            	//	$("#modForm").dialog('close');
	            	}
	            }
	        }		        
	    });	
		$("#board_frm").submit();
	}// a_board_proc
	
	
	function downloadBoard(ori_name 
			              ,rename
			              ,path){
		var url = "/download.do?path="+path+"&filename="+ori_name+"&refilename="+rename;
		location.href=url;
			
	}	
	
	function a_board_main(ajax_url){
		alert('a_board_main = '+ajax_url);
		
		//if(!valCheck('title','제목을 입력하세요')) return false;
		if(!valCheck('re_content','답변 내용을 입력하세요')) return false;
		
		
		var queryString = $("form[name=board_frm]").serialize() ;
		
		$('#board_frm').ajaxForm({		        
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
	            if(data.suc){
	            	$("#qnaGrid").trigger("reloadGrid");
	            }
	        }		        
	    });	
		$("#board_frm").submit();
	}// a_board_proc
	
	function maxLengthCheck(id, title, maxLength){
	     var obj = $("#"+id);
	     if(maxLength == null) {
	         maxLength = obj.attr("maxLength") != null ? obj.attr("maxLength") : 1000;
	     }
	     
	     if(Number(byteCheck(obj)) > Number(maxLength)) {
	         alert(title + "이(가) 입력가능문자수를 초과하였습니다.\n(영문, 숫자, 일반 특수문자 : " + maxLength + " / 한글, 한자, 기타 특수문자 : " + parseInt(maxLength/2, 10) + ").");
	         obj.focus();
	         return false;
	     } else {
	         return true;
	    }
	}
	
	function send_sms_ajax(){
		console.log('send_sms_ajax');
		$.ajax({
			url: "https://www.apiorange.com/api/send/sms.do",
			type: "POST",
			headers: {
				"Content-Type": "application/json; charset=utf-8",
				"Authorization": "bc0Yl8Ijyp8fGdj24aCw9VeNLgeZZfNGtzxp98yJ9Ds="
			},
			data: JSON.stringify({
				sender            : '0542421079',
				name              : '테스트',
				phone             : '01048512238',
				subject           : '[청담원외탕전 답변] '+$('#title').val(),
				msg               : $('#re_content').val(),				
				use_reject        : 'Y'
			}),
			success : function(data) {				
				return true;
			},
			error : function(request, status, error) {
				return false;
			}
		});
	}
	
</script>


<form action="" id="board_frm" name="board_frm" enctype="multipart/form-data" method="post" >
	<input type="hidden" name="board_name" id="board_name" 	   value="${add_bean.board_name}" />
	<input type="hidden" name="ref"        id="ref"        	   value="${add_bean.ref }">
	<input type="hidden" name="ref_step"   id="ref_step"   	   value="${add_bean.ref_step }">
	<input type="hidden" name="ref_level"  id="ref_level"  value="${add_bean.ref_level }">
	<input type="hidden" name="seq"  id="seq"  value="${add_bean.seq }">
	
	<input type="hidden" name="email"  id="email"  value="${info.email }">
	<input type="hidden" name="handphone"  id="handphone"  value="${info.handphone }">

	<table class="basic01">
		<colgroup>
			<col width="150px" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th>이름</th>
				<td class="tdL">${info.mem_name}</td>
			</tr>
			<tr>
				<th>문의유형 </th>
				<td class="tdL">
					<select name=cate_nm id="cate_nm" style="width: 90%;">
						<option value="배송관련" <c:if test="${info.cate_nm eq '배송관련' }">selected="selected"</c:if>>배송관련</option>
						<option value="취소/교환/반품" <c:if test="${info.cate_nm eq '취소/교환/반품' }">selected="selected"</c:if>>취소/교환/반품</option>
						<option value="상품관련" <c:if test="${info.cate_nm eq '상품관련' }">selected="selected"</c:if>>상품관련</option>
						<option value="기타" <c:if test="${info.cate_nm eq '기타' }">selected="selected"</c:if>>기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목 </th>
				<td class="tdL">
					${info.title}
					<input type="hidden" name="title" id="title" value="${info.title}" style="width: 90%;" />
				</td>
			</tr>
			<tr>
				<th>한의원명 </th>
				<td class="tdL">${info.mem_han_name}</td>
			</tr>
			<tr>
				<th>발송 휴대폰번호 </th>
				<td class="tdL">${info.handphone}</td>
			</tr>
			<tr>
				<th>첨부파일 </th>
				<td class="tdL">
					<c:if test="${not empty info.ori_name1 }">
						<a onclick="downloadBoard('${info.ori_name1}', '${info.re_name1}', '${info.board_name}')"  href="#">${info.ori_name1}</a>
						<!-- <label for="file_check1">기족파일 삭제</label>
						<input type="checkbox" name="file_check1" id="file_check1" value="Y" /> -->					
						<input type="hidden" name="pre_re_name1" value="${info.re_name1}" />
						<input type="hidden" name="pre_ori_name1" value="${info.ori_name1}" />  
					</c:if>
					
					<c:if test="${not empty info.ori_name2 }">
						<br/><a href="/download.do?path=notice&filename=${info.ori_name2}&refilename=${info.re_name2}">${info.ori_name2}</a>
						<!-- <label for="file_check2">기족파일 삭제</label>
						<input type="checkbox" name="file_check2" id="file_check2" value="Y" /> -->
						<input type="hidden" name="pre_re_name2" value="${info.re_name2}" />
						<input type="hidden" name="pre_ori_name2" value="${info.ori_name2}" />
					</c:if> 
					
					<c:if test="${not empty info.ori_name3 }">
						<br/><a href="/download.do?path=notice&filename=${info.ori_name3}&refilename=${info.re_name3}">${info.ori_name3}</a>
						<!-- <label for="file_check3">기족파일 삭제</label>
						<input type="checkbox" name="file_check3" id="file_check3" value="Y" /> --> 
						<input type="hidden" name="pre_re_name3" value="${info.re_name3}" />
						<input type="hidden" name="pre_ori_name3" value="${info.ori_name3}" />
					</c:if>
				</td>
			</tr>
			<tr >
				<th>내용 </th>
				<td class="tdL">
					${info.content}
					<textarea name="content" id="content" style="width:100%; height:412px; display:none;">${info.content}</textarea>
				</td>
			</tr>
			<tr>
				<th>답변처리상태 </th>
				<td class="tdL">
					<select name="re_com" id="re_com"  style="width: 90%;">
						<option value="n" <c:if test="${info.re_com eq 'n' }">selected="selected"</c:if>>대기중</option>
						<option value="y" <c:if test="${info.re_com eq 'y' }">selected="selected"</c:if>>답변완료</option>
					</select>
				</td>
			</tr>
			<tr style="display:none;">
				<th>처리 </th>
				<td class="tdL">
					<label for="email_send" style="color: blue;">이메일로 전송</label>
					<input type="checkbox" name="email_send" id="email_send" value="y"  <c:if test="${info.email_send eq 'y' }">checked="checked"</c:if> />
					&nbsp;&nbsp;&nbsp;&nbsp;
					
					<label for="sms_send" style="color: red;">문자메세지 전송.</label>
					<input type="checkbox" name="sms_send" id="sms_send" value="y"  <c:if test="${info.sms_send eq 'y' }">checked="checked"</c:if> />
					<input type="text" id="sms_length" style="width: 50px;text-align: right;"   />/1000byte
				</td>
			</tr>
			<tr>
				<th>답변 내용 </th>
				<td class="tdL">
					<textarea name="re_content" id="re_content" style="width:100%; height:212px;">${info.re_content}</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	<%-- <a href="write?ref=${view.REF}&ref_level=${view.REF_LEVEL+1}&ref_step=${view.REF_STEP+1}&board_name=${bean.board_name}&seq=${bean.seq}&page=${bean.page}&pagelistno=${bean.pagelistno}<c:if test="${! empty bean.search_value }">&search_title=${bean.search_title}&search_value=${bean.search_value}</c:if>" class="button">답글쓰기</a> --%>
	
</form>
	
