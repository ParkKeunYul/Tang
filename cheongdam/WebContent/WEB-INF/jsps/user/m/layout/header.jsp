<%@ page language="java" pageEncoding="UTF-8"%>
<!-- header -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<input type="hidden" id="userInfo_id" value="${userInfo.id}" />
<input type="hidden" id="userInfo_level" value="${userInfo.member_level}" />
<div class="headerWrapper" id="header">
	<h1 class="logo"><a href="/"><img src="/assets/user/m/images/logo_top.png" alt="청담원외탕전"></a></h1>

	<!-- GNB -->
	<div class="headerGnbBox">
		<a href="#layerGNB" class="btnGNB"><span class="hidden">전체메뉴 열기</span></a>

		<div class="gnbBG">
			<nav class="gnbWrapper" id="layerGNB">
				<div class="gnbBtns">
					<span class="logoLayer"><img src="/assets/user/m/images/logo_top_ov.png" alt="청담원외탕전"></span>
					<button type="button" class="btnCloseMenu"><span class="hidden">전체메뉴 닫기</span></button>
					<div>
						<c:choose>
					         <c:when test = "${empty userInfo}">
					         	<button type="button" onclick="location.href='/m/m06/01.do'" class="btnJoin"><span>회원가입</span></button>
								<button type="button" onclick="location.href='/m/m06/login.do'" class="btnLogin"><span>로그인</span></button>  	
					         </c:when>
					         <c:otherwise>
					         	<button type="button" onclick="location.href='/logout.do'" class="btnLogin"><span>로그아웃</span></button>
					         </c:otherwise>
					    </c:choose>
					</div>
				</div>

				<div class="gnbBox">
					<ul class="gnbDepth01">
						<li class="menu01">
							<a href="/m/m01/01.do" class="depth1">청담원외탕전 소개</a>
							<div class="dep2Wrapper">
								<ul class="gnbDepth02">
									<li><a href="/m/m01/01.do" class="depth2">청담원외탕전 소개</a></li>
									<li><a href="/m/m01/02.do" class="depth2">청담원외탕전 약속</a></li>
									<li><a href="/m/m01/03.do" class="depth2">위치안내</a></li>
								</ul>
							</div>
						</li>
						
						<li class="menu02" style="display: none;">
							<a href="/m/m05/06.do"  class="depth1 req_login">탕전처방</a>
							<div class="dep2Wrapper">
								<ul>
									<li><a href="/m/m02/06.do" class="depth2 req_login">실속처방</a></li>
									<!-- <li><a href="/m/m05/02.do" class="depth2 req_login">장바구니</a></li> -->
								</ul>
							</div>
						</li>
						<li class="menu02">
							<a href="/m/m03/01.do"  class="depth1 req_login">약속처방</a>
							<div class="dep2Wrapper">
								<ul>
									<li><a href="/m/m03/01.do" class="depth2 req_login">약속처방</a></li>
									<li><a href="/m/m03/02.do" class="depth2 req_login">약속처방 보관함</a></li>
									<li><a href="/m/m03/03.do" class="depth2 req_login">사전조제지시서 관리</a></li>
								</ul>
							</div>
						</li>
						<li class="menu03">
							<a href="/m04/01.do" class="depth1 req_login">고객센터</a>
							<div class="dep2Wrapper">
								<ul>
									<li><a href="/m/m04/01.do" class="depth2 req_login">공지사항</a></li>
									<li><a href="/m/m04/02.do" class="depth2 req_login">이용안내</a></li>
									<li><a href="/m/m04/03.do" class="depth2 req_login">1:1 문의</a></li>
								</ul>
							</div>
						</li>

						<li class="menu04">
							<a href="/m05/01.do" class="depth1 req_login">마이페이지</a>
							<div class="dep2Wrapper">
								<ul>
									<li><a href="/m/m05/01.do" class="depth2 req_login">내 정보수정</a></li>
									<li><a href="/m/m05/03.do" class="depth2 req_login">주문내역</a></li>
									<li><a href="/m/m05/04.do" class="depth2">탕전공동사용계약서</a></li>
									<li><a href="/m/m05/99.do" class="depth2">포인트 사용내역</a></li>
								</ul>
							</div>
						</li>
						
					</ul>
				</div>
			</nav>
		</div>

	</div>
	<!-- //GNB -->
</div>
