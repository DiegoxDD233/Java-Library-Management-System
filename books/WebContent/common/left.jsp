<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="col-md-2 bootstrap-admin-col-left">
	<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
		<li><a href="${pageContext.request.contextPath}/book?method=listByPage"><i
				class="glyphicon glyphicon-chevron-right"></i> Book management</a></li>
		<li><a href="${pageContext.request.contextPath}/user?method=list"><i
				class="glyphicon glyphicon-chevron-right"></i> User management</a></li>
		<li><a href="${pageContext.request.contextPath}/type?method=listByPage"><i
				class="glyphicon glyphicon-chevron-right"></i> Book classification management</a></li>
		<li><a href="${pageContext.request.contextPath}/history?method=list"><i
				class="glyphicon glyphicon-chevron-right"></i> Book borrowing information</a></li>
		<li><a href="${pageContext.request.contextPath}/history?method=backList"><i
				class="glyphicon glyphicon-chevron-right"></i> Book return information</a></li>
	</ul><br><br>
	<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
		<li><a href="${pageContext.request.contextPath}/book?method=rank"><i
				class="glyphicon glyphicon-chevron-right"></i> Popular Book Recommendation</a></li>
		<li><a href="${pageContext.request.contextPath}/user?method=rank"><i
				class="glyphicon glyphicon-chevron-right"></i> Best readers</a></li>
	</ul><br><br>
	<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
		<li><a href="${pageContext.request.contextPath}/problem?method=listByPage"><i
				class="glyphicon glyphicon-chevron-right"></i> Feedback</a></li>
	</ul>
</div>