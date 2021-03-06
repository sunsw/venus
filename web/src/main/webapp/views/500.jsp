<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="/assets/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
	<link href="/app/css/index.css" rel="stylesheet" type="text/css"/>
	<style>
		body {
			margin: 0;
			padding: 0;
			width: 100%;
			height: 100%;
			color: #B0BEC5;
			display: table;
			font-weight: 100;
			font-family: 'Lato';
		}

		.content {
			text-align: center;
			margin-top: 120px;
		}

		.title {
			font-size: 72px;
			margin-bottom: 40px;
		}
	</style>
	<title>服务器错误</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="content">
	<div class="title">服务器报错啦，请联系管理员~</div>
</div>
<jsp:include page="common/footer.jsp"/>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
</body>
</html>