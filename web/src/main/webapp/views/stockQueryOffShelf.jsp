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
    <link href="/app/css/stockOffShelf.css" rel="stylesheet" type="text/css"/>
    <title>产品下架查询</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="row clearfix">
    <div class="col-md-12 column">
        <ul class="breadcrumb" style="margin: 1em">
            <li>
                <a href="#">库存监管</a>
            </li>
            <li class="active">
                产品下架查询
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockOffShelfSubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockOffShelf">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-4 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">产品 id</label>
                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="productId" class="form-control" id="input3" value="${stockInfo.productId}"/>
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
            <div class="form-group">
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
            </div>
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
                <button id="stockOffShelfSubmitButton" type="button" class="btn enter_press_search" style="width: 8em">查询</button>
            </div>
        </div>
        <div class="col-md-3 column" style="padding-top: 12%;text-align: right;">
            <shiro:hasRole name="tourpm">
                <button id="applicationForPurchaseButton" type="button" class="btn btn-primary">申请采购
                </button>
            </shiro:hasRole>
        </div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockOffShelfTable">
            <thead>
            <tr>
                <th>
                <shiro:hasRole name="tourpm">
                        批量选择
                </shiro:hasRole>
                </th>
                <th>产品 id</th>
                <th>产品名称</th>
                <th>SKU名称</th>
                <th>国家</th>
                <th>大区</th>
                <th>供应商名称</th>
                <th>有效期</th>
                <th>类型</th>
                <th>有效期</th>
                <th>入库日期</th>
                <th>剩余数量</th>
                <th>库存监控阈值</th>
                <shiro:hasRole name="tourconsultant">
                    <th>在架阈值</th>
                </shiro:hasRole>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result}" var="re">
                <tr skuId="${re.stockInfo.skuId}" stockInfoId="${re.stockInfo.id}" stockKeepId="${re.stockKeep.id}" stockPurchaseId="${re.stockPurchase.id}" stockPurchaseNumber="${re.stockPurchase.number}">
                    <td>
                    <shiro:hasRole name="tourpm">
                        <c:if test="${re.stockKeep.status==0 || re.stockKeep.status==3}">
                        <input class="applyRadio" type="radio"/>
                        </c:if>
                    </shiro:hasRole>
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
                            ${re.stockInfo.country}
                    </td>
                    <td>
                            ${re.stockInfo.area}
                    </td>
                    <td>
                            ${re.stockInfo.supplierName}
                    </td>
                    <td>
                        <fmt:formatDate value="${re.stockInfo.createTime}" pattern="yyyy-MM-dd"/>
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
                        <fmt:formatDate value="${re.stockKeep.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${re.stockKeep.entryDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                            ${re.stockKeep.number}
                    </td>
                    <td>
                            ${re.stockKeep.stockLimit}
                    </td>
                    <shiro:hasRole name="tourconsultant">
                        <td>
                            ${re.stockKeep.rackLimit}
                        </td>
                    </shiro:hasRole>
                    <td>
                        <%--<option value="0">未入库</option>--%>
                        <%--<option value="1">待入库</option>--%>
                        <%--<option value="2">未检查</option>--%>
                        <%--<option value="3">已入库</option>--%>
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
                    <c:if test="${re.stockKeep.status==3}">
                        <shiro:hasRole name="stockmanager">
                            <a class="storage-check-a" href="#">入库检查</a>
                        </shiro:hasRole>
                    </c:if>
                    <shiro:hasRole name="tourpm">
                        <a class="set-threshold-a" href="#">设置阈值</a>
                    </shiro:hasRole>
                    <shiro:hasRole name="tourconsultant">
                        <a class="set-online-threshold-a" href="#">设置在架阈值</a>
                    </shiro:hasRole>
                    <c:if test="${re.stockKeep.status==2}">
                        <shiro:hasRole name="stockmanager">
                            <a class="storage-a" href="#">入库</a>
                        </shiro:hasRole>
                    </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
