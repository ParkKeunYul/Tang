$(document).ready(function() {
		
  	$("#jqGrid").jqGrid({
  		//caption : '최근 로그인 정보',
  		//dataType : 'local', // 로딩시 최초 조회 		  		
  		datatype: "local", 
  		url : '/admin/base/login/select.do',
  		datatype: 'json',
  		hidegrid: false,
  		width: "100%",
  		height: "100%",
  		rowNum: 20,
  		rowList: [20,50,100,500],
  		//rowList: [3],
  		colNames:[
  			'번호'   , '아이디'    , '이름'  , '한의원명'  , '접속IP' , 
  			'브라우져', '최근 로그인'
  		],
  		colModel:[
  			{name:'seqno',		index:'a_seqno',	width:48,	align:"center"  ,sortable : false ,key: true},
  			{name:'id',			index:'id',			width:120,	align:"left"    ,sortable : false},
  			{name:'name',		index:'name',		width:120,	align:"center"  ,sortable : false},
  			{name:'han_name',	index:'han_name',	width:200,	align:"left"    ,sortable : false},
  			{name:'user_ip',	index:'user_ip',	width:200,	align:"center"  ,sortable : false},  			  			  	
  			{name:'user_ip',	index:'user_ip',	width:200,	align:"center"  ,sortable : false},
  			{name:'user_br',	index:'user_br',	width:200,	align:"center"  ,sortable : false},
  			{name:'wdate2',		index:'wdate',		width:200,	align:"center"  ,sortable : false}
  		],
		pager: "#jqGridControl",
		viewrecords: true,
		autowidth: true,				
		//sortname: 'seqno',
		//sortorder: "desc",
		viewrecords: true,
		loadtext  : '데이터를 불러오는중입니다.',
		emptyrecords  : '검색된 데이터가 없습니다',
		//multiselect: true,
		// cellEdit : true,
		loadComplete: function(data) {
		}							
	});
  	
  	//페이지 넘 
  	jQuery("#jqGrid").jqGrid('navGrid','#jqGridControl',
  		{add:false,del:false,edit:false,search:false,refreshtext:"새로고침",position:'left'}	  				  	
  	);
  	
  	
  	$('#search_btn').click(function() {
  		var search_value = $('#search_value').val();
		var search_title = $('#search_title').val();
			
		var param = { 
			 search_value : search_value
			,search_title : search_title
			,pageSearch   : 1
		};				
		$("#jqGrid").setGridParam({"postData": param }).trigger("reloadGrid",[{page : 1}]);				
		return false;
	});
	  	
});