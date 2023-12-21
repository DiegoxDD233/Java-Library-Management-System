<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html class="ax-vertical-centered">
<head>
	<title>Library Management System</title>
	<jsp:include page="../common/css.jsp"></jsp:include>
	<!-- <style>
		body {
			background-image: url("05.jpg");
		}
	</style> -->
</head>

<body class="bootstrap-admin-with-small-navbar">
	<jsp:include page="../common/top.jsp"></jsp:include>

	<div class="container">
		<!-- left, vertical navbar & content -->
		<div class="row">
			<jsp:include page="../common/user_left.jsp"></jsp:include>
			<!-- content -->
			<div class="col-md-10">
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Feedback</div>
							</div>
							<div
								class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
								<form class="form-horizontal" action="/books/AddProblemServlet"
									method="post">
									<div class="col-lg-8 form-group">
										<label class="col-lg-4" for="query_bname">Title</label>
										<div class="col-lg-12">
											<input class="form-control" id="bookName" name="name"
												type="text" value="" required="required" placeholder="please write less than 30 characters">
											<label for="query_bname" style="display: none;"></label>
										</div>
									</div>
									<div class="col-lg-8 form-group">
										<label class="col-lg-4" for="query_bname">Question Page</label>
										<div class="col-lg-12">
											<input class="form-control" id="bookName" name="page"
												type="text" value="" required="required" placeholder="books/XXX.jsp(write only XXX)">
											<label for="query_bname" style="display: none;"></label>
										</div>
									</div>
									<div class="col-lg-8 form-group">
										<label class="col-lg-4" for="query_bname">Question Detail</label>
										<div class="col-lg-12">
											<textarea name="body" required="required" class="form-control" placeholder="please write less than 255 characters"
												style="height: 150px;resize: none;"></textarea>
											<label for="query_bname" style="display: none;"></label>
										</div>
									</div>
									<div class="col-lg-8 form-group">
										<label class="col-lg-4" for="query_bname">contact</label>
										<div class="col-lg-12">
											<input class="form-control" id="bookName" name="phone"
												type="text" value="" required="required" placeholder="Phone/email">
											<label for="query_bname" style="display: none;"></label>
										</div>
									</div>
									<div class="col-lg-8 form-group">
										<label class="control-label" for="query_bname"></label>
										<button type="submit" class="btn btn-primary" id="btn_query">Submit</button>
										<label for="query_bname" style="display: none;"></label>&nbsp;
										<a href="/books/myproblem.jsp"><i
											class="glyphicon glyphicon-chevron-right"></i> MyFeedback</a>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-------------------------------------------------------------->

	<jsp:include page="../common/userInfo.jsp"></jsp:include>
	<jsp:include page="../common/js.jsp"></jsp:include>
</body>
</html>