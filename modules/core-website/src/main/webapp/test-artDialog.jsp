<%--
  Created by IntelliJ IDEA.
  User: Gongle
  Date: 14-1-10
  Time: 下午4:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>

    <script src="${ctx}/static/assets/js/jquery-1.10.2.js"></script>
    <script src="${ctx}/static/plugins/artDialog/4.1.7/jquery.artDialog.source.js"></script>
    <link rel="stylesheet" href="${ctx}/static/plugins/artDialog/4.1.7/skins/default.css">
</head>
<body>
      <script>
          //http://www.planeart.cn/demo/artDialog/_doc/API.html 锁屏 [lock & background & opacity]
         var d =  art.dialog({
           //   lock: true,
              background: '#fff', // 背景色
              opacity: 0.95,	// 透明度
              content: '如果定义了回调函数才会出现相应的按钮',
              ok: function () {
                  this.title('3秒后自动关闭').time(3);
                  return false;
              },
              cancelVal: '关闭',
              cancel: true //为true等价于function(){}
          });
      </script>
</body>
</html>