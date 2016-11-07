$(function () {

    $(".active").removeClass("active");
    $("#stockFinancial").addClass("active");

    //表单清空
    $("#clearValue").click(function () {
        $("form input").each(function () {
            $(this).val("");
        });
        $("form select").each(function () {
            $(this).val("");
        });
    });

    $("select").each(function () {
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });

    $("#stockFinancialSubmitButton").click(function () {
        var idDom = $("#input3");
        if (idDom.val() != "" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }
        $("#stockFinancialSubmitForm").submit();
    });

    var newDate = new Date(Date.now() - 24 * 60 * 60 * 1000);
    var nowFullYear = newDate.getFullYear();
    var nowMonth = newDate.getMonth() + 1;
    var nowDate = newDate.getDate();
    var datetimepickerStartDate = (nowMonth == 1 ? (nowFullYear - 1) : nowFullYear) + (nowMonth == 1 ? 12 : (nowMonth < 11 ? '-0' + (nowMonth - 1) : '-' + (nowMonth - 1))) + (nowDate < 10 ? '-0' + nowDate : '-' + nowDate);
    var datetimepickerEndDate = nowFullYear + (nowMonth < 10 ? '-0' + nowMonth : '-' + nowMonth) + (nowDate < 10 ? '-0' + nowDate : '-' + nowDate);
    $('.form_date').datetimepicker({
        weekStart: 1,
        format: 'yyyy-mm-dd',
        todayBtn: 1,
        autoclose: 1,
        startDate: datetimepickerStartDate,
        endDate: datetimepickerEndDate,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

    $("#DownloadExcel").click(function () {
        var url = "/page/stockFinancial/exportFinancial?";
        if ($("input[name='productId']").val() != undefined) {
            url += "&productId=" + $("input[name='productId']").val();
        }
        if ($("input[name='skuName']").val() != undefined) {
            url += "&skuName=" + $("input[name='skuName']").val();
        }
        if ($("input[name='supplierName']").val() != undefined) {
            url += "&supplierName=" + $("input[name='supplierName']").val();
        }
        if ($("select[name='type']").val() != undefined) {
            url += "&type=" + $("select[name='type']").val();
        }
        if ($("select[name='area']").val() != undefined) {
            url += "&area=" + $("select[name='area']").val();
        }
        window.location.href = url;
    });

    //TODO 分页按钮 点击
    $("#paginationUl a").click(function () {
        var pageNo = $(this).html();
        if (isNaN(pageNo)) {
            pageNo = $(this).attr('pageNo');
        }
        if ($("#stockFinancialSubmitForm #hiddenPageNo").length > 0) {
            $("#stockFinancialSubmitForm #hiddenPageNo").val(pageNo);
        } else {
            $("#stockFinancialSubmitForm").append('<input name="pageNo" type="hidden" value="' + pageNo + '" id="hiddenPageNo"/>');
        }
        $("#stockFinancialSubmitButton").click();
    });

});

function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "_";
    var seperator2 = ":";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
    //+ " " + date.getHours() + seperator2 + date.getMinutes()
    //+ seperator2 + date.getSeconds();
    return currentdate;
}

//检查是否为正整数
function isInteger(a) {
    var reg = /^\d+$/
    return reg.test(a);
}