<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>

    <%@ include file="/WEB-INF/included/resource.jsp" %>


</head>
<body>
<div class="container">
    <div class="form-container card">

        <form class="form-signin" role="form" action="/login" method="post">
            <h2 class="form-signin-heading">登录</h2>
            <c:if test="${not empty shiroLoginFailure }">
                <div class="red">${shiroLoginFailure}</div>
            </c:if>
            <input type="text" class="form-control" name="username" placeholder="用户名" required autofocus>
            <input type="password" class="form-control" name="password" placeholder="密码" required>
            <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
            <label class="checkbox">
                <input type="checkbox" value="remember-me">保持登录状态
            </label>
        </form>

    </div>
</div>
<!-- /container -->
</body>
</html>
