function popup(url,name,width,height,Scroll,resize){
	var popWin = window.open(url,name,"width="+width+",height="+height+",location=no,status=no,scrollbars="+Scroll+",resizable="+resize);
	popWin.focus();
}

function popup(url,name,width,height,Scroll,resize,top,left){
	var popWin = window.open(url,name,"width="+width+",height="+height+",location=no,status=no,scrollbars="+Scroll+",resizable="+resize+",top="+top+",left="+left);
	popWin.focus();
}

function popup2(url,name,Scroll,resize){
	var popWin = window.open(url,name,"location=no,status=no,scrollbars="+Scroll+",resizable="+resize);
	popWin.focus();
}

function whichBrs() {
	  var agt=navigator.userAgent.toLowerCase();
	  var whichBrower = "";
	  if (agt.indexOf("opera") != -1) {
	    whichBrower='Opera';
	  }
	  else if (agt.indexOf("staroffice") != -1) {
	    whichBrower='Star Office';
	  }
	  else if (agt.indexOf("webtv") != -1) {
	    whichBrower='WebTV';
	  }
	  else if (agt.indexOf("beonex") != -1) {
	    whichBrower='Beonex';
	  }
	  else if (agt.indexOf("chimera") != -1) {
	    whichBrower='Chimera';
	  }
	  else if (agt.indexOf("netpositive") != -1) {
	    whichBrower='NetPositive';
	  }
	  else if (agt.indexOf("phoenix") != -1) {
	    whichBrower='Phoenix';
	  }
	  else if (agt.indexOf("firefox") != -1) {
	    whichBrower='Firefox';
	  }
	  else if (agt.indexOf("safari") != -1) {
	    whichBrower='Safari';
	  }
	  else if (agt.indexOf("skipstone") != -1) {
	    whichBrower='SkipStone';
	  }
	  else if (agt.indexOf("msie") != -1) {
	    whichBrower='InternetExplorer';
	  }  
	  else if (agt.indexOf("nt") != -1) {
	    whichBrower='InternetExplorer';
	  }
	  else if (agt.indexOf("netscape") != -1) {
	    whichBrower='Netscape';
	  }
	  else if (agt.indexOf("mozilla/5.0") != -1) {
	    whichBrower='Mozilla';
	  }
	  else if (agt.indexOf('\/') != -1) { 
	    if (agt.substr(0,agt.indexOf('\/')) != 'mozilla') { 
	      whichBrower=navigator.userAgent.substr(0,agt.indexOf('\/'));
	    }
	    else {
	      whichBrower='Netscape';
	    }
	  }
	  else if (agt.indexOf(' ') != -1) {
	    whichBrower=navigator.userAgent.substr(0,agt.indexOf(' ')); 
	  }
	  else {
	    whichBrower=navigator.userAgent;
	  }
	  if(whichBrower!="InternetExplorer") {
	    alert("현재 실행중인 브라우저는 "+whichBrower+" 입니다.\n인터넷익스플로러를 실행하여 증명서 출력을사용하여 주시기 바랍니다.");
	    self.close();
	  }
}


