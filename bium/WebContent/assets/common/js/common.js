function popup(url,name,width,height,Scroll,resize){
	var popWin = window.open(url,name,"width="+width+",height="+height+",location=no,status=no,scrollbars="+Scroll+",resizable="+resize);
	popWin.focus();
}

function popup2(url,name,Scroll,resize){
	var popWin = window.open(url,name,"location=no,status=no,scrollbars="+Scroll+",resizable="+resize);
	popWin.focus();
}

/**
 * @alias 접속 기종 체크
 */
function check_device(){
    var mobileKeyWords = new Array('iPhone', 'iPad', 'BlackBerry', 'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson');
    var device_name = '';
    for (var word in mobileKeyWords){
        if (navigator.userAgent.match(mobileKeyWords[word]) != null){
            device_name = mobileKeyWords[word];
            break;
        }
    }
        
    return device_name;
}


