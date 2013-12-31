<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="zh-CN"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="zh-CN"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="zh-CN"> <![endif]-->
<!--[if gt IE 8]><!--><html lang="zh-CN"><!--<![endif]-->
<head>

    <%@ include file="/WEB-INF/included/resource.jsp" %>
    <link rel="stylesheet" href="${ctx}/static/assets/css/login.css">
</head>
<body id="body-login">
<div class="container">
    <div class="form-container card">

        <form class="form-signin" role="form" action="login" method="post">
            <h2 class="form-signin-heading">登录</h2>
            <c:if test="${not empty shiroLoginFailure }">
                <div class="red" style="text-align: center;padding:0 0 5px 0">${shiroLoginFailure}</div>
            </c:if>
            <input type="text" class="form-control" name="username" placeholder="用户名" required autofocus>
            <input type="password" class="form-control" name="password" placeholder="密码" required>
            <c:if test="${not empty sessionScope.showCaptcha == true }">

                <input name="captcha" class="form-control" autocomplete="off" placeholder="验证码" style="width: 40%;">
                <img id="captchaImg" title="点击刷新验证码" src="login/getCaptcha" width="70" height="28"/>

            </c:if>
            <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
            <label class="checkbox" for="rememberMe">
                <input type="checkbox" id="rememberMe" name="rememberMe">保持登录状态
            </label>

        </form>

    </div>
</div>
<script>
    seajs.use(['jquery'], function ($) {

        $("#captchaImg").on('click', function () {
            $(this).attr("src", "login/getCaptcha?_=" + (new Date()).getTime());
        })

    })
</script>
<!-- /container -->
</body>
</html>
