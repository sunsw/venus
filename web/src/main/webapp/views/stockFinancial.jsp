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
    <title>财务盘点表</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="row clearfix">
    <div class="col-md-12 column">
        <ul class="breadcrumb" style="margin: 1em">
            <li>
                <a href="#">盘点</a>
            </li>
            <li class="active">
                财务盘点表
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockFinancialSubmitForm" class="form-horizontal" role="form" method="GET"
          action="/page/stockFinancial/">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-4 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">产品 id</label>

                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="productId" class="form-control" id="input3"
                           value="${stockFinancial.productId}" data-original-title="请输入一个正整数"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input2" class="col-sm-4 control-label">SKU名称</label>

                <div class="col-sm-8">
                    <input type="text" name="skuName" class="form-control" id="input2"
                           value="${stockFinancial.skuName}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input1" class="col-sm-4 control-label">供应商名称</label>

                <div class="col-sm-8">
                    <input type="text" name="supplierName" class="form-control" id="input1"
                           value="${stockFinancial.supplierName}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input5" class="col-sm-4 control-label">票的类型</label>

                <div class="col-sm-8">
                    <select name="type" class="form-control" id="input5"
                            value="${stockFinancial.type}">
                        <option value="">请选择</option>
                        <option value="0">实体票</option>
                        <option value="1">电子票</option>
                        <option value="2">电子码</option>
                        <option value="3">二维码</option>
                        <option value="4">条形码</option>
                        <%--<option value="5">电子票&附件</option>--%>
                        <%--<option value="6">电子码&附件</option>--%>
                        <option value="-2">海玩电子码</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-4 column">
            <%--<div class="form-group">
                <label for="input0" class="col-sm-4 control-label">国家</label>

                <div class="col-sm-8">
                    <select name="country" class="form-control" id="input0"
                            value="${stockFinancial.country}" readonly onchange='$(this).val("")'>
                        <option value="">请选择</option>
                        <option value="香港">香港</option>
                        <option value="新加坡">新加坡</option>
                        <option value="马来西亚">马来西亚</option>
                        <option value="法国">法国</option>
                        <option value="德国">德国</option>
                        <option value="美国">美国</option>
                    </select>
                </div>
            </div>--%>
            <div class="form-group">
                <label for="input6" class="col-sm-4 control-label">大区</label>

                <div class="col-sm-8">
                    <select name="area" class="form-control" id="input6"
                            value="${stockFinancial.area}" <shiro:hasRole name="tourpm">disabled</shiro:hasRole>>
                        <option value="">请选择</option>
                        <option value="NASA">NASA</option>
                        <option value="AP">AP</option>
                        <option value="EMEA">EMEA</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="input10" class="col-md-4 control-label">开始时间</label>

                <div class="col-md-1"></div>
                <div class="input-group date form_date col-md-6" data-date="" data-date-format="dd MM yyyy"
                     data-link-field="input10" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="<fmt:formatDate value='${stockFinancial.createTime}' pattern='yyyy-MM-dd'/>" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="input10" name="createTime" value="<fmt:formatDate value='${stockFinancial.createTime}' pattern='yyyy-MM-dd'/>"/>
            </div>
            <div class="form-group">
                <label for="input11" class="col-md-4 control-label">结束时间</label>

                <div class="col-md-1"></div>
                <div class="input-group date form_date col-md-6" data-date="" data-date-format="dd MM yyyy"
                     data-link-field="input11" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text" value="<fmt:formatDate value='${stockFinancial.modifyTime}' pattern='yyyy-MM-dd'/>" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="input11" name="modifyTime" value="<fmt:formatDate value='${stockFinancial.modifyTime}' pattern='yyyy-MM-dd'/>"/>
            </div>

            <div class="form-group" style="text-align: right">
                <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
                &nbsp;&nbsp;
                <button id="stockFinancialSubmitButton" type="button" class="btn enter_press_search" style="width: 6em">查询</button>
                &nbsp;&nbsp;
                <button id="DownloadExcel" type="button" class="btn btn-primary">导出Excel</button>
                &nbsp;&nbsp;&nbsp;&nbsp;
            </div>
        </div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockKeepTable">
            <thead>
            <tr>
                <th>采购单号</th>
                <th>批次号</th>
                <th>产品 id</th>
                <th>产品名称</th>
                <th>SKU名称</th>
                <th>类型</th>
                <th>大区</th>
                <th>供应商名称</th>
                <th>库存数量</th>
                <th>出库数量</th>
                <th>退票</th>
                <th>当日余量</th>
                <th>单价(原币种)</th>
                <th>汇率</th>
                <th>货币</th>
                <th>CNY成本单价</th>
                <th>剩余库存总成本</th>
                <th>有效期</th>
                <th>日期</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr>
                    <td>
                            ${re.purchaseNo}
                    </td>
                    <td>
                            ${re.pid}
                    </td>
                    <td>
                            ${re.productId}
                    </td>
                    <td>
                            ${re.productName}
                    </td>
                    <td>
                            ${re.skuName}
                    </td>
                    <td>
                        <c:if test="${re.type==-1}">
                            -
                        </c:if>
                        <c:if test="${re.type==0}">
                            实体票
                        </c:if>
                        <c:if test="${re.type==1}">
                            电子票
                        </c:if>
                        <c:if test="${re.type==2}">
                            电子码
                        </c:if>
                        <c:if test="${re.type==3}">
                            二维码
                        </c:if>
                        <c:if test="${re.type==4}">
                            条形码
                        </c:if>
                        <%--<c:if test="${re.type==5}">--%>
                            <%--电子票&附件--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${re.type==6}">--%>
                            <%--电子码&附件--%>
                        <%--</c:if>--%>
                        <c:if test="${re.type==-2}">
                            海玩电子码
                        </c:if>
                    </td>
                    <td>
                            ${re.area}
                    </td>
                    <td>
                            ${re.supplierName}
                    </td>
                    <td>
                            ${re.totalNumber}
                    </td>
                    <td>
                            ${re.saleNumber}
                    </td>
                    <td>
                            ${re.refundNumber}
                    </td>
                    <td>
                            ${re.remainNumber}
                    </td>
                    <td>
                            ${re.realPrice}
                    </td>
                    <td>
                            ${re.exchangeRate}
                    </td>
                    <td>
                            ${re.currency}
                    </td>
                    <td>
                            ${re.cnyValue}
                    </td>
                    <td>
                            ${re.totalValue}
                    </td>
                    <td>
                        <fmt:formatDate value="${re.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${re.createTime}" pattern="yyyy-MM-dd"/>
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
<script type="text/javascript" src="/assets/scripts/Blob.js"></script>
<script type="text/javascript" src="/assets/scripts/FileSaver.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="text/javascript" src="/app/js/stockFinancial.js"></script>
</body>
</html>
