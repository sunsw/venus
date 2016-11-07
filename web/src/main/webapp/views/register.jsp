<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>海玩 库存管理系统</title>
	<meta name="keywords" content="库存管理，海玩"/>
	<meta name="description" content="海玩网的库存管理系统"/>
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="/assets/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%--<jsp:include page="/WEB-INF/views/common/header.jsp" ></jsp:include>--%>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="panel panel-default">
				<div class="panel-heading">注册</div>
				<div class="panel-body">
					<c:if test="${error!=null}">
						<div class="alert alert-danger">
							<strong>Whoops!</strong> 请检查以下错误： <br><br>
							<ul>
								<li>${error}</li>
							</ul>
						</div>
					</c:if>

					<form class="form-horizontal" role="form" method="POST" action="/page/user/register">
						<div class="form-group">
							<label class="col-md-4 control-label">Name</label>
							<div class="col-md-6">
								<input type="text" class="form-control" name="username">
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4 control-label">E-Mail Address</label>
							<div class="col-md-6">
								<input type="email" class="form-control" name="email">
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4 control-label">Password</label>
							<div class="col-md-6">
								<input type="password" class="form-control" name="password">
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4 control-label">Confirm Password</label>
							<div class="col-md-6">
								<input type="password" class="form-control" name="password_confirmation">
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-6 col-md-offset-4">
								<button type="submit" class="btn btn-primary">
									Register
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
</body>
</html>