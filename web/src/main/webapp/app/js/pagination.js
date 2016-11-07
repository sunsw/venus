//DONE 分页按钮 点击
$("#pagination a").click(function () {
    var pageNum = $(this).html();
    if (isNaN(pageNum)) {
        pageNum = $(this).attr('pageNum');
    }
    if ($("#queryForm #hiddenPageNum").length > 0) {
        $("#queryForm #hiddenPageNum").val(pageNum);
    } else {
        $("#queryForm").append('<input name="pageNum" type="hidden" value="' + pageNum + '" id="hiddenPageNum"/>');
    }
    $("#queryForm").submit();
});

//DONE easter eggs pageSize
var showAllRecordTime = 1;
$("#pagination li:last").click(function () {
    if (showAllRecordTime < 10) {
        showAllRecordTime++;
    } else {
        var href = window.location.href.indexOf('?') < 0 ? '?' : '';
        if (href.indexOf('pageNum') < 0) {
            href += '&pageNum=1';
        } else {
            href = href.replace(/pageNum=\d*/, 'pageNum=1');
        }
        if (/(\d+)/.test($(this).html())) {
            location.href = href + '&pageSize=' + RegExp.$1;
        }
    }
});