<div class="modal fade" id="applicationForPurchaseDiv" role="dialog" aria-labelledby="myModalLabel1"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 86em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel1">
                    申请采购
                </h4>
            </div>
            <div class="modal-body">
                <div class="container">
                    <form method="post" id="addListForm" class="form-horizontal" action="/page/stockPurchase/addList">
                        <div class="row clearfix">
                            <div class="col-md-4 column">
                                <div class="form-group">
                                    <label for="applicant" class="col-sm-5 control-label">申请人</label>

                                    <div class="col-sm-7">
                                        <input type="text" class="form-control" id="applicant" name="applicant" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="申请人不能为空"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="col-sm-5 control-label">申请人邮箱</label>

                                    <div class="col-sm-7">
                                        <input type="text" class="form-control" id="email" name="email" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="申请人邮箱不能为空"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="currency" class="col-sm-5 control-label">货币</label>
                                    <div class="col-sm-7">
                                        <select class="form-control" id="currency" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="请选择货币类型">
                                            <option value="CNY">CNY</option>
                                            <option value="USD">USD</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 column">
                                <div class="form-group">
                                    <label for="area" class="col-sm-3 control-label">大区</label>

                                    <div class="col-sm-9">
                                        <select class="form-control" id="area" name="area" data-original-title="请选择大区类型" <shiro:hasRole name="tourpm">disabled</shiro:hasRole>>
                                            <option value="">请选择</option>
                                            <option value="NASA">NASA</option>
                                            <option value="AP">AP</option>
                                            <option value="EMEA">EMEA</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2 column">
                            </div>
                            <div class="col-md-3 column">
                                <input type="hidden" name="floating">
                                <input type="checkbox" id="floatingCheckbox"/>是否有Floating Deposit
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="col-md-12 column">
                                <table class="table table-condensed">
                                    <thead>
                                    <tr>
                                        <th>产品名称</th>
                                        <th>SKU名称</th>
                                        <th>国家</th>
                                        <th>大区</th>
                                        <th>供应商名称</th>
                                        <th>单价</th>
                                        <th>数量</th>
                                        <th>是否在预算范围内</th>
                                        <th>库存消化周期</th>
                                        <th>最后付款日</th>
                                        <th>预期毛利率</th>
                                        <th>金额</th>
                                    </tr>
                                    </thead>
                                    <tbody id="newModalTBody" data-original-title="请正确填写表单">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="applicationForPurchaseDivSubmit" type="button" class="btn btn-primary"> 提交申请</button>
            </div>
        </div>
    </div>
</div>
    <%--TODO--%>
