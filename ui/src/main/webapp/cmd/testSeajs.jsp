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
    <title>CMD:seajs hello world</title>
    <script src="../static/assets/sea-modules/seajs/2.1.1/sea-debug.js"></script>
   <%-- <script src="<%=request.getContextPath()%>/static/assets/sea-modules/jquery/1.10.1/jquery-debug.js"></script>
    <script src="<%=request.getContextPath()%>/static/assets/sea-modules/jquery/1.10.1/jquery-migrate.js"></script>--%>
    <script>
        // Set configuration
        seajs.config({
            base: "<%=request.getContextPath()%>/static/assets/sea-modules",
            alias: {
                "jquery": "jquery/1.10.1/jquery-debug.js",
                "jqueryMigrate": "jquery/1.10.1/jquery-migrate.js",
                "blockUI": "jquery-blockUI/jquery.blockUI.js"
            },
            preload: ['jquery' , 'jqueryMigrate' ]
        });
        seajs.on('exec', function (module) {
            if (module.uri === seajs.resolve('jquery')) {
                console.log('on.exec :: module.uri === seajs.resolve("jquery")');
               // window.$ = window.jQuery = module.exports;
            }
        })
    </script>
    <script>
        //demo :: main
        seajs.use(['jquery','blockUI','jqueryMigrate'], function ($, blockUI,jqueryMigrate) {
            blockUI($)
            console.log(typeof(jqueryMigrate) == "function")
            jqueryMigrate($)
            $.blockUI({ message: '<h1> Just a moment...</h1>' });
        })
    </script>
</head>
<body>
   <h2>CMD:seajs hello world</h2>
</body>
</html>