<%@page import="kr.co.hany.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="kr.co.hany.common.Const"%>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-2.0.js" type="text/javascript"></script>
<%
	/*
	*******************************************************
	* <결제요청 파라미터>
	* 결제시 Form 에 보내는 결제요청 파라미터입니다.
	* 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
	* 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
	* POST로 처리 / 인코딩 EUC-KR / 로그 외부 노출 되지 않도록 주의
	*******************************************************
	*/
	String encodeKey		= Const.NP_encodeKey; // 상점키
	String MID       		= Const.NP_MID;                   // 상점아이디
	//String moid             = Const.NP_moid;              // 상품주문번호
	
	Map<String, Object> view = (Map<String, Object>)request.getAttribute("view");
	
	String Amt            	= (view.get("price")+"").replace(".0", "");         // 결제상품금액
	
	
	/* int sale_per            = StringUtil.ObjectToInt(bean.get("sale_per"));
	
	
	int sale_price =  (StringUtil.ObjectToInt(Amt) * sale_per) / 100;
	
	System.out.println("총가격      = "+ Amt);
	System.out.println("할인퍼센트 = "+ sale_per);
	System.out.println("할인가격   = "+ sale_price);		
	String tot_price = (Amt-sale_price)+""; */
	
	System.out.println("결제금액   = "+ (Amt));
	
	
	String moid             = Const.NP_moid+"p"+(String.format("%08d", StringUtil.ObjectToInt(view.get("seqno"))));              // 상품주문번호      
		
	String charset          = "utf-8";
	
	/*
	*******************************************************
	* <해쉬암호화> (수정하지 마세요)
	* SHA-256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
	*******************************************************
	*/
	DataEncrypt sha256Enc 	  = new DataEncrypt();
	String ediDate      	  = getyyyyMMddHHmmss();	
	String encryptData    	  = sha256Enc.encrypt(ediDate + MID + Amt + encodeKey);
	System.out.println("할인가격 = "+ encryptData);
	/*
	******************************************************* 
	* <서버 IP값>
	*******************************************************
	*/
	InetAddress inet        = InetAddress.getLocalHost();	
%>
<script>
	//결제창 최초 요청시 실행됩니다. <<'nicepayStart()' 이름 수정 불가능>>
	function nicepayStart(){
	    goPay(document.frm);
	}

	//결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
	function nicepaySubmit(){
	    document.frm.submit();
	}

	//결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
	function nicepayClose(){
	    alert("결제가 취소 되었습니다");
	}
</script>
<!-- contents -->
<div class="contents">

	<p class="subtit_top">기본을 지키며 신뢰로 다가가는 비움환 원외탕전이 되겠습니다.<span>약속처방</span></p>
	<ul class="submenu w33">
		<li><a href="01.do" class="sel">약속처방</a></li>
		<li><a href="02.do" class="">약속처방 보관함</a></li>
		<li><a href="03.do" class="">사전조제지시서 관리</a></li>
	</ul>

	<form action="personal_com.do" name="frm" id="frm">
		
		<!-- 본문내용 -->
		<table class="basic_view">
			<colgroup>
				<col width="120px" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th>상품명</th>
					<th class="subject" <c:if test="${view.pay_yn eq 'y' }">style="text-decoration: line-through;"</c:if>  >${view.title}</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>결제금액</th>
					<td><span class="price" <c:if test="${view.pay_yn eq 'y' }">style="text-decoration: line-through;"</c:if>><fmt:formatNumber value="${view.price}" pattern="#,###" /></span>원</td>
				</tr>
			</tbody>
		</table>
		<div class="table_con" style="min-height: 300px;<c:if test="${view.pay_yn eq 'y' }">text-decoration: line-through;</c:if>">${view.CONTENT}</div>
	
		<div id="nice_pay_setting_area"  style="display: none;">
			<input type="text" name="seqno" value="${view.seqno}" />
		
			<input type="text" name="PayMethod"   value="CARD">
			<input type="text" name="GoodsName"   value="${view.title}"> <!-- 상품명 -->
			<input type="text" name="GoodsCnt"    value="1"> <!-- 상품겟수 -->
			<input type="text" name="Amt"         value="${view.price}"> <!-- 결제금액 -->
			<input type="text" name="BuyerName"   value="${userInfo.name}">
			<input type="text" name="BuyerTel"    value="${userInfo.handphone}">
			<input type="text" name="Moid"        value="<%=moid%>">
			<input type="text" name="MID"         value="<%=MID%>">
			
			<!-- IP -->
	        <input type="text" name="MallIP" value="<%=inet.getHostAddress()%>"/>      <!-- 상점서버IP -->
	                          
	          <!-- 옵션 -->
		  	<input type="text" name="CharSet"    value="<%=charset%>"/>                   <!-- 인코딩 설정 -->               
	        <input type="text" name="BuyerEmail" value="${userInfo.email}"/>             <!-- 구매자 이메일 -->				  
	        <input type="text" name="GoodsCl"    value="1"/>                              <!-- 상품구분(실물(1),컨텐츠(0)) -->
	        <input type="text" name="TransType"  value="0"/>                            <!-- 일반(0)/에스크로(1) --> 
	            
	        <!-- 변경 불가능 -->
	        <input type="text" name="EdiDate" value="<%=ediDate%>"/>                   <!-- 전문 생성일시 -->
	        <input type="text" name="EncryptData" value="<%=encryptData%>"/>            <!-- 해쉬값	-->
	        <input type="text" name="TrKey" value=""/>
		</div>
		<!-- // orderview -->

		
		<!-- btnarea -->
		<div class="btn_area01">
			<a href="personal.do?page=${bean.page}"><span class="cw h60">목록가기</span></a>
			<c:if test="${view.pay_yn eq  'n' }"><a href="#" id="orderPerBtn"><span class="cp h60">결제하기</span></a></c:if>
			<c:if test="${view.pay_yn eq  'y' }"><span class="cB h60">결제완료</span></c:if>
		</div>		
		<!-- //btnarea -->
	
	<!-- //본문내용 -->
	<script>
		$(document).ready(function() {
			
			$("#orderPerBtn").click(function() {
				nicepayStart();
				return false;
			});
			
		});
	</script>
	</form>
	
</div>
<!-- // contents -->

<!-- // container -->
<%!
		public final synchronized String getyyyyMMddHHmmss(){
		    SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		    return yyyyMMddHHmmss.format(new Date());
		}
		// SHA-256 형식으로 암호화
		public class DataEncrypt{
			MessageDigest md;
			String strSRCData = "";
			String strENCData = "";
			String strOUTData = "";
		
			public DataEncrypt(){ }
			public String encrypt(String strData){
				String passACL = null;
				MessageDigest md = null;
				try{
					md = MessageDigest.getInstance("SHA-256");
					md.reset();
					md.update(strData.getBytes());
					byte[] raw = md.digest();
					passACL = encodeHex(raw);
				}catch(Exception e){
					System.out.print("암호화 에러" + e.toString());
			    }
				return passACL;
			}
			
			public String encodeHex(byte [] b){
				char [] c = Hex.encodeHex(b);
				return new String(c);
			}
		}
	%>