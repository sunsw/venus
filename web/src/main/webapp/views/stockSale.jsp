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
    <link href="/app/css/stockSale.css" rel="stylesheet" type="text/css"/>
    <title>库存出库</title>
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
                库存出库
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="stockSaleSubmitForm" class="form-horizontal" role="form" method="GET" action="/page/stockSale">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-3 column">
            <shiro:hasRole name="stockmanager">
                <div class="form-group">
                    <label for="createTimeId" class="col-md-4 control-label">开始日期</label>

                    <div class="input-group date form_date col-md-8" data-date="" data-date-format="dd MM yyyy"
                         data-link-field="createTimeId" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text"
                               value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.createTime}" pattern="yyyy-MM-dd"/>"
                               readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <input type="hidden" id="createTimeId" name="stockSale.createTime"
                           value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.createTime}" pattern="yyyy-MM-dd"/>"/>
                </div>
                <div class="form-group">
                    <label for="modifyTimeId" class="col-md-4 control-label">结束日期</label>

                    <div class="input-group date form_date col-md-8" data-date="" data-date-format="dd MM yyyy"
                         data-link-field="modifyTimeId" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text"
                               value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.modifyTime}" pattern="yyyy-MM-dd"/>"
                               readonly>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <input type="hidden" id="modifyTimeId" name="stockSale.modifyTime"
                           value="<fmt:formatDate value="${stockKeepSaleInfo.stockSale.modifyTime}" pattern="yyyy-MM-dd"/>"/>
                </div>
            </shiro:hasRole>
            <div class="form-group">
                <label for="input6" class="col-sm-4 control-label">产品 Id</label>

                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="stockInfo.productId" class="form-control" id="input6"
                           value="${stockKeepSaleInfo.stockInfo.productId}" data-original-title="请输入一个正整数"/>
                </div>
            </div>
        </div>
        <div class="col-md-3 column">
            <shiro:hasRole name="stockmanager">
                <div class="form-group">
                    <label for="input3" class="col-sm-4 control-label">渠道</label>

                    <div class="col-sm-8">
                        <select name="stockSale.channel" class="form-control" id="input3"
                                value="${stockKeepSaleInfo.stockSale.channel}">
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
                    <label for="input10" class="col-sm-4 control-label">产品名称</label>

                    <div class="col-sm-8">
                        <input type="text" name="stockInfo.productName" class="form-control" id="input10"
                               value="${stockKeepSaleInfo.stockInfo.productName}"/>
                    </div>
                </div>
            </shiro:hasRole>
            <div class="form-group">
                <label for="input8" class="col-sm-4 control-label">订单号</label>

                <div class="col-sm-8">
                    <input type="text" name="stockSale.orderId" class="form-control" id="input8"
                           value="${stockKeepSaleInfo.stockSale.orderId}"/>
                </div>
            </div>
        </div>
        <div class="col-md-3 column">
            <shiro:hasAnyRoles name="stockmanager,tourconsultant">
                <div class="form-group">
                    <label for="input5" class="col-sm-4 control-label">票的类型</label>

                    <div class="col-sm-8">
                        <select name="stockKeep.type" class="form-control" id="input5"
                                value="${stockKeepSaleInfo.stockKeep.type}">
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
            </shiro:hasAnyRoles>
            <div class="form-group">
                <label for="input0" class="col-sm-4 control-label">出库状态</label>

                <div class="col-sm-8">
                    <select name="stockSale.status" class="form-control" id="input0"
                            value="${stockKeepSaleInfo.stockSale.status}">
                        <option value="">请选择</option>
                        <option value="0">待出库</option>
                        <option value="1">已出库</option>
                        <option value="2">失败</option>
                    </select>
                </div>
            </div>
            <div class="form-group" align="right">
                <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
                &nbsp;&nbsp;
                <button id="stockSaleQueryButton" type="button" class="btn btn-primary enter_press_search"
                        style="width: 6em">查询
                </button>
                <shiro:hasRole name="stockmanager">
                    &nbsp;&nbsp;
                    <button id="DownloadExcel" type="button" class="btn btn-primary" style="width: 6em">
                        导出Excel
                    </button>
                </shiro:hasRole>
                <shiro:hasRole name="tourconsultant">
                    &nbsp;&nbsp;
                    <button id="applicationForGetTicketButton" type="button" class="btn btn-primary">申请领实体票</button>
                </shiro:hasRole>
            </div>
        </div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockInfoTable">
            <thead>
            <tr>
                <th>申请时间</th>
                <th>申请人</th>
                <th>渠道</th>
                <th>订单号</th>
                <th>产品名称</th>
                <th>SKU名称</th>
                <th>出库数量</th>
                <shiro:hasAnyRoles name="stockmanager,tourconsultant">
                    <th>票务类型</th>
                </shiro:hasAnyRoles>
                <shiro:hasRole name="tourconsultant">
                    <th>发货类型</th>
                </shiro:hasRole>
                <th>有效期</th>
                <th>出库状态</th>
                <shiro:hasAnyRoles name="stockmanager,tourconsultant">
                    <th>操作</th>
                    <th>操作人</th>
                    <th>操作时间</th>
                </shiro:hasAnyRoles>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr skuId="${re.stockInfo.skuId}" stockInfoId="${re.stockInfo.id}" stockKeepId="${re.stockKeep.id}"
                    stockSaleId="${re.stockSale.id}">
                    <td>
                        <fmt:formatDate value="${re.stockSale.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                            ${re.stockSale.ext0}
                    </td>
                    <td>
                        <c:if test="${re.stockSale.channel==1}">
                            网站
                        </c:if>
                        <c:if test="${re.stockSale.channel==2}">
                            Android
                        </c:if>
                        <c:if test="${re.stockSale.channel==3}">
                            IOS
                        </c:if>
                        <c:if test="${re.stockSale.channel==4}">
                            WAP
                        </c:if>
                        <c:if test="${re.stockSale.channel==5}">
                            去哪儿网
                        </c:if>
                        <c:if test="${re.stockSale.channel==6}">
                            去哪儿度假
                        </c:if>
                        <c:if test="${re.stockSale.channel==7}">
                            京东
                        </c:if>
                        <c:if test="${re.stockSale.channel==8}">
                            拉手网
                        </c:if>
                        <c:if test="${re.stockSale.channel==9}">
                            青芒果
                        </c:if>
                        <c:if test="${re.stockSale.channel==10}">
                            穷游网
                        </c:if>
                        <c:if test="${re.stockSale.channel==11}">
                            新浪微博
                        </c:if>
                        <c:if test="${re.stockSale.channel==21}">
                            天猫API
                        </c:if>
                        <c:if test="${re.stockSale.channel==22}">
                            天猫
                        </c:if>
                        <c:if test="${re.stockSale.channel==25}">
                            去哪儿API
                        </c:if>
                        <c:if test="${re.stockSale.channel==99}">
                            小渠道
                        </c:if>
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
                    <shiro:hasAnyRoles name="stockmanager,tourconsultant">
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
                    </shiro:hasAnyRoles>
                    <shiro:hasRole name="tourconsultant">
                        <td>
                                <%--TODO 发货类型--%>
                            <c:if test="${re.stockSale.deliverType == 0}">
                                手动
                            </c:if>
                            <c:if test="${re.stockSale.deliverType == 1}">
                                自动
                            </c:if>
                        </td>
                    </shiro:hasRole>
                    <td>
                            <%--TODO 有效日期--%>
                        <fmt:formatDate value="${re.stockKeep.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                            <%--出库状态--%>
                        <c:if test="${re.stockSale.status==0}">
                            待出库
                        </c:if>
                        <c:if test="${re.stockSale.status==1}">
                            已出库
                        </c:if>
                        <c:if test="${re.stockSale.status==2}">
                            失败
                        </c:if>
                        <c:if test="${re.stockSale.status==3}">
                            已退回
                        </c:if>
                    </td>
                    <shiro:hasAnyRoles name="stockmanager,tourconsultant">
                        <td>
                                <%--TODO--%>
                            <shiro:hasRole name="stockmanager">
                                <c:if test="${re.stockSale.status==0}">
                                    <a href="#" class="stock-sale-opt">确认</a>
                                </c:if>
                                <c:if test="${re.stockSale.status==1}">
                                    已确认
                                </c:if>
                            </shiro:hasRole>
                        </td>
                        <td>
                                ${re.stockSale.ext1}
                        </td>
                        <td>
                            <fmt:formatDate value="${re.stockSale.optTime}" pattern="yyyy-MM-dd"/>
                        </td>
                    </shiro:hasAnyRoles>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <jsp:include page="common/pagination.jsp"></jsp:include>
    </div>
