// 값이 체크
function valCheck(id,msg){
	var val = $('#'+id).val();
	if(val == '' || val == null){
		alert(msg);
		$('#'+id).focus();
		return false;
	}
	return true;
}

// 숫자
function valNum(id){
	var val = $('#'+id).val();
	if( isNaN(val) ){
		alert('숫자만 입력 가능합니다');
		$('#'+id).focus();
		return false;
	}
	return true;
}


// 비밀번호 일치
function pwdCheck(pwd, repwd){
	var pwdVal   = $('#'+pwd).val();
	var repwdVal = $('#'+repwd).val();
	
	if(pwdVal != repwdVal){
		alert('비밀번호가 일치하지 않습니다.');
		$('#'+repwd).val('');
		$('#'+repwd).focus();
		return false; 
	}
	return true;
}

// 길이체크
function lenCheck(id , len, msg){
	var val = $('#'+id).val();
	if(val.length < len){
		alert(msg);
		$('#'+id).focus();
		return false;
	}
	return true;
}

// 로그인 안했을떄
function notLogin(url){
	if(confirm('로그인후 신청하실수 있습니다. 로그인화면으로 이동하시겠습니까?')){
		var a = '/05_member/login?return_url='+url;
		location.href=a;
	}
}

function notLogin(url, msg){
	if(confirm(msg)){
		var a = '/05_member/login?return_url='+url;
		location.href=a;
	}
}

// 이미지 체크
function checkImgType(id){
	var img = $('#'+id).val();
	if(img!= null && img != ''){
		var img_extension = img.substring(img.lastIndexOf('.')+1).toLowerCase();
		if(!(img_extension == "gif" || img_extension =="png" || img_extension =="jpg" || img_extension =="jpeg") ){
			alert('확장자가 gif,png,jpg,jpeg인 이미지 파일만 업로드 할수 있습니다.');
			return false;
		}
	}
	return true;
}

function checkFileType(id){
	var img = $('#'+id).val();
	if(img!= null && img != ''){
		var img_extension = img.substring(img.lastIndexOf('.')+1).toLowerCase();
		if( (img_extension == "jsp" || img_extension =="asp" || img_extension =="js" || img_extension =="css" || img_extension =="exe" || img_extension =="php"|| img_extension =="dll") )
		{
			alert('확장자가 jsp,asp,js,css,exe,php,dll 파일은 첨부  할수 없습니다.');
			return false;
		}
	}
	
	return true;
}


function gotwitter(){
	var sUrl			= location.href;
	var contents        = $('#view_contents').val();
	var sTitle			= document.title+" | "+contents;  
	window.open("http://twitter.com/home?status="+encodeURIComponent(sTitle)+" "+encodeURIComponent(sUrl));
}
function gofacebook(){
	var sUrl			= location.href;
	var sTitle			= document.title;
	window.open("http://www.facebook.com/sharer.php?u=" +encodeURIComponent(sUrl) + "&t=111111"+encodeURIComponent(sTitle));
}
function gome2day(){
	var sUrl			= location.href;
	var sTitle			= document.title;
																						   
	window.open("http://me2day.net/posts/new?new_post[body]=" +encodeURIComponent(sTitle) + "-"+encodeURIComponent(sUrl));
}

function action(url, msg){
	if(confirm(msg)){
		location.href=url;
	}
}

//한글 숫자 조합
function isValidKorean(val){
	var idReg = /^[ㄱ-ㅎ가-힣0-9]{1,6}$/g;
	if(idReg.test(val)){
		return true;
	}else{
		return false;
	}
}

//영문,숫자,특수문자 혼용
function isValidPass(val){
	var str = /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/;

	if(str.test(val)){
		return true;
	}else{
		return false;
	}
}

/*
 * @alias 영문 숫자 조합
 * */
function isValidId(val) {
	var idReg = /^[a-z0-9]{1,20}$/g;
	var chk_num = val.search(/[0-9]/g); 
	var chk_eng = val.search(/[a-z]/ig);
	
	if(chk_num < 0 || chk_eng < 0)
	{ 
	    return false;
	}else if (idReg.test(val)) {
		return true;
	} else {
		return false;
	}
}

/**
 * 영문과 숫자 조합
 * @param str : 비교할 대상자
 * @returns {Boolean}
 */
