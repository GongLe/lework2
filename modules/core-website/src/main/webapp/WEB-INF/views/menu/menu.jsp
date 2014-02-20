<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>菜单管理</title>
</head>

<body>
<div id="main-body-content">
    加载中...
</div>
<script>
    seajs.use([ 'jquery', 'notify', 'dialog', 'treetable', 'confirmDelete', 'blockUI' ], function ($, notify, dialog) {
        $(function () {
            window.loadTreetable = function () {
                $('#main-body-content').load2('menu/treetable', {'$SiteMesh': false})
            }
            loadTreetable();
        })
    })
</script>
</body>

</html>