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

    $("select").each(function(){
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });

    $("#stockExpressQueryButton").click(function(){
        var idDom = $("#input6");
        if (idDom.val()!="" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        $("#stockExpressSubmitForm").submit();
    });

    //TODO 分页按钮 点击
    $("#paginationUl a").click(function(){
        var pageNo = $(this).html();
        if(isNaN(pageNo)){
            pageNo = $(this).attr('pageNo');
        }
        if($("#stockExpressSubmitForm #hiddenPageNo").length>0){
            $("#stockExpressSubmitForm #hiddenPageNo").val(pageNo);
        }else{
            $("#stockExpressSubmitForm").append('<input name="pageNo" type="hidden" value="'+pageNo+'" id="hiddenPageNo"/>');
        }
        $("#stockExpressQueryButton").click();
    });
});

//检查是否为正整数
function isInteger(a) {
    var reg =/^\d+$/
    return reg.test(a);
}