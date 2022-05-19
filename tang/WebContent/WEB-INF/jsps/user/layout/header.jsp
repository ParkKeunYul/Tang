<%@ page language="java" pageEncoding="UTF-8"%>
<!-- header -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<div class="headerWrapper" id="header">
	<input type="hidden" id="userInfo_id" value="${userInfo.id}" />
	<input type="hidden" id="userInfo_level" value="${userInfo.member_level}" />
	<!-- GNB -->
	<div class="headerFixedBox">
		<div class="gnbWrapper">
			<div class="topBox">
				<h1><a href="/main.do"><img src="/assets/user/images/common/logo.png" alt="북경한의원 원외탕전실" /></a></h1>
			</div>
			<div class="gnbBox">
				<ul class="gnbDepth01">
					<li class="menu01">
						<a href="/m01/01.do" class="depth1">원외탕전실 소개</a>
						<div class="depWrapper" style="display:none;">
							<ul>
								<li><a href="/m01/01.do" class="sel">원장님 인사말</a></li>
								<li><a href="/m01/02.do">탕전실의 약속</a></li>
								<li><a href="/m01/03.do">찾아오시는 길</a></li>
							</ul>
						</div>
					</li>
					<li class="menu02">
						<a href="/m02/01.do" class="depth1 req_login">탕전처방</a>
						<div class="depWrapper" style="display:none;">
							<ul>
								<li><a href="/m02/01.do" class="req_login">처방하기</a></li>
								<li><a href="/m02/02.do" class="req_login">방제사전</a></li>
								<li><a href="/m02/03.do" class="req_login">포장보기</a></li>
								<li><a href="/m02/04.do" class="req_login">환경설정</a></li>
								<li><a href="/m02/05.do" class="req_login">사용설명서</a></li>
							</ul>
						</div>
					</li>
					<li class="menu03">
						<a href="/m03/01.do" class="depth1 req_login">약속처방</a>
						<div class="depWrapper" style="display:none;">
							<ul>
								<li><a href="/m03/01.do"  class="req_login">약속처방</a></li>
								<li><a href="/m03/02.do"  class="req_login">약속처방 보관함</a></li>
							</ul>
						</div>
					</li>
					<li class="menu04">
						<a href="/m04/01.do" class="depth1 req_login">고객센터</a>
						<div class="depWrapper" style="display:none;">
							<ul>
								<li><a href="/m04/01.do"  class="req_login">공지사항</a></li>
								<li><a href="/m04/02.do"  class="req_login">이용안내</a></li>
								<li><a href="/m04/03.do"  class="req_login">1:1문의</a></li>
							</ul>
						</div>
					</li>
					
					<c:choose>
				         <c:when test = "${empty userInfo}">
				         	<li class="menu05">
								<a href="/m06/01.do" class="depth1 tc01">회원가입</a>
							</li>
				         	<li class="login"><a href="#" id="loginBtn">로그인</a></li>
				         </c:when>
				         <c:otherwise>
				         	<li class="menu05">
								<a href="/m05/01.do" class="depth1 tc01 req_login">마이페이지</a>
								<div class="depWrapper" style="display:none;">
									<ul>
										<li><a href="/m05/01.do" class="req_login">내 정보수정</a></li>
										<li><a href="/m05/02.do" class="req_login">장바구니</a></li>
										<li><a href="/m05/03.do" class="req_login">주문내역</a></li>
										<li><a href="/m05/04.do" class="req_login">나의 처방관리</a></li>
										<li><a href="/m05/05.do" class="req_login">환자관리</a></li>
									</ul>
								</div>
							</li>
				         	<li class="login"><a href="/logout.do" id="logOutBtn">로그아웃</a></li>
				         </c:otherwise>
				    </c:choose>
					<!--<li class="login"><a href="#">로그아웃</a></li>-->
				</ul>
			</div>
		</div>
	</div>
	<!-- //GNB -->
</div>
