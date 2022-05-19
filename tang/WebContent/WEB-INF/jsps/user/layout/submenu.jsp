<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="snbArea">
	<p class="stit"><%=fir_nm%></p>
	<div class="snb">
		<a href="#"><img src="/assets/user/images/common/home.png" alt="" /></a> &gt;
		<a href="#"><%=sec_nm%></a> &gt;
		<a href="#" class="txt01"><%=thr_nm%></a>
	</div>
</div>
<div class="subMenu">
	<%if(fir_n == 1){ %>
		<ul class="subMenu_inner w33">
			<li><a href="/m01/01.do" class="<%if(sub_n == 1) out.print("sel");%>">원장님 인사말</a></li>
			<li><a href="/m01/02.do" class="<%if(sub_n == 2) out.print("sel");%>">탕전실의 약속</a></li>
			<li><a href="/m01/03.do" class="<%if(sub_n == 3) out.print("sel");%>">찾아오시는 길</a></li>
		</ul>
	<%}else if(fir_n == 2){ %>
		<ul class="subMenu_inner w20 ">
			<li><a href="/m02/01.do" class="<%if(sub_n == 1) out.print("sel");%> req_login">처방하기</a></li>
			<li><a href="/m02/02.do" class="<%if(sub_n == 2) out.print("sel");%> req_login">방제사전</a></li>
			<li><a href="/m02/03.do" class="<%if(sub_n == 3) out.print("sel");%> req_login">포장보기</a></li>
			<li><a href="/m02/04.do" class="<%if(sub_n == 4) out.print("sel");%> req_login">환경설정</a></li>
			<li><a href="/m02/05.do" class="<%if(sub_n == 5) out.print("sel");%> req_login">사용설명서</a></li>
		</ul>
	<%}else if(fir_n == 3){ %>
		<ul class="subMenu_inner w50 ">
			<li><a href="/m03/01.do" class="<%if(sub_n == 1) out.print("sel");%> req_login">전체처방</a></li>
			<li><a href="/m03/02.do" class="<%if(sub_n == 2) out.print("sel");%> req_login">약속처방 보관함</a></li>
		</ul>
	<%}else if(fir_n == 4){ %>
		<ul class="subMenu_inner w33">
			<li><a href="/m04/01.do" class="<%if(sub_n == 1) out.print("sel");%> req_login">공지사항</a></li>
			<li><a href="/m04/02.do" class="<%if(sub_n == 2) out.print("sel");%> req_login">이용안내</a></li>
			<li><a href="/m04/03.do" class="<%if(sub_n == 3) out.print("sel");%> req_login">1:1문의</a></li>
		</ul>
	<%}else if(fir_n == 5){ %>
		<ul class="subMenu_inner w20 ">
			<li><a href="/m05/01.do" class="<%if(sub_n == 1) out.print("sel");%> req_login">내 정보수정</a></li>
			<li><a href="/m05/02.do" class="<%if(sub_n == 2) out.print("sel");%> req_login">장바구니</a></li>
			<li><a href="/m05/03.do" class="<%if(sub_n == 3) out.print("sel");%> req_login">주문내역</a></li>
			<li><a href="/m05/04.do" class="<%if(sub_n == 4) out.print("sel");%> req_login">나의 처방관리</a></li>
			<li><a href="/m05/05.do" class="<%if(sub_n == 5) out.print("sel");%> req_login">환자관리</a></li>
		</ul>
	<%}else if(fir_n == 6  && sub_n > 1){ %>
		<ul class="subMenu_inner w50 ">
			<li><a href="/m06/02.do" class="<%if(sub_n == 2) out.print("sel");%>">개인정보처리방침</a></li>
			<li><a href="/m06/03.do" class="<%if(sub_n == 3) out.print("sel");%>">이용약관</a></li>
		</ul>
	<%} %>
	
	
</div>

