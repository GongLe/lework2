<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
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
<%--<link id="colorTheme" rel="stylesheet" href="../static/assets/css/color.blue.css">--%>
<script src="../static/assets/js/jquery-1.10.2.js"></script>
<script src="../static/assets/js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript">
    if("ontouchend" in document) document.write("<script src='../static/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="../static/plugins/bootstrap/js/bootstrap.js"></script>
<script src="../static/assets/js/lework.prototype.js"></script>
<script src="../static/assets/js/lework.utils.js"></script>
<script src="../static/assets/js/lework.js"></script>

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


