var a_addr1 = '경상북도 포항시 북구 장량로 140번길 6';
var a_addr2 = '청담원외탕전 (장성동)';
var a_zip   = '29056';
var a_tel1  = '054';
var a_tel2  = '242';
var a_tel3  = '1079';
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

$(window).load(function(){
    Base.init();

});

var Base = {
    init : function(){
        if ($('.main-slide').length !== 0) {
            $('.main-slide').bxSlider({
                slideMargin: 0,
                startSlide: 0,
                auto:true,
                autoDelay:500,
                autoHover:true,
                onSliderLoad: function(){ 
                	$(".main-slide").css("visibility", "visible");
                }
            });
        };
    },
    
};
$(document).ready(function(){
	
	$('.gnbDepth2bg').stop().animate({ 
		width  :  '0px'
	}, 320, function() { 
		 console.log('gnbDepth2bg 0 완료');
	});

	$('.headerWrapper').stop().animate({ 
		width  :  '200px'
	}, 320, function() { 
		 console.log('gnbDepth2bg 200 완료');
	});
	
    // 디바이스 종류 설정
    var pc_device = "win16|win32|win64|mac|macintel";
 
    // 접속한 디바이스 환경
    var this_device = navigator.platform;
 
    if ( this_device ) {
    	
    	/*
        if ( pc_device.indexOf(navigator.platform.toLowerCase()) < 0 ) {
            console.log('MOBILE');
            var nowPath = window.location.pathname;
         //   alert( 'http://m.cdherb.com/m'+ nowPath );
            location.href ='http://m.cdherb.com/m/'+ nowPath;
        } else {
            console.log('PC');
            var nowPath = window.location.pathname;
            console.log( 'http://m.cdherb.com/m'+ nowPath );
        }
        */
    }
	
	$(".return_top").hide(); // 탑 버튼 숨김
	//탑버튼 보이게 하기
	$(window).scroll(function () {
		if ($(this).scrollTop() > 200) { // 원하는 윈도우 높이값 적어넣기
			$('.return_top').fadeIn();
		} else {
			$('.return_top').fadeOut();
		}
	});
	//탑으로 이동하기
	$('.return_top').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 500);  // 탑으로 이동하는 스크롤 속도
		return false;
	});

	$(".gnbDepth li").mouseover(function (){			
		$('.depWrapper').hide();

		var index = $(this).index(); 
		$(".submenu0" + (index+1)).css("display",""); 
								
		var gnbDepth2bg = $('.gnbDepth2bg').width(); 
		

		if(gnbDepth2bg == 160){	  				
			$('.gnbDepth2bg').stop().css('width', '160px');  
			$('.headerWrapper').stop().css('width', '360px');
		}else{  
			
			/*$('.gnbDepth2bg').stop().animate({ 
				width  :  '160px'
			}, 320, function() {  
				 console.log('gnbDepth2bg 160 완료');
			});
							
			$('.headerWrapper').stop().animate({ 
				width  :  '360px'
			}, 320, function() { 
				 console.log('headerWrapper 360 완료');
			});		*/
			var animate_time = 320 - (gnbDepth2bg * 2);
			$('.gnbDepth2bg').stop().animate({ 
				width  :  '160px'
			}, animate_time, function() {  // 0.32초 동안 width 가 160px로 증가됨
				 console.log('gnbDepth2bg 160 완료');
			});

			$('.headerWrapper').stop().animate({ 
				width  :  '360px'
			}, animate_time, function() { 
				 console.log('headerWrapper 360 완료');
			});
		}
					
		try{
			
			var img_nm   = $(this).find('a').find('img').attr('src').replace('_ov', '');			
			var img_over = img_nm.substr(0 , img_nm.lastIndexOf('.')) +"_ov.png";

			$(this).find('a').find('img').attr('src', img_over);
		}catch(e){}
		
		
	});		
	$(".gnbDepth li").mouseleave(function (){
		
		$('.gnbDepth2bg').stop().animate({ 
			width  :  '0px'
		}, 320, function() { 
			 console.log('gnbDepth2bg 0 완료');
		});

		$('.headerWrapper').stop().animate({ 
			width  :  '200px'
		}, 320, function() { 
			 console.log('gnbDepth2bg 200 완료');
		});


		try{				
			var img_over = $(this).find('a').find('img').attr('src');				
			var img_nm  = img_over.replace('_ov', '');
			$(this).find('a').find('img').attr('src', img_nm);
		}catch(e){}
		
	});
	$(".req_login").click(function() {
		var userInfo_id = objToStr($('#userInfo_id').val(),'');
		
		if(userInfo_id == ''){
			alert('로그인이 필요한 서비스입니다.');
			
			var rtnUrl = $(this).attr('href');
			console.log('rtnUrl= ', rtnUrl);
			
			return false;
		}else{
			var userInfo_level = objToStr($('#userInfo_level').val(),'');
			//if(userInfo_level == 1 || userInfo_level == 0){
			if(userInfo_level == 0){
				
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
	
	$(".req_login_pop").click(function() {
		var userInfo_id = objToStr($('#userInfo_id').val(),'');
		
		if(userInfo_id == ''){
			alert('로그인이 필요한 서비스입니다.');
			
			var rtnUrl = $(this).attr('href');
			
			location.href='/m06/login.do?rtnUrl='+rtnUrl;
			
			return false;
		}else{
			var userInfo_level = objToStr($('#userInfo_level').val(),'');
			//if(userInfo_level == 1 || userInfo_level == 0){
			if(userInfo_level == 0){
				
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

});



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
	var width = 800;
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



function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function deliveryInfo(url){
	var width  = 769;
	var height = 796;
	var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
	var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
		
	window.open (url,"delivery_view_2","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
}



