<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp"%>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
    <script src="static/assets/js/html5shiv.js"></script>
    <script src="static/assets/js/respond.js"></script>
<![endif]-->

<link rel="stylesheet" href="${ctx}/static/assets/sea-modules/bootstrap/3.0.3/bootstrap.css" >
<link rel="stylesheet" href="${ctx}/static/assets/css/overwrite-bootstrap.css" >

<link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome/css/font-awesome.css">
<!--[if IE 7]>
<link rel="stylesheet" href="${ctx}/static/assets/css/font-awesome/css/font-awesome-ie7.css">
<![endif]-->
<link rel="stylesheet" href="${ctx}/static/assets/css/layout.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/form.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/button.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/sidebar2.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/table.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/tabs.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/component.css">
<link rel="stylesheet" href="${ctx}/static/assets/css/utils.css">
<!--color theme-->
<link rel="stylesheet" href="${ctx}/static/assets/css/color.coffee.css">


<!--lework custom component style-->
<link rel="stylesheet" href="${ctx}/static/assets/css/lework.component.css">
<script src="${ctx}/static/assets/sea-modules/seajs/2.1.1/sea-debug.js"></script>

<script>
    var STATIC_VERSION = (new Date()).getTime() ;
    // Set configuration
    seajs.config({
        base: '<%=request.getContextPath()%>/static/assets/sea-modules',
        map: [
            [ '.js' , '.js?v=' + STATIC_VERSION  ],
            [ '.css' , '.css?v=' + STATIC_VERSION  ]
        ],
        alias: {
            '_jquery': 'jquery/1.10.2/jquery-debug.js',
            'jquery': 'jquery/1.10.2/jquery-migrate.js',
            'cookie': 'jquery-cookie/jquery.cookie.js',
            'easyui': 'easyui/jquery.easyui.min.js',
            '_easyuiCss': 'easyui/themes/bootstrap/easyui.custom.css',
            '_easyuiLocale': 'easyui/locale/easyui-lang-zh_CN.js',
            '_datatables': 'jquery-datatables/1.9.4/jquery.dataTables.js', /**私有模块,供模块依赖调用**/
            'datatables': 'jquery-datatables/1.9.4/jquery.dataTables.options.js',
            'form': 'jquery-form/jquery.form.js',
            'qtip2': 'jquery-qtip2/jquery.qtip.js',
            'chosen': 'jquery-chosen/chosen.jquery.js',
            'colorbox': 'jquery-colorbox/jquery.colorbox.js',
            'dialog': 'artDialog/4.1.7/jquery.artDialog.js',
            'notify': 'notify/notify.js',
            'slimscroll': 'jquery-slimscroll/jquery.slimscroll.js',
            'blockUI': 'jquery-blockUI/jquery.blockUI.js',
            'validate': 'jquery-validation/1.11.1/jquery.validate.js',
            'validateMethods': 'jquery-validation/1.11.1/additional-methods.js',
            'validate_cn_zh': 'jquery-validation/1.11.1/jquery_validate_message_cn_zh.js',
            'fullCalendar': 'jquery-fullcalendar/1.6.4/fullcalendar.js',
            'bootstrap': 'bootstrap/3.0.3/bootstrap.js',
            'bootbox': 'bootbox/4.1.0/bootbox.js',
            'wdatePicker': 'My97DatePicker/WdatePicker.js',
            'xDate': 'xdate/xdate.js',
            'confirmDelete': 'lework/lework.jquery.confirmdelete.js',
            'extendPrototype': 'lework/lework.prototype.js',
            'funPage': 'lework/lework.function.page.js', /**页面功能定义**/
            'utils': 'lework/lework.utils.js',
            'mustache': 'mustache/mustache.js'
        },
        preload: ['jquery', 'bootstrap', 'extendPrototype', 'funPage','chosen','slimscroll' ]
    });
    seajs.on('exec', function (module) {
        if (module.uri === seajs.resolve('jquery')) {
            // window.$ = window.jQuery = module.exports;
        }
    })

</script>



