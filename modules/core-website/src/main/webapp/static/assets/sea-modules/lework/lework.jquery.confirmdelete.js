/**
 * 基于qtip2实现inline confirm box效果,
 * 依赖于jquery.qtip2插件
 * css  class qtip-confirmbox
 * @author Gongle
 * @date 2013年10月15日
 * <code>
        $('#ID').confirmDelete({onConfirm: function () {
                //snip...
                //返回false弹出层将不会关闭
                return true;
            },
            onCancel:function(){
                //snip...
                //返回false弹出层将不会关闭
                return false;
            }
            });
 * </code>
 **/

;
(function (window, document, undefined) {

    var init = function ($) {
        var ConfirmDelete = function (ele, options) {
            this.options = options;
            this.$ele = $(ele);
            this.init();
        };
        // ConfirmBox PLUGIN DEFINITION
        // =======================
        ConfirmDelete.DEFAULTS = {
            onConfirm: null,
            onCancel: null,
            text: '<span class="text-warning" >确认删除？</span>',
            position: {my: 'center center',
                at: 'center center',
                adjust: {
                    x: -45
                }
            },
            cssClass: 'qtip-confirmbox',
            viewport: $(window)
        };
        var old = $.fn.confirmDelete;
        ConfirmDelete.prototype.init = function () {
            this.bindQtip2();
        }
        ConfirmDelete.prototype.hide = function () {
            this.$ele.qtip('hide');
        }
        ConfirmDelete.prototype.show = function () {
            this.$ele.qtip('show');
        }
        ConfirmDelete.prototype.bindQtip2 = function () {
            var that = this;
            this.$ele.qtip({
                overwrite: false,
                style: {
                    name: 'light',
                    classes: this.options.cssClass
                },
                show: {solo: true, ready: true},

                position: this.options.position,
                show: {
                    event: 'click'
                },
                hide: {
                    event: 'unfocus'
                },
                events: {
                    render: function (event, api) {
                        //确认
                        $('.confirmDelete', api.elements.content).on('click', function (e) {
                            e.preventDefault();

                            if ($.isFunction(that.options.onConfirm))
                                that.options.onConfirm.apply(that.$ele[0], that.$ele[0]) != false && that.hide();
                            else
                                that.hide();


                        });
                        //取消
                        $('.confirmCancel', api.elements.content).on('click', function (e) {
                            e.preventDefault();
                            if ($.isFunction(that.options.onCancel))
                                that.options.onCancel.apply(that.$ele[0], that.$ele[0]) != false && that.hide();
                            else
                                that.hide();
                        });
                    }
                },
                content: {text: '<div style="min-width:160px;">' + that.options.text + '<button class="btn btn-danger btn-sm  confirmDelete" >确认</button>&nbsp;' +
                    ' <button class="btn btn-white btn-sm  confirmCancel" >取消</button> </div> '},
                viewport: this.options.viewport
            });
        }

        $.fn.confirmDelete = function (option) {
            return this.each(function () {
                var $this = $(this)
                var data = $this.data('lework.confirmDelete')
                var options = $.extend({}, ConfirmDelete.DEFAULTS, typeof option == 'object' && option)
                if (!data) {
                    $this.data('lework.confirmDelete', (data = new ConfirmDelete(this, options)));
                }

                if (typeof option == 'string') data[option].call(data)
            })
        }

        $.fn.confirmDelete.Constructor = ConfirmDelete;


        // ConfirmDelete NO CONFLICT
        // =================

        $.fn.confirmDelete.noConflict = function () {
            $.fn.confirmDelete = old
            return this
        }

    }

    // CMD模块化 jquery plugin
    if (typeof define === "function" && define) {
        define(function (require) {
            var jQuery = require('jquery');
            require('qtip2');
            init(jQuery);
            return jQuery;
        });
    } else {
        // 无模块化时,直接赋值到jQuery全局变量
        init(window.jQuery);
    }

})(window, document, undefined);
