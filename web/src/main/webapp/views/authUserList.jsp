<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>用户管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="/app/css/authUserList.css"/>
</head>
<body>

<ul class="breadcrumb" style="margin: 1em">
    <li>
        <a href="#">系统管理</a>
    </li>
    <li class="active">
        用户管理
    </li>
</ul>

<form id="queryForm" class="form-horizontal" role="form" method="post" action="/page/user/list">
    <div class="col-md-10 col-md-offset-1">
        <div class="form-group">
            <label for="skuName" class="col-md-2 control-label">用户名</label>
            <div class="col-md-4">
                <input type="text" id="skuName" name="skuName" class="form-control" value="${authUser.username}"/>
            </div>
            <label for="phone" class="col-md-2 control-label">电话</label>
            <div class="col-md-4">
                <input type="text" id="phone" name="phone" class="form-control"
                       value="${authUser.phone}"/>
            </div>
        </div>
        <div class="form-group">
            <label for="email" class="col-md-2 control-label">邮箱</label>

            <div class="col-md-4">
                <input type="text" id="email" name="email" class="form-control"
                       value="${authUser.email}"/>
            </div>
            <label for="status" class="col-md-2 control-label">状态</label>

            <div class="col-md-4">
                <select id="status" name="area" class="form-control" value="${authUser.status}">
                    <option value="">请选择</option>
                    <option value="Y">启用</option>
                    <option value="N">禁用</option>
                </select>
            </div>
        </div>
        <div class="form-group col-md-12 pull-right">
            <div class="btn-group pull-right">
                <button type="button" class="btn btn-default" onclick="query()">
                    <span class="glyphicon glyphicon-search"></span>
                </button>
                <button type="button" class="btn btn-default" onclick="add()">
                    <span class="glyphicon glyphicon-plus"></span>
                </button>
                <button type="button" class="btn btn-default" onclick="edit()">
                    <span class="glyphicon glyphicon-pencil"></span>
                </button>
                <button type="button" class="btn btn-default" onclick="del()">
                    <span class="glyphicon glyphicon-minus"></span>
                </button>
            </div>
        </div>
    </div>
</form>

<div class="col-md-12 column">
    <table class="table table-striped table-hover table-condensed" id="stockInfoTable">
        <thead>
        <tr>
            <th>选择</th>
            <th>序号</th>
            <th>用户名</th>
            <th>组织</th>
            <th>电话</th>
            <th>邮箱</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="item" varStatus="status">
            <tr value="${item}">
                <td>
                    <input type="checkbox"/>
                </td>
                <td>
                    ${pageInfo.startRow + status.index}
                </td>
                <td>
                        ${item.username}
                </td>
                <td>
                        ${item.organizationId}
                </td>
                <td>
                        ${item.phone}
                </td>
                <td>
                        ${item.email}
                </td>
                <td>
                    opt
                </td>
                    <%--<td>--%>
                    <%--<fmt:formatDate value="${re.stockKeep.validDate}" pattern="yyyy-MM-dd"/>--%>
                    <%--</td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <jsp:include page="common/pagination.jsp"></jsp:include>
</div>

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
                                <label class="col-md-2 control-label" for="exampleInputProductName">产品名称</label>

                                <div class="col-md-10"><input type="text" readonly class="form-control"
                                                              id="exampleInputProductName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="exampleInputProductId">产品Id</label>

                                <div class="col-md-10"><input type="text" readonly class="form-control"
                                                              id="exampleInputProductId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="exampleInputSkuName">Sku名称</label>

                                <div class="col-md-10"><input type="text" readonly class="form-control"
                                                              id="exampleInputSkuName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="exampleInputTicketType">票的类型</label>

                                <div class="col-md-10">
                                    <select class="form-control" id="exampleInputTicketType" name="type"
                                            data-original-title="请选择类型">
                                        <option value="">请选择</option>
                                        <option value="0">实体票</option>
                                        <option value="1">电子票</option>
                                        <option value="2">电子码</option>
                                        <%--<option value="5">电子票&附件</option>--%>
                                        <%--<option value="6">电子码&附件</option>--%>
                                        <option value="-2">海玩电子码</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="exampleInputNumber">入库数量</label>

                                <div class="col-md-10"><input type="text" class="form-control" id="exampleInputNumber"
                                                              readonly
                                                              name="number"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="realPrice">单价(原币种)</label>

                                <div class="col-md-10"><input type="text" class="form-control" id="realPrice"
                                                              name="realPrice"
                                                              data-original-title="请输入正数实际单价"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="exchangeRate">汇率</label>

                                <div class="col-md-10"><input type="text" class="form-control" id="exchangeRate"
                                                              name="exchangeRate"
                                                              data-original-title="请输入正数汇率"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label" for="exampleInputPeriod">有效期</label>

                                <div class="col-md-10"><span style="position: relative; z-index: 9999;"><input
                                        type="text" class="form-control" id="exampleInputPeriod"
                                        data-original-title="请输入有效期"
                                        name="validDate"/></span></div>
                            </div>
                            <div class="form-group" id="ticketInputFilesFormGroup">
                                <label class="col-md-2 control-label" for="ticketInputFiles">上传文件</label>

                                <div class="col-md-10"><input type="file" multiple id="ticketInputFiles"/></div>
                            </div>
                            <div class="form-group" id="whenUploadShow" style="display: none;">
                                <div id="progressSpans">
                                    <br/>
                                    &nbsp;&nbsp;&nbsp;文件名：<span></span><br/>
                                    文件大小：<span></span><br/>
                                    文件类型：<span></span><br/>

                                    <div style="text-align: right"></div>
                                    <div style="text-align: right"></div>
                                </div>
                                <div class="progress">
                                    <div id="progressBar" class="my-progress-bar" style="width: 0"></div>
                                </div>
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

<div class="modal fade" id="editEntityModal" role="dialog" aria-labelledby="myModalLabel5"
     aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">
                    编辑库存
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" class="form-horizontal">
                            <input type="hidden" id="editEntityStockKeepId">
                            <input type="hidden" id="editEntityStockInfoId">

                            <div class="form-group">
                                <label class="col-md-4 control-label" for="editEntityProductId">产品Id</label>

                                <div class="col-md-8"><input type="text" readonly class="form-control"
                                                             id="editEntityProductId"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="editEntitySkuName">Sku名称</label>

                                <div class="col-md-8"><input type="text" readonly class="form-control"
                                                             id="editEntitySkuName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="editEntityNumber">库存数量</label>

                                <div class="col-md-8"><input type="text" class="form-control" id="editEntityNumber"
                                                             data-original-title="请输入一个正整数"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="editEntityOnlineNumber">在架数量</label>

                                <div class="col-md-8"><input type="text" class="form-control"
                                                             id="editEntityOnlineNumber" readonly/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="editEntityOnlineStockNumber">在架阈值</label>

                                <div class="col-md-8"> 低于：<input type="text" class="form-control"
                                                                 id="editEntityOnlineStockNumber" readonly/></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="submitEditEntity" type="button" class="btn btn-primary"> 确认</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/assets/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/app/js/pagination.js"></script>
<script>
    function query() {
        $("#queryForm").submit();
    }
</script>
</body>
</html>
