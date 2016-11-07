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
    <link href="/app/css/stockRefund.css" rel="stylesheet" type="text/css"/>
    <title>申请退票&查询</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="row clearfix">
    <div class="col-md-12 column">
        <ul class="breadcrumb" style="margin: 1em">
            <li>
                <a href="#">退票</a>
            </li>
            <li class="active">
                申请退票&查询
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockRefundSubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockRefund">
        <div class="row">
            <div class="col-md-3 column">
                <div class="form-group">
                    <label for="input4" class="col-sm-4 control-label">订单号</label>

                    <div class="col-sm-8">
                        <input type="text" name="orderId" class="form-control" id="input4" value="${orderId}">
                    </div>
                </div>
            </div>
            <div class="col-md-3 column">
                <div class="form-group">
                    <label for="input7" class="col-md-4 control-label">退票发起日期</label>

                    <div class="col-md-1"></div>
                    <div class="input-group date form_date col-md-8" data-date="" data-date-format="dd MM yyyy"
                         data-link-field="input7" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" value="${date}" readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <input type="hidden" id="input7" name="date" value="${date}" /><br/>
                </div>
            </div>
            <div class="col-md-3 column">
                <div class="form-group">
                    <label for="input9" class="col-sm-4 control-label">产品Id</label>

                    <div class="col-sm-8">
                        <input maxlength="9" type="text" name="productId" class="form-control" id="input9" value="${productId}" data-original-title="请输入一个正整数">
                    </div>
                </div>

            </div>
            <div class="col-md-2 column">
                <div class="form-group">
                    <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
                    &nbsp;&nbsp;
                    <button id="queryStockRefundButton" type="button" class="btn enter_press_search" style="width: 6em">查询</button>
                </div>
            </div>
        </div>
        <shiro:hasRole name="tourconsultant">
        <div class="row">
            <div class="col-md-10 column"></div>
            <div class="col-md-2 column">
                <button id="applicationForRefundButton" type="button" class="btn btn-primary">申请退票
                </button>
            </div>
        </div>
        </shiro:hasRole>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockRefundTable">
            <thead>
            <tr>
                <th>退票单号</th>
                <th>发起人</th>
                <th>产品ID-Name</th>
                <th>SKU名称</th>
                <th>订单号</th>
                <th>数量</th>
                <th>退票状态</th>
                <th>操作</th>
                <th>操作人</th>
                <th>操作时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr stockRefundId="${re.stockRefund.id}">
                    <td>
                            ${re.stockRefund.id}
                    </td>
                    <td>
                            ${re.stockRefund.ext2}
                    </td>
                    <td>
                            ${re.stockInfo.productId}-${re.stockInfo.productName}
                    </td>
                    <td>
                            ${re.stockInfo.skuName}
                    </td>
                    <td>
                            ${re.stockSale.orderId}
                    </td>
                    <td>
                            ${re.stockRefund.number}
                    </td>
                    <td>
                        <c:if test="${re.stockRefund.status==0}">
                            收到退票
                        </c:if>
                        <c:if test="${re.stockRefund.status==1}">
                            已完成
                        </c:if>
                    </td>
                    <td>
                        <shiro:hasRole name="tourpm">
                            退票
                        </shiro:hasRole>
                        <c:if test="${re.stockRefund.status==0}">
                            <shiro:hasRole name="stockmanager">
                                <a class="confirmRefund" href="#">确认</a>
                            </shiro:hasRole>
                        </c:if>
                    </td>
                    <td>
                            ${re.stockRefund.ext0}
                    </td>
                    <td>
                        <fmt:formatDate value="${re.stockRefund.optTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <jsp:include page="common/pagination.jsp"></jsp:include>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
<div class="modal fade" id="setRefundDiv" role="dialog" aria-labelledby="myModalLabel1"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel1">
                    退实体票
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" id="refundForm" class="form-horizontal" enctype="multipart/form-data"
                              method="POST" action="/page/stockRefund/add">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="refundOrderId">订单号 *</label>

                                <div class="col-sm-8"><input type="text" class="form-control" name="orderId" required
                                                             id="refundOrderId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="refundSkuName">Sku名称 *</label>

                                <div class="col-sm-8">
                                    <select class="form-control" id="refundSkuName" name="skuId" readonly>
                                        <option value="">请先输入订单号</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="refundNumber">退票数量 *</label>

                                <div class="col-sm-8"><input type="number" class="form-control" name="number"
                                                             id="refundNumber"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="refundExpCompany">快递公司</label>

                                <div class="col-sm-8"><input type="text" class="form-control" name="expCompany"
                                                             id="refundExpCompany"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="refundExpCode">快递单号</label>

                                <div class="col-sm-8"><input type="text" class="form-control" name="expCode"
                                                             id="refundExpCode"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="refundNote">备注</label>

                                <div class="col-sm-8"><input type="text" class="form-control" name="note"
                                                             id="refundNote"/></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitRefund" type="button" class="btn btn-primary"> 确认</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/assets/scripts/jquery.media.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="text/javascript" src="/app/js/stockRefund.js"></script>
</body>
</html>
