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
    <link href="/app/css/stockKeep.css" rel="stylesheet" type="text/css"/>
    <title>库存统计</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="row clearfix">
    <div class="col-md-12 column">
        <ul class="breadcrumb" style="margin: 1em">
            <li>
                <a href="#">创建库存</a>
            </li>
            <li class="active">
                库存统计
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockKeepSubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockKeep/selectSummary">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-4 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">产品 id</label>
                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="productId" class="form-control" id="input3" value="${stockInfo.productId}" data-original-title="请输入一个正整数"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input2" class="col-sm-4 control-label">SKU名称</label>

                <div class="col-sm-8">
                    <input type="text" name="skuName" class="form-control" id="input2" value="${stockInfo.skuName}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input1" class="col-sm-4 control-label">供应商名称</label>

                <div class="col-sm-8">
                    <input type="text" name="supplierName" class="form-control" id="input1" value="${stockInfo.supplierName}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input5" class="col-sm-4 control-label">票的类型</label>
                <div class="col-sm-8">
                    <select name="type" class="form-control" id="input5" value="${stockKeep.type}">
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
                    <select name="country" class="form-control" id="input0" value="${stockInfo.country}" readonly onchange='$(this).val("")'>
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
                    <select name="area" class="form-control" id="input6" value="${stockInfo.area}" <shiro:hasRole name="tourpm">disabled</shiro:hasRole>>
                        <option value="">请选择</option>
                        <option value="NASA">NASA</option>
                        <option value="AP">AP</option>
                        <option value="EMEA">EMEA</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="input7" class="col-sm-4 control-label">状态</label>
                <div class="col-sm-8">
                    <select name="status" class="form-control" id="input7" value="${stockKeep.status}">
                        <option value="">请选择</option>
                        <option value="0">未入库</option>
                        <option value="1">已提交</option>
                        <option value="2">待入库</option>
                        <option value="3">未检查</option>
                        <option value="4">已入库</option>
                    </select>
                </div>
            </div>
            <div class="form-group" style="text-align: right">
                <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
                &nbsp;&nbsp;
                <button id="stockKeepSubmitButton" type="button" class="btn enter_press_search" style="width: 6em">查询</button>
            </div>
        </div>
        <div class="col-md-1 column"></div>
        <div class="col-md-1 column" style="padding-top: 12%;text-align: right;">
            <button id="DownloadExcel" type="button" class="btn btn-primary">导出Excel
            </button>
        </div>
        <div class="col-md-1 column"></div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockKeepTable">
            <thead>
            <tr>
                <th>产品 id</th>
                <th>产品名称</th>
                <th>SKU名称</th>
                <th>大区</th>
                <th>供应商名称</th>
                <th>类型</th>
                <th>状态</th>
                <th>当前余量</th>
                <th>当天销量</th>
                <th>当天退量</th>
                <th>昨天销量</th>
                <th>昨天退量</th>
                <th>历史销量</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr skuId="${re.stockInfo.skuId}" stockInfoId="${re.stockInfo.id}" stockKeepId="${re.stockKeep.id}">
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
                            ${re.stockInfo.area}
                    </td>
                    <td>
                            ${re.stockInfo.supplierName}
                    </td>
                    <td>
                        <c:if test="${re.stockKeep.type==-1}">
                            -
                        </c:if>
                        <c:if test="${re.stockKeep.type==0}">
                            实体票
                        </c:if>
                        <c:if test="${re.stockKeep.type==1}">
                            电子票
                        </c:if>
                        <c:if test="${re.stockKeep.type==2}">
                            电子码
                        </c:if>
                        <c:if test="${re.stockKeep.type==3}">
                            二维码
                        </c:if>
                        <c:if test="${re.stockKeep.type==4}">
                            条形码
                        </c:if>
                        <%--<c:if test="${re.stockKeep.type==5}">--%>
                            <%--电子票&附件--%>
                        <%--</c:if>--%>
                        <%--<c:if test="${re.stockKeep.type==6}">--%>
                            <%--电子码&附件--%>
                        <%--</c:if>--%>
                        <c:if test="${re.stockKeep.type==-2}">
                            海玩电子码
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${re.stockKeep.status==0}">
                            未入库
                        </c:if>
                        <c:if test="${re.stockKeep.status==1}">
                            已提交
                        </c:if>
                        <c:if test="${re.stockKeep.status==2}">
                            待入库
                        </c:if>
                        <c:if test="${re.stockKeep.status==3}">
                            未检查
                        </c:if>
                        <c:if test="${re.stockKeep.status==4}">
                            已入库
                        </c:if>
                    </td>
                    <td>
                            ${re.stockKeep.totalNumber + re.stockKeep.number}
                    </td>
                    <td>
                            ${re.todaySale}
                    </td>
                    <td>
                            ${re.todayRefund}
                    </td>
                    <td>
                            ${re.yesterdaySale}
                    </td>
                    <td>
                            ${re.yesterdayRefund}
                    </td>
                    <td>
                            ${re.historySale-re.historyRefund}
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
<script type="text/javascript" src="/app/js/stockKeep.js"></script>
</body>
</html>
