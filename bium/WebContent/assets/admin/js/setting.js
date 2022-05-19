/*topmenu control*/
$(document).ready(function(){
	$('#Wrap').css("height",$(window).height());
	/* height*/
	$(window).resize(function() {
		$('#Wrap').css("height",$(window).height());
	});
	
	//tab scroll
	$('.tabProduct a').bind('click', function(e) {
		$.cookie('tabStart', 'tabOn');
	});
	
	//사이즈 변화로 타이틀 클래스 바꾸기
	chkTd();
	$(window).resize(function() {
		 chkTd();
	});
	function chkTd(){
		if(($('.tbl').eq(0).width()-($('.tbl').eq(1).width()) < 10)){
			$('#dateTit').removeClass("dateTit2").addClass("dateTit");
			$('#dateTitB').removeClass("dateTitB2").addClass("dateTitB");
		} else {
			$('#dateTit').removeClass("dateTit").addClass("dateTit2");
			$('#dateTitB').removeClass("dateTitB").addClass("dateTitB2");
		};
	};
	/*datepicker*/
	if($( ".datePicker").length > 0){
		 datePic($('.datePicker'));
	};
	
    //ui
	if($( "input[type=submit]" ).length > 0){
		btnUiCss($("input[type=submit]"),2);	
	};
	if($( ".button" ).length > 0){
		btnUiCss($(".button"),2);
	};
	if($( "button" ).length > 0){
		btnUiCss($("button"),3);
	};
});
/*datePicker activate*/
function datePic(obj){
	obj.datepicker({
		dateFormat: "yy-mm-dd",
		closeText:'닫기',
		prevText:'이전달',
		nextText:'다음달',
		showButtonPanel: true,
		currentText:'오늘',
		closeText: '닫기',
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames:['일','월','화','수','목','금','토'],
		dayNamesShort:['일','월','화','수','목','금','토'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		beforeShow: function(input, inst) {
			var firstInput = $(this).attr('name')+"_st";
			var secondInput = $(this).attr('name')+"_ed";
			if($(this).attr('id') == firstInput){
				return {
					maxDate: $("#"+secondInput).datepicker("getDate")
				};
			}
			if($(this).attr('id') == secondInput){
				return {
					minDate: $("#"+firstInput).datepicker("getDate")
				};
			};
			var i_offset= $(input).offset();
			setTimeout(function(){
		       $('#ui-datepicker-div').css({'top':i_offset.top, 'bottom':'', 'left':'10px'});
			});
		}
	});
}


/*button ui*/
function btnUiCss(obj,typeNum){
	if(typeNum == 1){
		obj.button()
	    .css({
	        "height": "24px",
	        "padding-top": "2px",
	        "padding-bottom": "6px",
	        "font-size": "12px",
	        "font-weight": "bolder"
	     });
	} else if(typeNum == 2){
		obj.button()
	    .css({
	        "height": "17px",
	        "padding-top": "1px",
	        "padding-bottom": "4px",
	        "font-size": "12px",
	        "font-weight": "bolder"
	     });	
	} else {
		obj.button()
	    .css({
	        "height": "24px",
	        "font-size": "12px",
	        "font-weight": "bolder"
	     });
	};
};

/* scrolling body top position */
function movingTop(Num){
	$( 'html, body' ).animate( {
		 scrollTop: Num
	 }, 'fast' );
};

/* 센터 팝업 */ 		
function winCenterOpen(url, name, w, h) {	 
	var win_left 	= (screen.width  - w ) / 2;		
	var win_top 	= (screen.height - h ) / 2;	
	var	winprops 	= 'height='			+	h
					+ ',width='			+	w
					+ ',top='			+	win_top
					+ ',left='			+	win_left
					+ ',scrollbars=no'
					+ ',resizable=false';
	win = window.open(url, name, winprops);
	win.focus();
};



function deliveryInfo(url){
	var width  = 769;
	var height = 796;
	var left2  = window.pageXOffset + parseInt( ( $(window).width()/2 )  - (width/2)  );
	var top2   = window.pageYOffset + parseInt( ( $(window).height()/2 ) - (height/2) );
		
	window.open (url,"delivery_view_2","toolbar=no, location=no, directories=no,resizable=no,left="+left2+",top="+top2+", width="+width+", height="+height+",scrollbars=yes")
}
