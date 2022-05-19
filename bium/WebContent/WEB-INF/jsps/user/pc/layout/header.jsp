<%@ page language="java" pageEncoding="UTF-8"%>
<!-- header -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<!-- header 시작 -->
<input type="hidden" id="userInfo_id" value="${userInfo.id}" />
<input type="hidden" id="userInfo_level" value="${userInfo.member_level}" />

<div class="headerWrapper" id="header">
	<!-- GNB -->
	<div class="headerGnbBox">
		<!-- gnbWrapper -->
		<nav class="gnbWrapper">
			<div class="gnbBtns">
				<h1><a href="/"><img src="/assets/user/pc/images/logo.png" alt="비움환원외탕전" /></a></h1>
				<ul class="loginbtn">
					<c:choose>
				         <c:when test = "${empty userInfo}">
				         	<li><a href="/m06/01_step1_1.do">회원가입</a></li>
							<li><a href="/m06/login.do">로그인</a></li>  	
				         </c:when>
				         <c:otherwise>
				         	<li class="logout"><a href="/logout.do" id="logOutBtn">로그아웃</a></li>
				         </c:otherwise>
				    </c:choose>
				</ul>
			</div>
			<div class="gnbBox">
				<!-- gnbDepth -->
				<ul class="gnbDepth">
					<li class="menu01">
						<a href="#" class="depth1">원외탕전 소개</a>
						<div class="dep2Wrapper">
							<ul>
								<li><a href="/m01/01.do" class="depth2">비움환원외탕전 소개</a></li>
								<li><a href="/m01/03.do" class="depth2">시설안내</a></li>
								<li><a href="/m01/02.do" class="depth2">위치안내</a></li>
							</ul>
						</div>
					</li>
					<li class="menu02">
						<a href="#" class="depth1">약속처방</a>
						<div class="dep2Wrapper">
							<ul>
								<li><a href="/m03/01.do" class="req_login depth2">약속처방</a></li>
								<c:if test="${userInfo.member_level eq 4 }">
									<li><a href="/m99/01.do" class="req_login depth2">약속처방(가맹점)</a></li>
								</c:if>
								<li><a href="/m03/02.do" class="req_login depth2">약속처방 보관함</a></li>
								<li><a href="/m03/03.do" class="req_login depth2">사전조제지시서 관리</a></li>
							</ul>
						</div>
					</li>
					
					
					<li class="menu02">
						<a href="#" class="depth1">비움환 연구소</a>
						<div class="dep2Wrapper">
							<ul>
								<li><a href="/m04/13.do" class="req_login depth2">자료실</a></li>
								
							 	<c:if test="${userInfo.member_level eq 4 }">
							 		<li><a href="/m04/11.do" class="req_login depth2">비움환자료실</a></li>
									<li><a href="/m04/12.do" class="req_login depth2">치험례 · 논문</a></li>							 		
							 	</c:if>
							 	
							</ul>
						</div>
					</li>
					
					<li class="menu03">
						<a href="#" class="depth1">고객센터</a>
						<div class="dep2Wrapper">
							<ul>
								<li><a href="/m04/01.do" class="req_login depth2">공지사항</a></li>
								<li><a href="/m04/02.do" class="req_login depth2">이용안내</a></li>
								<li><a href="/m04/03.do" class="req_login depth2">1:1문의</a></li>
							</ul>
						</div>
					</li>
					<li class="menu04">
						<a href="#" class="depth1">마이페이지</a>
						<div class="dep2Wrapper">
							<ul>
								<li><a href="/m05/01.do" class="req_login depth2">회원 정보수정</a></li>
								<li><a href="/m05/03.do" class="req_login depth2">주문내역</a></li>
							</ul>
						</div>
					</li>
				</ul>
				<!-- gnbDepth //-->
			</div>
			<ul class="Micon">
				<li><a href="/m05/03.do" class="req_login "><img src="/assets/user/pc/images/btn_list.png" alt="" /><span>주문내역</span></a></li>
				<li><a href="/m03/01.do" class="req_login "><img src="/assets/user/pc/images/btn_plist.png" alt="" /><span>약속처방<br/>보관함</span></a></li>
				<li><a href="/m01/02.do"><img src="/assets/user/pc/images/btn_map.png" alt="" /><span>위치안내</span></a></li>
			</ul>
			<p class="cscenter">
				<img src="/assets/user/pc/images/cscenter.png" alt="상담전화 054-123-4567" /><br/>
				<a href="http://pf.kakao.com/_GRpwK/chat" target="_blank"><img src="/assets/user/pc/images/kakaoch.png" alt="카카오상담" class="mt10" /></a>
			</p>
		</nav>
	</div>
	<!-- // GNB -->
</div>
<!-- //header -->
