<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Library Management System</title>
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
			<jsp:include page="../common/left.jsp"></jsp:include>
			
			<!-- content -->
			<div class="col-md-10">
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Reader management</div>
							</div>
							<div
								class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
								<form class="form-horizontal" action="/books/selectServlet"
									method="post">
									<div class="col-lg-3 form-group">
										<button type="button" class="btn btn-primary" id="btn_add"
											data-toggle="modal" data-target="#addModal">Add users</button>
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
									<th>Account</th>
									<th>Name</th>
									<th>Phone</th>
									<th>Available Days</th>
									<th>Max Borrow Number</th>
									<th>Operation</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${uList}" var="user" varStatus="status">
									<tr>
										<td>${user.uid}</td>
										<td>${user.account}</td>
										<td>${user.name}</td>
										<td>${user.phone}</td>
										<td>${user.lendNum}</td>
										<td>${user.maxNum}</td>
										<td><button type="button" class="btn btn-warning btn-xs"
										data-toggle="modal" data-target="#updateModal" id="btn_update"
										onclick="showInfo2('${user.uid}','${user.account}','${user.name}',
										'${user.phone}','${user.lendNum}','${user.maxNum}')">Change</button>
									<button type="button" class="btn btn-danger btn-xs"
										onclick="deleteUser(${user.uid})">Delete</button></td>
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
    function showInfo2(uid,account,name,phone,lend_num,max_num) {
        document.getElementById("updateusername").value = account;
        document.getElementById("updatename").value = name;
        document.getElementById("updatephone").value = phone;
        document.getElementById("updateaid").value = uid;
        document.getElementById("updatelend_num").value = lend_num;
        document.getElementById("updatemax_num").value = max_num;
    }
    function deleteUser(uid) {
    	con=confirm("Are you sure to delete?"); 
    	if(con==true){
    		location.href = "/books/user?method=delUser&uid="+uid;
    	}
    }
    </script>
	<!-- 修改模态框（Modal） -->
	<!-------------------------------------------------------------->
	
	<!-- 修改模态框（Modal） -->
	<form class="form-horizontal" method="post" 
		action="/books/user?method=updUser">
		<!--保证样式水平不混乱-->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="updateModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="updateModalLabel">Change Reader Info</h4>
					</div>
					<div class="modal-body">

						<!---------------------表单-------------------->

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Account</label>
							<div class="col-sm-7">
								<input type="hidden" id="updateaid" name="uid"> 
								<input
									type="text" class="form-control" id="updateusername"
									name="account" placeholder="" readonly="readonly"> <label
									class="control-label" for="updateISBN" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updatename"
									name="name" placeholder="" readonly="readonly"> <label
									class="control-label" for="updateBookName"
									style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Phone</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updatephone"
									name="phone" placeholder=""> <label
									class="control-label" for="updatePress" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Available Borrow Days</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updatelend_num"
									name="lendNum" placeholder=""> <label
									class="control-label" for="updatePress" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Max Borrow Number</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updatemax_num"
									name="maxNum" placeholder=""> <label
									class="control-label" for="updatePress" style="display: none;"></label>
							</div>
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
			<!-- /.modal -->
		</div>
	</form>

	<!-------------------------------------------------------------->

	<!--------------------------------------添加的模糊框------------------------>
	<form class="form-horizontal" method="post" onsubmit="return checkAdd()"
		action="/books/user?method=addUser">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<!-- <h4 class="modal-title" id="myModalLabel">添加新读者</h4> -->
						<h5 style="text-align:center" id="msg"></h5>
					</div>
					<div class="modal-body">

						<!---------------------表单-------------------->

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Account</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="account"
									id="addISBN" required="required" placeholder="Please Enter Account">
								<label class="control-label" for="addISBN"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="name"
									id="addBookName" required="required" placeholder="Please Enter Name">
								<label class="control-label" for="addBookName"
									style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Phone</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="phone"
									id="addPress" required="required" placeholder="Please Enter Phone">
								<label class="control-label" for="addPress"
									style="display: none;"></label>								</div>
							</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Password</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" name="password"
									id="addPress" required="required" placeholder="Please Enter Password">
								<label class="control-label" for="addPress"
									style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Available Borrow Days</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="lendNum"
									id="updatelend_num" required="required" placeholder="Please Enter Available Borrow Days">
								<label class="control-label" for="addNum"
									style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Max Borrow Number</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="maxNum"
									id="updatemax_num" required="required" placeholder="Please Enter Max Borrow Number">
								<label class="control-label" for="addPress"
									style="display: none;"></label>
							</div>
						</div>
						
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">User Character</label>
							<div class="col-sm-7">
								<select class="form-control" id="addBookType" name="role">
										<option value="1">Normal User</option>
										<option value="2">Manager</option>
								</select> 
								<label class="control-label" for="addBookType"
									style="display: none;"></label>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Add</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	<!--------------------------------------添加的模糊框------------------------>

	<jsp:include page="../common/userInfo.jsp"></jsp:include>
	<jsp:include page="../common/js.jsp"></jsp:include>
	<script type="text/javascript">
		var f = false;
		
		$("#addISBN").blur(function(){
			$.get("${pageContext.request.contextPath}/user?method=checkUser",{"account":$("#addISBN").val()},function(res){
				//json string to var
				var obj = JSON.parse(res);
				if (obj.code == 200){
					//account available
					$("#msg").css({"color":"green"});
					$("#addISBN").css({"border-color":"green"});
					f = true;
				}else{
					//account exist
					$("#msg").css({"color":"red"});
					$("#addISBN").css({"border-color":"red"});
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