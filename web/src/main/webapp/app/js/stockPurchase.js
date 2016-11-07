$(function () {

    $(".active").removeClass("active");
    $("#stockIn").addClass("active");

    //表单清空
    $("#clearValue").click(function () {
        $("form input").each(function () {
            $(this).val("");
        });
        $("form select").each(function () {
            $(this).val("");
        });
    });

    $('.form_date').datetimepicker({
        weekStart: 1,
        format: 'yyyy-mm-dd',
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

    $('#applyPurchaseTempValidDate').datetimepicker({
        language: 'zh-CN',
        pickTime: false,
        todayBtn: true,
        autoclose: true,
        minView: '2',
        forceParse: false,
        format: "yyyy-mm-dd"
    });

    //DONE stock-sidebar
    $("div.stock-sidebar a").removeClass("active");
    $("div.stock-sidebar a[href='/page/stockPurchase']").addClass("active");

    $("select").each(function () {
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });

    $("#DownloadExcel").click(function () {
        var url = "/page/stockPurchase/exportSummary?";
        if ($("input[name='stockInfo.productId']").val() != undefined) {
            url += "&stockInfo.productId=" + $("input[name='stockInfo.productId']").val();
        }
        if ($("input[name='stockInfo.supplierName']").val() != undefined) {
            url += "&stockInfo.supplierName=" + $("input[name='stockInfo.supplierName']").val();
        }
        if ($("select[name='stockPurchase.status']").val() != undefined) {
            url += "&stockPurchase.status=" + $("select[name='stockPurchase.status']").val();
        }
        if ($("input[name='stockPurchase.createTime']").val() != undefined) {
            url += "&stockPurchase.createTime=" + $("input[name='stockPurchase.createTime']").val();
        }
        if ($("input[name='stockPurchase.modifyTime']").val() != undefined) {
            url += "&stockPurchase.modifyTime=" + $("input[name='stockPurchase.modifyTime']").val();
        }
        window.location.href = url;
    });

    $("#stockPurchaseSubmitButton").click(function () {
        var idDom = $("#input3");
        if (idDom.val() != "" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }
        //DONE
        $("#stockPurchaseSubmitForm").submit();
    });

    //申请延期
    $(".purchase-apply").click(function () {
        var theTr = $(this).parent().parent();
        var trMessage = theTr.find("td");

        $("#applyStockInfoId").val(theTr.attr("stockInfoId"));
        $("#applyPurchaseId").val(trMessage.get(1).innerHTML.trim());
        $("#applyPurchaseProductId").val(trMessage.get(2).innerHTML.trim());
        $("#applyPurchaseSkuName").val(trMessage.get(4).innerHTML.trim());
        $("#applyPurchaseTempDelayDate").val("");
        $("#applyPurchaseTempValidDate").val("");
        $("#applyPurchaseDelayNote").val("");
        $("#delayApplyPurchaseModal").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    //DONE 提交申请延期
    $("#submitDelayApplyPurchase").click(function () {
        var tempDelayDate = $("#applyPurchaseTempDelayDate");
        if (!isInteger(tempDelayDate.val())) {
            tempDelayDate.tooltip('show');
            tempDelayDate.click(function () {
                tempDelayDate.tooltip('hide');
            });
            return;
        }
        var tempValidDate = $("#applyPurchaseTempValidDate");
        if (tempValidDate.val() == "") {
            tempValidDate.tooltip('show');
            tempValidDate.click(function () {
                tempValidDate.tooltip('hide');
            });
            return;
        }
        var delayNote = $("#applyPurchaseDelayNote");
        if (delayNote.val() == "") {
            delayNote.tooltip('show');
            delayNote.click(function () {
                delayNote.tooltip('hide');
            });
            return;
        }

        var stockPurchaseId = $("#applyPurchaseId").val();
        $.ajax({
            type: 'post',
            url: '/page/stockPurchase/applyDelay',
            data: {
                id: stockPurchaseId,
                stockInfoId: $("#applyStockInfoId").val(),
                tempDelayDate: tempDelayDate.val(),
                tempValidDate: tempValidDate.val(),
                delayNote: delayNote.val(),
                delayStatus:2
            },
            success: function (result) {
                if (result == 'SUCCESS') {
                    $("#stockPurchaseSubmitForm").submit();
                }
            }
        });
    });

    //DONE 取消到期提醒
    $("#submitDelayCancelPurchase").click(function () {
        confirm('确定取消该批次产品有效期提醒？',function(){
            var stockPurchaseId = $("#applyPurchaseId").val();
            $.ajax({
                type: 'post',
                url: '/page/stockPurchase/cancelDelay',
                data: {
                    id: stockPurchaseId,
                    stockInfoId: $("#applyStockInfoId").val(),
                    delayStatus:-1
                },
                success: function (result) {
                    if (result == 'SUCCESS') {
                        $("#stockPurchaseSubmitForm").submit();
                    }
                }
            });
        });
    });

    //审核延期
    $(".purchase-check").click(function () {
        var theTr = $(this).parent().parent();
        var trMessage = theTr.find("td");

        $("#checkStockInfoId").val(theTr.attr("stockInfoId"));
        $("#checkPurchaseId").val(trMessage.get(1).innerHTML.trim());
        $("#checkPurchaseProductId").val(trMessage.get(2).innerHTML.trim());
        $("#checkPurchaseSkuName").val(trMessage.get(4).innerHTML.trim());
        $("#checkPurchaseTempDelayDate").val(theTr.attr("tempDelayDate"));
        $("#checkPurchaseTempValidDate").val(theTr.attr("tempValidDate"));
        $("#checkPurchaseDelayNote").val(theTr.attr("delayNote"));

        $("#checkPurchaseDelayRejection").val("");
        $("#delayCheckPurchaseModal").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    //DONE 提交审核延期
    $("#submitDelayCheckPurchase").click(function () {
        var tempDelayDate = $("#checkPurchaseTempDelayDate");
        var tempValidDate = $("#checkPurchaseTempValidDate");
        var stockPurchaseId = $("#checkPurchaseId").val();
        $.ajax({
            type: 'post',
            url: '/page/stockPurchase/admitDelay',
            data: {
                id: stockPurchaseId,
                delayDate: tempDelayDate.val(),
                validDate: tempValidDate.val(),
                delayStatus:3
            },
            success: function (result) {
                if (result == 'SUCCESS') {
                    $("#stockPurchaseSubmitForm").submit();
                }
            }
        });
    });

    //DONE 驳回审核延期
    $("#submitDelayBackPurchase").click(function () {
        var tempDelayDate = $("#checkPurchaseTempDelayDate");
        var tempValidDate = $("#checkPurchaseTempValidDate");
        var delayNote = $("#checkPurchaseDelayNote");
        var delayRejection = $("#checkPurchaseDelayRejection");
        if (delayRejection.val() == "") {
            delayRejection.tooltip('show');
            delayRejection.click(function () {
                delayRejection.tooltip('hide');
            });
            return;
        }
        var stockPurchaseId = $("#checkPurchaseId").val();
        $.ajax({
            type: 'post',
            url: '/page/stockPurchase/rejectDelay',
            data: {
                id: stockPurchaseId,
                stockInfoId: $("#checkStockInfoId").val(),
                tempDelayDate: tempDelayDate.val(),
                tempValidDate: tempValidDate.val(),
                delayNote: delayNote.val(),
                delayRejection: delayRejection.val(),
                delayStatus:1
            },
            success: function (result) {
                if (result == 'SUCCESS') {
                    $("#stockPurchaseSubmitForm").submit();
                }
            }
        });
    });

    //DONE 设置实际单价、汇率-a 点击
    $(".editPurchase-a").click(function () {
        var theTr = $(this).parent().parent();
        var trMessage = theTr.find("td");

        $("#editPurchaseId").val(trMessage.get(1).innerHTML.trim());
        $("#editPurchaseProductId").val(trMessage.get(2).innerHTML.trim());
        $("#editPurchaseSkuName").val(trMessage.get(4).innerHTML.trim());
        $("#editPurchasePrice").val(trMessage.get(8).innerHTML.trim());
        $("#editPurchaseNumber").val(trMessage.get(9).innerHTML.trim());
        $("#editPurchaseRealPrice").val(trMessage.get(12).innerHTML.trim());
        $("#editPurchaseExchangeRate").val(trMessage.get(13).innerHTML.trim());
        $("#editPurchaseModal").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    //DONE 提交修改实际单价、汇率
    $("#submitEditPurchase").click(function () {
        var realPrice = $("#editPurchaseRealPrice");
        if (!isRightFloat(realPrice.val())) {
            realPrice.tooltip('show');
            realPrice.click(function () {
                realPrice.tooltip('hide');
            });
            return;
        }
        var exchangeRate = $("#editPurchaseExchangeRate");
        if (!isRightFloat(exchangeRate.val())) {
            exchangeRate.tooltip('show');
            exchangeRate.click(function () {
                exchangeRate.tooltip('hide');
            });
            return;
        }

        var stockPurchaseId = $("#editPurchaseId").val();
        $.ajax({
            type: 'post',
            url: '/page/stockPurchase/update',
            data: {
                id: stockPurchaseId,
                realPrice: realPrice.val(),
                exchangeRate: exchangeRate.val()
            },
            success: function (result) {
                if (result == 'SUCCESS') {
                    $("#stockPurchaseSubmitForm").submit();
                }
            }
        });
    });


    //TODO 紧急手动提醒
    $("a.urgentAlert").click(function () {
        var theTr = $(this).parent().parent();
        var stockPurchaseId = theTr.attr("stockPurchaseId");
        $.ajax({
            type: "POST",
            url: '/page/stockPurchase/remind/' + stockPurchaseId,
            success: function (result) {
                if (result == 'SUCCESS') {
                    alert("紧急手动提醒 成功");
                    //$("#stockPurchaseSubmitForm").submit();
                } else {
                    alert("紧急手动提醒 失败");
                }
            }
        });
    });
    //TODO 申请撤销
    $("a.toRevocation").click(function () {
        var theTr = $(this).parent().parent();
        var stockPurchaseId = theTr.attr("stockPurchaseId");
        $.ajax({
            type: "POST",
            url: '/page/stockPurchase/rollback/' + stockPurchaseId,
            success: function (result) {
                if (result == 'SUCCESS') {
                    alert("申请撤销 成功", function () {
                        window.location.reload();
                    });
                    //$("#stockPurchaseSubmitForm").submit();
                } else {
                    alert("申请撤销 失败");
                }
            }
        });
    });
    //TODO 分页按钮 点击
    $("#paginationUl a").click(function () {
        var pageNo = $(this).html();
        if (isNaN(pageNo)) {
            pageNo = $(this).attr('pageNo');
        }
        if ($("#stockPurchaseSubmitForm #hiddenPageNo").length > 0) {
            $("#stockPurchaseSubmitForm #hiddenPageNo").val(pageNo);
        } else {
            $("#stockPurchaseSubmitForm").append('<input name="pageNo" type="hidden" value="' + pageNo + '" id="hiddenPageNo"/>');
        }
        $("#stockPurchaseSubmitButton").click();
    });
});

function pageClick(pageNo) {
    window.location.href = "/page/stockPurchase?pageNo=" + pageNo;
};

//验证有两位小数的正实数
function isRightFloat(a) {
    return /^\d+(\.\d+)?$/.test(a);
}

//检查是否为正整数
function isInteger(a) {
    var reg = /^\d+$/
    return reg.test(a);
}
