<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html lang="ko">
<head>	
	<title>청담원외탕전</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
	<meta name="title" content="청담원외탕전">
	<link rel="stylesheet" type="text/css" href="/assets/user/m/css/public.css" />
	<script  src="https://code.jquery.com/jquery-1.12.4.js" ></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$(".popBtn").click(function() {
			print();
			return false;
		});
	});
	</script>
	<%
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY년     MM월      dd일");
	%>
	<style>
		[class^=btnType] {
			display:inline-block; overflow:hidden; box-sizing:border-box; height:3.5rem; min-width:8rem; line-height:3.5rem; padding-left:.6rem; padding-right:.6rem; vertical-align:middle; text-align:center; font-size:1.2rem; font-weight:700; background:#949494; color:#fff; cursor:pointer;
		}
		
		.btnArea{
			width: 100%;
			text-align: center;;
		}
		
		.btnArea.write button{
			width: 45%;
			margin: 0 .4rem;
		}
		.colorGreen{
			background: #00b49c;
			 
		}
		
		@media print{
			.btnArea{
				display: none;
			}
		}
	</style>
	<style type="text/css" media="print">
	    @page 
	    {
	        size: auto;   /* auto is the initial value */
	        margin: 0mm;  /* this affects the margin in the printer settings */
	    }
	</style>
