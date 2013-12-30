<%--
  Created by IntelliJ IDEA.
  User: Gongle
  Date: 13-12-27
  Time: 下午3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="../static/assets/js/html5shiv.js"></script>
    <script src="../static/assets/js/respond.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="/static/plugins/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="../static/assets/css/overwrite-bootstrap.css">

    <link rel="stylesheet" href="../static/assets/css/font-awesome/css/font-awesome.css">
    <!--[if IE 7]>
    <link rel="stylesheet" href="../static/assets/css/font-awesome/css/font-awesome-ie7.css">
    <![endif]-->
    <link rel="stylesheet" href="../static/assets/css/layout.css">
    <link rel="stylesheet" href="../static/assets/css/form.css">
    <link rel="stylesheet" href="../static/assets/css/button.css">
    <link rel="stylesheet" href="../static/assets/css/sidebar2.css">
    <link rel="stylesheet" href="../static/assets/css/table.css">
    <link rel="stylesheet" href="../static/assets/css/tabs.css">
    <link rel="stylesheet" href="../static/assets/css/component.css">
    <link rel="stylesheet" href="../static/assets/css/utils.css">

    <link rel="stylesheet" href="../static/assets/sea-modules/jquery-qtip2/jquery.qtip.css">
    <link rel="stylesheet" href="../static/assets/sea-modules/jquery-chosen/chosen.css">
    <link rel="stylesheet" href="../static/assets/sea-modules/jquery-colorbox/colorbox.css">

    <!--lework custom component style-->
    <link rel="stylesheet" href="../static/assets/css/lework.component.css">

    <title>CMD:seajs hello world</title>
    <link rel="stylesheet" href="">
    <script src="../static/assets/sea-modules/seajs/2.1.1/sea-debug.js"></script>
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
                'wdatePicker': 'My97DatePicker/WdatePicker.js',
                'xDate': 'xdate/xdate.js',
                'confirmDelete': 'lework/lework.jquery.confirmdelete.js',
                'extendPrototype': 'lework/lework.prototype.js',
                'utils': 'lework/lework.utils.js'
            },
            preload: ['jquery','extendPrototype']
        });
        seajs.on('exec', function (module) {
            if (module.uri === seajs.resolve('jquery')) {
               // window.$ = window.jQuery = module.exports;
            }
        })
    </script>
    <script>
        //demo :: main
        seajs.use(['blockUI' , 'cookie','datatables','validate' ], function (blockUI,$) {

        })
        seajs.use(['confirmDelete' ], function ($) {
            $('#seaJsConfirmDelete').confirmDelete({onConfirm: function () {
                //snip...
                //返回false弹出层将不会关闭
                return true;
            },
            onCancel:function(){
                //snip...
                //返回false弹出层将不会关闭
            //    return false;
            }
            });
        })
    </script>
</head>
<body>
   <h2>CMD:seajs hello world</h2>
  <div class="row">
      <div class="col-md-5"></div>
      <div class="col-md-5">
          <a href="javascript:;" id="seaJsConfirmDelete">confirmDelete</a>
      </div>
  </div>
</body>
</html>