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
    <link href="/app/css/stockExpress.css" rel="stylesheet" type="text/css"/>
    <title>实物快递</title>
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
                实物快递
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockExpressSubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockSale/stockExpress">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-3 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">快递单号</label>
                <div class="col-sm-8">
                    <input type="text" name="stockSale.expCode" class="form-control" id="input3" value="${stockKeepSaleInfo.stockSale.expCode}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input4" class="col-sm-4 control-label">订单号</label>
                <div class="col-sm-8">
                    <input type="text" name="stockSale.orderId" class="form-control" id="input4" value="${stockKeepSaleInfo.stockSale.orderId}"/>
                </div>
            </div>
        </div>
        <div class="col-md-3 column">
            <div class="form-group">
                <label for="createTimeId" class="col-md-4 control-label">发货日期</label>

                <div class="col-md-1"></div>
                <div class="input-group date form_date col-md-7" data-date="" data-date-format="dd MM yyyy"
                     data-link-field="createTimeId" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.optTime}" pattern="yyyy-MM-dd"/>" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="createTimeId" name="stockSale.optTime" value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.optTime}" pattern="yyyy-MM-dd"/>"/>
            </div>
            <div class="form-group">
                <label for="input6" class="col-sm-4 control-label">产品 Id</label>
                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="stockInfo.productId" class="form-control" id="input6" value="${stockKeepSaleInfo.stockInfo.productId}" data-original-title="请输入一个正整数"/>
                </div>
            </div>
        </div>
        <div class="col-md-3 column">
            <div class="form-group">
                <label for="input7" class="col-sm-4 control-label">发货状态</label>
                <div class="col-sm-8">
                    <select name="stockSale.status" class="form-control" id="input7" value="${stockKeepSaleInfo.stockSale.status}">
                        <option value="">请选择</option>
                        <option value="0">未发货</option>
                        <option value="1">已发货</option>
                        <option value="2">失败</option>
                    </select>
                </div>
            </div>
          <%--  <div class="form-group">
                <label for="input8" class="col-sm-4 control-label">发件人</label>
                <div class="col-sm-8">
                    <input type="text" name="stockSale.optUser" class="form-control" id="input8" value="${stockKeepSaleInfo.stockSale.optUser}"/>
                </div>
            </div>--%>
        </div>
        <div class="col-md-2 column" style="padding-top: 4%; text-align: right;">
            <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
            &nbsp;&nbsp;
            <button id="stockExpressQueryButton" type="button" class="btn enter_press_search" style="width: 6em">查询</button>
        </div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockInfoTable">
            <thead>
            <tr>
                <th>发货日期</th>
                <th>发件人</th>
                <th>快递公司</th>
                <th>快递单号</th>
                <th>订单号</th>
                <th>产品</th>
                <th>SKU名称</th>
                <th>数量</th>
                <th>收货人</th>
                <th>联系方式</th>
                <th>收货地址</th>
                <th>发货状态</th>
                <th>操作人</th>
                <th>操作时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr skuId="${re.stockInfo.skuId}" stockInfoId="${re.stockInfo.id}" stockKeepId="${re.stockKeep.id}" stockSaleId="${re.stockSale.id}">
                    <td>
                        <fmt:formatDate value="${re.stockSale.optTime}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        ${re.stockSale.ext0}
                    </td>
                    <td>
                        ${re.stockSale.expCompany}
                    </td>
                    <td>
                        ${re.stockSale.expCode}
                    </td>
                    <td>
                        ${re.stockSale.orderId}
                    </td>
                    <td>
                        ${re.stockInfo.productId}-${re.stockInfo.productName}
                    </td>
                    <td>
                        ${re.stockInfo.skuName}
                    </td>
                    <td>
                        ${re.stockSale.number}
                    </td>
                    <td>
                        ${re.stockSale.acceptor}
                    </td>
                    <td>
                        ${re.stockSale.phone}
                    </td>
                    <td>
                        ${re.stockSale.address}
                    </td>
                    <td>
                        <c:if test="${re.stockSale.status==0}">
                            未发货
                        </c:if>
                        <c:if test="${re.stockSale.status==1}">
                            已发货
                        </c:if>
                        <c:if test="${re.stockSale.status==2}">
                            失败
                        </c:if>
                    </td>
                    <td>
                        ${re.stockSale.ext1}
                    </td>
                    <td>
                        <fmt:formatDate value="${re.stockSale.optTime}" pattern="yyyy-MM-dd"/>
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
<script type="text/javascript" src="/app/js/stockExpress.js"></script>
</body>
</html>
