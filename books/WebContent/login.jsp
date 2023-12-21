<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
		+ request.getContextPath() + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
	<base href="<%=basePath%>" />
	<title>Library Management System</title>
	<jsp:include page="common/css.jsp"></jsp:include>
	<style>
		body {
			background-image: url("static/images/05.jpg");
		}
		.alert {
			margin: 0 auto 20px;
			text-align: center;
		}
	</style>
</head>

<body class="bootstrap-admin-without-padding">
	<div class="container">
		<div class="row">
			<div class="col-lg-12" style="margin-top: 100px">
				<div class="alert alert-info">
					<a class="close" data-dismiss="alert" href="#">&times;</a>
					Welcome to the Library Management System
				</div>
				<form class="bootstrap-admin-login-form" method="post"
					action="<%=basePath%>login?method=login">
					<%
						String state = (String) session.getAttribute("state");
						session.removeAttribute("state");
						if (state != null) {
					%>
					<label class="control-label" for="username">Input error!Please try again</label>

					<%}%>
					<div class="form-group">
						<label class="control-label" for="username">Account&nbsp;</label> <input
							type="text" class="form-control" id="username" name="account"
							required="required" placeholder="Please enter your account" /> <label
							class="control-label" for="username" style="display: none;"></label>
					</div>
					<div class="form-group">
						<label class="control-label" for="password">Password&nbsp;</label> <input
							type="password" class="form-control" id="password"
							name="password" required="required" placeholder="Please enter your password" /> <label
							class="control-label" for="username" style="display: none;"></label>
					</div>

					<label class="control-label" for="password"></label><br> <input
						type="submit" class="btn btn-lg btn-primary btn-block"
						value="login" />
				</form>
			</div>
		</div>
	</div>
	<script src="static/jQuery/jquery-3.1.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/login.js"></script>
	<script type="text/javascript">
		function changeValidateCode(obj) {
			//每次请求用当前时间作为参数，防止浏览器使用缓存数据
			var timeNow = new Date().getTime();
			obj.src = "CodeServlet?time=" + timeNow;
			document.getElementById('code').value = "";
		}
	</script>
</body>
</html>