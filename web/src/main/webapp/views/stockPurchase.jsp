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
    <link href="/app/css/stockPurchase.css" rel="stylesheet" type="text/css"/>
    <title>采购记录</title>
</head>
<body>
<jsp:include page="common/header.jsp"/>
<div class="row clearfix">
    <div class="col-md-12 column">
        <ul class="breadcrumb" style="margin: 1em">
            <li>
                <a href="#">商品入库</a>
            </li>
            <li class="active">
                采购记录
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockPurchaseSubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockPurchase">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-4 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">产品 id</label>

                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="stockInfo.productId" class="form-control" id="input3"
                           value="${stockPurchaseInfo.stockInfo.productId}" data-original-title="请输入一个正整数"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input1" class="col-sm-4 control-label">供应商名称</label>

                <div class="col-sm-8">
                    <input type="text" name="stockInfo.supplierName" class="form-control" id="input1"
                           value="${stockPurchaseInfo.stockInfo.supplierName}"/>
                </div>
            </div>
            <div class="form-group">
                <label for="input7" class="col-sm-4 control-label">采购状态</label>

                <div class="col-sm-8">
                    <select name="stockPurchase.status" class="form-control" id="input7"
                            value="${stockPurchaseInfo.stockPurchase.status}">
                        <option value="">请选择</option>
                        <option value="0">已提交</option>
                        <option value="1">已通过</option>
                        <option value="2">未通过</option>
                        <option value="3">申请撤销</option>
                        <option value="4">已撤销</option>
                        <option value="5">正在上传</option>
                        <option value="6">上传完成/未检查</option>
                        <option value="7">已入库</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="input8" class="col-sm-4 control-label">延期状态</label>

                <div class="col-sm-8">
                    <select name="stockPurchase.delayStatus" class="form-control" id="input8"
                            value="${stockPurchaseInfo.stockPurchase.delayStatus}">
                        <option value="">请选择</option>
                        <option value="0">正常</option>
                        <option value="1">快过期</option>
                        <option value="2">待延期</option>
                        <option value="3">已延期</option>
                        <option value="-1">取消提醒</option>
                        <option value="-2">已售完</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-4 column">
            <div class="form-group">
                <label for="input5" class="col-md-4 control-label">开始日期</label>

                <div class="input-group date form_date col-md-8" data-date="" data-date-format="dd MM yyyy"
                     data-link-field="input5" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text"
                           value="<fmt:formatDate value="${stockPurchaseInfo.stockPurchase.createTime}" pattern="yyyy-MM-dd"/>"
                           readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="input5" name="stockPurchase.createTime"
                       value="<fmt:formatDate value="${stockPurchaseInfo.stockPurchase.createTime}" pattern="yyyy-MM-dd"/>"/>
            </div>
            <div class="form-group">
                <label for="input15" class="col-md-4 control-label">结束日期</label>

                <div class="input-group date form_date col-md-8" data-date="" data-date-format="dd MM yyyy"
                     data-link-field="input15" data-link-format="yyyy-mm-dd">
                    <input class="form-control" size="16" type="text"
                           value="<fmt:formatDate value="${stockPurchaseInfo.stockPurchase.modifyTime}" pattern="yyyy-MM-dd"/>"
                           readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <input type="hidden" id="input15" name="stockPurchase.modifyTime"
                       value="<fmt:formatDate value="${stockPurchaseInfo.stockPurchase.modifyTime}" pattern="yyyy-MM-dd"/>"/>
            </div>

            <div class="form-group" style="text-align: right">
                <button id="clearValue" type="button" class="btn" style="width: 6em;">重置</button>
                &nbsp;&nbsp;
                <button id="stockPurchaseSubmitButton" type="button" class="btn btn-primary enter_press_search" style="width: 6em;">查询
                </button>
                <shiro:hasRole name="stockmanager">
                    &nbsp;&nbsp;
                    <button id="DownloadExcel" type="button" class="btn btn-primary" style="width: 6em">
                        导出Excel
                    </button>
                </shiro:hasRole>
            </div>
        </div>
        <!--div class="col-md-3 column" style="padding-top: 12%;text-align: right;">
            <shiro:hasRole name="tourpm">
                <button id="applicationForPurchaseButton" type="button" class="btn btn-primary">申请采购
                </button>
            </shiro:hasRole>
        </div-->
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockPurchaseTable">
            <thead>
            <tr>
                <th>采购单号</th>
                <th>批次号</th>
                <th>产品 id</th>
                <th>产品名称</th>
                <th>SKU名称</th>
                <th>大区</th>
                <th>供应商名称</th>
                <th>货币</th>
                <th>单价</th>
                <th>补货数量</th>
                <th>补货总额(元)</th>
                <th>预期毛利率(%)</th>
                <th>单价(原币种)</th>
                <th>汇率</th>
                <th>申请日期</th>
                <th>最后付款日</th>
                <th>审核状态</th>
                <th>有效期</th>
                <th>延期状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr skuId="${re.stockInfo.skuId}" stockPurchaseId="${re.stockPurchase.id}" stockInfoId="${re.stockInfo.id}"
                        tempValidDate="<fmt:formatDate value='${re.stockPurchase.tempValidDate}' pattern='yyyy-MM-dd'/>" tempDelayDate="${re.stockPurchase.tempDelayDate}" delayNote="${re.stockPurchase.delayNote}">
                    <td>
                            ${re.stockPurchase.purchaseNo}
                    </td>
                    <td>
                            ${re.stockPurchase.id}
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
                            ${re.stockInfo.area}
                    </td>
                    <td>
                            ${re.stockInfo.supplierName}
                    </td>
                    <td>
                            ${re.stockPurchase.currency}
                            <%--货币--%>
                    </td>
                    <td>
                            ${re.stockPurchase.price}
                            <%--单价--%>
                    </td>
                    <td>
                            ${re.stockPurchase.number}
                            <%--补货数量--%>
                    </td>
                    <td>
                            ${re.stockPurchase.price * re.stockPurchase.number}
                            <%--补货金额--%>
                    </td>
                    <td>
                            ${re.stockPurchase.rate}
                    </td>
                    <td>
                            ${re.stockPurchase.realPrice}
                            <%--单价(原币种)--%>
                    </td>
                    <td>
                            ${re.stockPurchase.exchangeRate}
                            <%--汇率--%>
                    </td>
                    <td>
                        <fmt:formatDate value="${re.stockPurchase.createTime}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                            <%--最后付款日--%>
                        <fmt:formatDate value="${re.stockPurchase.payDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <c:if test="${re.stockPurchase.status==0}">
                            已提交
                        </c:if>
                        <c:if test="${re.stockPurchase.status==1}">
                            已通过
                        </c:if>
                        <c:if test="${re.stockPurchase.status==2}">
                            未通过
                        </c:if>
                        <c:if test="${re.stockPurchase.status==3}">
                            申请撤销
                        </c:if>
                        <c:if test="${re.stockPurchase.status==4}">
                            已撤销
                        </c:if>
                        <c:if test="${re.stockPurchase.status==5}">
                            正在上传
                        </c:if>
                        <c:if test="${re.stockPurchase.status==6}">
                            上传完成/未检查
                        </c:if>
                        <c:if test="${re.stockPurchase.status==7}">
                            已入库
                        </c:if>
                            <%--审核状态--%>
                    </td>
                    <td>
                        <fmt:formatDate value="${re.stockPurchase.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <c:if test="${re.stockPurchase.delayStatus==0}">
                            正常
                        </c:if>
                        <c:if test="${re.stockPurchase.delayStatus==1}">
                            快过期
                        </c:if>
                        <c:if test="${re.stockPurchase.delayStatus==2}">
                            待延期
                        </c:if>
                        <c:if test="${re.stockPurchase.delayStatus==3}">
                            已延期
                        </c:if>
                        <c:if test="${re.stockPurchase.delayStatus==-1}">
                            取消提醒
                        </c:if>
                        <c:if test="${re.stockPurchase.delayStatus==-2}">
                            已售完
                        </c:if>
                    </td>
                    <td>
                        <shiro:hasRole name="tourpm">
                            <c:if test="${re.stockPurchase.status == 0}">
                                <a href="#" class="urgentAlert">紧急手动提醒</a> / <a href="#" class="toRevocation">申请撤销</a>
                                <%--操作--%>
                            </c:if>
                            <c:if test="${re.stockPurchase.delayStatus == 1}">
                                <a href="#" class="purchase-apply"> 申请延期</a>
                            </c:if>
                        </shiro:hasRole>
                        <shiro:hasPermission name="purchase:edit">
                            <c:if test="${re.stockPurchase.delayStatus == 2}">
                                <a href="#" class="purchase-check"> 审核延期</a>
                            </c:if>
                            <a href="#" class="editPurchase-a"> 编辑</a>
                        </shiro:hasPermission>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <jsp:include page="common/pagination.jsp"></jsp:include>
    </div>
