<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>个人中心</title>
    <link rel="stylesheet" href="${ctx}/static/assets/css/profile.css">
</head>

<body>
<div id="main-body-content" >
    <h3>&nbsp;&nbsp;个人中心</h3>
    <div class="row">

        <div class="col-md-3">
            <div class="clearfix"></div>
            <div class="profile-sidebar hidden-print affix " role="complementary">
                <ul class="nav profile-sidenav">

                    <li>
                        <a href="#glyphicons">基本信息</a>
                    </li>
                    <li>
                        <a href="#dropdowns">头像设置</a>
                        <ul class="nav">
                            <li><a href="#dropdowns-example">Example</a></li>
                            <li><a href="#dropdowns-alignment">Alignment options</a></li>
                            <li><a href="#dropdowns-headers">Headers</a></li>
                            <li><a href="#dropdowns-disabled">Disabled menu items</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#btn-groups">联系信息</a>
                        <ul class="nav">
                            <li><a href="#btn-groups-single">Basic example</a></li>
                            <li><a href="#btn-groups-toolbar">Button toolbar</a></li>
                            <li><a href="#btn-groups-sizing">Sizing</a></li>
                            <li><a href="#btn-groups-nested">Nesting</a></li>
                            <li><a href="#btn-groups-vertical">Vertical variation</a></li>
                            <li><a href="#btn-groups-justified">Justified link variation</a></li>
                        </ul>
                    </li>

                    <li>
                        <a href="#input-groups">Input groups</a>
                        <ul class="nav">
                            <li><a href="#input-groups-basic">Basic example</a></li>
                            <li><a href="#input-groups-sizing">Sizing</a></li>
                            <li><a href="#input-groups-checkboxes-radios">Checkbox and radios addons</a></li>
                            <li><a href="#input-groups-buttons">Button addons</a></li>
                            <li><a href="#input-groups-buttons-dropdowns">Buttons with dropdowns</a></li>
                            <li><a href="#input-groups-buttons-segmented">Segmented buttons</a></li>
                        </ul>
                    </li>
                    <li class="">
                        <a href="#nav">Navs</a>
                        <ul class="nav">
                            <li class=""><a href="#nav-tabs">Tabs</a></li>
                            <li class=""><a href="#nav-pills">Pills</a></li>
                            <li class=""><a href="#nav-justified">Justified nav</a></li>
                            <li class=""><a href="#nav-disabled-links">Disabled links</a></li>
                            <li class=""><a href="#nav-dropdowns">Using dropdowns</a></li>
                        </ul>
                    </li>
                    <li class="active">
                        <a href="#navbar">Navbar</a>
                        <ul class="nav">
                            <li class="active"><a href="#navbar-default">Default navbar</a></li>
                            <li class=""><a href="#navbar-forms">Forms</a></li>
                            <li><a href="#navbar-buttons">Buttons</a></li>

                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-md-8">
            <form role="form" action="${ctx}/account/profile" method="post" name="inputForm" id="inputForm">
                <div class="form-group">
                    <label for="loginName">帐号</label>
                    <input type="text" class="form-control" id="loginName" name="loginName" value="${entity.loginName}"
                           disabled="disabled">
                </div>
                <div class="form-group">
                    <label for="name">姓名</label>
                    <input type="text" class="form-control" placeholder="姓名" id="name" name="name"
                           value="${entity.name}">
                </div>
                <div class="form-group">
                    <label for="name"> 昵称</label>
                    <input type="text" class="form-control" placeholder="昵称" name="niceName" id="niceName"
                           value="${entity.niceName}">
                </div>
                <div class="form-group">
                    <label for="name">电子邮箱</label>
                    <input type="text" class="form-control" placeholder="电子邮箱" name="email" id="email"
                           value="${entity.email}">
                </div>
                <div class="form-group">
                    <label for="name">修改密码</label>
                    <input type="password" class="form-control"  placeholder="输入新密码" name="plainPassword"
                           id="plainPassword">
                </div>
                <div class="form-group" style="display: none;">
                    <label for="name">确认新密码</label>
                    <input type="password" class="form-control"  placeholder="确认新密码" name="plainPassword2"
                           id="plainPassword2">
                </div>
                <div class="form-group">
                    <label for="name">创建时间</label>
                    <input type="text" class="form-control" name="createdDate" id="createdDate" disabled="disabled"
                           value="<fmt:formatDate value="${entity.createdDate}" pattern="yyyy-MM-dd HH:mm" />">
                </div>
                <button type="submit" class="btn btn-white">保存</button>
            </form>
        </div>
        <div class="col-md-10">

        </div>
    </div><!--/.row-->

</div> <!--/#main-body-content -->

<script>

    seajs.use(['mustache', 'jquery', 'dialog', 'notify', 'validate', 'chosen', 'form'], function (mustache, $, dialog, notify) {
       $(function(){

           var $inputForm = $('#inputForm');
           //控制密码修改输入框
           $('#plainPassword').on('change.pwd', function () {
               $('#plainPassword2').parents('.form-group').show();
               $(this).off('change.pwd');
           });
           var ajaxSubmitOption = {
               // target: '#output2',   // target element(s) to be updated with server response
               beforeSubmit: $.noop,  // pre-submit callback
               success: function (resp, statusText) {
                   notify({content: resp.msg});

               },
               dataType: 'json'        // 'xml', 'script', or 'json' (expected server response type)
           };
           //from validater
           $inputForm.validate({
               submitHandler: function (form) {
                   $(form).ajaxSubmit(ajaxSubmitOption);
               }, rules: {
                   name: {
                       required: true,
                       minlength: 1,
                       maxlength: 50
                   },
                   plainPassword: {
                       required: false,
                       minlength: 6,
                       maxlength: 32
                   },
                   plainPassword2: {
                       required: false,
                       minlength: 6,
                       maxlength: 32,
                       equalTo: "#plainPassword"
                   }, email: {
                       required: true,
                       email: true
                   }
               }, messages: {
                   plainPassword2 :{
                       equalTo:'密码输入不一致'
                   }
               }});


       } ) //dom ready
    })  //seajs use


</script>

</body>
</html>