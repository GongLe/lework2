<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="zh-CN"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="zh-CN"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="zh-CN"> <![endif]-->
<!--[if gt IE 8]><!--><html lang="zh-CN"><!--<![endif]-->
<head>
    <title><sitemesh:title/></title>

    <%@ include file="/WEB-INF/included/resource.jsp" %>

    <sitemesh:head/>
</head>

<body>
    <div id="main-wrap">
    <%@include file="/WEB-INF/included/sidebar.jsp" %>

        <div id="main-content">
            <div id="main-topbar">
                <%@ include file="/WEB-INF/included/navbar.jsp" %>
            </div> <!--/#main-topbar-->
            <div id="main-body">
                <div id="main-body-content">

                </div> <!--/#main-body-content -->
            </div>  <!--/#main-body-->
        </div> <!--/#main-content-->
     </div> <!--/#main-wrap-->
</body>
</html>