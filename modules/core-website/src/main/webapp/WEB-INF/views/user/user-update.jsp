<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div  id="userInputBody" style="padding:15px 40px 0 5px;/*width: 600px;max-height:600px;*/"  >
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1" >
            <form action="user/update"  method="post" id="inputForm" name="inputForm" class="form-horizontal" role="form">
                <!--隐藏域-->
                <input type="hidden" name="$SiteMesh" value="false">
                <form:hidden path="entity.id" />
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="name" >姓名</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="name" name="name"   value="${entity.name}" placeholder="输入姓名">
                    </div>
                </div>
                <div class="form-group">
                    <label   class="col-xs-2 control-label"  for="loginName">用户名</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="loginName" name="loginName"   value="${entity.loginName}" placeholder="输入用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label   class="col-xs-2 control-label" for="plainPassword">密码</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="password"  name="plainPassword" id="plainPassword"
                        <c:if test="${entity.isNew == true }">  value="123456" title="默认密码为123456" placeholder="输入密码" </c:if>
                        <c:if test="${entity.isNew == false }"> placeholder="新密码"</c:if>    >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="status">状态</label>
                    <div class="col-xs-10">
                        <form:select path="entity.status" cssClass="form-control">
                            <form:options items="${statusList}" itemValue="code" itemLabel="name"/>
                        </form:select>

                    </div>
                </div>

                <div class="form-group">
                    <label   class="col-xs-2 control-label" for="orgId">所属部门</label>

                    <div class="col-xs-10">
                        <le:selectTree attr=" class=\"form-control\" " value="${entity.orgId}"
                                       treeReuslt="${orgTree}" name="orgId" headerKey="--选择部门--"
                                       headerValue=""></le:selectTree>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">所属角色</label>

                    <div class="col-xs-10">
                        <select id="roleIds" name="roleIds" multiple >
                            <c:forEach items="${chosenRoleOptions}" var="group">
                                <optgroup label="${group.key}">
                                    <c:forEach items="${group.value}" var="opt">
                                        <option
                                                <c:if test="${opt.selected == true}">selected="selected"</c:if>
                                                value="${opt.value}">${opt.name}</option>
                                    </c:forEach>
                                </optgroup>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-2 control-label" for="email">手机号码</label>

                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="mobile" name="mobile" value="${entity.mobile}"
                               placeholder="输入手机号码">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-2 control-label" for="email">Email</label>

                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="email" name="email" value="${entity.email}"
                               placeholder="输入email">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-2 control-label" for="description">描述</label>

                    <div class="col-xs-10">

                        <textarea class="form-control" rows="3" id="description" name="description"
                                  placeholder="输入描述信息"> ${entity.description}</textarea>
                    </div>
                </div>

            </form>

        </div>

    </div> <!--/.row-->
</div><!--/#inputBody-->
<script>
    seajs.use(['mustache', 'jquery', 'dialog', 'notify', 'slimscroll', 'validate', 'chosen', 'form'], function (mustache, $, dialog, notify) {

        $(function () {
            var $inputForm = $('#inputForm');
            $('#userInputBody').slimscroll({
                width: '630px',
                height: '460px'
            }); //slimscroll

            var ajaxSubmitOption = {
                // target: '#output2',   // target element(s) to be updated with server response
                beforeSubmit: $.noop,  // pre-submit callback
                success: function (resp, statusText) {
                    notify({content: resp.msg});
                    //关闭弹出层
                    var d = dialog.list['UPDATE_DIALOG'];
                    d && d.close();
                    //刷新父页面表格
                    $.isFunction(window.refreshDatatables) && window.refreshDatatables();
                }, // post-submit callback
                // other available options:
                //url:       url         // override for form's 'action' attribute
                //type:      type        // 'get' or 'post', override for form's 'method' attribute
                dataType: 'json'        // 'xml', 'script', or 'json' (expected server response type)
            };

            //from validater
            $inputForm.validate({
                submitHandler: function (form) {
                    $(form).ajaxSubmit(ajaxSubmitOption);
                },
                rules: {
                    name: {
                        required: true,
                        normalChar: true,
                        maxlength: 50
                    },
                    loginName: {
                        required: true,
                        maxlength: 50,
                        account: true,
                        remote: {
                            url: 'user/validateLoginName', //后台处理程序
                            type: 'post',               //数据发送方式
                            dataType: 'json',           //接受数据格式
                            data: {                     //要传递的数据
                                userId: function () {
                                    return $inputForm.find('#id').val();
                                }
                            }
                        }
                    },
                    email: {
                        required: false,
                        email:true,
                        maxlength: 50,
                        remote: {
                            url: 'user/validateEmail', //后台处理程序
                            type: 'post',               //数据发送方式
                            dataType: 'json',           //接受数据格式
                            data: {                     //要传递的数据
                                userId: function () {
                                    return $inputForm.find('#id').val();
                                }
                            }
                        }
                    },
                    mobile: {
                        isMobile: true
                    },
                    plainPassword: {
                        minlength:6,
                        maxlength: 32
                    },
                    status: {
                        required: true
                    },
                    description: {
                        maxlength: 200
                    }
                }, messages: {
                    loginName: {
                        remote: '该用户名已被注册'
                    },
                    email: {
                        remote: '该Email已被注册'
                    }
                }
            }); //end validate


            $inputForm.find('#roleIds').chosen({
                width: '284px',
                placeholder_text_multiple: '请选择角色'
            }); //chosen

        }) //dom ready
    })//seajs use
</script>
