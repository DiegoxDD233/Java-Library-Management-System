<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Book Info Management</title>
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
			<!-- left, vertical navbar -->
			<jsp:include page="../common/left.jsp"></jsp:include>

			<!-- content -->
			<div class="col-md-10">
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">Search</div>
							</div>
							<div
								class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
								<form class="form-horizontal" action="/books/book?method=listByPage"
									method="post">
									<!-- <input type="hidden" name="tip" value="1"> -->
									<div class="col-lg-7 form-group">
										<label class="col-lg-4 control-label" for="query_bname">Book Info</label>
										<div class="col-lg-8">
											<input class="form-control"  name="word"
												type="text" value="${word}"> <label class="control-label"
												for="query_bname" style="display: none;"></label>
										</div>
									</div>
									<div class="col-lg-3 form-group">

										<button type="submit" class="btn btn-primary" id="btn_query">Search</button>
									</div>
									<div class="col-lg-3 form-group">
										<button type="button" class="btn btn-primary" id="btn_add"
											data-toggle="modal" data-target="#addModal">Add Book</button>
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
									<th>Serial Number</th>
									<th>Book Type</th>
									<th>Book Name</th>
									<th>Author Name</th>
									<th>Press</th>
									<th>Total Number</th>
									<th>Operation</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${bList}" var="book" varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${book.typeName}</td>
										<td>${book.bookName}</td>
										<td>${book.author}</td>
										<td>${book.press}</td>
										<td>${book.num}</td>
										<td><button type="button" class="btn btn-warning btn-xs"
										data-toggle="modal" data-target="#updateModal" id="btn_update"
										onclick="showInfo2('${book.bid}','${book.tid}','${book.bookName}','${book.author}','${book.press}','${book.num}')">
											Change</button>
									<button type="button" class="btn btn-danger btn-xs"
										onclick="deletebook(${book.bid})">Delete</button></td>
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
		function showInfo2(bid, tid, name, autho, press, num) {
			document.getElementById("updateBookName").value = name;
			document.getElementById("updateAutho").value = autho;
			document.getElementById("updatePress").value = press;
			document.getElementById("updateBookType").value = tid;
			document.getElementById("updateNum").value = num;
			document.getElementById("updateBookId").value = bid;
		}

		function deletebook(bid) {
			con = confirm("are you sure to delete this?");
			if(con == true) {
				location.href = "/books/book?method=delBook&bid=" + bid;
			}
		}
	</script>

	<!-------------------------------------------------------------->

	<!-- 修改模态框（Modal） -->
	<form class="form-horizontal" method="post"
		action="/books/book?method=updBook">
		<!--保证样式水平不混乱-->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="updateModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="updateModalLabel">Change Book Info</h4>
					</div>
					<div class="modal-body">

						<!---------------------表单-------------------->

						<input name="bid" id="updateBookId" type="hidden"/>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Book Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updateBookName" readonly="readonly"
									name="bookName" placeholder="Please Enter Book's Name"> <label
									class="control-label" for="updateBookName"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Book Type</label>
							<div class="col-sm-7">
								<select class="form-control" id="updateBookType" name="tid"
									>
									<option value="-1">Please Choose One</option>
									<c:forEach items="${typeList}" var="type" varStatus="status">
										<option value="${type.tid}">${type.typeName}</option>
									</c:forEach>
								</select> 
								<label class="control-label" for="updateBookType"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Author Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updateAutho" readonly="readonly"
									name="author" placeholder="Please Enter Author Name"> <label
									class="control-label" for="updateAutho" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Press</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updatePress"
									name="press" placeholder="Please Enter Press Name"> <label
									class="control-label" for="updatePress" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Total Number</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="updateNum"
									name="num" placeholder="Please Enter Total Number"> <label
									class="control-label" for="updatePress" style="display: none;"></label>
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
		action="/books/book?method=addBook">
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
							<label for="firstname" class="col-sm-3 control-label">Book Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="addBookName"
									required="required" name="bookName" placeholder="Please Enter Book Name">
								<label class="control-label" for="addBookName"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Book Type</label>
							<div class="col-sm-7">
								<select class="form-control" id="addBookType" name="tid">
									<option value="No Category">Please Choose One</option>
									<c:forEach items="${typeList}" var="type" varStatus="status">
										<option value="${type.tid}">${type.typeName}</option>
									</c:forEach>
								</select> 
								<label class="control-label" for="addBookType"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Author Name</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="addAutho"
									required="required" name="author" placeholder="Please Enter Author Name">
								<label class="control-label" for="addAutho"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Press</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="addPress"
									required="required" name="press" placeholder="Please Enter Press Name">
								<label class="control-label" for="addPress"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label for="firstname" class="col-sm-3 control-label">Total Number</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="addNum"
									required="required" name="num" placeholder="Please Enter Total Number">
								<label class="control-label" for="addNum" style="display: none;"></label>
							</div>
						</div>

						<!---------------------表单-------------------->
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
	<!--------------------------------------修改密码的模糊框------------------------>

	<jsp:include page="../common/userInfo.jsp"></jsp:include>
	<jsp:include page="../common/js.jsp"></jsp:include>
	<script type="text/javascript">
		var f = false;
		
		$("#addBookName").blur(function(){
			$.get("${pageContext.request.contextPath}/book?method=checkBook",{"bookName":$("#addBookName").val()},function(res){
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