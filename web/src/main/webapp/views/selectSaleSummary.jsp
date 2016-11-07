<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="/assets/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
    <link href="/assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
    <link href="/app/css/index.css" rel="stylesheet" type="text/css"/>
    <link href="/app/css/selectSaleSummary.css" rel="stylesheet" type="text/css"/>
    <title>出库统计</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="row clearfix">
    <div class="col-md-12 column">
        <ul class="breadcrumb" style="margin: 1em">
            <li>
                <a href="#">商品出库</a>
            </li>
            <li class="active">
                出库统计
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="selectSaleSummarySubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockSale/selectSaleSummary">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-3 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">渠道</label>
                <div class="col-sm-8">
                    <select name="stockSale.channel" class="form-control" id="input3" value="${stockKeepSaleInfo.stockSale.channel}">
                        <option value="">请选择</option>
                        <option value="1">网站</option>
                        <option value="2">Android</option>
                        <option value="3">IOS</option>
                        <option value="4">WAP</option>
                        <option value="5">去哪儿门票</option>
                        <option value="6">去哪儿度假</option>
                        <option value="7">京东</option>
                        <option value="8">拉手网</option>
                        <option value="9">青芒果</option>
                        <option value="10">穷游网</option>
                        <option value="11">新浪微博</option>
                        <option value="21">天猫API</option>
                        <option value="22">天猫</option>
                        <option value="25">去哪儿API</option>
                        <option value="99">小渠道</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="input4" class="col-sm-4 control-label">产品名称</label>
                <div class="col-sm-8">
                    <input type="text" name="stockInfo.productName" class="form-control" id="input4" value="${stockKeepSaleInfo.stockInfo.productName}"/>
                </div>
            </div>
        </div>
        <div class="col-md-3 column">
            <div class="form-group">
                <label for="createTimeId" class="col-md-4 control-label">申请日期</label>

                <div class="col-md-1"></div>
                <div class="input-group date form_date col-md-7" data-date="" data-date-format="dd MM yyyy"
                     data-link-field="createTimeId" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.createTime}" pattern="yyyy-MM-dd"/>" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="createTimeId" name="stockSale.createTime"  value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.createTime}" pattern="yyyy-MM-dd"/>"/>
            </div>
            <div class="form-group">
                <label for="input6" class="col-sm-4 control-label">产品 Id</label>
                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="stockInfo.productId" class="form-control" id="input6" value="${stockKeepSaleInfo.stockInfo.productId}" data-original-title="请输入一个正整数"/>
                </div>
            </div>
        </div>
        <div class="col-md-2 column" style="padding-top: 4%; text-align: right;">
            <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
            &nbsp;&nbsp;
            <button id="selectSaleSummarySubmitButton" type="button" class="btn enter_press_search" style="width: 6em">查询</button>
        </div>
        <div class="col-md-3 column">
        </div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover" id="stockInfoTable">
            <thead>
            <tr>
                <th>日期</th>
                <th>产品ID</th>
                <th>产品名称</th>
                <th>SKU</th>
                <th>渠道名称</th>
                <th>当天申请量</th>
                <th>当天出票量</th>
                <th>总欠票量</th>
                <th>退票记录</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr skuId="${re.stockInfo.skuId}" stockInfoId="${re.stockInfo.id}" stockKeepId="${re.stockKeep.id}" stockSaleId="${re.stockSale.id}">
                    <td>
                            <fmt:formatDate value="${re.stockInfo.createTime}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                            ${re.stockInfo.productId}
                    </td>
                    <td>
                            ${re.stockInfo.productName}
                    </td>
                    <td>
                            ${re.stockInfo.skuName}
                    </td>
                    <td>
                        <c:if test="${re.channel==1}">
                            网站
                        </c:if>
                        <c:if test="${re.channel==2}">
                            Android
                        </c:if>
                        <c:if test="${re.channel==3}">
                            IOS
                        </c:if>
                        <c:if test="${re.channel==4}">
                            WAP
                        </c:if>
                        <c:if test="${re.channel==5}">
                            去哪儿门票
                        </c:if>
                        <c:if test="${re.channel==6}">
                            去哪儿度假
                        </c:if>
                        <c:if test="${re.channel==7}">
                            京东
                        </c:if>
                        <c:if test="${re.channel==8}">
                            拉手网
                        </c:if>
                        <c:if test="${re.channel==9}">
                            青芒果
                        </c:if>
                        <c:if test="${re.channel==10}">
                            穷游网
                        </c:if>
                        <c:if test="${re.channel==11}">
                            新浪微博
                        </c:if>
                        <c:if test="${re.channel==21}">
                            天猫API
                        </c:if>
                        <c:if test="${re.channel==22}">
                            天猫
                        </c:if>
                        <c:if test="${re.channel==25}">
                            去哪儿API
                        </c:if>
                        <c:if test="${re.channel==99}">
                            小渠道
                        </c:if>
                    </td>
                    <td>
                        ${re.apply}
                            <%--${re.stockSale.orderId}--%>
                    </td>
                    <td>
                        ${re.saled}
                    </td>
                    <td>
                        ${re.owed}
                    </td>
                    <td>
                        ${re.refund}
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <jsp:include page="common/pagination.jsp"></jsp:include>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/assets/scripts/jquery.media.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="text/javascript" src="/app/js/selectSaleSummary.js"></script>
</body>
</html>
