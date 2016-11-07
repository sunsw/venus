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

    $("select").each(function () {
        //DONE select 回显
        $(this).val($(this).attr("value"));
    });
    $("#stockInfoSubmitButton").click(function () {
        //TODO
        var idDom = $("#input3");
        if (!idDom.val() == "" && !isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        $("#stockInfoSubmitForm").submit();
    });

    $('#exampleInputPeriod').datetimepicker({
        language: 'zh-CN',
        pickTime: false,
        todayBtn: true,
        autoclose: true,
        minView: '2',
        forceParse: false,
        format: "yyyy-mm-dd"
    });

    $("#applicationForPurchaseButton").click(function () {
        $("#floating").val(9);
        var __this__ = $(this);
        //申请采购 点击
        var newGridHtml = "";
        //newGridHtml += "<input type='hidden' id='stockPurchaseList' name='stockPurchaseList' value=''/>";
        var allCheckedRadio = $("#stockInfoTable input.applyRadio:checked");
        if (allCheckedRadio.length < 1) {
            __this__.tooltip('show');
            setTimeout(function () {
                __this__.tooltip('hide');
            }, 2000);
            return;
        }
        allCheckedRadio.each(function (index) {
            var thisSkuId = $(this).parent().parent().attr("skuId");
            var stockInfoId = $(this).parent().parent().attr("stockInfoId");
            var newTrHtml = "<tr>";
            //newTrHtml += "<input type='hidden' name='stockPurchaseList.StockPurchases.skuId["+index+"]' value='"+thisSkuId+"'/>";
            //newTrHtml += "<input type='hidden' nameBack='stockInfoId' value='"+stockInfoId+"'/>";
            newTrHtml += "<input type='hidden' name='stockPurchases[" + index + "].stockInfoId' value='" + stockInfoId + "'/>";
            var thisTd = $(this).parent().next();
            for (var i = 0; i < 6; i++) {
                thisTd = thisTd.next();
                newTrHtml += (i == 3 ? "<td style='width: 4em'>" : "<td>") + thisTd.html() + "</td>"
            }
            //DONE 添加固定数据 start
            /*
             newTrHtml += "<td><input type='text' class='form-control' nameBack='stockPurchaseList.StockPurchases["+index+"].price' style='width: 8em'/></td>" +
             "<td><input type='text' class='form-control' nameBack='stockPurchaseList.StockPurchases["+index+"].number' style='width: 4em'/></td>" +
             "<td><input class='inRange' nameBack='stockPurchaseList.StockPurchases["+index+"].isWithinBudget' type='checkbox'/>是</td>" +
             "<td><input type='text' class='form-control' nameBack='stockPurchaseList.StockPurchases["+index+"].period' style='width: 4em'/></td>" +
             "<td><input type='text' class='form-control' nameBack='stockPurchaseList.StockPurchases["+index+"].rate' style='width: 4em'/></td>" +
             "<td>-</td>" +
             "<td><input type='text' class='form-control style='width: 8em'/></td>";
             */
            newTrHtml += "<td><input type='text' class='form-control alg-price' value='0' name='stockPurchases[" + index + "].price' style='width: 8em'/></td>" +
                "<td><input type='text' class='form-control alg-number' value='1' name='stockPurchases[" + index + "].number' style='width: 4em'/></td>" +
                "<td><input name='stockPurchases[" + index + "].isWithinBudget' type='hidden'/><input class='inRange' type='checkbox'/>是</td>" +
                "<td><input type='text' class='form-control' name='stockPurchases[" + index + "].delayDate' style='width: 4em'/></td>" +
                "<td><input type='text' class='form-control' name='stockPurchases[" + index + "].period' style='width: 4em'/></td>" +
                "<td><span style='position: relative; z-index: 9999;'><input readonly type='text' class='form-control last-pay-date' name='stockPurchases[" + index + "].payDate' style='width: 7em'/></span></td>" +
                "<td><input type='text' class='form-control' name='stockPurchases[" + index + "].rate' style='width: 4em'/></td>" +
                "<td><input type='text' readonly class='form-control alg-ze' value='0' style='width: 8em'/></td>";
            //DONE 添加固定数据 end
            newTrHtml += "</tr>";

            newGridHtml += newTrHtml;
        });
        $("#newModalTBody").html(newGridHtml);
        $("#applicationForPurchaseDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
        //DONE 动态的日历
        $("input.last-pay-date").each(function () {
            $(this).datetimepicker({
                language: 'zh-CN',
                pickTime: false,
                todayBtn: true,
                autoclose: true,
                minView: '2',
                forceParse: false,
                format: "yyyy-mm-dd"
            });
        });
    });

    //DONE 单价*数量=金额
    $(document).on("keyup", ".alg-price", function () {
        var parentTr = $(this).parent().parent();
        var price = $(this).val();
        var number = parentTr.find("input.alg-number").val();
        parentTr.find("input.alg-ze").val(price * number);
    });
    $(document).on("keyup", ".alg-number", function () {
        var parentTr = $(this).parent().parent();
        var number = $(this).val();
        var price = parentTr.find("input.alg-price").val();
        parentTr.find("input.alg-ze").val(price * number);
    });
    //DONE 入库-a 点击
    $(".storage-a").click(function () {
        $("#whenUploadShow").hide();
        $("#storageDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
        var theTr = $(this).parent().parent();
        var skuId = theTr.attr("skuId");
        var trMessage = theTr.find("td");
        var purchaseId = theTr.attr("stockPurchaseId");
        $("#exampleInputPeriod").val("");
        $("#exampleInputStockPurchaseId").val(purchaseId);
        $("#exampleInputProductName").val(trMessage.get(2).innerHTML.trim());
        $("#exampleInputProductId").val(trMessage.get(1).innerHTML.trim());
        $("#exampleInputSkuName").val(trMessage.get(3).innerHTML.trim());
        var ticketTypeName = trMessage.get(6).innerHTML.trim();

        $("#storageInForm input[name=stockKeepId]").val(theTr.attr("stockkeepid"));
        $("#storageInForm input[name=stockPurchaseId]").val(purchaseId);

        $("#exampleInputTicketType option").each(function () {
            if (ticketTypeName == $(this).html()) {
                //$(this).attr("select", "select");
                $("#exampleInputTicketType").val($(this).attr("value"));
                return false;
            }
        });

        var restCount;
        $.ajax({
            type: 'get',
            url: '/page/stockKeep/countByPurchaseId',
            data: {
                purchaseId: purchaseId
            },
            async: false,
            success: function (result) {
                restCount = result;
            }
        });
        $("#exampleInputNumber").val(theTr.attr("stockPurchaseNumber") - restCount);
        if (ticketTypeName != '实体票' && ticketTypeName != '海玩电子码') {
            $("#ticketInputFilesFormGroup").html('<label class="col-sm-2 control-label" for="ticketInputFiles">上传文件</label><div class="col-sm-10"><input type="file" multiple="" id="ticketInputFiles"></div>');
        } else {
            $("#ticketInputFilesFormGroup").html("");
        }
        var ticketTypeValue = $("#exampleInputTicketType").val();
        if (ticketTypeName != "-") {
            $("#exampleInputTicketType").get(0).onchange = function () {
                $("#exampleInputTicketType").val(ticketTypeValue);
            };
            $("#exampleInputTicketType").attr("readonly", "readonly");
        } else {
            $("#exampleInputTicketType").get(0).onchange = function () {
                var thisValue = $("#exampleInputTicketType").val();
                if (thisValue == 0 || thisValue == -2) {
                    $("#ticketInputFilesFormGroup").html("");
                } else {
                    $("#ticketInputFilesFormGroup").html('<label class="col-sm-2 control-label" for="ticketInputFiles">上传文件</label><div class="col-sm-10"><input type="file" multiple="" id="ticketInputFiles"></div>');
                }
            };
        }

    });

    var nginx = window.location.host;
    if (nginx.indexOf(":") != -1) {
        nginx = "http://" + nginx.substring(0, nginx.indexOf(":"));
    } else {
        nginx = "http://" + nginx;
    }

    //DONE 入库确认-a 点击
    var showPdfIFrame = $("#showPdfIFrame");
    var showJpgImg = $("#showJpgImg");
    var showCodeDiv = $("#showCodeDiv");
    var prevRandomNextDiv = $("#prevRandomNextDiv");
    var previewSrcList;
    var previewSrcIndex = 0;
    var tempShowTicketType;
    var changePreview = function (index) {
        if (tempShowTicketType && (tempShowTicketType == 2 || tempTicketType == 6)) {
            prevRandomNextDiv.hide();
            showPdfIFrame.hide();
            showJpgImg.hide();
            showCodeDiv.show();
            var codeTable = '<textarea style="width: 100%;height: 100%" readonly> 共' + previewSrcList.length + '张\n';
            for (var i = 0; i < previewSrcList.length; i++) {
                codeTable += previewSrcList[i] + '\t\t';
            }
            showCodeDiv.html(codeTable + '</textarea>');
            $("#storageCheckFillCount").html('全部');
        } else {
            prevRandomNextDiv.show();
            var srcName = previewSrcList[index];
            if (srcName.endsWith('pdf')) {
                showPdfIFrame.show();
                showJpgImg.hide();
                showCodeDiv.hide();
                showPdfIFrame.attr("src", "/page/showPdf?src=" + nginx + srcName);
            } else if (srcName.endsWith('jpg') || srcName.endsWith('jpeg') || srcName.endsWith('gif') || srcName.endsWith('png') || srcName.endsWith('bmp')) {
                //TODO
                showPdfIFrame.hide();
                showJpgImg.show();
                showCodeDiv.hide();
                showJpgImg.attr("src", nginx + srcName);
            }
            $("#storageCheckFillCount").html((index + 1) + "/" + previewSrcList.length);
        }
    };
    $(".storage-check-a").click(function () {
        var theTr = $(this).parent().parent();
        var skuId = theTr.attr("skuId");
        var trMessage = theTr.find("td");
        tempShowTicketType = trMessage.eq(6).attr('ticketType');
        $("#checkInputSupplierName").val(trMessage.get(5).innerHTML.trim());
        $("#checkInputProductId").val(trMessage.get(1).innerHTML.trim());
        $("#checkInputSkuName").val(trMessage.get(3).innerHTML.trim());

        $("#storageCheckFillProductId").html(trMessage.get(1).innerHTML.trim());
        $("#storageCheckFillProductName").html(trMessage.get(2).innerHTML.trim());
        $("#storageCheckFillSkuName").html(trMessage.get(3).innerHTML.trim());
        $("#previewPurchaseId").val(theTr.attr("stockpurchaseid"));
        $("#previewIndex").val("0");
        //var previewSrc = stockInfoUtil.preview($("#previewPurchaseId").val());
        //alert($("#previewPurchaseId").val());
        $.ajax({
            type: "GET",
            url: '/page/stockPurchase/preview',
            data: {purchaseId: $("#previewPurchaseId").val()},
            async: false,
            success: function (result) {
                previewSrcList = result;
            }
        });
        if (previewSrcList) {
            changePreview(0);
        }
        $("#storageCheckDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
    });
    //DONE showPdf 上一张
    $("#storageCheckShowPdfPrev").click(function () {
        if (previewSrcIndex > 0) {
            changePreview(--previewSrcIndex);
        }
    });
    //DONE showPdf 随机
    $("#randomPrev").click(function () {
        var t = previewSrcIndex;
        while (previewSrcList.length > 1 && t == previewSrcIndex) {
            previewSrcIndex = Math.floor(Math.random() * (previewSrcList.length));
        }
        changePreview(previewSrcIndex);
    });
    //DONE showPdf 下一张
    $("#storageCheckShowPdfNext").click(function () {
        if (previewSrcIndex < previewSrcList.length - 1) {
            changePreview(++previewSrcIndex);
        }
    });


    var thresholdInputEmail = $("#thresholdInputEmail");
    var hasThresholdInputEmailChange = false;
    thresholdInputEmail.change(function () {
        hasThresholdInputEmailChange = true;
    });
    var tempAlarmId;
    //DONE 设置阈值-a 点击
    $(".set-threshold-a").click(function () {
        var theTr = $(this).parent().parent();
        var skuId = theTr.attr("skuId");
        var trMessage = theTr.find("td");
        var stockKeepId = theTr.attr("stockKeepId");
        var stockInfoId = theTr.attr("stockInfoId");

        $("#thresholdInputStockKeepId").val(stockKeepId);
        $("#thresholdInputStockInfoId").val(stockInfoId);

        $("#thresholdInputNumber").val(trMessage.get(9).innerHTML.trim());
        $("#thresholdInputProductId").val(trMessage.get(1).innerHTML.trim());
        $("#thresholdInputSkuName").val(trMessage.get(3).innerHTML.trim());
        $("#thresholdInputAlert").val(trMessage.get(10).innerHTML.trim());

        $("#setThresholdDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
        //TODO Email
        $.ajax({
            type: 'post',
            url: '/page/alarmContact/selectByStockInfoIdType',
            data: {
                stockInfoId: stockInfoId,
                type: 'stock'
            },
            success: function (result) {
                tempAlarmId = result.id;
                thresholdInputEmail.val(result.email);
                hasThresholdInputEmailChange = false;
            }
        });
    });
    var thresholdInputOnlineEmail = $("#thresholdInputOnlineEmail");
    var hasThresholdInputOnlineEmailChange = false;
    thresholdInputOnlineEmail.change(function () {
        hasThresholdInputOnlineEmailChange = true;
    });
    var tempAlarmOnlineId;
    //DONE 设置在架阈值-a 点击
    $(".set-online-threshold-a").click(function () {
        var theTr = $(this).parent().parent();
        var skuId = theTr.attr("skuId");
        var trMessage = theTr.find("td");
        var stockKeepId = theTr.attr("stockKeepId");
        var stockInfoId = theTr.attr("stockInfoId");

        $("#onlineThresholdInputStockKeepId").val(stockKeepId);
        $("#onlineThresholdInputStockInfoId").val(stockInfoId);

        $("#onlineThresholdInputNumber").val(trMessage.get(9).innerHTML.trim());
        $("#onlineThresholdInputProductId").val(trMessage.get(1).innerHTML.trim());
        $("#onlineThresholdInputSkuName").val(trMessage.get(3).innerHTML.trim());
        $("#thresholdInputOnlineNumber").val(trMessage.get(11).innerHTML.trim());
        $("#thresholdInputOnlineStockNumber").val(trMessage.get(12).innerHTML.trim());
        $("#setOnlineThresholdDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
        //TODO Email
        $.ajax({
            type: 'post',
            url: '/page/alarmContact/selectByStockInfoIdType',
            data: {
                stockInfoId: stockInfoId,
                type: 'rack'
            },
            success: function (result) {
                tempAlarmOnlineId = result.id;
                thresholdInputOnlineEmail.val(result.email);
                hasThresholdInputOnlineEmailChange = false;
            }
        });
    });

    //DONE 设置实体票数量-a 点击
    $(".editEntity-a").click(function () {
        var theTr = $(this).parent().parent();
        var skuId = theTr.attr("skuId");
        var trMessage = theTr.find("td");
        var stockKeepId = theTr.attr("stockKeepId");
        var stockInfoId = theTr.attr("stockInfoId");

        $("#editEntityStockKeepId").val(stockKeepId);
        $("#editEntityStockInfoId").val(stockInfoId);

        $("#editEntityProductId").val(trMessage.get(1).innerHTML.trim());
        $("#editEntitySkuName").val(trMessage.get(3).innerHTML.trim());
        $("#editEntityNumber").val(trMessage.get(9).innerHTML.trim());
        $("#editEntityOnlineNumber").val(trMessage.get(11).innerHTML.trim());
        $("#editEntityOnlineStockNumber").val(trMessage.get(12).innerHTML.trim());
        $("#editEntityModal").modal({
            backdrop: 'static',
            keyboard: false
        });
    });

    //DONE 主窗体Radio
    $("#stockInfoTable tbody td").each(function () {
        if ($(this).find("a").length > 0)return true;
        $(this).click(function () {
            var radioDom = $(this).parent().find("input.applyRadio")[0];
            if (!radioDom)return;
            //var typeName = $(this).parent().find("td").get(11).innerHTML.trim();
            //if(typeName!='未入库' && typeName!='已入库')return;
            if (radioDom.checked) {
                $(this).parent().removeClass("select-tr");
                radioDom.checked = false;
            } else {
                $(this).parent().addClass("select-tr");
                radioDom.checked = true;
            }
            //radioDom.checked =! radioDom.checked;
        });
    });

    //弹窗Radio
    //$("#applicationForPurchaseDiv input[type=radio]").each(function(){
    //    $(this)[0].onclick = function(){
    //        if($(this)[0].checked=true){
    //            $(this)[0].checked=false;
    //        }
    //        return false;
    //    };
    //});
    //NODE 提交申请
    $("#applicationForPurchaseDivSubmit").click(function () {
        //DONE 校验
        var currencyDom = $("#currency");
        if (currencyDom.val() == '') {
            currencyDom.tooltip('show');
            currencyDom.click(function () {
                currencyDom.tooltip('hide');
            });
            return;
        }
        var floatingDom = $("#floating");
        if (floatingDom.val() == '') {
            floatingDom.tooltip('show');
            floatingDom.click(function () {
                floatingDom.tooltip('hide');
            });
            return;
        }

        var newModalTBodyDom = $("#newModalTBody");
        var allPrices = $("input[name$='price']");
        for (var i = 0; i < allPrices.length; i++) {
            if (allPrices[i].value == '' || isNaN(allPrices[i].value)) {
                newModalTBodyDom.tooltip('show');
                newModalTBodyDom.click(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                newModalTBodyDom.keydown(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                return;
            }
        }
        var allNumber = $("td input[name$='number']");
        for (var i = 0; i < allNumber.length; i++) {
            if (allNumber[i].value == '' || isNaN(allNumber[i].value)) {
                newModalTBodyDom.tooltip('show');
                newModalTBodyDom.click(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                newModalTBodyDom.keydown(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                return;
            }
        }
        var allDelayDate = $("input[name$='delayDate']");
        for (var i = 0; i < allDelayDate.length; i++) {
            if (allDelayDate[i].value == '' || isNaN(allDelayDate[i].value)) {
                newModalTBodyDom.tooltip('show');
                newModalTBodyDom.click(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                newModalTBodyDom.keydown(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                return;
            }
        }
        var allPeriod = $("input[name$='period']");
        for (var i = 0; i < allPeriod.length; i++) {
            if (allPeriod[i].value == '' || isNaN(allPeriod[i].value)) {
                newModalTBodyDom.tooltip('show');
                newModalTBodyDom.click(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                newModalTBodyDom.keydown(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                return;
            }
        }
        var allPayDate = $("input[name$='payDate']");
        for (var i = 0; i < allPayDate.length; i++) {
            if (allPayDate[i].value == '') {
                newModalTBodyDom.tooltip('show');
                newModalTBodyDom.click(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                newModalTBodyDom.keydown(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                return;
            }
        }
        var allRate = $("input[name$='rate']");
        for (var i = 0; i < allRate.length; i++) {
            if (allRate[i].value == '' || isNaN(allRate[i].value)) {
                newModalTBodyDom.tooltip('show');
                newModalTBodyDom.click(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                newModalTBodyDom.keydown(function () {
                    newModalTBodyDom.tooltip('hide');
                });
                return;
            } else {
                if (isFloat(allRate[i].value) == false) {
                    newModalTBodyDom.tooltip('show');
                    newModalTBodyDom.click(function () {
                        newModalTBodyDom.tooltip('hide');
                    });
                    newModalTBodyDom.keydown(function () {
                        newModalTBodyDom.tooltip('hide');
                    });
                    return;
                }
            }
        }

        $(this).attr('disabled', 'disabled');
        $("input.inRange").each(function () {
            if ($(this).get(0).checked) {
                $(this).prev().val(1);
            } else {
                $(this).prev().val(0);
            }
        });
        $("#addListForm").submit();
        //var stockPurchaseList = [];
        //    var stockPurchase = {};
        //$("#newModalTBody tr").each(function(){
        //    $(this).find("input[nameBack]").each(function(){
        //        stockPurchase[$(this).attr("nameBack")]= $(this).val();
        //    });
        //stockPurchaseList.push(stockPurchase);
        //});
        //$("#stockPurchaseList").val(JSON.stringify(stockPurchaseList));

        /*
         var applicant = $("#addListForm input[name=applicant]").val();
         var email = $("#addListForm input[name=email]").val();
         var area = $("#addListForm input[name=area]").val();
         var currency = $("#addListForm input[name=currency]").val();
         var floating = $("#addListForm input[name=floating]").val();
         //复合提交
         $.ajax({
         type: "POST",
         url: "/page/stockPurchase/addList",
         data: {
         applicant: applicant,
         email: email,
         area: area,
         currency: currency,
         floating: floating,
         StockPurchases: stockPurchaseList
         }
         });
         */

    });

    //TODO 具体上传的方法
    var files;
    var progressSpans = $("#progressSpans span");
    var progressSpanDivs = $("#progressSpans div");
    var progressShowTip = progressSpanDivs.get(1);
    var progressBar = document.getElementById('progressBar');
    var stockPurchaseId;
    var uploadPdfNumber;
    var exampleInputPeriod;
    var successUploadList = [];
    var overflowUploadList = [];
    var failUploadList = [];
    var repList = [];
    var tempTicketType;

    var recursiveUpload = function (uploadIndex) {
        var fileSize = 0;
        var file = files[uploadIndex];
        if (file.size > 1024 * 1024)
            fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
        else
            fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';
        progressSpans.get(0).innerHTML = file.name;
        progressSpans.get(1).innerHTML = fileSize;
        progressSpans.get(2).innerHTML = file.type;
        progressSpanDivs.get(0).innerHTML = (uploadIndex + 1) + '/' + files.length;

        var fd = new FormData();
        fd.append("fileToUpload", file);
        fd.append("stockPurchaseId", stockPurchaseId);
        fd.append("number", uploadPdfNumber);
        fd.append("validDate", exampleInputPeriod);
        if (tempTicketType != undefined) {
            fd.append("type", tempTicketType);
        }

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
            if (uploadIndex < files.length - 1) {
                progressBar.style.width = '0';
                progressShowTip.innerHTML = '0%';
                if (xhr.readyState == 4 && xhr.status == 200) {
                    eval("var res =" + event.target.responseText);
                    var flag = res['flag'];
                    var isThisRep = res['rep'];
                    if (isThisRep && isThisRep > 0) {
                        repList.push(file.name);
                    }
                    if (flag == 1 || flag == 2 || flag == 5) {
                        successUploadList.push(file.name);
                    } else if (flag == 6) {
                        overflowUploadList.push(file.name);
                    } else {
                        failUploadList.push(file.name);
                    }
                }
                recursiveUpload(uploadIndex + 1);
            } else if (uploadIndex == files.length - 1) {
                if (overflowUploadList.length < 1 && failUploadList.length < 1) {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        eval("var res =" + event.target.responseText);
                        var amount = Number(res['amount']);
                        var total = Number(res['total']);
                        var rep = Number(res['rep']);
                        //TODO repStr
                        if (tempTicketType == 2 || tempTicketType == 6) {
                            $("#submitStorageIn").removeAttr('disabled');
                            var flag = res['flag'];
                            if (flag == 6) {
                                alert("上传文件数量超出采购数据！");
                                return false;
                            } else if (flag == 2) {
                                alert("本次上传成功" + res['suc'] + "张，还需要" + (amount - total) + "张待上传！", function () {
                                    var repStr = res['repStr'];
                                    if (repStr && repStr != '') {
                                        var reps = repStr.split("\n");
                                        alert("上传的文件有" + (reps.length - 1) + "张重复或0字节文件，其它已成功，还需要" + (amount - total) + "张待上传！", function () {
                                            var BB = self.Blob;
                                            var fileName = "stock_rep_异常票.txt"; //文件名
                                            saveAs(
                                                new BB(
                                                    ["\ufeff" + reps.join('\r\n')],
                                                    {type: "test/plain;charset=utf8;"}
                                                ), fileName);
                                            alert("请注意接收下载异常票记录！", function () {
                                                $("#stockInfoSubmitForm").submit();
                                            });
                                        });
                                    } else {
                                        $("#stockInfoSubmitForm").submit();
                                    }
                                });
                            } else if (flag == 1) {
                                alert("上传成功！", function () {
                                    $("#stockInfoSubmitForm").submit();
                                });
                            } else {
                                alert("未知异常");
                                return false;
                            }
                        } else {
                            if (amount > total) {
                                if (rep != 0) {
                                    repList.push(file.name)
                                }
                                if (repList.length > 1) {
                                    alert("上传的文件有" + (repList.length - 1) + "张重复或0字节文件，其它已成功，还需要" + (amount - total) + "张待上传！", function () {
                                        //DONE 下载重复票的记录导出 start
                                        if (repList.length > 1) {
                                            var BB = self.Blob;
                                            var fileName = "stock_rep_异常票.txt"; //文件名
                                            saveAs(
                                                new BB(
                                                    ["\ufeff" + repList.join('\r\n')],
                                                    {type: "test/plain;charset=utf8;"}
                                                ), fileName);
                                            alert("请注意接收下载异常票记录！", function () {
                                                $("#stockInfoSubmitForm").submit();
                                            });
                                        }
                                        //DONE 下载重复票的记录导出 end
                                    });
                                } else {
                                    alert("本次上传成功，还需要" + (amount - total) + "张待上传！", function () {
                                        $("#stockInfoSubmitForm").submit();
                                    });
                                }
                            } else {
                                alert("全部上传成功！", function () {
                                    $("#stockInfoSubmitForm").submit();
                                });
                            }
                        }

                    }
                } else {
                    alert("上传部分文件存在异常，请保留稍后记录以便处理！");
                    $("#whenUploadShow").hide();
                    var errorMessage = '';
                    errorMessage += '<div style="color: #dc143c">上传成功列表：</div>';
                    for (var i in successUploadList) {
                        errorMessage += successUploadList[i] + '<br/>';
                    }
                    if (overflowUploadList.length > 0) {
                        errorMessage += '<div style="color: #dc143c">上传超出采购申请数列表：</div>';
                        for (var i in overflowUploadList) {
                            errorMessage += overflowUploadList[i] + '<br/>';
                        }
                    }
                    if (failUploadList.length > 0) {
                        errorMessage += '<div style="color: #dc143c">上传失败列表：</div>';
                        for (var i in failUploadList) {
                            errorMessage += failUploadList[i] + '<br/>';
                        }
                    }
                    errorMessage += '以及其它未上传成功电子票';
                    $("#ticketInputFilesFormGroup").html(errorMessage);
                }
            }
        }, false);
        xhr.addEventListener("error", function (event) {
            alert("There was an error attempting to upload the file.");
        }, false);
        xhr.addEventListener("abort", function (event) {
            alert("The upload has been canceled by the user or the browser dropped the connection.");
        }, false);
        xhr.open("POST", "/file/upload");
        xhr.send(fd);
    };
    //DONE 入库 submitStorageIn
    $("#submitStorageIn").click(function () {
        var idDom = $("#exampleInputTicketType");
        if (idDom.val() == "") {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        } else {
            tempTicketType = idDom.val();
        }

        idDom = $("#realPrice");
        if (idDom.val().trim().length < 1 || isRightFloat(idDom.val()) == false) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        idDom = $("#exchangeRate");
        if (idDom.val().trim().length < 1 || isRightFloat(idDom.val()) == false) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        idDom = $("#exampleInputPeriod");
        if (idDom.val().trim().length < 1) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        successUploadList = [];
        overflowUploadList = [];
        failUploadList = [];
        repList = ['重复的票'];
        var param = {};
        $("#storageInForm [name]").each(function () {
            param[$(this).attr("name")] = $(this).val();
        });

        $(this).attr('disabled', 'disabled');
        $.ajax({
            type: "post",
            url: "/page/stockKeep/in",
            data: param,
            success: function (result) {
                if (result == 'SUCCESS') {
                    stockPurchaseId = $("#exampleInputStockPurchaseId").val();
                    uploadPdfNumber = $("#exampleInputNumber").val();
                    exampleInputPeriod = $("#exampleInputPeriod").val();
                    try {
                        files = document.getElementById('ticketInputFiles').files;
                    } catch (e) {
                    }
                    if (param.type == 1 || param.type == 5) {//电子票、电子票&附件
                        //uploadFunc();
                        if (!uploadPdfNumber) {
                            alert("产品信息异常!");
                        } else if (files.length < 1) {
                            alert("请选择文件！");
                        } else if (uploadPdfNumber < files.length) {
                            alert("上传的文件数量超过采购量!");
                        } else if (files.length > 0) {
                            $("#whenUploadShow").show();
                            recursiveUpload(0);
                        }
                        $("#submitStorageIn").removeAttr('disabled');
                    } else if (param.type == 2 || param.type == 6) {//电子码、电子码&附件
                        if (files.length > 1) {
                            alert("电子码最多上传一个Excel文件");
                            $("#submitStorageIn").removeAttr('disabled');
                            return false;
                        } else if (files.length < 1) {
                            alert("请选择文件！");
                            $("#submitStorageIn").removeAttr('disabled');
                            return false;
                        }
                        var xlsFile = files[0];
                        if (!xlsFile.name.endsWith('.xls')) {
                            alert('只支持xls后缀 Excel2003 表格');
                            $("#submitStorageIn").removeAttr('disabled');
                            return false;
                        }
                        recursiveUpload(0);
                    } else {
                        window.location.reload();
                    }
                } else {
                    alert("提交失败，未知异常");
                }
            }
        });

        //$("#storageInForm").submit();

        //if(){}
        //uploadFunc();
    });

    //DONE 发现问题 撤销入库
    $("#cancelStorageCheckButton").click(function () {
        $.ajax({
            type: 'get',
            url: '/page/stockPurchase/cancel/' + $("#previewPurchaseId").val(),
            success: function (result) {
                window.location.reload();
            }
        });
    });

    //DONE 确认入库检查提交
    $("#submitStorageCheckButton,#submitStorageCheck").click(function () {
        $("#submitStorageCheckButton,#submitStorageCheck").attr('disabled', 'disabled');
        $.ajax({
            type: 'get',
            url: "/page/stockPurchase/toChecked/" + $("#previewPurchaseId").val() + '?type=' + tempShowTicketType,
            success: function (result) {
                window.location.reload();
            }
        });
    });

    //DONE 提交修改库存阈值
    $("#submitThreshold").click(function () {
        var idDom = $("#thresholdInputAlert");
        if (!isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        idDom = $("#thresholdInputEmail");
        if (!endWith(idDom.val(), ';')) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        var stockKeepId = $("#thresholdInputStockKeepId").val();
        var stockInfoId = $("#thresholdInputStockInfoId").val();
        var stockLimit = $("#thresholdInputAlert").val();
        if (hasThresholdInputEmailChange) {
            $.ajax({
                type: 'post',
                url: '/page/alarmContact/update',
                data: {
                    id: tempAlarmId,
                    stockInfoId: stockInfoId,
                    type: 'stock',
                    email: thresholdInputEmail.val()
                },
                success: function (result) {
                    if (result != 'SUCCESS') {
                        alert("更新报警邮箱失败！");
                    } else {
                        $.ajax({
                            type: 'post',
                            url: '/page/stockKeep/setStockLimit',
                            data: {
                                id: stockKeepId,
                                stockLimit: stockLimit
                            },
                            success: function (result) {
                                if (result == 'SUCCESS') {
                                    $("#setThresholdDiv").modal('hide');
                                    var thisTd = $("#stockInfoTable tr[stockinfoid=" + stockInfoId + "] td:eq(10)");
                                    thisTd.html(stockLimit);
                                    thisTd.css('background', "#ffff00");
                                    setTimeout(function () {
                                        thisTd.attr('style', '');
                                    }, 1000);
                                } else {
                                    alert("设置失败");
                                }
                            }
                        });
                    }
                },
                error: function (e) {
                    alert("更新报警邮箱失败！");
                }
            });
        } else {
            $.ajax({
                type: 'post',
                url: '/page/stockKeep/setStockLimit',
                data: {
                    id: stockKeepId,
                    stockLimit: stockLimit
                },
                success: function (result) {
                    if (result == 'SUCCESS') {
                        $("#setThresholdDiv").modal('hide');
                        var thisTd = $("#stockInfoTable tr[stockinfoid=" + stockInfoId + "] td:eq(10)");
                        thisTd.html(stockLimit);
                        thisTd.css('background', "#ffff00");
                        setTimeout(function () {
                            thisTd.attr('style', '');
                        }, 1000);
                    } else {
                        alert("设置失败");
                    }
                }
            });
        }
    });
    //DONE 提交修改在架数量&阈值
    $("#submitOnlineThreshold").click(function () {
        var idDom = $("#thresholdInputOnlineNumber");
        if (!isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        idDom = $("#thresholdInputOnlineStockNumber");
        if (!isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        try {
            if ($("#onlineThresholdInputNumber").val() - $("#thresholdInputOnlineNumber").val() < 0) {
                alert("在架数量不可大于库存数量!");
                return;
            }
        } catch (e) {
        }

        idDom = $("#thresholdInputOnlineEmail");
        if (!endWith(idDom.val(), ';')) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        var stockKeepId = $("#onlineThresholdInputStockKeepId").val();
        var stockInfoId = $("#onlineThresholdInputStockInfoId").val();
        if (hasThresholdInputOnlineEmailChange) {
            $.ajax({
                type: 'post',
                url: '/page/alarmContact/update',
                data: {
                    id: tempAlarmOnlineId,
                    stockInfoId: stockInfoId,
                    type: 'rack',
                    email: thresholdInputOnlineEmail.val()
                },
                success: function (result) {
                    if (result != 'SUCCESS') {
                        alert("更新报警邮箱失败！");
                    } else {
                        $.ajax({
                            type: 'post',
                            url: '/page/stockKeep/setRack',
                            data: {
                                id: stockKeepId,
                                number: $("#thresholdInputOnlineNumber").val(),
                                rackLimit: $("#thresholdInputOnlineStockNumber").val()
                            },
                            success: function (result) {
                                if (result == 'SUCCESS') {
                                    $("#stockInfoSubmitForm").submit();
                                } else {
                                    alert("设置失败");
                                }
                            }
                        });
                    }
                },
                error: function (e) {
                    alert("更新报警邮箱失败！");
                }
            })
        } else {
            $.ajax({
                type: 'post',
                url: '/page/stockKeep/setRack',
                data: {
                    id: stockKeepId,
                    number: $("#thresholdInputOnlineNumber").val(),
                    rackLimit: $("#thresholdInputOnlineStockNumber").val()
                },
                success: function (result) {
                    if (result == 'SUCCESS') {

                        $("#stockInfoSubmitForm").submit();
                    } else {
                        alert("设置失败");
                    }
                }
            });
        }
    });

    //DONE 提交修改库存数量
    $("#submitEditEntity").click(function () {
        var idDom = $("#editEntityNumber");
        if (!isInteger(idDom.val())) {
            idDom.tooltip('show');
            idDom.click(function () {
                idDom.tooltip('hide');
            });
            return;
        }

        try {
            if ($("#editEntityNumber").val() - $("#editEntityOnlineNumber").val() < 0) {
                alert("在架数量不可大于库存数量!");
                return;
            }
        } catch (e) {
        }

        var stockKeepId = $("#editEntityStockKeepId").val();
        var stockInfoId = $("#editEntityStockInfoId").val();
        var totalNumber = $("#editEntityNumber").val() - $("#editEntityOnlineNumber").val();
        $.ajax({
            type: 'post',
            url: '/page/stockKeep/update',
            data: {
                id: stockKeepId,
                stockInfoId: stockInfoId,
                totalNumber: totalNumber
            },
            success: function (result) {
                $("#stockInfoSubmitForm").submit();
            }
        });
    });

    var stockInfoUtil = {
        preview: function (purchaseId) {
            var previewSrc;
            $.ajax({
                type: "GET",
                data: {purchaseId: purchaseId},
                async: false,
                success: function (result) {
                    previewSrc = result;
                }
            });
            return previewSrc;
        }
    };

    //DONE 分页按钮 点击
    $("#paginationUl a").click(function () {
        var pageNo = $(this).html();
        if (isNaN(pageNo)) {
            pageNo = $(this).attr('pageNo');
        }
        if ($("#stockInfoSubmitForm #hiddenPageNo").length > 0) {
            $("#stockInfoSubmitForm #hiddenPageNo").val(pageNo);
        } else {
            $("#stockInfoSubmitForm").append('<input name="pageNo" type="hidden" value="' + pageNo + '" id="hiddenPageNo"/>');
        }
        $("#stockInfoSubmitButton").click();
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

//验证有两位小数的实数
function isFloat(a) {
    return /^-?\d{1,2}(.\d{1,2})?$/.test(a);
    //var reg0 = /^-?[0-9]+(.[0-9]{2})?$/;
    //var reg1 = /^-?[0-9]+(.[0-9]{1})?$/;
    //if (reg0.test(a) || reg1.test(a)) {
    //    return true;
    //}
    //return false;
}

//验证有两位小数的正实数
function isRightFloat(a) {
    return /^\d+(\.\d+)?$/.test(a);
}

//检查是否为正整数
function isInteger(a) {
    var reg = /^\d+$/
    return reg.test(a);
}

function endWith(o, s) {
    if (s == null || s == "" || o.length == 0 || s.length > o.length)
        return false;
    if (o.substring(o.length - s.length) == s)
        return true;
    else
        return false;
}