/*$(document).ready(function(){
 $("#qna > li > a").on("click", function(e){
 if($(this).parent().has("ul")) {
 e.preventDefault();
 }

 if(!$(this).hasClass("open")) {
 // hide any open menus and remove all other classes
 $("#qna li ul").slideUp(350);
 $("#qna li a").removeClass("open");

 // open our new menu and add the open class
 $(this).next("ul").slideDown(350);
 $(this).addClass("open");
 }

 else if($(this).hasClass("open")) {
 $(this).removeClass("open");
 $(this).next("ul").slideUp(350);
 }
 });
 });
 */
var a_addr1 = '경상북도 포항시 북구 장성동 1417-10';
var a_addr2 = '청담원외탕전';
var a_zip   = '29056';
var a_tel1  = '054';
var a_tel2  = '123';
var a_tel3  = '4567';
var a_tang_name = '청담원외탕전';


var CookieManager = {
	put : function(name, value, expiredays) {

		console.log('CookieManager put = ', name);

		var expire = new Date();
		expire.setDate(expire.getDate() + expiredays);
		var cookies = name + '=' + escape(value) + '; path=/ ';
		if (typeof (expiredays) != 'undefined')
			cookies += ';expires=' + expire.toGMTString() + ';';
		document.cookie = cookies;
	},

	get : function(name) {
		name = name + '=';
		var cookies = document.cookie;
		var start = cookies.indexOf(name);
		var value = '';
		if (start != -1) {
			start += name.length;
			var end = cookies.indexOf(';', start);
			if (end == -1)
				end = cookies.length;
			value = cookies.substring(start, end);
		}
		return unescape(value);
	},

	remove : function(name) {
		CookieManager.put(name, '', -1);
	},

	removeAll : function() {
		var cookies = document.cookie.split(";");
		for (var i = 0; i < cookies.length; i++) {
			var key = cookies[i].split("=")[0];
			if (key != "JSESSIONID") {
				CookieManager.remove(key);
			}
		}
	}
};



$(document).ready(function() {
	$(".gnbDepth01 li").mouseover(function() {
		$('.depWrapper').hide();
		$(this).children('.depWrapper').show();
	}).mouseenter(function() {
		$('.depWrapper').hide();
		$(this).children('.depWrapper').show();
	});

	$('.headerFixedBox').mouseleave(function() {
		$('.depWrapper').hide();
	});

	$("#loginBtn").click(function() {
		console.log('loginBtn');
	});

	$("#loginBtn").click(function() {
		location.href = $(this).attr('href');
	});

	$("#popLoginBtn").click(function() {
		userLoginProc();
		return false;
	});

	$("#pop_id, #pop_password").keydown(function(key) {
		if (key.keyCode == 13) {
			userLoginProc();
		}
	});
	
	
	$(".req_login").click(function() {
		var userInfo_id = objToStr($('#userInfo_id').val(),'');
		if(userInfo_id == ''){
			alert('로그인이 필요한 서비스입니다.');
			return false;
		}else{
			var userInfo_level = objToStr($('#userInfo_level').val(),'');
			if(userInfo_level == 1 || userInfo_level == 0){
				
				var link_url = $(this).attr('href');
				if(link_url == '/m05/01.do'){
					return true;
				}else{
					alert('정회원 서비스입니다.');
					return false;
				}
			}
		}
	});

	var cookie_exist = objToStr(CookieManager.get("loginID"), '');
	if (cookie_exist != '') {
		$('#pop_id').val(cookie_exist);
		$("#pop_idsave").prop("checked", true);
	}
});

function userLoginProc() {
	if (!valCheck('pop_id', '아이디를 입력하세요.'))
		return;
	if (!valCheck('pop_password', '비밀번호를 입력하세요.'))
		return;

	$.ajax({
		url : '/login_proc.do',
		type : 'POST',
		data : {
			id : $('#pop_id').val(),
			password : $('#pop_password').val()
		},
		error : function() {
			alert('에러가 발생했습니다.\n관리자에 문의하세요.');
		},
		success : function(data) {
			// console.log('data = ', data);
			if (data.suc) {
				if ($("#pop_idsave").is(":checked")) {
					CookieManager.put('loginID', $('#pop_id').val(), 60);
				} else {
					CookieManager.put('loginID', $('#pop_id').val(), 0);
					CookieManager.remove('loginID');
				}
				$('#pop_id').val('');
				$('#pop_password').val('');
				location.href = data.url;
				
			} else {
				alert(data.msg);
			}
		}
	});
}

function find_addr(zip, addr1, addr2) {
	var element_layer = document.getElementById("layerFindAddr");

	new daum.Postcode({
		oncomplete : function(data) {

			var fullAddr = data.address; // 최종 주소 변수
			var extraAddr = ''; // 조합형 주소 변수

			if (data.userSelectedType === 'R') {

				if (data.bname !== '') {
					extraAddr += data.bname;
				}
				if (data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}
				fullAddr = data.roadAddress;

			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				fullAddr = data.jibunAddress;
			}

			fullAddr = fullAddr;

			var addrNm = "(" + data.bname;
			if (data.buildingName != '' && data.buildingName != null
					&& data.buildingName != undefined) {
				addrNm = addrNm + "," + data.buildingName
			}
			addrNm = addrNm + ")";

			// console.log('data = ', data);

			$('#' + zip).val(data.zonecode);
			$('#' + addr1).val(fullAddr);
			$('#' + addr2).focus();
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

}

function initLayerPosition(element_layer) {
	var width = 1000;
	var height = 600;
	var borderWidth = 5;

	// 위에서 선언한 값들을 실제 element에 넣는다.
	element_layer.style.width = width + 'px';
	element_layer.style.height = height + 'px';
	element_layer.style.border = borderWidth + 'px solid';
	// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	// element_layer.style.left = '210px';
	// element_layer.style.top = '100px';
	element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
			+ 'px';
	element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
			+ 'px';
}

function closeDaumPostcode() {
	$('.find_addr_layer_pop').hide();
}

function objToStr(val, rep) {
	try {
		if (val == null || val == "" || val == undefined) {

			if (rep != undefined && rep != null) {
				return rep;
			} else {
				return '';
			}
		}
	} catch (e) {
		return '';
	}
	return val;
}

function downloadBoard(ori_name, rename, path) {
	var url = "/download.do?path=" + path + "&filename=" + ori_name
			+ "&refilename=" + rename;
	location.href = url;
	return false;
}



function comma(number) {
	/*str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');*/
	console.log( number );
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function deliveryInfo(url){
	var width  = 769;
	var height = 796;
	var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
	var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
		
	window.open (url,"delivery_view_2","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
}
