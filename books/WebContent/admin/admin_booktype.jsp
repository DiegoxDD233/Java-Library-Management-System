<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>BookType</title>
	<jsp:include page="../common/css.jsp"></jsp:include>
	<!-- <style>
	body {
		background-image: url("static/images/05.jpg");
	}
	</style> -->
</head>

<body class="bootstrap-admin-with-small-navbar">
	<jsp:include page="../common/top.jsp"></jsp:include>
	
	<div class="container">
		<!-- left, vertical navbar & content -->
		<div class="row">
			<jsp:include page="../common/left.jsp"></jsp:include>

			<!-- content -->
			<div class="col-md-10">
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Book Classification Management</div>
							</div>
							<div
								class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
								<form class="form-horizontal" action="/books/selectServlet"
									method="post">
									<div class="col-lg-3 form-group">
										<button type="button" class="btn btn-primary" id="btn_add"
											data-toggle="modal" data-target="#addModal">Add Type</button>
									</div>
								</form>
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
									<th>ID</th>
									<th>Book Type Name</th>
									<th>Operation</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${tList}" var="type" varStatus="status">
									<tr>
										<td>${type.tid}</td>
										<td>${type.typeName}</td>
										<td>
											<button type="button" class="btn btn-warning btn-xs" data-toggle="modal" data-target="#updateModal" id="btn_update"
										onclick="showInfo2('${type.tid}','${type.typeName}')">Change</button>
											<button type="button" class="btn btn-danger btn-xs" onclick="deletebook(${type.tid})">Delete</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						${requestScope.pagation}
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function showInfo2(tid, name) {
			console.log(tid);
			console.log(name);
			document.getElementById("updatetid").value = tid;
			document.getElementById("updatename").value = name;
		}

		function deletebook(tid) {
			con = confirm("Are you sure to Delete?");
			if(con == true) {
				location.href = "<%=basePath%>/type?method=delType&tid=" + tid;
			}
		}
	</script>
	<!-------------------------------------------------------------->

	<!-- 修改模态框（Modal） -->
	<form class="form-horizontal" method="post"
		action="<%=basePath%>/type?method=updType">
		<!--保证样式水平不混乱-->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="updateModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="updateModalLabel">Change Book Type</h4>
					</div>
					<div class="modal-body">

						<!---------------------表单-------------------->

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Book Name</label>
							<div class="col-sm-7">
								<input type="hidden" name="tid" id="updatetid">
								 <input
									type="text" class="form-control" id="updatename" name="typeName"
									placeholder="Please Enter Book Name"> <label class="control-label"
									for="updateBookName" style="display: none;"></label>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Change</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	<!-------------------------------------------------------------->

	<!--------------------------------------添加的模糊框------------------------>
	<form class="form-horizontal" method="post" onsubmit="return checkAdd()"
		action="<%=basePath%>/type?method=addType">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h5 style="text-align:center" id="msg"></h5>
					</div>
					<div class="modal-body">

						<!---------------------表单-------------------->

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Type Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="addBookName"
									required="required" name="typeName" placeholder="Please Enter Type Name">
								<label class="control-label" for="addBookName"
									style="display: none;"></label>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Add</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	<!--------------------------------------添加的模糊框------------------------>

	<!-------------------------------------------------------------->

	<jsp:include page="../common/userInfo.jsp"></jsp:include>
	<jsp:include page="../common/js.jsp"></jsp:include>
	<script type="text/javascript">
		var f = false;
		
		$("#addBookName").blur(function(){
			$.get("${pageContext.request.contextPath}/type?method=checkType",{"typeName":$("#addBookName").val()},function(res){
				//json string to var
				var obj = JSON.parse(res);
				if (obj.code == 200){
					//account available
					$("#msg").css({"color":"green"});
					$("#addBookName").css({"border-color":"green"});
					f = true;
				}else{
					//account exist
					$("#msg").css({"color":"red"});
					$("#addBookName").css({"border-color":"red"});
					f = false;
				}
				$("#msg").html(obj.msg);
			});
		});
		function checkAdd(){
			return f;
		}
		
	</script>
</body>
</html>