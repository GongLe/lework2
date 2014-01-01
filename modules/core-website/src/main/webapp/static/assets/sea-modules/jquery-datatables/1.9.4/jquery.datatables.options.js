;
(function (window, document, undefined) {

    var init = function ($) {
        /** jquery DataTables Plugins 全局设置 **/
        if ($.fn.dataTable) {
            /**
             * 扩充datatables方法,刷新,保持分页,排序信息.
             */
            $.fn.dataTableExt.oApi.fnStandingRedraw = function (oSettings) {
                if (oSettings.oFeatures.bServerSide === false) {
                    var before = oSettings._iDisplayStart;

                    oSettings.oApi._fnReDraw(oSettings);

                    // iDisplayStart has been reset to zero - so lets change it back
                    oSettings._iDisplayStart = before;
                    oSettings.oApi._fnCalculateEnd(oSettings);
                }

                // draw the 'current' page
                oSettings.oApi._fnDraw(oSettings);
            };
            /**适配Spring data jpa page 参数
             * @link{http://docs.spring.io/spring-data/jpa/docs/1.4.2.RELEASE/reference/html/repositories.html}
             */
            $.springDataJpaPageableAdapter = function (sSource, aoData, fnCallback, oSettings) {

                //extract name/value pairs into a simpler map for use later
                var paramMap = {};
                for (var i = 0; i < aoData.length; i++) {
                    paramMap[aoData[i].name] = aoData[i].value;
                }
                var colSize = parseInt(paramMap['iColumns']);
                //page calculations ,仅支持单列排序
                var pageSize = paramMap.iDisplayLength;
                var start = paramMap.iDisplayStart;
                var pageNum = (start == 0) ? 1 : (start / pageSize) + 1; // pageNum is 1 based
                //排序的列索引
                var sortColsDetail = [] , indexTemp;

                //计算排序列,最多支持{colSize}次排序
                for (var j = 0; j < colSize; j++) {
                    indexTemp = paramMap['iSortCol_' + j ];
                    if (!indexTemp) {
                        break;
                    }
                    sortColsDetail.push(paramMap['mDataProp_' + indexTemp ] + ',' + paramMap['sSortDir_' + j ])
                }

                //create new json structure for parameters for REST request
                // var restParams = [] ;
                var restParams = aoData;
                restParams.push({'name': 'size', 'value': pageSize  });
                restParams.push({'name': 'page', 'value': pageNum - 1});
                //  restParams.push({'name': 'sort', 'value': sortName });
                //写入排序
                for (var i = 0; i < sortColsDetail.length; i++) {
                    restParams.push({'name': 'sort', 'value': sortColsDetail[i] })
                }
                //finally, make the request
                oSettings.jqXHR = $.ajax({
                    'dataType': 'json',
                    'type': 'post',
                    'url': sSource,
                    'data': restParams,
                    'success': function (data) {
                        data.sEcho = paramMap.sEcho;
                        fnCallback(data);
                    }
                });
            };
            //datatables 配置
            var _opt = {
                sPaginationType: 'full_numbers',
                oLanguage: {
                    sSearch: '<span>搜索:</span> ',
                    sInfo: '显示_START_到_END_条,共_TOTAL_条记录',
                    sInfoEmpty: '显示0到0条,共0条记录',
                    sLengthMenu: '每页_MENU_条',
                    sProcessing: '&nbsp;',
                    sEmptyTable: '<div class="alert no-margin" style="font-size:12px;padding:5px;">无可用数据</div>',
                    sZeroRecords: '<div class="alert no-margin" style="font-size:12px;padding:5px;">无记录数据/div>',
                    oPaginate: {  'sFirst': '首页', 'sPrevious': ' 上一页 ', 'sNext': ' 下一页 ', 'sLast': ' 尾页 ' }
                }
            };
            $.extend(true, $.fn.dataTable.defaults, _opt);


        }
    }

    // CMD模块化 jquery plugin
    if (typeof define === "function" && define) {
        define(function (require) {
            var jQuery = require('jquery');
            require('_datatables')  ;
            init(jQuery);
            return jQuery;
        });
    } else {
        // 无模块化时,直接赋值到jQuery全局变量
        init(window.jQuery);
    }

})(window, document, undefined)
