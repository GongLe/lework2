/**
 * lework alert 组件
 * google alert style @see http://www.bootcss.com/p/google-bootstrap/components.html#alerts
 * User: Gongle
 * Date: 13-11-23
 */

;(function ( window, document, undefined ) {

    var init = function($) {

        var $container;
        var noop = function () {
        };
        var DEFAULTS = {
            onClose: noop,
            content: '', /**html or text **/
            timer: 5000, /** 6秒后关闭 **/
            id: null,
            width: '150px',
            type: '', /**info,success,danger,error**/
            parentEl: 'body' /**父容器,默认为body**/
        };



        function Notfiy(opt) {
            this.settings = $.extend({}, DEFAULTS, opt);
            this.init();
            this.create();
            this.autoColse();
        };
        Notfiy.prototype.init = function () {
            if (!$container) {
                //创建容器
                $(this.settings.parentEl)
                    .append('<div class="lework-PopupPanel" id="lework-PopupPanel" ></div>');
                $container = $('#lework-PopupPanel')
            }
        };

        /**渲染html,附件事件
         * <pre>
         *     <div class="lework-notify" id="1386050958197">
         *         <div class="lework-notify-inner">hello</div>
         *         <button type="button" class="close" title="关闭">×</button>
         *         </div>
         *     </pre>
         */
        Notfiy.prototype.create = function () {
            var that = this;
            //create alert body
            this.$alert = $('<div />')
                /*.css('width', this.settings.width)*/
                .addClass('lework-notify' + (this.settings.type ? ' lework-notify-' + this.settings.type : ''))
                .prop({'id': (this.settings.id ? this.settings.id : (new Date()).getTime()) })
                .on('close.alert', function () {
                    that.hide();
                    if ($.isFunction(that.settings.onClose)) {
                        that.settings.onClose.apply(this);
                    }
                    that.destroy();
                }) .html('<div class="alert-inner-text">'+(that.settings.content || '&nbsp;&nbsp;')+'</div> ')
            this.$alert.append(' <button type="button" class="close" title="关闭" >×</button> ')
            //关闭按钮
            this.$alert.on('click', '.close', function (e) {
                e.preventDefault();
                $(this).parent().trigger('close.alert');
            })
            that.$alert.appendTo($container);
            $('<div class="clearfix" />').appendTo($container);
        };
        Notfiy.prototype.autoColse = function () {
            // debugger;
            //自动关闭
            var that = this;
            if (that.settings.timer) {
                setTimeout(function () {
                    that.$alert.trigger('close.alert');
                }, that.settings.timer)
            }
        }
        Notfiy.prototype.hide = function () {
            this.$alert.hide();
        };
        Notfiy.prototype.destroy = function () {
            this.$alert.off('close.alert').remove();
            //   this.$alert = null;
        };
        Notfiy.prototype.update = function (content) {
            this.$alert.html(this.settings.content);
        }
        return function (options) {
            return   new Notfiy(options);
        }
    } ;

    // CMD模块化
    if (typeof define === "function" && define) {
        define(function (require ) {
            var jQuery = require('jquery');
            require('./notify.css');    //load css
            return init(jQuery);
        });
    } else {
        // 无模块化时,直接赋值到jQuery全局变量
        window.notify= init(window.jQuery);
    }

})( window, document, undefined );
