<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div  id="roleInputBody" style="padding:35px 40px 0 5px;/*width: 600px;max-height:600px;*/"  >
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1" >
            <form action="role/update"  method="post" id="inputForm" name="inputForm" class="form-horizontal" role="form">
                <!--隐藏域-->
                <input type="hidden" name="$SiteMesh" value="false">
                <form:hidden path="entity.id" />
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="name" >名称</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="name" name="name"   value="${entity.name}" placeholder="输入角色名称">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="code" >编码</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="code" name="code"   value="${entity.code}"
                               placeholder="输入角色编码"   data-rule-required="true"    data-rule-maxlength="50"  >
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
                    <label class="col-xs-2 control-label" for="type">分类</label>
                    <div class="col-xs-10">

                        <form:select  path="entity.type" cssClass="form-control">
                            <form:options  items="${typeList}"  itemValue="code" itemLabel="name"/>
                        </form:select>
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
            $('#roleInputBody').slimscroll({
                width: '630px',
                height: '300px'
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
                    code: {
                        required: false,
                        account:true,
                        maxlength: 50,
                        remote: {
                            url: 'role/validateRoleCode', //后台处理程序
                            type: 'post',               //数据发送方式
                            dataType: 'json',           //接受数据格式
                            data: {                     //要传递的数据
                                roleId: function () {
                                    return $inputForm.find('#id').val();
                                }
                            }
                        }
                    },
                    status: {
                        required: true
                    },
                    description: {
                        maxlength: 200
                    }
                }, messages: {
                }
            }); //end validate

        }) //dom ready
    })//seajs use
</script>