</div>

<div class="modal fade" id="delayApplyPurchaseModal" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    申请延期
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <input type="hidden" class="form-control" id="applyStockInfoId"/>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="applyPurchaseId">批次号</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="applyPurchaseId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="applyPurchaseProductId">产品Id</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="applyPurchaseProductId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="applyPurchaseSkuName">Sku名称</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="applyPurchaseSkuName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="applyPurchaseTempDelayDate">预警天数</label>

                                <div class="col-sm-8"><input type="text" class="form-control" id="applyPurchaseTempDelayDate" data-original-title="请输入一个正整数"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="applyPurchaseTempValidDate">有效期</label>

                                <div class="col-sm-8"><span style="position: relative; z-index: 9999;"><input
                                        type="text" class="form-control" id="applyPurchaseTempValidDate" data-original-title="请输入有效期"
                                        name="validDate"/></span></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="applyPurchaseDelayNote">延期原因</label>

                                <div class="col-sm-8">
                                    <textarea rows="3" style="width: 16em;" id="applyPurchaseDelayNote" data-original-title="请输入延期原因"></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitDelayApplyPurchase" type="button" class="btn btn-primary"> 确认</button>
                <button id="submitDelayCancelPurchase" type="button" class="btn btn-danger"> 取消提醒</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="delayCheckPurchaseModal" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    审核延期
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <input type="hidden" class="form-control" id="checkStockInfoId"/>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseId">批次号</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="checkPurchaseId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseProductId">产品Id</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="checkPurchaseProductId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseSkuName">Sku名称</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="checkPurchaseSkuName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseTempDelayDate">预警天数</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="checkPurchaseTempDelayDate" data-original-title="请输入一个正整数"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseTempValidDate">有效期</label>

                                <div class="col-sm-8"><span style="position: relative; z-index: 9999;"><input
                                        type="text" readonly class="form-control" id="checkPurchaseTempValidDate" data-original-title="请输入有效期"
                                        name="validDate"/></span></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseDelayNote">延期原因</label>

                                <div class="col-sm-8">
                                    <textarea rows="3" readonly style="width: 16em;" id="checkPurchaseDelayNote" data-original-title="请输入延期原因"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="checkPurchaseDelayRejection">驳回原因</label>

                                <div class="col-sm-8">
                                    <textarea rows="3" style="width: 16em;" id="checkPurchaseDelayRejection" data-original-title="请输入驳回原因"></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitDelayCheckPurchase" type="button" class="btn btn-primary"> 确认</button>
                <button id="submitDelayBackPurchase" type="button" class="btn btn-danger"> 驳回</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editPurchaseModal" role="dialog" aria-labelledby="myModalLabel5"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    编辑采购记录
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchaseId">批次号</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="editPurchaseId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchaseProductId">产品Id</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="editPurchaseProductId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchaseSkuName">Sku名称</label>

                                <div class="col-sm-8"><input type="text" readonly class="form-control" id="editPurchaseSkuName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchasePrice">单价</label>

                                <div class="col-sm-8"><input type="text" class="form-control" id="editPurchasePrice" readonly/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchaseNumber">补货数量</label>

                                <div class="col-sm-8"><input type="text" class="form-control" id="editPurchaseNumber" readonly/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchaseRealPrice">单价(原币种)</label>

                                <div class="col-sm-8"><input type="text" class="form-control" id="editPurchaseRealPrice" data-original-title="请输入一个正数"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="editPurchaseExchangeRate">汇率</label>

                                <div class="col-sm-8"><input type="text" class="form-control" id="editPurchaseExchangeRate" data-original-title="请输入一个正数"/></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitEditPurchase" type="button" class="btn btn-primary"> 确认</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/assets/scripts/jquery.media.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="text/javascript" src="/app/js/stockPurchase.js"></script>
</body>
</html>
