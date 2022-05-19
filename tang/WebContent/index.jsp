<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <title></title>
</head>
<body>
<%
   pageContext.setAttribute("aaa", "&quot;"); 
   pageContext.setAttribute("bbb", "<p style=&quot;1111&quot;>&quot;aaabbbccc&quot;<p>");
%>
<%-- ${fn:replace(bbb, aaa , "\"") } <br/>
2222<br/>

<c:out value="${fn:replace(bbb, aaa , '\"') }" default="Korea" escapeXml="true"/>

<c:out value="${fn:replace(bbb, aaa , '\"') }" default="Korea" escapeXml="false"/>
 --%>
 <jsp:forward page="/main.do"/> 
</body>
</html>