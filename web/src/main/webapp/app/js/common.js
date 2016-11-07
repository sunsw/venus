/*!
 * jquery-confirm v1.7.5 (http://craftpip.github.io/jquery-confirm/)
 * Author: Boniface Pereira
 * Website: www.craftpip.com
 * Contact: hey@craftpip.com
 *
 * Copyright 2013-2015 jquery-confirm
 * Licensed under MIT (https://github.com/craftpip/jquery-confirm/blob/master/LICENSE)
 */

if (typeof jQuery === 'undefined') {
    throw new Error('jquery-confirm requires jQuery');
}

Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1,                 //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds()                 //秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

var jconfirm, Jconfirm;
(function ($) {
    "use strict";
    $.confirm = function (options) {
        /*
         *  Alias of jconfirm
         */
        return jconfirm(options);
    };
    $.alert = function (options) {
        /*
         *  Alias of jconfirm
         */
        options.cancelButton = false;
        return jconfirm(options);
    };
    $.dialog = function (options) {
        /*
         *  Alias of jconfirm
         */
        options.cancelButton = false;
        options.confirmButton = false;
        return jconfirm(options);
    };
    jconfirm = function (options) {
        /*
         * initial function for calling.
         */
        if (jconfirm.defaults) {
            /*
             * Merge global defaults with plugin defaults
             */
            $.extend(jconfirm.pluginDefaults, jconfirm.defaults);
        }
        /*
         * merge options with plugin defaults.
         */
        var options = $.extend({}, jconfirm.pluginDefaults, options);
        return new Jconfirm(options);
    };
    Jconfirm = function (options) {
        /*
         * constructor function Jconfirm,
         * options = user options.
         */
        $.extend(this, options);
        this._init();
    };
    Jconfirm.prototype = {
        _init: function () {
            var that = this;
            this._rand = Math.round(Math.random() * 99999);
            this._buildHTML();
            this._bindEvents();
            setTimeout(function () {
                that.open();
            }, 0);
        },
        animations: ['anim-scale', 'anim-top', 'anim-bottom', 'anim-left', 'anim-right', 'anim-zoom', 'anim-opacity', 'anim-none', 'anim-rotate', 'anim-rotatex', 'anim-rotatey', 'anim-scalex', 'anim-scaley'],
        _buildHTML: function () {
            var that = this;

            /*
             * Cleaning animations.
             */
            this.animation = 'anim-' + this.animation.toLowerCase();
            if (this.animation === 'none')
                this.animationSpeed = 0;

            /*
             * Append html to body.
             */
            this.$el = $(this.template).appendTo(this.container).addClass(this.theme);
            this.$el.find('.jconfirm-box-container').addClass(this.columnClass);

            this.CSS = {
                '-webkit-transition-duration': this.animationSpeed / 1000 + 's',
                'transition-duration': this.animationSpeed / 1000 + 's',
                '-webkjit-transition-timing-function': 'cubic-bezier(0.27, 1.12, 0.32, ' + this.animationBounce + ')',
                'transition-timing-function': 'cubic-bezier(0.27, 1.12, 0.32, ' + this.animationBounce + ')',
            };

            this.$el.find('.jconfirm-bg').css(this.CSS);
            this.$b = this.$el.find('.jconfirm-box').css(this.CSS).addClass(this.animation);

            /*
             * Setup title contents
             */
            this.setTitle();
            this.contentDiv = this.$el.find('div.content');

            /*
             * Settings up buttons
             */
            this.$btnc = this.$el.find('.buttons');
            if (this.confirmButton && this.confirmButton.trim() !== '') {
                this.$confirmButton = $('<button class="btn">' + this.confirmButton + '</button>')
                    .appendTo(this.$btnc)
                    .addClass(this.confirmButtonClass);
            }
            if (this.cancelButton && this.cancelButton.trim() !== '') {
                this.$cancelButton = $('<button class="btn">' + this.cancelButton + '</button>')
                    .appendTo(this.$btnc)
                    .addClass(this.cancelButtonClass);
            }

            if (!this.confirmButton && !this.cancelButton) {
                this.$btnc.remove();
            }

            if (!this.confirmButton && !this.cancelButton && this.closeIcon == null) {
                this.$closeButton = this.$b.find('.closeIcon').show();
            }

            if (this.closeIcon === true) {
                this.$closeButton = this.$b.find('.closeIcon').show();
            }

            this.setContent();

            if (this.autoClose)
                this._startCountDown();
        },
        setTitle: function (string) {
            this.title = (typeof string !== 'undefined') ? string : this.title;

            if (this.title) {
                this.$el.find('div.title').html('<i class="' + this.icon + '"></i> ' + this.title);
            } else {
                this.$el.find('div.title').remove();
            }
        },
        setContent: function (string) {
            var that = this;
            this.content = (string) ? string : this.content;
            var animate = (string) ? true : false;

            /*
             * Set content.
             */
            if (typeof this.content === 'boolean') {
                if (!this.content)
                    this.contentDiv.remove();
                else
                    console.error('Invalid option for property content: passed TRUE');
            } else if (typeof this.content === 'string') {

                if (this.content.substr(0, 4).toLowerCase() === 'url:') {
                    this.contentDiv.html('');
                    this.$btnc.find('button').prop('disabled', true);
                    var url = this.content.substring(4, this.content.length);
                    $.get(url).done(function (html) {
                        that.contentDiv.html(html);
                    }).always(function (data, status, xhr) {
                        if (typeof that.contentLoaded === 'function')
                            that.contentLoaded(data, status, xhr);

                        that.$btnc.find('button').prop('disabled', false);
                        that.setDialogCenter();
                    });
                } else {
                    this.contentDiv.html(this.content);
                }

            } else if (typeof this.content === 'function') {

                this.contentDiv.html('');
                this.$btnc.find('button').attr('disabled', 'disabled');

                var promise = this.content(this);
                if (typeof promise !== 'object') {
                    console.error('The content function must return jquery promise.');
                } else if (typeof promise.always !== 'function') {
                    console.error('The object returned is not a jquery promise.');
                } else {
                    promise.always(function (data, status) {
                        that.$btnc.find('button').removeAttr('disabled');
                        that.setDialogCenter();
                    });
                }

            } else {
                console.error('Invalid option for property content, passed: ' + typeof this.content);
            }

            this.setDialogCenter(animate);
        },
        _startCountDown: function () {
            var opt = this.autoClose.split('|');
            if (/cancel/.test(opt[0]) && this.type === 'alert') {
                return false;
            } else if (/confirm|cancel/.test(opt[0])) {
                this.$cd = $('<span class="countdown">').appendTo(this['$' + opt[0] + 'Button']);
                var that = this;
                that.$cd.parent().click();
                var time = opt[1] / 1000;
                this.interval = setInterval(function () {
                    that.$cd.html(' [' + (time -= 1) + ']');
                    if (time === 0) {
                        that.$cd.parent().trigger('click');
                        clearInterval(that.interval);
                    }
                }, 1000);
            } else {
                console.error('Invalid option ' + opt[0] + ', must be confirm/cancel');
            }
        },
        _bindEvents: function () {
            var that = this;

            this.$el.find('.jconfirm-scrollpane').click(function (e) {
                if (that.backgroundDismiss) {
                    that.cancel();
                    that.close();
                } else {
                    that.$b.addClass('hilight');
                    setTimeout(function () {
                        that.$b.removeClass('hilight');
                    }, 400);
                }
            });

            this.$el.find('.jconfirm-box').click(function (e) {
                e.stopPropagation();
            });

            if (this.$confirmButton) {
                this.$confirmButton.click(function (e) {
                    e.preventDefault();
                    var r = that.confirm(that.$b);
                    that.onAction();

                    if (typeof r === 'undefined' || r)
                        that.close();
                });
            }
            if (this.$cancelButton) {
                this.$cancelButton.click(function (e) {
                    e.preventDefault();
                    var r = that.cancel(that.$b);
                    that.onAction();

                    if (typeof r === 'undefined' || r)
                        that.close();
                });
            }
            if (this.$closeButton) {
                this.$closeButton.click(function (e) {
                    e.preventDefault();
                    that.cancel();
                    that.onAction();
                    that.close();
                });
            }
            if (this.keyboardEnabled) {
                setTimeout(function () {
                    $(window).on('keyup.' + this._rand, function (e) {
                        that.reactOnKey(e);
                    });
                }, 500);
            }

            $(window).on('resize.' + this._rand, function () {
                that.setDialogCenter(true);
            });

        },
        reactOnKey: function key(e) {

            /*
             * prevent keyup event if the dialog is not last!
             */
            var a = $('.jconfirm');
            if (a.eq(a.length - 1)[0] !== this.$el[0])
                return false;

            var key = e.which;
            if (key === 27) {
                /*
                 * if ESC key
                 */
                if (!this.backgroundDismiss) {
                    /*
                     * If background dismiss is false, Glow the modal.
                     */
                    this.$el.find('.jconfirm-bg').click();
                    return false;
                }

                if (this.$cancelButton) {
                    this.$cancelButton.click();
                } else {
                    this.close();
                }
            }
            if (key === 13 || key == 32) {
                /*
                 * if ENTER or SPACE key
                 */
                if (this.$confirmButton) {
                    this.$confirmButton.click();
                } else {

                }
            }
        },
        setDialogCenter: function (animate) {
            var windowHeight = $(window).height();
            var boxHeight = this.$b.outerHeight();
            var topMargin = (windowHeight - boxHeight) / 8;
            var minMargin = 100;
            if (boxHeight > (windowHeight - minMargin)) {
                var style = {
                    'margin-top': minMargin / 8,
                    'margin-bottom': minMargin / 2,
                }
            } else {
                var style = {
                    'margin-top': topMargin,
                }
            }
            if (animate) {
                this.$b.animate(style, {
                    duration: this.animationSpeed,
                    queue: false
                });
            } else {
                this.$b.css(style);
            }
        },
        close: function () {
            var that = this;

            if (this.isClosed())
                return false;

            if (typeof this.onClose === 'function')
                this.onClose();
            /*
             unbind the window resize & keyup event.
             */
            $(window).unbind('resize.' + this._rand);
            if (this.keyboardEnabled)
                $(window).unbind('keyup.' + this._rand);

            that.$el.find('.jconfirm-bg').removeClass('seen');
            this.$b.addClass(this.animation);

            setTimeout(function () {
                that.$el.remove();
            }, this.animationSpeed + 10); // wait 10 miliseconds more, ensure everything is done.

            jconfirm.record.closed += 1;
            jconfirm.record.currentlyOpen -= 1;

            if (jconfirm.record.currentlyOpen < 1)
                $('body').removeClass('jconfirm-noscroll');

            return true;
        },
        open: function () {
            var that = this;
            if (this.isClosed())
                return false;

            that.$el.find('.jconfirm-bg').addClass('seen');

            $('body').addClass('jconfirm-noscroll');
            this.$b.removeClass(this.animations.join(' '));
            /**
             * Blur the focused elements, prevents re-execution with button press.
             */
            $('body :focus').trigger('blur');
            this.$b.find('input[autofocus]:visible:first').focus();
            jconfirm.record.opened += 1;
            jconfirm.record.currentlyOpen += 1;
            if (typeof this.onOpen === 'function')
                this.onOpen();
            return true;
        },
        isClosed: function () {
            return (this.$el.css('display') === '') ? true : false;
        }
    };

    jconfirm.pluginDefaults = {
        template: '<div class="jconfirm"><div class="jconfirm-bg"></div><div class="jconfirm-scrollpane"><div class="container"><div class="row"><div class="jconfirm-box-container span6 offset3"><div class="jconfirm-box"><div class="closeIcon"><span class="glyphicon glyphicon-remove"></span></div><div class="title"></div><div class="content"></div><div class="buttons"></div><div class="jquery-clear"></div></div></div></div></div></div></div>',
        title: 'Hello',
        content: 'Are you sure to continue?',
        contentLoaded: function () {
        },
        icon: '',
        confirmButton: '确定',
        cancelButton: '取消',
        confirmButtonClass: 'btn-default',
        cancelButtonClass: 'btn-default',
        theme: 'white',
        animation: 'scale',
        animationSpeed: 400,
        animationBounce: 1.5,
        keyboardEnabled: false,
        container: 'body',
        confirm: function () {
        },
        cancel: function () {
        },
        backgroundDismiss: true,
        autoClose: false,
        closeIcon: null,
        columnClass: 'col-md-6 col-md-offset-3',
        onOpen: function () {
        },
        onClose: function () {
        },
        onAction: function () {
        }
    };

    jconfirm.record = {
        opened: 0,
        closed: 0,
        currentlyOpen: 0,
    };
})(jQuery);

