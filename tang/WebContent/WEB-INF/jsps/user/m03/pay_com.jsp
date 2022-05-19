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
<!-- container -->
<div id="container">
	<!-- submenuArea -->
	<%
		String fir_nm = "약속처방";
		String sec_nm = "약속처방";
		String thr_nm = "처방하기";
		int fir_n = 3;
		int sub_n = 1;
	%>
	<%@include file="../layout/submenu.jsp"%>

	<!-- contents -->
	<div id="contents">
		
		
		
	</div>
	<!-- //contents -->
</div>
<!-- //container -->	