<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Mercury management system</title>
    <link rel="shortcut icon" href="/app/img/favicon.ico" type="image/x-icon"/>
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
            background: url("/app/img/star.jpg") no-repeat;
            background-size: 100%;
        }

        .content {
            text-align: center;
            margin-top: 120px;
        }

        .title {
            font-size: 72px;
            margin-bottom: 40px;
            color: #fffa2d;
        }
    </style>
</head>
<body>
<div class="container-fluid" style="margin-top: 6em">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default navbar-fixed-top navbar-inverse" role="navigation">
                <div class="navbar-header" style="width: 30em">
                    <a class="navbar-brand" style="padding: 0em;" href="/">
                        <img src="/app/img/mercury-pic.jpg" style="width: 3em;height: 3em;"/>
                    </a>
                    <a class="navbar-brand" style="padding: 0em;" href="/">
                        <img src="/app/img/logo.jpg" style="width: 10em;height: 3em;"/>
                    </a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li id="stockIn" class="stock-nav dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">商品入库<strong
                                    class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="/app/test.html">test</a>
                                </li>
                                <li class="divider"></li>
                                <shiro:hasAnyRoles name="stockmanager,tourpm,tourconsultant,accountants">
                                    <li>
                                        <a href="/page/stockInfo">入库管理</a>
                                    </li>
                                </shiro:hasAnyRoles>
                                <shiro:hasRole name="tourpm">
                                    <li class="divider"></li>
                                    <li>
                                        <a href="/page/stockAttachment">附件管理</a>
                                    </li>
                                </shiro:hasRole>
                                <shiro:hasAnyRoles name="stockmanager,tourpm">
                                    <li class="divider"></li>
                                    <li>
                                        <a href="/page/stockPurchase">采购记录</a>
                                    </li>
                                </shiro:hasAnyRoles>
                                <shiro:hasAnyRoles name="stockmanager,tourpm,tourconsultant,channeloperator">
                                    <li class="divider"></li>
                                    <li>
                                        <a href="/page/stockKeep/selectSummary">库存统计</a>
                                    </li>
                                </shiro:hasAnyRoles>
                            </ul>
                        </li>
                        <li id="stockOut" class="stock-nav dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">商品出库<strong
                                    class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <shiro:hasAnyRoles name="stockmanager,tourpm,tourconsultant">
                                    <li>
                                        <a href="/page/stockSale">库存出库</a>
                                    </li>
                                </shiro:hasAnyRoles>
                                <shiro:hasAnyRoles name="stockmanager,channeloperator">
                                    <li class="divider"></li>
                                    <li>
                                        <a href="/page/stockSale/selectSaleSummary">出库统计</a>
                                    </li>
                                </shiro:hasAnyRoles>
                                <shiro:hasAnyRoles name="tourconsultant,channeloperator">
                                    <li class="divider"></li>
                                    <li>
                                        <a href="/page/stockSale/stockExpress">实物快递</a>
                                    </li>
                                </shiro:hasAnyRoles>
                            </ul>
                        </li>
                        <shiro:hasAnyRoles name="stockmanager,tourconsultant">
                            <li id="stockRefund" class="stock-nav dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">退票<strong
                                        class="caret"></strong></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a href="/page/stockRefund">申请退票&查询</a>
                                    </li>
                                </ul>
                            </li>
                        </shiro:hasAnyRoles>
                        <shiro:hasAnyRoles name="tourpm,accountants,channeloperator,stockmanager">
                            <li id="stockInventory" class="stock-nav dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">盘点<strong
                                        class="caret"></strong></a>
                                <ul class="dropdown-menu">
                                    <shiro:hasAnyRoles name="tourpm,channeloperator">
                                        <li>
                                            <a href="/page/stockKeep/selectInventory">盘点表</a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                    <shiro:hasAnyRoles name="accountants,stockmanager">
                                        <li>
                                            <a href="/page/stockFinancial/">财务盘点</a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                </ul>
                            </li>
                        </shiro:hasAnyRoles>
                    </ul>
                    <ul class="nav navbar-nav navbar-right" style="margin-right: 1em;">
                        <li>
                            <a href="#"><img src="/app/img/user.png" style="width: 1.6em;height: 1.6em"/></a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                ${userInfo.username} <strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="http://i.haiwan.com:8081" target="_blank">登录ERP</a>
                                </li>
                                <li>
                                    <a href="https://payment.haiwan.com" target="_blank">登录Payment</a>
                                </li>
                                <li class="divider">
                                <li>
                                    <a href="#" id="showResetPasswordDiv" data-toggle="modal">修改密码</a>
                                </li>
                                <li class="divider">
                                </li>
                                <li>
                                    <a href="/page/user/logout">退出</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </nav>
        </div>
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
                                    <label class="col-sm-4 control-label" for="oldPsw">当前密码</label>
                                    <div class="col-sm-8"><input type="password" class="form-control" id="oldPsw"
                                                                 data-toggle='tooltip' data-original-title="请填写当前密码"
                                                                 placeholder="  输入当前密码"/></div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="newPsw">新密码</label>
                                    <div class="col-sm-8"><input type="password" class="form-control" id="newPsw"
                                                                 data-toggle='tooltip' data-original-title="密码长度过短"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="confPsw">确认密码</label>
                                    <div class="col-sm-8"><input type="password" class="form-control" id="confPsw"
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
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div id="content" class="content">
                <div class="title">欢迎来到Mercury！
                    <c:forEach items="${menus}" var="menu">
                        ${menu.menuTitle}
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="application/javascript">
    function test() {
        $.get("/views/common/test.html", function (a) {
            $("#content").html(a);
        })
    }

    $(document).on("click", 'a[href!="#"]', function (a) {
        a.preventDefault();
        var b = $(a.currentTarget);
        window.location.search ? window.location.href = window.location.href.replace(window.location.search, "").replace(window.location.hash, "") + "#" + b.attr("href") : window.location.hash = b.attr("href");
    });

    $(window).on("hashchange", function () {
        checkURL()
    });

    function checkURL() {
        var a = location.href.split("#").splice(1).join("#");
        if (!a)try {
            var b = window.document.URL;
            b && b.indexOf("#", 0) > 0 && b.indexOf("#", 0) < b.length + 1 && (a = b.substring(b.indexOf("#", 0) + 1))
        } catch (c) {
        }
        if (container = $("#content"), a) {
            $("nav li.active").removeClass("active"), $('nav li:has(a[href="' + a + '"])').addClass("active");
            var d = $('nav a[href="' + a + '"]').attr("title");
            document.title = d || document.title, debugState && root.console.log("Page title: %c " + document.title, debugStyle_green), loadURL(a + location.search, container)
        } else {
            var e = $('nav > ul > li:first-child > a[href!="#"]');
            window.location.hash = e.attr("href"), e = null
        }
    }

    function loadURL(a, b) {
        $.ajax({
            "type": "GET",
            "url": a,
            "dataType": "html",
            "cache": !0,
            "success": function (a) {
                b.css({"opacity": "0.0"}).html(a).delay(50).animate({"opacity": "1.0"}, 300), a = null, b = null
            },
            "error": function (c, d, e) {
                b.html('<h4 class="ajax-loading-error"><i class="fa fa-warning txt-color-orangeDark"></i> Error requesting <span class="txt-color-red">' + a + "</span>: " + c.status + ' <span style="text-transform: capitalize;">' + e + "</span></h4>")
            },
            "async": !0
        })
    }
</script>
</body>
</html>
