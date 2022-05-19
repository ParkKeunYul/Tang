<%@ page language="java" pageEncoding="UTF-8"%>
<!-- header -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<div class="headerWrapper" id="header">
	<input type="hidden" id="userInfo_id" value="${userInfo.id}" />
	<input type="hidden" id="userInfo_level" value="${userInfo.member_level}" />
	<!-- GNB -->	
	<div class="headerFixedBox">
		<!-- LnbArea -->
		<div id="LnbArea">
			<div class="logoarea">
				<h1><a href="/"><img src="/assets/user/pc/images/common/logo.png" alt="청담원외탕전" /></a></h1>
			</div>
			<ul class="loginbtn">				
				<c:choose>
			         <c:when test = "${empty userInfo}">
			         	<li><a href="/m06/01.do"><img src="/assets/user/pc/images/common/btn_join.png" alt="회원가입" /></a></li>
			       		<li><a href="/m06/login.do"><img src="/assets/user/pc/images/common/btn_login.png" alt="로그인" /></a></li>  	
			         </c:when>
			         <c:otherwise>
			         	<li class="logout"><a href="/logout.do" id="logOutBtn"><img src="/assets/user/pc/images/common/btn_logout.png" alt="로그아웃" /></a></li>
			         </c:otherwise>
			    </c:choose>
			</ul>
			<!-- Lnb -->
			<ul class="gnbDepth">
				<li class="menu01">
					<a href="/m01/01.do"><img src="/assets/user/pc/images/common/mm01.png" alt="청담원외탕전 소개" /></a>
					<div class="depWrapper submenu01" style="display:none;">
						<ul>
							<li><a href="/m01/01.do">청담원외탕전 소개</a></li>
							<li><a href="/m01/02.do">청담원외탕전의 약속</a></li>
							<li><a href="/m01/03.do">위치안내</a></li>
						</ul>
					</div>
				</li>
				
				<li class="menu02" style="display: none;">
					<a href="/m02/06.do" style="height: 50px;display: inline-block;"><img src="/assets/user/pc/images/common/mm02.png" alt="탕전처방" /></a>
					<div class="depWrapper submenu02" style="display:none;top:50px">
						<ul>
							<!-- <li><a href="/m02/01.do">처방하기</a></li> -->
							<li><a href="/m02/06.do" class="req_login">실속처방</a></li>
							<li><a href="/m05/02.do" class="req_login">장바구니</a></li>
							<!-- <li><a href="/m02/02.do">방제사전</a></li>
							<li><a href="/m02/03.do">포장보기</a></li>
							<li><a href="/m02/04.do">환경설정</a></li>
							<li><a href="/m02/05.do">사용설명서</a></li> -->
						</ul>
					</div>
				</li>
				<li class="menu03">
					<a href="/m03/01.do" class="req_login"><img src="/assets/user/pc/images/common/mm03.png?3" alt="약속처방" /></a>
					<div class="depWrapper submenu03" style="display:none;top:50px;">
						<ul>
							<li><a href="/m03/01.do" class="req_login">약속처방</a></li>
							<li><a href="/m03/02.do" class="req_login">약속처방 보관함</a></li>
							<li><a href="/m03/03.do" class="req_login">사전조제지시서 관리</a></li>
						</ul>
					</div>
				</li>
				<li class="menu04">
					<a href="/m04/01.do" class="req_login"><img src="/assets/user/pc/images/common/mm04.png?4" alt="고객센터" /></a>
					<div class="depWrapper submenu04" style="display:none;top:100px;">
						<ul>
							<li><a href="/m04/01.do" class="req_login">공지사항</a></li>
							<li><a href="/m04/02.do" class="req_login">이용안내</a></li>
							<li><a href="/m04/03.do" class="req_login">문의게시판</a></li>
						</ul>
					</div>
				</li>
				<li class="menu05">
					<a href="/m05/01.do" class="req_login"><img src="/assets/user/pc/images/common/mm05.png?5" alt="마이페이지" /></a>
					<div class="depWrapper submenu05" style="display:none;top:150px;">
						<ul>
							<li><a href="/m05/01.do" class="req_login">내 정보수정</a></li>
							<!-- <li><a href="/m05/02.do" class="req_login">장바구니</a></li> -->
							<li><a href="/m05/03.do" class="req_login">주문내역</a></li>
							<!-- <li><a href="/m05/07.do" class="req_login">나의 처방관리</a></li> -->
							<li><a href="/m05/05.do" class="req_login">환자관리</a></li>
							<li><a href="/m05/04.do" class="req_login">탕전공동사용계약서</a></li>							
							<li><a href="/m05/99.do" class="req_login">포인트 사용내역</a></li>
						</ul>
					</div>
				</li>
					
			</ul>
			<div class="gnbDepth2bg" style="width:0px;"></div>
			<!-- Lnb //-->
		</div>
		<!-- LnbArea //-->
		<ul class="Micon">
			<li><a href="/m05/03.do" class="req_login"><img src="/assets/user/pc/images/common/icon01.png" alt="주문내역" /></a></li>
			<li><a href="/m03/02.do" class="req_login"><img src="/assets/user/pc/images/common/icon02.png" alt="약속처방 보관함" /></a></li>
			<li><a href="/m01/03.do"><img src="/assets/user/pc/images/common/icon03.png" alt="오시는길" /></a></li>
		</ul>
		<p class="cscenter"><img src="/assets/user/pc/images/common/cscenter.png" alt="상담전화 054-123-4567" /></p>
		<a href="/m05/04.do" style="margin-left:13px;"><img src="/assets/user/pc/images/common/btn_print.png" alt="신고서류 자동완성 출력" /></a>
	</div>
	<!-- // GNB -->
</div>
