<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Library Management System</title>
	<jsp:include page="common/css.jsp"></jsp:include>	
	<!-- <style>
		body {
			background-image: url("static/images/05.jpg");
		}
	</style> -->
</head>

<body class="bootstrap-admin-with-small-navbar">
	<jsp:include page="common/top.jsp"></jsp:include>
	<div class="container">
		<div class="row">
			<c:if test="${userDB.role == 1}">
				<jsp:include page="common/user_left.jsp"></jsp:include>			
			</c:if>
			<c:if test="${userDB.role == 2}">
				<jsp:include page="common/left.jsp"></jsp:include>			
			</c:if>
			<!-- content -->
			<div class="col-md-10 col-md-push-3">
				
				
				<div><img alt="" src="static/images/neterror.jpg"><br></div>
				<div><span style="font-size: 50px;color:red">
					${msg}
				</span></div>
				
			</div>
		</div>
	</div>

	<!-------------------------------------------------------------->

	<jsp:include page="common/userInfo.jsp"></jsp:include>
	<jsp:include page="common/js.jsp"></jsp:include>
</body>
</html>