function CheckPass(str){ 
	var filter = str.search(/[^0-9a-zA-Z]/g);

	if(filter > -1){ 
		return false;
	}else{ 
		var chk_num = str.search(/[0-9]/g); 
		var chk_eng = str.search(/[a-z]/ig); 

		if(chk_num < 0 || chk_eng < 0 ){ 
			return false;
		} else {
			return true;
		}
	} 	
}
/**
 * 숫자 입력
 */
function onlyNum() { 
	  var keycode = window.event.keyCode;
	 
	  if(keycode == 8 || (keycode >= 35 && keycode <= 40) || (keycode >= 46 && keycode <= 57) || (keycode >= 96 && keycode <= 105) || keycode == 110 || keycode == 190) {
	    window.event.returnValue = true;
	    return;
	  } else {
	    window.event.returnValue = false;
	    return;
	  }
	}

/**
 * @alias textarea br태그 처리
 */
function setBr(str) {
	str = replaceAll(str, "\n", "<br/>");
	str = replaceAll(str, "\r", "<br/>");
	return str;
}

/**
 * @alias textarea br태그 복처리
 */
function detBr(str) {
	str = replaceAll(str, "<br/>", "\n");
	str = replaceAll(str, "<br/>", "\r");
	return str;
}

//주민번호 * 처리
	$(".td_regNo").each(function(index) {
		try {
    	$(this).text(ValueFilter.convert("reg_no2", $(this).text()));
		} catch(e){}
	});
	
/**
 * @alias INPUT TYPE 입력값 제한
 * @param obj : INPUT TYPE Object
 * @param type : 입력값 제한 Type
 * 		- NUMB 	: 숫자
 * 		- NUCM 	: 숫자 and [ 복사, 잘라내기, SHIFT, DELETE, END, HOME, CTRL, C,V,X ]
 * 		- CHAR 	: 한글
 * 		- HCNO 	: 한글 AND 숫자
 * 		- ECHR 	: 영문
 * 		- ECNO 	: 영문 또는 숫자
 * 		- URL 	: 영문, 숫자, ?./=_&: -
 * 		- HNSP 	: 한글, 숫자, ", .,()-Space
 * 		- ENSP	: 영문, 숫자, ?./=_&:, Space , (,)괄호
 * 		- HENO	: 한글, 숫자, 영문
 * @return N/A
 * <input type=text onkeypress="gf_checkTypes(this, 'NUMB', event)" />
 */
