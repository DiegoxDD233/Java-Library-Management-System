<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form class="form-horizontal" method="post"
	action="/books/user?method=updUserInfo">
	<!--保证样式水平不混乱-->
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="updatepwd" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Change Password</h4>
				</div>
				<div class="modal-body">
				
					<!--正文-->
					<input type="hidden" name="tip" value="1"> <input
						type="hidden" name="url" value="admin_user">
					<div class="form-group">
						<label for="firstname" class="col-sm-3 control-label">Original Password</label>
						<div class="col-sm-7">
							<input type="password" class="form-control" name="password"
								id="oldPwd" placeholder="Please Enter Original Password"> <label
								class="control-label" for="oldPwd" style="display: none"></label>
						</div>
					</div>

					<div class="form-group">
						<label for="firstname" class="col-sm-3 control-label">New Password</label>
						<div class="col-sm-7">
							<input type="password" class="form-control" name="password2"
								id="newPwd" placeholder="Please Enter New Password"> <label
								class="control-label" for="newPwd" style="display: none"></label>
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

<!-------------------------个人资料模糊框------------------------------------->

<form class="form-horizontal" method="post"
	action="/books/user?method=updUserInfo">
	<!--保证样式水平不混乱-->
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="updateinfo" tabindex="-1" role="dialog"
		aria-labelledby="ModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="ModalLabel">Personal Info</h4>
				</div>
				<div class="modal-body">

						<!--正文-->
					<input type="hidden" name="tip" value="2"> <input
						type="hidden" name="url" value="admin_user">
					<div class="form-group">
						<label for="firstname" class="col-sm-3 control-label">Real Name</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" id="name" name="name"
								placeholder="Please Enter Your Real Name"
								value='${user.name}'> <label
								class="control-label" for="name" style="display: none"></label>
						</div>
					</div>

					<div class="form-group">
						<label for="firstname" class="col-sm-3 control-label">Phone Number</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" id="phone" name="phone"
								placeholder="Please Enter Your Phone Number"
								value='${user.phone}'> <label
								class="control-label" for="phone" style="display: none"></label>
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