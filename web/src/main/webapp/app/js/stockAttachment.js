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

    $("#submitButton").click(function () {
        $("#queryForm").submit();
    });

    $("#addModel").click(function () {
        $("#modelWin form input").each(function () {
            $(this).val("");
        });
        $("#productId").removeAttr('disabled');
        $("#productName").removeAttr('disabled');
        $("#topt").removeAttr('disabled');
        $("#type").removeAttr('disabled');
        $("#validDate").removeAttr('disabled');
        $("#sp1").css('display', '');
        $("#sp2").css('display', '');
        $("#winSubmit").attr('disabled', 'disabled');
        $("#ticketInputFilesFormGroup").hide();
        $("#whenUploadShow").hide();

        $("#flag").val("add");
        $("#type").val("1");
        $("#modelWin").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    $("#winSubmit").click(function () {
        var productId = $("#productId").val();
        var productName = $("#productName").val();
        var type = $("#type").val();
        var validDate = $("#validDate").val();

        if (productId == "" || productName == "" || type == "" || validDate == "") {
            alert("请正确填写表单, " + (productId == "" ? "产品ID " : " ") + (productName == "" ? "产品名称 " : " ") +
                (type == "" ? "类型 " : " ") + (validDate == "" ? "有效期 " : " ") + " 不能为空！");
            return;
        }
        $("#winSubmit").attr('disabled', 'disabled');
        var flag = $("#flag").val();
        if (flag == "add") {
            $("#winForm").attr('action', '/page/stockAttachment/add');
        } else if (flag == "edit") {
            $("#winForm").attr('action', '/page/stockAttachment/edit');
        } else if (flag == "import") {
            //$("#winForm").attr('action', '/page/file/upload');
            upload();
            return;
        }
        $("#validDate").val($("#validDate").val() + " 23:59:59");
        $("#winForm").submit();
    });

    $("#productId").blur(function () {
        $.ajax({
            type: 'POST',
            url: '/page/stockInfo/productIdExist',
            data: {
                productId: $('#productId').val()
            },
            success: function (data) {
                if (data == false) {
                    $('#productId').focus();
                    $('#productId').tooltip('show');
                    $('#productId').click(function () {
                        $('#productId').tooltip('hide');
                    });
                    $("#winSubmit").attr('disabled', 'disabled');
                } else {
                    $("#winSubmit").removeAttr('disabled');
                }
            }
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

    //DONE 分页按钮 点击
    $("#paginationUl a").click(function () {
        var pageNo = $(this).html();
        if (isNaN(pageNo)) {
            pageNo = $(this).attr('pageNo');
        }
        if ($("#queryForm #hiddenPageNo").length > 0) {
            $("#queryForm #hiddenPageNo").val(pageNo);
        } else {
            $("#queryForm").append('<input name="pageNo" type="hidden" value="' + pageNo + '" id="hiddenPageNo"/>');
        }
        $("#submitButton").click();
    });

    //DONE easter eggs pageSize
    var showAllRecordTime = 1;
    $("#paginationUl li:last").click(function () {
        if (showAllRecordTime < 10) {
            showAllRecordTime++;
        } else {
            var href = window.location.href.replace(/pageNo=\d*/, 'pageNo=1');
            href += href.indexOf('?') < 0 ? '?' : '&';
            if (/(\d+)/.test($(this).html())) {
                location.href = href + 'pageSize=' + RegExp.$1;
            }
        }
    });
});

function confirmImp(id) {
    var tr = $("#" + id);
    var type = tr.attr("type");
    var number = tr.attr("number");
    if (type == 1 && number > 0) {
        alert("该附件为通用型，且已上传，不能再上传！");
    } else {
        toImp(id);
    }
}

function toImp(id) {
    $("#modelWin form input").each(function () {
        $(this).val("");
    });
    $.ajax({
        type: 'POST',
        url: '/page/stockAttachment/selectById',
        data: {
            id: id
        },
        success: function (data) {
            if (data) {
                $("#flag").val("import");
                $('#id').val(data.id);
                $('#stockInfoId').val(data.stockInfoId);
                $('#productId').val(data.productId);
                $('#productName').val(data.productName);
                $('#type').val(data.type);
                $('#validDate').val(new Date(data.validDate).Format("yyyy-MM-dd"));

                $("#productId").attr('disabled', 'disabled');
                $("#productName").attr('disabled', 'disabled');
                $("#type").attr('disabled', 'disabled');
                $("#validDate").attr('disabled', 'disabled');
                $("#sp1").css('display', 'none');
                $("#sp2").css('display', 'none');
                $("#ticketInputFilesFormGroup").show();
            }
        }
    });
    $("#winSubmit").removeAttr('disabled');
    $("#modelWin").modal({
        backdrop: 'static',
        keyboard: false
    });
}

function confirmExp(id) {
    var tr = $("#" + id);
    var number = tr.attr("number");
    if (number < 1) {
        alert("该附件数量为0，不能导出！");
    } else {
        exp(id);
    }
}

function exp(id) {
    window.location.href = "/page/stockAttachment/exportAttachment?id=" + id;
}

function edit(id) {
    $("#modelWin form input").each(function () {
        $(this).val("");
    });
    $.ajax({
        type: 'POST',
        url: '/page/stockAttachment/selectById',
        data: {
            id: id
        },
        success: function (data) {
            if (data) {
                $("#flag").val("edit");
                $('#id').val(data.id);
                $('#stockInfoId').val(data.stockInfoId);
                $('#productId').val(data.productId);
                $('#productName').val(data.productName);
                $('#type').val(data.type);
                $('#validDate').val(new Date(data.validDate).Format("yyyy-MM-dd"));

                $("#productId").attr('disabled', 'disabled');
                $("#productName").attr('disabled', 'disabled');
                if (data.type == 1) {
                    $("#type").attr('disabled', 'disabled');
                } else {
                    $("#topt").attr('disabled', 'disabled');
                    $("#type").removeAttr('disabled');
                }
                $("#validDate").removeAttr('disabled');
                $("#sp1").css('display', '');
                $("#sp2").css('display', '');
                $("#winSubmit").removeAttr('disabled');
                $("#ticketInputFilesFormGroup").hide();
                $("#whenUploadShow").hide();
            }
        }
    });
    $("#winSubmit").removeAttr('disabled');
    $("#modelWin").modal({
        backdrop: 'static',
        keyboard: false
    });
}

function del(id) {
    confirm('确认删除？', function () {
        $.ajax({
            type: 'POST',
            url: '/page/stockAttachment/delAttachment',
            data: {
                id: id
            },
            success: function (result) {
                if (result == 'success') {
                    $("#queryForm").submit();
                }
            }
        });
    });
}

var files;
var progressSpans = $("#progressSpans span");
var progressSpanDivs = $("#progressSpans div");
var progressShowTip = progressSpanDivs.get(1);
var progressBar = document.getElementById('progressBar');
var successUploadList = [];
var failUploadList = [];
var repList = [];

function upload() {
    var param = {};
    $("#winForm [name]").each(function () {
        param[$(this).attr("name")] = $(this).val();
    });
    files = document.getElementById('ticketInputFiles').files;
    if (files.length < 1) {
        alert("请选择文件！");
        $("#winSubmit").removeAttr('disabled');
        return;
    }
    if (param.type == 1) {//通用型
        if (files.length > 1) {
            alert("通用型附件只需上传一份！");
            $("#winSubmit").removeAttr('disabled');
            return;
        }
    }
    $("#whenUploadShow").show();
    recursiveUpload(0);
}

//循环上传
function recursiveUpload(uploadIndex) {
    var fileSize = 0;
    var file = files[uploadIndex];
    if (!file.name.endsWith('.jpg') && !file.name.endsWith('.png') && !file.name.endsWith('.pdf')) {//文件格式限制
        repList.push(file.name);
        if (uploadIndex < files.length - 1) {
            progressBar.style.width = '0';
            progressShowTip.innerHTML = '0%';
            recursiveUpload(uploadIndex + 1);
        } else if (uploadIndex == files.length - 1) {
            endUpload();
        }
        return;
    }
    if (file.size > 512 * 1024) {//文件大小不能超过500KB！
        repList.push(file.name);
        if (uploadIndex < files.length - 1) {
            progressBar.style.width = '0';
            progressShowTip.innerHTML = '0%';
            recursiveUpload(uploadIndex + 1);
        } else if (uploadIndex == files.length - 1) {
            endUpload();
        }
        return;
        //fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
    } else {
        fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
    }
    progressSpans.get(0).innerHTML = file.name;
    progressSpans.get(1).innerHTML = fileSize;
    progressSpans.get(2).innerHTML = file.type;
    progressSpanDivs.get(0).innerHTML = (uploadIndex + 1) + '/' + files.length;

    var fd = new FormData();
    fd.append("fileToUpload", file);
    fd.append("stockInfoId", $("#stockInfoId").val());
    fd.append("validDate", $("#validDate").val() + " 23:59:59");
    fd.append("type", $("#type").val());

    var xhr = new XMLHttpRequest();
    xhr.upload.addEventListener("progress", function (event) {
        if (event.lengthComputable) {
            var percentComplete = Math.round(event.loaded * 100 / event.total) + '%';
            progressBar.style.width = percentComplete;
            progressShowTip.innerHTML = percentComplete;
        }
    }, false);
    xhr.addEventListener("load", function (event) {
        /* 服务器端返回响应时候触发event事件*/
        if (xhr.readyState == 4 && xhr.status == 200) {
            eval("var res =" + event.target.responseText);
            var flag = res['flag'];
            if (flag == 1) {
                successUploadList.push(file);
            } else if (flag == 2) {
                repList.push(file.name);
            } else {
                failUploadList.push(file.name);
            }
        }

        if (uploadIndex < files.length - 1) {
            progressBar.style.width = '0';
            progressShowTip.innerHTML = '0%';
            recursiveUpload(uploadIndex + 1);
        } else if (uploadIndex == files.length - 1) {
            endUpload();
        }
    }, false);
    xhr.addEventListener("error", function (event) {
        alert("There was an error attempting to upload the file.");
    }, false);
    xhr.addEventListener("abort", function (event) {
        alert("The upload has been canceled by the user or the browser dropped the connection.");
    }, false);
    xhr.open("POST", "/file/uploadAttachment");
    xhr.send(fd);
};

function endUpload() {
    if (repList.length > 0) {
        alert("上传的文件有" + (repList.length) + "张失败（重复、0字节、大于500KB、非jpg/png/pdf），已成功上传" + (successUploadList.length) + "张！", function () {
            //DONE 下载重复票的记录导出 start
            var BB = self.Blob;
            var fileName = "stock_rep_异常票.txt"; //文件名
            saveAs(
                new BB(
                    ["\ufeff" + repList.join('\r\n')],
                    {type: "test/plain;charset=utf8;"}
                ), fileName);
            alert("请注意接收下载异常票记录！", function () {
                $.ajax({
                    type: 'POST',
                    url: '/page/stockPurchase/ftpAttachment',
                    data: {
                        stockInfoId: $("#stockInfoId").val()
                    },
                    success: function (result) {
                        $("#modelWin").modal('hide');
                        $("#queryForm").submit();
                    }
                });
            });
            //DONE 下载重复票的记录导出 end
        });
    } else {
        alert("成功上传" + (successUploadList.length) + "张！", function () {
            $.ajax({
                type: 'POST',
                url: '/page/stockPurchase/ftpAttachment',
                data: {
                    stockInfoId: $("#stockInfoId").val()
                },
                success: function (result) {
                    $("#modelWin").modal('hide');
                    $("#queryForm").submit();
                }
            });
        });
    }
    if (successUploadList.length > 0) {
        $.ajax({
            type: 'POST',
            url: '/page/stockAttachment/edit',
            data: {
                id: $("#id").val(),
                size: Math.round(successUploadList[successUploadList.length - 1].size * 100 / 1024) / 100
            },
            success: function (data) {
            }
        });
    }
}

