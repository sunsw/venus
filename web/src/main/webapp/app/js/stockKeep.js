$(function(){

    $(".active").removeClass("active");
    $("#stockIn").addClass("active");

    //表单清空
    $("#clearValue").click(function() {
        $("form input").each(function() {
            $(this).val("");
        });
        $("form select").each(function() {
            $(this).val("");
        });
    });

    $("select").each(function(){
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });
    $("#stockKeepSubmitButton").click(function(){
        var idDom = $("#input3");
        if (idDom.val()!="" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }
        $("#stockKeepSubmitForm").submit();
    });
    $("#DownloadExcel").click(function(){
        var url = "/page/stockKeep/exportSummary?";
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
        if ($("select[name='status']").val() != undefined) {
            url += "&status=" + $("select[name='status']").val();
        }
        window.location.href=url;
    });

    //TODO 分页按钮 点击
    $("#paginationUl a").click(function(){
        var pageNo = $(this).html();
        if(isNaN(pageNo)){
            pageNo = $(this).attr('pageNo');
        }
        if($("#stockKeepSubmitForm #hiddenPageNo").length>0){
            $("#stockKeepSubmitForm #hiddenPageNo").val(pageNo);
        }else{
            $("#stockKeepSubmitForm").append('<input name="pageNo" type="hidden" value="'+pageNo+'" id="hiddenPageNo"/>');
        }
        $("#stockKeepSubmitButton").click();
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
    var reg =/^\d+$/
    return reg.test(a);
}