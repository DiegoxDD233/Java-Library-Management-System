<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	if (session.getAttribute("userDB") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}	
%>
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
			<div class="col-md-10">
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">BookSearch</div>
							</div>
							<div class="bootstrap-admin-panel-content">
								<ul>
									<li>Query book information based on book name, author, and category</li>
									<li>You can check the number, name, classification, author, number of books, etc</li>
								</ul>
							</div>
						</div>
					</div>

					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Borrowing information</div>
							</div>
							<div class="bootstrap-admin-panel-content">
								<ul>
									<li>Displays the basic information of the borrowed book, the date of borrowing, the deadline for returning the book, etc</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Popular Book Recommendation</div>
							</div>
							<div class="bootstrap-admin-panel-content">
								<ul>
									<li>Displays the number of books borrowed, including basic book information</li>
									<li>You can borrow books directly on the current interface, and you can check the number of books borrowed</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Borrowing History</div>
							</div>
							<div class="bootstrap-admin-panel-content">
								<ul>
									<li>Query specific information such as borrowing history and borrowing duration</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Best readers</div>
							</div>
							<div class="bootstrap-admin-panel-content">
								<ul>
									<li>Displays the number of borrowings for each known reader, as well as basic information about the reader</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Feedback</div>
							</div>
							<div class="bootstrap-admin-panel-content">
								<ul>
									<li>If you have any questions, please leave your contact information, we will record it in the library and give feedback in time</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-------------------------------------------------------------->

	<jsp:include page="common/userInfo.jsp"></jsp:include>
	<jsp:include page="common/js.jsp"></jsp:include>
</body>
</html>