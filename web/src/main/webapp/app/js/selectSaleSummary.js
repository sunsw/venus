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

   //DONE stock-sidebar
    //$("div.stock-sidebar a").removeClass("active");
    //$("div.stock-sidebar a[href='/page/stockSale']").addClass("active");

    /*//TODO 当前时间
    var newDate = new Date();
    var nowFullYear = newDate.getFullYear();
    var nowMonth = newDate.getMonth()+1;
    var nowDate = newDate.getDate();
    $("#createTimeId").val(nowFullYear+(nowMonth<10?'-0'+nowMonth:'-'+nowMonth)+(nowDate<10?'-0'+nowDate:'-'+nowDate));
     */

    $("select").each(function(){
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });

    $("#selectSaleSummarySubmitButton").click(function(){
        var idDom = $("#input6");
        if (idDom.val()!="" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }
        //TODO 校验
        $("#selectSaleSummarySubmitForm").submit();
    });

    //TODO 分页按钮 点击
    $("#paginationUl a").click(function(){
        var pageNo = $(this).html();
        if(isNaN(pageNo)){
            pageNo = $(this).attr('pageNo');
        }
        if($("#selectSaleSummarySubmitForm #hiddenPageNo").length>0){
            $("#selectSaleSummarySubmitForm #hiddenPageNo").val(pageNo);
        }else{
            $("#selectSaleSummarySubmitForm").append('<input name="pageNo" type="hidden" value="'+pageNo+'" id="hiddenPageNo"/>');
        }
        $("#selectSaleSummarySubmitButton").click();
    });

});

//检查是否为正整数
function isInteger(a) {
    var reg =/^\d+$/
    return reg.test(a);
}