//DONE 覆盖alert
window.alert = function (message, func) {
    $.alert({
        title: '提示!!',
        content: '<span style="font-size: 2em">' + message + '</span>',
        confirmButtonClass: 'btn-info',
        animation: 'top',
        onClose: function () {
            func && func();
        }
    });
};
//DONE 覆盖confirm
window.confirm = function (message, func, cancelFunc) {
    $.confirm({
        title: '确认!',
        content: '<span style="font-size: 2em">' + message + '</span>',
        confirmButtonClass: 'btn-danger',
        cancelButtonClass: 'btn-info',
        animation: 'top',
        confirm: function () {
            func && func();
        },
        cancel: function () {
            cancelFunc && cancelFunc();
        }
    });
};

$(function () {

    $(".navbar-nav li.stock-nav").click(function () {
        /**
         * 导航栏按钮
         */
        $(this).parent().find("li").removeClass("active");
        $(this).addClass("active");
        //var listGroup = $(".stock-sidebar div.list-group");
        //listGroup.hide();
        //listGroup.filter("[showFor="+$(this).find("a").html()+"]").show();
    });
    $(".stock-sidebar div.list-group[showFor]:first").show();
    //tooltip 手动触发
    $("[data-toggle=tooltip]").tooltip({
        trigger: 'manual'
    });

    //$("#button1").click(function(){
    //    confirm('请正确输入表单内容，请验证输入信息的正确！',function(){
    //        alert('ok');
    //    },function(){
    //        alert('cancel');
    //    });
    //});

    //DONE resetPassword
    $("#showResetPasswordDiv").click(function () {
        $("#oldPsw").val("");
        $("#newPsw").val("");
        $("#confPsw").val("");
        $("#resetPasswordDiv").modal({
            backdrop: 'static',
            keyboard: false
        });
    });
    $("#oldPsw").keyup(function () {
        if ($(this).val().length > 0) {
            $(this).tooltip('hide');
        }
    });
    $("#newPsw").keyup(function () {
        if ($(this).val().length > 4) {
            $(this).tooltip('hide');
        }
        if ($(this).val() == $("#confPsw").val()) {
            $("#confPsw").tooltip('hide');
        }
    });
    $("#confPsw").keyup(function () {
        if ($("#newPsw").val() == $(this).val()) {
            $(this).tooltip('hide');
        } else {
            $(this).tooltip('show');
        }
    });
    $("#submitResetPassword").click(function () {
        var oldPsw = $("#oldPsw").val();
        var newPsw = $("#newPsw").val();
        var confPsw = $("#confPsw").val();
        if (oldPsw.length < 1) {
            $("#oldPsw").tooltip('show');
            return;
        }
        if (newPsw.length < 5) {
            $("#newPsw").tooltip('show');
            return;
        }
        if (confPsw != newPsw) {
            $("#confPsw").tooltip('show');
            return;
        }
        confirm('请确认您将修改您的密码！', function () {
            $.ajax({
                type: 'post',
                url: '/page/user/changePsw',
                data: {
                    oldPsw: oldPsw,
                    newPsw: newPsw,
                    confPsw: confPsw
                },
                success: function (result) {
                    if (result == 'logout') {
                        //未登录
                        alert('对不起，您未登录请前往登录', function () {
                            window.location.href = '/page/login';
                        });
                    } else if (result == 'misMatch') {
                        //misMatch:新密码两次不匹配
                        $("#confPsw").tooltip('show');
                    } else if (result == 'wrongPsw') {
                        //wrongPsw:原密码错误
                        alert('您输入的当前密码不正确', function () {
                            //$("#oldPsw").focus();
                        });
                    } else if (result == 'fail') {
                        //fail:修改失败
                        alert('修改失败');
                    } else if (result == 'success') {
                        //success:修改成功
                        alert('修改密码成功，下次登录请使用新密码');
                        $("#resetPasswordDiv").modal('hide');
                    } else {
                        alert('未知异常');
                    }
                },
                error: function (e) {
                    alert('未知异常');
                }
            })
        });
    });

    $('input,select').keypress(function (event) {
        if (event.keyCode == 13 && $('div.modal:not(:hidden)').length == 0) {
            $('.enter_press_search').click();
        }
    });

});
