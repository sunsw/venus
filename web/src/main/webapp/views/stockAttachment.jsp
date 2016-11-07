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
    <link href="/app/css/authUserList.css" rel="stylesheet" type="text/css"/>
    <title>附件管理</title>
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
                附件管理
            </li>
        </ul>
    </div>
</div>
<div class="row clearfix">
    <form id="queryForm" class="form-horizontal" role="form" method="GET" action="/page/stockAttachment">
        <div class="col-md-1 column">
        </div>
        <div class="col-md-4 column">
            <div class="form-group">
                <label for="input3" class="col-sm-4 control-label">产品 id</label>

                <div class="col-sm-8">
                    <input maxlength="9" type="text" name="productId" class="form-control" id="input3" data-original-title="请输入一个正整数"
                           value="${stockInfo.productId}"/>
                </div>
            </div>
        </div>
        <div class="col-md-4 column">
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
            <div class="form-group" style="text-align: right">
                <button id="addModel" type="button" class="btn" style="width: 6em">增加附件</button>
                &nbsp;&nbsp;
                <button id="clearValue" type="button" class="btn" style="width: 6em">重置</button>
                &nbsp;&nbsp;
                <button id="submitButton" type="button" class="btn btn-primary enter_press_search" style="width: 6em">查询</button>
            </div>
        </div>
    </form>
</div>
<div class="row clearfix">
    <div class="col-md-12 column">
        <table class="table table-striped table-hover table-condensed" id="stockInfoTable">
            <thead>
            <tr>
                <th>产品 id</th>
                <th>产品名称</th>
                <th>大区</th>
                <th>附件名称</th>
                <th>类型</th>
                <th>有效期</th>
                <th>大小(KB)</th>
                <th>数量</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${result.result}" var="re">
                <tr stockInfoId="${re.stockInfoId}" id="${re.id}" type="${re.type}" number="${re.ext3}">
                    <td>
                            ${re.productId}
                    </td>
                    <td>
                            ${re.ext0}
                    </td>
                    <td>
                            ${re.ext1}
                    </td>
                    <td>
                            ${re.productName}
                    </td>
                    <td>
                        <c:if test="${re.type==1}">
                            通用型
                        </c:if>
                        <c:if test="${re.type==2}">
                            每单一份
                        </c:if>
                        <c:if test="${re.type==3}">
                            每人一份
                        </c:if>
                    </td>
                    <td>
                        <fmt:formatDate value="${re.validDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                            ${re.size}
                    </td>
                    <td>
                            ${re.ext3}
                    </td>
                    <td>
                        <a href="javascript:confirmImp(${re.id})">导入</a>&nbsp;&nbsp;
                        <a href="javascript:confirmExp(${re.id})">导出</a>&nbsp;&nbsp;
                        <a href="javascript:edit(${re.id})">编辑</a>&nbsp;&nbsp;
                        <a href="javascript:del(${re.id})">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <jsp:include page="common/pagination.jsp"></jsp:include>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>

<div class="modal fade" id="modelWin" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
    <div class="modal-dialog" style="width: 28em">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="winTitle">
                    增加附件
                </h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix">
                    <div class="col-md-12 column">
                        <form role="form" id="winForm" class="form-horizontal" enctype="multipart/form-data" method="POST" action="/page/stockAttachment/add">
                            <input type="hidden" name="id" id="id"/>
                            <input type="hidden" name="flag" id="flag"/>
                            <input type="hidden" name="stockInfoId" id="stockInfoId"/>

                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="productId">产品ID *</label>

                                <div class="col-sm-8"><input type="text" class="form-control" name="productId" required id="productId" data-original-title="产品ID不存在"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="productName">附件名称 *</label>

                                <div class="col-sm-8"><input type="text" class="form-control" name="productName" required id="productName"/></div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" for="type">类型 *</label>

                                <div class="col-sm-8">
                                    <select class="form-control" id="type" name="type" readonly>
                                        <option id="topt" value="1" selected>通用型</option>
                                        <option value="2">每单一份</option>
                                        <option value="3">每人一份</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="validDate" class="col-md-4 control-label">有效期 *</label>

                                <div class="input-group date form_date col-md-7" style="padding-left: 15px;" data-date="" data-date-format="dd MM yyyy" data-link-field="input15" data-link-format="yyyy-mm-dd">
                                    <input class="form-control" size="16" type="text" id="validDate" name="validDate" readonly/>
                                    <span class="input-group-addon" id="sp1"><span class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon" id="sp2"><span class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                            </div>
                            <div class="form-group" id="ticketInputFilesFormGroup">
                                <label class="col-sm-4 control-label" for="ticketInputFiles">上传文件</label>

                                <div class="col-sm-8"><input type="file" multiple id="ticketInputFiles"/></div>
                            </div>
                            <div class="form-group" id="whenUploadShow" style="display: none;">
                                <div id="progressSpans">
                                    <br/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文件名：<span></span><br/>
                                    &nbsp;&nbsp;&nbsp;文件大小：<span></span><br/>
                                    &nbsp;&nbsp;&nbsp;文件类型：<span></span><br/>

                                    <div style="text-align: right; padding-right: 10px;"></div>
                                    <div style="text-align: right; padding-right: 10px;"></div>
                                </div>
                                <div class="progress">
                                    <div id="progressBar" class="my-progress-bar" style="width: 0"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="winSubmit" type="button" class="btn btn-primary">确认</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/assets/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/scripts/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/assets/scripts/jquery.media.js"></script>
<script type="text/javascript" src="/assets/scripts/Blob.js"></script>
<script type="text/javascript" src="/assets/scripts/FileSaver.js"></script>
<script type="text/javascript" src="/app/js/common.js"></script>
<script type="text/javascript" src="/app/js/stockAttachment.js"></script>
</body>
</html>
