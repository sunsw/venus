$(function(){

    $(".active").removeClass("active");
    $("#stockOut").addClass("active");

    //表单清空
    $("#clearValue").click(function() {
        $("form input").each(function() {
            $(this).val("");
        });
        $("form select").each(function() {
            $(this).val("");
        });
    });

   //DONE stock-sidebar
    //$("div.stock-sidebar a").removeClass("active");
    //$("div.stock-sidebar a[href='/page/stockSale']").addClass("active");

    $("#createTimeId").datetimepicker({
        language: 'zh-CN',
        pickTime: false,
        todayBtn: true,
        autoclose: true,
        minView: '2',
        forceParse: false,
        format: "yyyy-mm-dd"
    });

    $('.form_date').datetimepicker({
        weekStart: 1,
        format: 'yyyy-mm-dd',
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

    $("#DownloadExcel").click(function(){
        var url = "/page/stockSale/exportSummary?";
        if ($("input[name='stockSale.createTime']").val() != undefined) {
            url += "&stockSale.createTime=" + $("input[name='stockSale.createTime']").val();
        }
        if ($("input[name='stockSale.modifyTime']").val() != undefined) {
            url += "&stockSale.modifyTime=" + $("input[name='stockSale.modifyTime']").val();
        }
        if ($("input[name='stockInfo.productId']").val() != undefined) {
            url += "&stockInfo.productId=" + $("input[name='stockInfo.productId']").val();
        }
        if ($("select[name='stockSale.channel']").val() != undefined) {
            url += "&stockSale.channel=" + $("select[name='stockSale.channel']").val();
        }
        if ($("input[name='stockInfo.productName']").val() != undefined) {
            url += "&stockInfo.productName=" + $("input[name='stockInfo.productName']").val();
        }
        if ($("input[name='stockSale.orderId']").val() != undefined) {
            url += "&stockSale.orderId=" + $("input[name='stockSale.orderId']").val();
        }
        if ($("select[name='stockKeep.type']").val() != undefined) {
            url += "&stockKeep.type=" + $("select[name='stockKeep.type']").val();
        }
        if ($("select[name='stockSale.status']").val() != undefined) {
            url += "&stockSale.status=" + $("select[name='stockSale.status']").val();
        }
        window.location.href=url;
    });

    $("#stockSaleSubmitForm [name=createTime]").datetimepicker({
        language: 'zh-CN',
        pickTime: false,
        todayBtn: true,
        autoclose: true,
        minView: '2',
        forceParse: false,
        format: "yyyy-mm-dd"
    });

    $("select").each(function(){
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });

    $("#applicationForGetTicketButton").click(function(){
        //DONE 申请领实体票，会记录上一次的输入
        $("#exampleInputOrderId").val("");
        $("#exampleInputCount").val("");
        $("#exampleInputProductName").val("");
        $("#exampleInputExpComp").val("");
        $("#exampleInputExpCode").val("");
        $("#exampleInputRemarks").val("");
        $("#applicationForGetTicketDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    //票务类型 回显
    if($("#stockSaleSubmitForm #stockKeepTypeHidden").val()==1){
        $("#typeCheckbox").get(0).checked = true;
    }

    $("#stockSaleQueryButton").click(function(){
        var idDom = $("#input6");
        if (idDom.val()!="" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        if($("#typeCheckbox").length<0 && $("#typeCheckbox").get(0).checked){
            $("#stockSaleSubmitForm #stockKeepTypeHidden").val(1);
        }else{
            $("#stockSaleSubmitForm #stockKeepTypeHidden").val(0);
        }
       $("#stockSaleSubmitForm").submit();
    });

    var productList = [];
    var rememberOrderId = '';
    var productSkuMap = {};
    /*
    //DONE select 产品名称
    $("#exampleInputOrderId").blur(function(){
        var orderId = $(this).val();
        if(rememberOrderId == orderId)return;
        rememberOrderId = orderId;
        $.ajax({
            type: 'get',
            url: '/page/stockInfo/order',
            data: {
                orderId: orderId
            },
            dataType: 'json',
            success: function(result){
                productList = result.data;
                var productSelect = $("#exampleInputProductName");
                var productOptions = '<option>选择产品</option>';
                for(var i in productList){
                    var thisProduct = productList[i];
                    productSkuMap[thisProduct.skuId] = thisProduct.productId;
                    productOptions += '<option value="'+thisProduct.skuId+'">'+thisProduct.productName+' - '+thisProduct.skuName+'</option>';
                }
                productSelect.html(productOptions);
            }
        });
    });
    */
    //TODO 提交出库
    $("#submitStockKeepOut").click(function () {
        var idDom = $("#exampleInputCount");
        if (!isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        var skuId = $("#exampleInputProductName").val();
        var productId = productSkuMap[$("#exampleInputProductName").val()];
        var orderId = $("#exampleInputOrderId").val();
        var number = $("#exampleInputCount").val();
        var expressCom = $("#exampleInputExpComp").val();
        var expressId = $("#exampleInputExpCode").val();
        if(skuId==null || skuId=='' || productId=='' || orderId=='' || number=='' || expressCom=='' || expressId==''){
            alert("申领信息全部必填！");
            return false;
        }
        var productAndSkuStr = $("#exampleInputProductName option[value="+skuId+"]").html();
        confirm('确定申领'+number+'张\n'+productAndSkuStr+'吗？\n  将不可撤销！',function(){
            $.ajax({
                type: 'post',
                url: '/page/stockKeep/out',
                data: {
                    productId: productId,
                    skuId: skuId,
                    orderId: orderId,
                    number: number,
                    expressCom: expressCom,
                    expressId: expressId
                },
                success: function (result) {
                    if (result == 'SUCCESS') {
                        if($("#typeCheckbox").length<0 && $("#typeCheckbox").get(0).checked){
                            $("#stockSaleSubmitForm #stockKeepTypeHidden").val(1);
                        }else{
                            $("#stockSaleSubmitForm #stockKeepTypeHidden").val(0);
                        }
                        $("#stockSaleSubmitForm").submit();
                    } else {
                        alert("出票失败，或因库存不足");
                    }
                }
            });
        });
    });

    $.ajax({
        type: 'get',
        url: '/page/stockInfo/allProducts',
        data: {
            type: 0
        },
        dataType: 'json',
        success: function(result){
            var productSelect = $("#exampleInputProductName");
            var productOptions = '<option value="">选择产品</option>';
            for(var i in result){
                var thisProduct = result[i].stockInfo;
                productSkuMap[thisProduct.skuId] = thisProduct.productId;
                productOptions += '<option value="'+thisProduct.skuId+'">'+thisProduct.productName+' - '+thisProduct.skuName+'</option>';
            }
            productSelect.html(productOptions);
        }
    });

    $("a.stock-sale-opt").click(function(){
        var stockSaleId = $(this).parent().parent().attr("stockSaleId");
        var __this__ = $(this);
        confirm('确定吗？ \n将不可撤销！',function(){
            $.ajax({
                type: 'post',
                url: '/page/stockSale/update',
                data: {
                    id: stockSaleId,
                    status: 1
                },
                success: function(result){
                    if(result=='SUCCESS'){
                        var parent = __this__.parent();
                        parent.prev().html("已出库");
                        parent.html("已确认");
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
        if($("#stockSaleSubmitForm #hiddenPageNo").length>0){
            $("#stockSaleSubmitForm #hiddenPageNo").val(pageNo);
        }else{
            $("#stockSaleSubmitForm").append('<input name="pageNo" type="hidden" value="'+pageNo+'" id="hiddenPageNo"/>');
        }
        $("#stockSaleQueryButton").click();
    });

});

//检查是否为正整数
function isInteger(a) {
    var reg =/^\d+$/
    return reg.test(a);
}
