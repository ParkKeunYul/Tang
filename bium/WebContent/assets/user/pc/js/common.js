var a_addr1 = '부산광역시 강서구 대저중앙로172번길 20';
var a_addr2 = '비움환원외탕전';
var a_zip   = '46700';
var a_tel1  = '051';
var a_tel2  = '941';
var a_tel3  = '5104';
var a_tang_name = '비움환원외탕전';

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
	/*
    // 디바이스 종류 설정
    var pc_device = "win16|win32|win64|mac|macintel";
 
    // 접속한 디바이스 환경
    var this_device = navigator.platform;
 
    if ( this_device ) {
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
 
    }
	*/
	
	$(".return_top").hide(); // 탑 버튼 숨김
	//탑버튼 보이게 하기
	$(window).scroll(function () {
		if ($(this).scrollTop() > 50) { // 원하는 윈도우 높이값 적어넣기
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
	//공통 : GNB
	TOP_GobalNav();

	//LNB 메뉴 슬라이드
	LNB_MenuActive();
	
		
	$(".req_login").click(function() {
		var userInfo_id = objToStr($('#userInfo_id').val(),'');
		console.log('userInfo_id =', userInfo_id);
		if(userInfo_id == ''){
			alert('로그인이 필요한 서비스입니다.');
			return false;
		}else{
			var userInfo_level = objToStr($('#userInfo_level').val(),'');
			
			//alert('userInfo_level = '+userInfo_level);
			//if(userInfo_level == 1 || userInfo_level == 0){
			if(userInfo_level == 0){
				
				var link_url = $(this).attr('href');
				//console.log(userInfo_level + 'link_url = ', link_url);
				
				if(link_url == '/m05/01.do' || link_url == '/m04/03.do' || link_url == '/m04/02.do'){
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




/* 공통 : GNB */
function TOP_GobalNav(){
	var _GNB = $('.gnbDepth');
	var hasSubMenu = _GNB.find('li > div');
	if( hasSubMenu.length ){ hasSubMenu.parent('li').addClass('hasSub'); } //서브메뉴 표시 아이콘 추가

	var $menuON = _GNB.find('.on');
	if( $menuON.length ){
		$menuON.parents('li').addClass('active');
		$menuON.parents('li').find('> a').addClass('on');
	}
	_GNB.find('.active > div').slideDown('fast');

	var $UL_A = _GNB.find('li>a');
	$UL_A.on('click',function(e){
		if ( $(this).next('div').length){ e.preventDefault(); }

		//siblings
		var _siblings = $(this).parent().siblings();
		_siblings.removeClass('active');
		_siblings.find('a').removeClass('on');
		_siblings.find('>div').hide();

		//this
		$(this).addClass('on');
		$(this).parent().addClass('active');

		var nextUL = $(this).next('div');
		if (nextUL.length && nextUL.is(':hidden')){
			$(this).next('div').slideDown();
		} else if (nextUL.length && nextUL.is(':visible')){
			$(this).next('div').hide();
			$(this).parent().removeClass('active');
			$(this).removeClass('on');
		}
	});

}


/** ------------------------------------------
 *  LNB (sly.js 실행)
 *  - node_lnb :
 *  - currentIndex  :
 * -------------------------------------------
 */
function LNB_MenuActive(){
	if(! $('.sliderFrame').length){return;}

	$('.sliderFrame').each(function(){
		var dataText = $(this).attr('data-idx');

		var $frame = $(this);
		var $wrap  = $frame.parent();
		$frame.sly({
			horizontal: 1,
			itemNav: 'forceCentered',
			smart: 1,
			activateMiddle: 1,
			activateOn: 'click',
			mouseDragging: 1,
			touchDragging: 1,
			releaseSwing: 1,
			startAt: dataText,
			scrollBar: false,//$wrap.find('.scrollbar'),
			scrollBy: 1,
			speed: 300,
			elasticBounds: 1,
			easing: 'easeOutExpo',
			dragHandle: 1,
			dynamicHandle: 1,
			clickBar: 1,

			// Buttons
			prev: $wrap.find('.btnPrev'),
			next: $wrap.find('.btnNext')
		});

		$(window).resize(function(e) {
			$frame.sly('reload');
		});
	});
}
