<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html class="ax-vertical-centered">
<head>
	<title>Book Borrowing Information</title>
	<jsp:include page="../common/css.jsp"></jsp:include>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/jQuery/jquery-3.1.1.min.js"></script>
	<script src="static/js/bootstrap-dropdown.min.js"></script>
	<script src="static/js/adminUpdateInfo.js"></script>
	<script src="static/js/adminUpdatePwd.js"></script>
	<!-- <style>
		body {
			background-image: url("static/images/05.jpg");
		}
	</style> -->
</head>

<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>

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
								<div class="text-muted bootstrap-admin-box-title">Book Borrow Info</div>
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
									<!-- <th>图书号</th> -->
									<th>Serial Number</th>
									<th>Book Name</th>
									<th>Reader Account</th>
									<th>Reader Name</th>
									<th>Borrow Date</th>
									<th>Return Deadline</th>
									<th>Operation</th>
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
										<td><button type="button" class="btn btn-warning btn-xs"
										onclick="haibook(${history.hid})">return</button>
									<button type="button" class="btn btn-info btn-xs"
										data-toggle="modal" data-target="#updateModal" id="btn_add"
										onclick="addtime('${history.hid}','${history.endTime}')">delay</button></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						${requestScope.pagation}
					</div>
				</div>
			</div>
		</div>
	<script type="text/javascript">
    function haibook(hid) {
    	con=confirm("Are you sure to return?"); 
    	if(con==true){
    		location.href = "/books/book?method=borrow&tip=2&show=2&hid="+hid;
    	}
    }
    function addtime(hid,endtime){
    	document.getElementById("updatehid").value = hid;
    	document.getElementById("updateendtime").value = endtime;
    }
    </script>
    <!-- 修改模态框（Modal） -->
	<!-------------------------------------------------------------->
	
    <!-- 修改模态框（Modal） -->
	<form class="form-horizontal" method="post"
		action="/books/history?method=delay">
		<!--保证样式水平不混乱-->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="updateModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="updateModalLabel">Extend Borrow Time</h4>
					</div>
					<div class="modal-body">

						<!---------------------表单-------------------->

						<div class="form-group">
							<label for="endtime" class="col-sm-3 control-label">Return Deadline</label>
							<div class="col-sm-7">
								<input type="hidden" id="updatehid" name="hid">
								<input type="text" class="form-control" id="updateendtime"
									name="endtime" placeholder=""> <label
									class="control-label" for="updateTime" style="display: none;"></label>
							</div>
						</div>
						<div class="modal-footer">
						<button type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Change</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			</div>
			<!-- /.modal -->
		</div>
	</form>

	<!--------------------------------------修改密码的模糊框------------------------>

	<jsp:include page="../common/userInfo.jsp"></jsp:include>
	<jsp:include page="../common/userInfo.jsp"></jsp:include>
</body>
</html>