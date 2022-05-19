
$(document).ready(function(){
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
	
});

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
