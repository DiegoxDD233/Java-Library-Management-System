<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 用户端左侧导航栏 -->
<div class="col-md-2 bootstrap-admin-col-left">
	<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
		<li><a href="/books/book?method=listByPage"><i
				class="glyphicon glyphicon-chevron-right"></i> BookSearch</a></li>
		<li><a href="/books/history?method=list"><i
				class="glyphicon glyphicon-chevron-right"></i> Borrowing information</a></li>
		<li><a href="/books/history?method=backList"><i
				class="glyphicon glyphicon-chevron-right"></i> Borrowing History</a></li>
	</ul><br><br>
	<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
		<li><a href="/books/book?method=rank"><i
				class="glyphicon glyphicon-chevron-right"></i> Popular Book Recommendation</a></li>
		<li><a href="/books/user?method=rank"><i
				class="glyphicon glyphicon-chevron-right"></i> Best readers</a></li>
	</ul><br><br>
	<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
		<li><a href="/books/problem?method=listByPage"><i
				class="glyphicon glyphicon-chevron-right"></i> Feedback</a></li>
	</ul>
</div>
