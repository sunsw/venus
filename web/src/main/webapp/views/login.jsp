<%@ page language="java" pageEncoding="utf-8" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Mercury management system</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="Mercury"/>
    <meta name="description" content="Mercury management system"/>

    <link rel="shortcut icon" href="/app/img/favicon.ico" type="image/x-icon"/>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link href="/app/css/login.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div id="Strip" class="row form-group">
    <div id="pic" class="col-lg-8 col-md-7 col-sm-0 col-xs-0"></div>
    <div id="login"
         class="col-lg-3 col-lg-offset-0 col-md-4 col-md-offset-0 col-sm-8 col-sm-offset-2 col-xs-10 col-xs-offset-1">
        <form class="form-horizontal" role="form" method="POST" action="/page/user/login">
            <div class="row form-group">
                <div id="loginTitle" class="col-xs-12">Mercury</div>
            </div>
            <div class="row form-group">
                <div class="col-xs-12">用户名(Username)</div>
            </div>
            <div class="row form-group">
                <div class="col-xs-12"><input type="text" id="u" name="username" table="mainTable"
                                              class="form-control input-lg" value=""/></div>
            </div>
            <div class="row form-group">
                <div class="col-xs-12">密码(Password)</div>
            </div>
            <div class="row form-group">
                <div class="col-xs-12"><input type="password" id="p" name="password" table="mainTable"
                                              class="form-control input-lg" value=""/></div>
            </div>
            <div class="row form-group">
                <div class="col-xs-12">&nbsp;</div>
            </div>
            <div class="form-group">
                <div class="col-xs-12">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="remember"> 保持登录
                            <%--<br/><br/>
                            <a href="/page/register"> 注册 </a>--%>
                        </label>
                        <button id="loginButton" type="submit" class="loginButton btn btn-lg">登录(Login)</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>