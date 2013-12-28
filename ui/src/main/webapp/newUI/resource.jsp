<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

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
<!--lework custom component style-->
<link rel="stylesheet" href="../static/assets/css/lework.component.css">
<%--<link id="colorTheme" rel="stylesheet" href="../static/assets/css/color.blue.css">--%>
<script src="../static/assets/js/jquery-1.10.2.js"></script>
<script src="../static/assets/js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript">
    if("ontouchend" in document) document.write("<script src='../static/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="../static/plugins/bootstrap/js/bootstrap.js"></script>
<!-- jquery validation -->
<script src="../static/plugins/jquery-validation/1.11.1/jquery.validate.js"></script>
<script src="../static/plugins/jquery-validation/1.11.1/additional-methods.js"></script>
<script src="../static/plugins/jquery-validation/1.11.1/jquery_validate_message_cn_zh.js" ></script>
<!--jquery datatables-->
<script src="../static/plugins/DataTables-1.9.4/media/js/jquery.dataTables.js"></script>
<!--jquery template JSRender-->
<script src="../static/plugins/JsRender/jsrender.min.js"></script>
<!--qtip2-->
<link rel="stylesheet" href="../static/plugins/qtip2/jquery.qtip.css">
<script src="../static/plugins/qtip2/jquery.qtip.js"></script>
<!--jquery.slimscroll-->
<script src="../static/plugins/slimscroll/jquery.slimscroll.js"></script>

<script src="../static/plugins/blockUI/jquery.blockUI.js"></script>

<!--jquery chonse-->
<script src="../static/plugins/chosen/chosen.jquery.js"></script>
<link rel="stylesheet" href="../static/plugins/chosen/chosen.css">

<script src="../static/assets/js/lework.prototype.js"></script>
<script src="../static/assets/js/lework.utils.js"></script>
<script src="../static/assets/js/lework.js"></script>
<!--lework jquery plugins :: ConfirmDelete -->
<script src="/static/plugins/lework.jquery.confirmdelete.js"></script>
<!--lework jquery plugins :: TableMutilDelete -->
<script src="/static/plugins/lework.jquery.TableMutilDelete.js" ></script>
<!--lework   plugins :: Alert -->
<link rel="stylesheet" href="../static/plugins/lework-alert/lework.jquery.alert.css" />
<script src="../static/plugins/lework-alert/lework.jquery.alert.js" ></script>
<!--jquery colorbox-->
<link rel="stylesheet" href="../static/plugins/colorbox/colorbox.css" >
<script src="../static/plugins/colorbox/jquery.colorbox.js"></script>
<!-- easyui css custom theme    -->
<link rel="stylesheet" href="../static/plugins/easyui/1.3.2/themes/bootstrap/easyui.custom.css" >
<!--icheck-->
<%--<link rel="stylesheet" href="../static/plugins/iCheck/skins/minimal/blue.css" >
<script src="../static/plugins/iCheck/icheck.js" ></script>--%>
<!-- jquery easyui loader-->
<script src="../static/plugins/easyui/1.3.2/easyloader.js" ></script>
<script>
    /**====================
     * jquery easyui
     * ====================**/
    if (easyloader) {
        easyloader.locale = "zh_CN"; // 本地化设置
        easyloader.theme = "bootstrap"; // 设置主题
        easyloader.css = false  ;
    }
    /**===============
     close ajax cache
     =================
     **/
    $.ajaxSetup ({
        cache: false
    });
</script>

<script>
    /**************demo*****************/
   $(function(){
       lework.alert({content:'演示信息提示',timer:10000,onClose:function(){
           lework.alert({content:'关闭回调',type:'info' })
       }})
       $('#demoCreate').on('click', function () {
           $.colorbox({href: 'modal.jsp', adjustY: '40%', width: '700px', overlayClose: false, scrolling: false});
       })


   })
</script>