<div class="modal fade" id="storageDiv" role="dialog" aria-labelledby="myModalLabel2"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 48em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel2">
                    入库
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-1 column">
                    </div>
                    <div class="col-md-10 column">
                        <form role="form" class="form-horizontal" id="storageInForm" enctype="multipart/form-data">
                            <input type="hidden" id="exampleInputStockPurchaseId">
                            <div class="form-group">
                                <input type="hidden" name="stockKeepId">
                                <input type="hidden" name="stockPurchaseId">
                                <label class="col-sm-2 control-label" for="exampleInputProductName">产品名称</label><div class="col-sm-10"><input type="text" readonly class="form-control" id="exampleInputProductName" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputProductId">产品Id</label><div class="col-sm-10"><input type="text" readonly class="form-control" id="exampleInputProductId" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputSkuName">Sku名称</label><div class="col-sm-10"><input type="text" readonly class="form-control" id="exampleInputSkuName" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputTicketType">票的类型</label>
                                <div class="col-sm-10">
                                    <select class="form-control" id="exampleInputTicketType" name="type" readonly>
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
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputNumber">入库数量</label><div class="col-sm-10"><input type="text" class="form-control" id="exampleInputNumber" name="number" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputPeriod">有效期</label><div class="col-sm-10"><span style="position: relative; z-index: 9999;"><input type="text" class="form-control" id="exampleInputPeriod" name="validDate" /></span></div>
                            </div>
                            <div class="form-group" id="ticketInputFilesFormGroup">
                                <label class="col-sm-2 control-label" for="ticketInputFiles">上传文件</label><div class="col-sm-10"><input type="file" multiple id="ticketInputFiles" /></div>
                                <p class="help-block">
                                    Example block-level help text here.
                                </p>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-1 column">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitStorageIn" type="button" class="btn btn-primary"> 提交申请</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="storageCheckDiv" role="dialog" aria-labelledby="myModalLabel3"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 86em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel3">
                    入库检查
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <div class="row clearfix">
                            <div class="col-md-1 column">
                            </div>
                            <div class="col-md-4 column">
                                <form role="form" class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label" for="checkInputProductId">产品Id</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="checkInputProductId" /></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label" for="checkInputSkuName">Sku名称</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="checkInputSkuName" /></div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label" for="checkInputSupplierName">供应商名称</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="checkInputSupplierName" /></div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-md-5 column">
                            </div>
                            <div class="col-md-2 column" style="padding-top: 12%;">
                                <button id="submitStorageCheckButton" type="button" class="btn btn-block btn-lg btn-primary">确认入库</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <table class="table table-condensed">
                            <thead>
                            <tr>
                                <th>产品 id</th>
                                <th>产品名称</th>
                                <th>SKU名称</th>
                                <th>库存未使用数量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td id="storageCheckFillProductId"></td>
                                <td id="storageCheckFillProductName"></td>
                                <td id="storageCheckFillSkuName"></td>
                                <td id="storageCheckFillCount"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form method="post" id="stockPurchaseToCheckedForm">
                            <input type="hidden" id="previewPurchaseId">
                        </form>
                        <iframe id="showPdfIFrame" src="" style="width:100%;height: 60%"></iframe>
                    </div>
                </div>
                <div class="row clearfix">
                    <div class="col-md-2 column">
                    </div>
                    <div class="col-md-2 column">
                        <button id="storageCheckShowPdfPrev" type="button" class="btn" style="width: 8em">上一张</button>
                    </div>
                    <div class="col-md-2 column">
                    </div>
                    <div class="col-md-2 column">
                        <button id="storageCheckShowPdfNext" type="button" class="btn" style="width: 8em">下一张</button>
                    </div>
                    <div class="col-md-4 column">
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitStorageCheck" type="button" class="btn btn-primary"> 确认入库 </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="setThresholdDiv" role="dialog" aria-labelledby="myModalLabel4"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel4">
                    设置阈值
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <input type="hidden" id="thresholdInputStockKeepId">
                            <input type="hidden" id="thresholdInputStockInfoId">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="thresholdInputProductId">产品Id</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="thresholdInputProductId" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="thresholdInputSkuName">Sku名称</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="thresholdInputSkuName" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="thresholdInputNumber">库存数量</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="thresholdInputNumber" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="thresholdInputAlert">库存紧张</label><div class="col-sm-8"> 低于：<input type="text" class="form-control" id="thresholdInputAlert" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="thresholdInputSoldOut">库存售罄</label><div class="col-sm-8"> 低于：<input type="text" class="form-control" readonly id="thresholdInputSoldOut" value="0" /></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitThreshold" type="button" class="btn btn-primary"> 确认 </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="setOnlineThresholdDiv" role="dialog" aria-labelledby="myModalLabel5"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel5">
                    设置在架阈值
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <input type="hidden" id="onlineThresholdInputStockKeepId">
                            <input type="hidden" id="onlineThresholdInputStockInfoId">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="onlineThresholdInputProductId">产品Id</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="onlineThresholdInputProductId" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="onlineThresholdInputSkuName">Sku名称</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="onlineThresholdInputSkuName" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="onlineThresholdInputNumber">库存数量</label><div class="col-sm-8"><input type="text" readonly class="form-control" id="onlineThresholdInputNumber" /></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="thresholdInputOnlineNumber">在架数量</label><div class="col-sm-8"> 低于：<input type="text" class="form-control" id="thresholdInputOnlineNumber" /></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitOnlineThreshold" type="button" class="btn btn-primary"> 确认 </button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/assets/scripts/jquery.media.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="text/javascript" src="/app/js/stockOffShelf.js"></script>
</body>
</html>
