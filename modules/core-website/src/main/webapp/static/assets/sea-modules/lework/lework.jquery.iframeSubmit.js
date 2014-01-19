/**
 * 把表单提交到iframe里面.
 * eg:  $('#inputForm').targetIframe()
 *
 */
$(function () {
    /**
     * iframe 连接池
     * items 格式: {i,dom,status}
     * @type {Array}
     */
    var IFRAME_POOL = {} ,
        IFRAME_SRC = /^https/i.test(window.location.href || '') ? 'javascript:false' : 'about:blank';

    var defaults = {
    ///    iframeID: 'hidden_submit_iframe',       // Iframe ID.
   //     iframeSrc: /^https/i.test(window.location.href || '') ? 'javascript:false' : 'about:blank',
        formID: 'hidden_submit_form',
        formAction: null,
        formMethod: 'POST',
        data: [],  //[{name:'parameter name',value:'parameter value' }]
        complete: null  // function (response) {  } // after response from the server has been received.

    };

    /**
     * 创建一个iframe并保存到连接池
     * @param id  String   iframeID
     * return json
     */
    function createIframe(id) {
        var retJson ,
            $dom = $('<iframe id="' + id + '" name="' + id + '" src="' + IFRAME_SRC  + '" style="display:none" ></iframe>')
                .on('load', function () {
                    //事件回调,改变iframe状态
                    afterLoadedCallback(this)
                })
                .appendTo('body');
        //保存到iframe pool
        retJson = {
            id: id,
            dom: $dom[0],
            status: 'busy'
        };
        IFRAME_POOL[retJson.id] = retJson ;
        return retJson;
    }

    /**
     * 获取闲置的iframe
     * return json
     */
    function getIframe() {
        var retJson , id;
        for (id in  IFRAME_POOL) {
            if (IFRAME_POOL[id].status == 'free')
                retJson = IFRAME_POOL[id];
            break;
        }
        if (!retJson) {
            //  create  iframe
            retJson = createIframe((new Date()).getTime());
        }

        return retJson;
    }

    /**
     *iframe on load 事件回调,改变iframe状态
     * @param dom
     */
    function afterLoadedCallback(dom) {
        var id = dom.id, ret;
        for (id in  IFRAME_POOL) {
            if (IFRAME_POOL[id]['id'] == id)
                ret = IFRAME_POOL[id];
            ret[id].status= 'busy';
            break;
        }

        return ret;
    }


    /**
     *把表单提交到iframe里面.
     * @returns {*}
     */
    $.fn.targetIframe = function () {

        return this.each(function () {
            var iframeJson = getIframe();
            $(this).attr('target', iframeJson.id)
        })
    }

    //TODO 待实现!?
    $.submitIframe = function(opt){

    }

})