function gf_checkTypes(obj, type, evt)
{
	try
    {
    	var key;
    	var val = obj.value;
    	var onlyEng = /^[a-zA-Z]+$/;
    	var mob = navigator.appName;
    	
    	if( mob == "Microsoft Internet Explorer" ){
    		key = evt.keyCode;
    	}else{
    		key = evt.which;
    		
    		// "<-"는 예외처리
    		if(key == 0x08) {
    			return true;
    		} 
    	}
    	console.log(key + " / "+ obj.value);
    	
        switch(type)
        {
            case "NUMB":    // 숫자
            	obj.style.imeMode = "disabled";
                if(
                        (48 <= key && key <= 57) || 
                        key == 0 || 
                        key == 45 || 
                        key == 8 ||
                        key == 9 ||
                        key == 16
                 )
                {
                    window.event.returnValue = true;
                }else{
                	obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }                   
                break;
            case "NUCM":    // 숫자 and [ 복사, 잘라내기, SHIFT, DELETE, END, HOME, CTRL, C,V,X ] 
            	obj.style.imeMode = "disabled";
            	if(
                    	(48 <= key && key >= 57) || 
                    	key == 0 || 
                    	key == 45 || 
                    	key == 8 ||  
                    	key == 9 ||  
                    	key == 16 ||  
                    	key == 17 ||  
                    	key == 35 ||  
                    	key == 36 ||
                    	key == 45 ||
                    	key == 46 ||
                    	key == 67 ||
                    	key == 86 ||
                    	key == 88 
               	)
                {
                    window.event.returnValue = true;
                }else{
                	obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }  
	                break;
            case "FLOT":    // 숫자 소수점, "." 추가
            	obj.style.imeMode = "disabled";
                if(
                        (48 <= key && key <= 57) || 
                        (96 <= key && key <= 105) || 
                        key == 110 || 
                        key == 190 || 
                        key == 0 || 
                        key == 45 || 
                        key == 8 ||
                        key == 9
                 )
                {
                    window.event.returnValue = true;
                }else{
                	obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }                   
                break;
            case "CHAR":    // 한글
            	obj.style.imeMode = "sMode";
                if( key == 229 )
                {
                	window.event.returnValue = true;
                }else{
                	obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                break;
            case "HCNO":    // 한글 또는 숫자
                obj.style.imeMode = "active";
                if( (key == 229) || (48 <= key && key <= 57) || (96 <= key && key <= 105) )
                {
                	window.event.returnValue = true;
                }else{
                	obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                break;
            case "ECHR":    // 영문
            	obj.style.imeMode = "disabled";
            	if( 65 <= key && key <=90)
            	{
            		window.event.keyCode = true;
            	}else{
            		obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			event.preventDefault();
            		}
            	}
                break;
            case "ECNO":    // 영문 또는 숫자 
                obj.style.imeMode = "disabled";
                if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x30 && key <= 0x39)))
                {
                    obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                else return true;
                break;
            case "URL" :    // 영문, 숫자, ?./=_&: -
                obj.style.imeMode = "disabled";
                if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x2E && key <= 0x3A) || key == 0x26 || key == 0x3D || key == 0x3F || key == 0x5F || key == 0x2D))
                {
                    obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                else return true;
                break;
            case "HNSP":    // 한글, 숫자, ", .,()-Space
                obj.style.imeMode = "active";
                if(!((key >= 0xAC00 && key <= 0xD7A3) || (key >= 0x3131 && key <= 0x314E) || (key >= 0x30 && key <= 0x39) || key == 0x20 || key == 0x22 || key == 0x28 || key == 0x29 || (key >= 0x2C && key <= 0x2E)))
                {
                    obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                else return true;
                break;
            case "ENSP" :    // 영문, 숫자, ?./=_&:, Space , (,)괄호
                obj.style.imeMode = "disabled";
                if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x2E && key <= 0x3A) || key == 0x26 || key == 0x3D || key == 0x3F || key == 0x5F || key == 0x20 || key == 0x28 || key == 0x29 || key == 0x2C ))
                {
                    obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                else return true;
                break;
            case "HENO":    // 한글, 숫자, 영문
                obj.style.imeMode = "active";
                if(!((key >= 0xAC00 && key <= 0xD7A3) || (key >= 0x3131 && key <= 0x314E) || (key >= 0x30 && key <= 0x39) 
                		|| (key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)))
                {
                    obj.focus();
                    if(window.event){
            			window.event.returnValue = false;
            			return false;
            		}else{
            			evt.preventDefault();
            		}
                }
                else return true;
                break;

	        }
    }
    catch(e)
    {
        alert("checkTypes error :" + e.Message());
	}
	
}

/**
 * @alias 주민번호 체크(내외국인)
 * @param socialno1	: 첫번째 주민등록번호 6자리
 * @param socialno2	: 두번째 주민등록번호 7자리
 * @return boolean
 */
function validCheckRRNO(socialno1, socialno2) {
	//내국인 주민번호 확인
	
	if(socialno2.substring(0, 1) < 5) {	
	var i, sum = 0;
	var str = socialno1 + socialno2;
	var jumin1 = socialno1, jumin2=socialno2;
	if (parseInt(jumin2) < 1000000 && parseInt(jumin2) > 2999999)
		return false;
	if (str.length < 13)	return false;
	for (i=0,sum=0; i<12; i++)
		sum += (((i%8) + 2) * (str.charAt(i) - "0"));
	//console.log("sum : " + sum);
	sum = 11 - (sum % 11);
	//console.log("sum : " + sum);
	sum = sum % 10;
	//console.log("sum : " + sum);
	if (sum == str.charAt(12))	return true;
	return false;
	//외국인 주민번호 확인
	} else {
		var fgnno = socialno1 + socialno2;
		var sum=0;
		var odd=0;
		buf = new Array(13);
		for(i=0; i<13; i++) { buf[i]=parseInt(fgnno.charAt(i)); }
		odd = buf[7]*10 + buf[8];
		if(odd%2 != 0) { return false; }
		if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) {
		        return false;
		}
		multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
		for(i=0, sum=0; i<12; i++) { sum += (buf[i] *= multipliers[i]); }
		sum = 11 - (sum%11);
		if(sum >= 10) { sum -= 10; }
		sum += 2;
		if(sum >= 10) { sum -= 10; }
		if(sum != buf[12]) { return false; }
		return true;
	}
}


function makeid(){
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < 15; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
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

	
	