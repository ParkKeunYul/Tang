<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
	alert("${sc_msg}");
	
	if("n" == "${sc_close}"){
		cmsResult();
	}else{
		location.href="${sc_url}";
		if("y" == "${sc_close}"){
			window.close();
		}	
	}
</script>