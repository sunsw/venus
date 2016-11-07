<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Mercury management system</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="shortcut icon" href="/app/img/favicon.ico" type="image/x-icon"/>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/app/css/index.css"/>
</head>
<body>

<nav class="navbar navbar-default navbar-fixed-top navbar-inverse" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand">
            <img src="/app/img/mercury-pic.jpg" height="50px;"/>
        </a>
        <a class="navbar-brand">
            <img src="/app/img/logo.jpg" height="50px;"/>
        </a>
    </div>

    <div>
        <ul class="nav navbar-nav">
            <c:forEach items="${menus}" var="menu">
                <c:if test="${menu.level == 1}">
                    <li class="mercury-nav dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                ${menu.menuTitle}<b class="caret"></b></a>

                        <ul class="dropdown-menu">
                            <c:set var="i" value="0"/>
                            <c:forEach items="${menus}" var="subMenu">
                                <c:if test="${subMenu.level == 2 && menu.id == subMenu.parentId}">
                                    <c:if test="${i != 0}">
                                        <li class="divider"></li>
                                    </c:if>
                                    <c:set var="i" value="1"/>
                                    <li>
                                        <a href="javascript:gotoUrl('${subMenu.menuUrl}')">${subMenu.menuTitle}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
        <ul class="nav navbar-nav navbar-right" style="margin-right: 5px;">
            <li>
                <a href="#"><img src="/app/img/user.png" height="20px;"/></a>
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    ${userInfo.username} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="http://i.haiwan.com:8081" target="_blank">登录ERP</a>
                    </li>
                    <li>
                        <a href="https://payment.haiwan.com" target="_blank">登录Payment</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="#" id="showResetPasswordDiv" data-toggle="modal">修改密码</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="/page/user/logout">退出</a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div style="width: 100%; position: absolute; top: 50px; bottom: 0px;">
    <iframe id="content" width="100%" height="100%" frameborder="0" scrolling="auto"
            src="/welcome.html"></iframe>
</div>

<div class="modal fade" id="resetPasswordDiv" role="dialog" aria-labelledby="myModalLabel00" aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel00">
                    修改密码
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="oldPsw">当前密码</label>
                                <div class="col-md-8"><input type="password" class="form-control" id="oldPsw"
                                                             data-toggle='tooltip' data-original-title="请填写当前密码"
                                                             placeholder="  输入当前密码"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="newPsw">新密码</label>
                                <div class="col-md-8"><input type="password" class="form-control" id="newPsw"
                                                             data-toggle='tooltip' data-original-title="密码长度过短"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="confPsw">确认密码</label>
                                <div class="col-md-8"><input type="password" class="form-control" id="confPsw"
                                                             data-toggle='tooltip' data-original-title="两次密码输入不一致"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="submitResetPassword" type="button" class="btn btn-danger"> 修改</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</div>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="/assets/js/jquery-1.11.3.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="/assets/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(".navbar-nav li.stock-nav").click(function () {
        $(this).parent().find("li").removeClass("active");
        $(this).addClass("active");
    });

    function gotoUrl(url) {
        $("#content").attr("src", url);
    }
</script>
</body>
</html>
