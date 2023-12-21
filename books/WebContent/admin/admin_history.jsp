<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html class="ax-vertical-centered">
<head>
	<title>Borrowing History</title>
	<jsp:include page="../common/css.jsp"></jsp:include>
	<!-- <style>
		body {
			background-image: url("static/image/05.jpg");
		}
	</style> -->
</head>

<body class="bootstrap-admin-with-small-navbar">
	<jsp:include page="../common/top.jsp"></jsp:include>

	<div class="container">
			<jsp:include page="../common/left.jsp"></jsp:include>

			<!-- content -->
			<div class="col-md-10">
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Book Return Info</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<table id="data_list" class="table table-hover table-bordered"
							>
							<thead>
								<tr>
									<th>Serial Number</th>
									<th>Book Name</th>
									<th>Reader Account</th>
									<th>Reader Name</th>
									<th>Borrow Date</th>
									<th>Return Date</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${hList}" var="history" varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${history.bookName}</td>
										<td>${history.account}</td>
										<td>${history.name}</td>
										<td>${history.beginTime}</td>
										<td>${history.endTime}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						${requestScope.pagation}
					</div>
				</div>
			</div>
		</div>
	<!--------------------------------------修改密码的模糊框------------------------>

	<jsp:include page="../common/userInfo.jsp"></jsp:include>
	<jsp:include page="../common/js.jsp"></jsp:include>
</body>
</html>