</div>
<div class="modal fade" id="applicationForGetTicketDiv" role="dialog" aria-labelledby="myModalLabel2"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 48em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel2">
                    申请领票-小渠道
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-1 column">
                    </div>
                    <div class="col-md-10 column">
                        <form role="form" class="form-horizontal" id="stockKeepOutForm">
                            <input type="hidden" id="exampleInputStockPurchaseId">

                            <div class="form-group">
                                <div class="col-sm-10">
                                    <label class="col-sm-2 control-label" for="exampleInputChannel">渠道</label>

                                    <div class="col-sm-10"><input type="text" class="form-control"
                                                                  id="exampleInputChannel" value="小渠道" readonly/></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputOrderId">订单号</label>

                                <div class="col-sm-10"><input type="text" name="orderId" class="form-control"
                                                              id="exampleInputOrderId" value=""/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputCount">领取数量</label>

                                <div class="col-sm-10"><input type="text" name="number" class="form-control"
                                                              id="exampleInputCount" data-original-title="请输入一个正整数"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-group">
                                    <input type="hidden" name="productId" id="productIdHidden"/>
                                    <label class="col-sm-2 control-label" for="exampleInputProductName">产品名称</label>

                                    <div class="col-sm-10">
                                        <select class="form-control" id="exampleInputProductName" name="skuId">
                                            <option value="">选择产品</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputExpCode">快递公司</label>

                                <div class="col-sm-10"><input type="text" name="expressCom" class="form-control"
                                                              id="exampleInputExpComp"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputExpCode">快递单号</label>

                                <div class="col-sm-10"><input type="text" name="expressId" class="form-control"
                                                              id="exampleInputExpCode"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="exampleInputRemarks">备注</label>

                                <div class="col-sm-10"><textarea class="form-control" id="exampleInputRemarks"
                                                                 name="note"></textarea></div>
                                <!-- TODO remark -->
                            </div>
                        </form>
                    </div>
                    <div class="col-md-1 column">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitStockKeepOut" type="button" class="btn btn-primary"> 提交</button>
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
<script type="text/javascript" src="/app/js/stockSale.js"></script>
</body>
</html>
