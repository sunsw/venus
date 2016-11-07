$(function () {

    $(".active").removeClass("active");
    $("#stockRefund").addClass("active");

    //表单清空
    $("#clearValue").click(function() {
        $("form input").each(function() {
            $(this).val("");
        });
        $("form select").each(function() {
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

    $("select").each(function () {
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });
    $("#queryStockRefundButton").click(function () {
        var idDom = $("#input9");
        if (idDom.val()!="" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        //TODO
        $("#stockRefundSubmitForm").submit();
    });

    //TODO 退票 点击
    $("#applicationForRefundButton").click(function () {
        $("#submitRefund").removeAttr("disabled");
        $("#setRefundDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    $("#refundOrderId").blur(function () {
        var orderId = $("#refundOrderId").val();
        $.ajax({
            type: 'get',
            url: '/page/stockInfo/order',
            data: {
                orderId: orderId
            },
            success: function (result) {
                if (result.success == true) {
                    $("#refundSkuName").empty();
                    $("#refundSkuName").append("<option value=\"\">请选择sku<\/option>");
                    if (result.data.length == 0) {
                        alert("该订单号无关联的出票信息");
                        return;
                    }
                    for (var i = 0; i < result.data.length; ++i) {
                        $("#refundSkuName").append("<option value=\"" + result.data[i].skuId + "\">" + result.data[i].productName + "-" + result.data[i].skuName + "<\/option>");
                    }
                }
            }
        });
    });


    //TODO 提交退票
    $("#submitRefund").click(function () {
        var refundOrderId = $("#refundOrderId").val();
        var refundSkuName = $("#refundSkuName").val();
        var refundNumber = $("#refundNumber").val();

        if (refundOrderId == "" || refundSkuName == "" || refundNumber == "") {
            alert("请正确填写表单, "+(refundOrderId == ""?"订单号 ":" ")+(refundSkuName == ""?"Sku名称 ":" ")+(refundNumber == ""?"退票数量 ":" ")+" 不能为空！");
            return;
        }
        confirm('确定退票吗？ \n将不可撤销！',function(){
            $("#submitRefund").attr('disabled', 'disabled');
            $("#refundForm").submit();
        });
    });

    $("a.confirmRefund").click(function(){
        var theTr = $(this).parent().parent();
        var stockRefundId = theTr.attr("stockRefundId");
        console.log(stockRefundId);
        confirm('确定提交吗？ \n将不可撤销！',function(){
            $.ajax({
                type: "POST",
                url: '/page/stockRefund/allow',
                data: {
                    stockRefundId: stockRefundId
                },
                success:function(result){
                    if(result == 'SUCCESS'){
                        alert("退票确认 成功",function(){
                            window.location.reload();
                        });
                    }else{
                        alert("退票 失败");
                    }
                }
            });
        });
    });

    //TODO 分页按钮 点击
    $("#paginationUl a").click(function(){
        var pageNo = $(this).html();
        if(isNaN(pageNo)){
            pageNo = $(this).attr('pageNo');
        }
        if($("#stockRefundSubmitForm #hiddenPageNo").length>0){
            $("#stockRefundSubmitForm #hiddenPageNo").val(pageNo);
        }else{
            $("#stockRefundSubmitForm").append('<input name="pageNo" type="hidden" value="'+pageNo+'" id="hiddenPageNo"/>');
        }
        $("#applicationForRefundButton").click();
    });
});

//检查是否为正整数
function isInteger(a) {
    var reg =/^\d+$/
    return reg.test(a);
}