</head>
<body>
<div class="contractPop">
	<div class="btnArea write">
		<button type="button" class="btnTypeBasic colorGreen popBtn"><span>계약서 출력하기</span></button>
	</div>

	<div class="page02">
		<p class="subtit">원외 탕전실 공동사용 계약서</p>
		<ul>
			<li>${bean.han_name}(이하 “동”이라 한다)과 강구제일한의원 부속 청담원외탕전(이하 “행”이라 한다)은 원외탕전실 공동이용에 관하여 다음과 같이 계약한다.</li>
			<li>
				<span>제1조【목적】</span>
				“동”은 “행”에 대해 한약의 조제 및 그에 따른 탕전, 포장, 보관, 운송 업무를 “행”에게 위탁, 일임한다.<br/>
			</li>
			<li>
				<span>제2조【원재료 등의 공급】 </span>
				1. “동”은 제1조의 탕전업무에 필요한 처방전을 “행”에게 제공한다.<br/>
				2. “행”은 “동”으로부터 제공받은 처방전대로 조제 및 탕전업무를 수행한다.<br/>
				3. 약재비용, 포장재료, 배송비 등에 대해서는 별도로 정한다.<br/>
			</li>
			<li>
				<span>제3조【업무협의】</span>
				1. 한약의 포장, 운송처에 대해서 “동”은 “행”에게 제공하는 처방전에 표기하고, “행”은 처방전 내용대로 처리한다.<br/>
				2. 처방에 따른 한약 복용법은 “동”이 제공하는 것을 원칙으로 하되, 이외의 사항은 협의에 따른다.</li>
			<li>
				<span>제4조【자료 공개의 의무】</span>
				1. 처방전 원본은 “동”이 보관하는 것을 원칙으로 한다.<br/>
				2. “행”은 정해진 기간에 “동”에게 조제 및 탕전내역을 제공하기로 한다.
			</li>
			<li>
				<span>제5조【비용부담】</span>
				조제 및 탕전에 대한 비용은 상호 협의에 따르며, “동”은 “행”의 청구서에 의거 약정된 기한 내에   지급하기로 한다.
			</li>
			<li>
				<span>제6조【조제 및 탕전 거절】 </span>
				“행”은 “동”이 탕전 의뢰한 한약재 중 해당기관에서 사용을 금하는 한약재 또는 마약류 등이 포함되어있을 경우에 한하여 “동”의 의뢰를 거절할 수 있다.
			</li>
			<li>
				<span>제7조【운송방법】</span> 
				제품의 운송 업무를 이행함에 있어서는 “행”의 결정에 따른다.
			</li>
			<li>
				<span>제8조【손해배상】 </span>
				1. 운송 중 파손된 한약에 대해서는 배상비용을 “행”이 부담하는 것을 원칙으로 하되, 배송사고의   발생에 “동”이 명백한 사유를 제공했을 경우는 그렇지 아니하다. <br/>
				2. 분실된 경우, 오배송의 책임은 상호 협의에 따른다. 
			</li>
			<li>
				<span>제9조【의료사고의 책임소재】</span> 
				“행”이 “동”의 처방전대로 조제 및 탕전을 성실히 이행한 경우 의료사고에 대한 모든 책임은 “동”에게 있다. 단, “행”의 조제 및 탕전 과정에서 명백한 과오가 증명될 경우 “행”과“동”의 상호 협의에 따라 대처한다.
			</li>
			<li>
				<span>제10조【계약의 유지 및 해지】</span>
				“행”과 “동”은 다음과 같은 사유가 발생하여 한약의 조제 및 탕전에 어려움이 있을 경우, 1개월 전에 반드시 서면으로 통보하고, 상호 협의 하에 계약을 해지할 수 있다. <br/>
				(단, 해지계약서를 작성 하여 각 1부씩 보관 한다.)<br/>
				1. 해당기관의  영업정지 기타 영업등록 취소 처분이 발생하는 경우<br/>
				2. 압류, 가압류, 가처분, 강제집행, 담보권신청등으로 계약이 지속될 수 없거나 파산, 청산 등으로  지급정지, 지급불능이 되는 경우<br/>
				3. 천재지변으로 인한 조제 및 탕전이 불가능한 경우
			</li>
			<li>
				<span>제11조【비밀의 유지】</span>
				“행”과 “동”은 본 계약의 수행으로 알게 된 비밀을 계약기간, 계약종료 이후에도 타인에게 누설해서는 안 된다.
			</li>
			<li>
				<span>제12조【지위의 양도금지】</span>
				“동”은 본 계약상의 지위를 제3자에게 양도할 수 없다.
			</li>
			<li>
				<span>제13조【유효기간】</span>
				1. 본 계약의 유효기간은 만 1년으로 하며, 계약 내용에 변동이 없을 경우 1년씩 자동 연장한다.<br/>
				2. 계약의 유지를 원치 않을 경우 1개월 전에 반드시 서면으로 통보한다.
			</li>
			<li>
				<span>제14조【규정 외 사항】</span>
				1. 본 계약에 정하지 않은 사항 또는 본 계약 조항의 해석에 대하여 이의가 발생한 때는, “동”과 “행”이 협의하여 해결하기로 한다.<br/>
				2. 본 계약에 기술되지 않은 부분의 내용은 상호 협의 및 보편적 상거래의 기준에 따라 우호적으로  협의 해결하는 것을 원칙으로 한다. 다만, 상호 해결이 되지 못할 시 분쟁의 해결은 “행”의 관할법원으로 한다.
			</li>
			<li> 계약을 증명하기 위해 본 서 2통을 작성하여, 각자 서명하고 날인한 뒤에 1통씩 보관한다. </li>
		</ul>
		<p class="date"><%=sdf.format(now) %></p>
	</div>
	<div class="page03">
		<table>
			<colgroup>
				<col width="8%" />
				<col width="30%" />
				<col width="*" />
			</colgroup>
			<tbody>				
				<tr>
					<th rowspan="5">동</th>
					<th>의료기관 명칭</th>
					<td>${bean.han_name}</td>
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<td>${bean.biz_no_1}-${bean.biz_no_2}-${bean.biz_no_3}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						(${bean.han_zipcode}) 
						${bean.han_address01 } ${bean.han_address02 }
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>${bean.han_tel_1}-${bean.han_tel_2}-${bean.han_tel_3}</td>
				</tr>
				<tr>
					<th>대표자</th>
					<td>${bean.ceo }         (인)</td>
				</tr>
				
				<tr>
					<th rowspan="9">행</th>
					<th>원 외 탕 전 실<br/>설치 의료기관명</th>
					<td>강구제일한의원</td>
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<td>452-98-00358</td>
				</tr>
				<tr>
					<th>원외탕전실 설치<br/>의 료 기 관 주 소</th>
					<td>경북 영덕군 강구면 동해대로 4467-1</td>
				</tr>
				<tr>
					<th>의료기관 연락처</th>
					<td>054-732-7975</td>
				</tr>
				<tr>
					<th>원외탕전실명</th>
					<td>청담원외탕전</td>
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<td>673-94-00961</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>포항시 북구 장량로140번길6</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>054-242-1079</td>
				</tr>
				<tr>
					<th>대표자</th>
					<td>이용세         (인)</td>
				</tr>
			</tbody>
		</table>
	</div>	
</div>
</body>
</html>
		