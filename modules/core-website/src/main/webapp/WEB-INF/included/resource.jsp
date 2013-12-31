<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%--<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>--%>

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

<link rel="stylesheet" href="${ctx}/static/assets/sea-modules/jquery-qtip2/jquery.qtip.css">
<link rel="stylesheet" href="${ctx}/static/assets/sea-modules/jquery-chosen/chosen.css">
<link rel="stylesheet" href="${ctx}/static/assets/sea-modules/jquery-colorbox/colorbox.css">

<!-- easyui css custom theme    -->
 <link rel="stylesheet" href="${ctx}/static/plugins/easyui/1.3.2/themes/bootstrap/easyui.custom.css" >

<!--lework custom component style-->
<link rel="stylesheet" href="${ctx}/static/assets/css/lework.component.css">
<script src="${ctx}/static/assets/sea-modules/seajs/2.1.1/sea-debug.js"></script>
<script>
    // Set configuration
    seajs.config({
        base: '<%=request.getContextPath()%>/static/assets/sea-modules',
        alias: {
            'jquery': 'jquery/1.10.2/jquery-debug.js',
            'migrate': 'jquery/1.10.2/jquery-migrate.js',
            'cookie': 'jquery-cookie/jquery.cookie.js',
            'datatables': 'jquery-datatables/1.9.4/jquery.dataTables.js',
            'qtip2': 'jquery-qtip2/jquery.qtip.js',
            'chosen': 'jquery-chosen/chosen.jquery.js',
            'colorbox': 'jquery-colorbox/jquery.colorbox.js',
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
            'funPage': 'lework/lework.function.page.js',
            'utils': 'lework/lework.utils.js'
        },
        preload: ['jquery', 'bootstrap', 'extendPrototype','funPage']
    });
    seajs.on('exec', function (module) {
        if (module.uri === seajs.resolve('jquery')) {
            // window.$ = window.jQuery = module.exports;
        }
    })
</script>

<!-- jquery easyui loader-->
<script src="${ctx}/static/plugins/easyui/1.3.2/easyloader.js" ></script>

<script>
    /**====================
     * jquery easyui
     * ====================**/
    if (easyloader) {
        easyloader.locale = "zh_CN"; // 本地化设置
        easyloader.theme = "bootstrap"; // 设置主题
        easyloader.css = false  ;
    }

</script>


