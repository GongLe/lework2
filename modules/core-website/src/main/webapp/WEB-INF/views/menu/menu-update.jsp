<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div  id="modalWrap" style="padding:15px 40px 0 5px;/*width: 600px;max-height:600px;*/"  >
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1" >
            <form action="menu/update"  method="post" id="inputForm" name="inputForm" class="form-horizontal" role="form">
                <!--隐藏域-->
                <input type="hidden" name="$SiteMesh" value="false">
                <form:hidden path="entity.id" />
                <div class="form-group">
                    <label   class="col-xs-2 control-label" for="parentId">上级菜单</label>

                    <div class="col-xs-10">
                        <le:selectTree attr=" class=\"form-control\" " value="${entity.parentId}"
                                       treeReuslt="${menuTree}" name="parentId" headerKey="--选择菜单--"
                                       headerValue=""></le:selectTree>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label" for="name"> 名称</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="name" name="name"   value="${entity.name}" placeholder="输入组织名称"
                               data-rule-required="true"    data-rule-maxlength="50"  >
                    </div>
                </div>
                <div class="form-group">
                    <label   class="col-xs-2 control-label" for="code">编码</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="code" name="code" value="${entity.code}" placeholder="输入组织代码"
                               data-rule-required="true"    data-rule-maxlength="50" >
                    </div>
                </div>

                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="url">url</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="url" name="url"   value="${entity.url}"
                               data-rule-required="false"  data-rule-maxlength="100"  placeholder="输入url">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="parentId">状态</label>
                    <div class="col-xs-10">
                        <form:select path="entity.status" cssClass="form-control">
                            <form:options items="${statusList}" itemValue="code" itemLabel="name"/>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="icon">icon</label>

                    <div class="col-xs-10">
                        <%--<input class="form-control" type="text" id="icon" name="icon" value="${entity.icon}"
                               data-rule-required="false" data-rule-maxlength="100" placeholder="输入icon">--%>
                        <div class="input-group">
                            <span class="input-group-addon" id="icon-preview"><i class="${entity.icon}"></i> </span>
                            <input type="text" class="form-control" id="icon" name="icon" value="${entity.icon}">
                              <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" id="selectIcon">选择Icon</button>
                              </span>
                        </div>
                        <!-- /input-group -->
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="description">描述</label>

                    <div class="col-xs-10">
                        <textarea class="form-control" rows="3" id="description" name="description"
                                  data-rule-required="false"     data-rule-maxlength="500"        placeholder="输入描述信息"> ${entity.description}</textarea>
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
            $('#modalWrap').slimscroll({
                width: '630px',
                height: '400px'
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
                    }
                }, messages: {

                }
            }); //end validate
            //------------icon弹出层----------
            $('#selectIcon').on('click',function(){
                dialog.ajaxModal({
                    id: 'fontawesome_dialog',
                    lock: true,
                    title: '选择icon',
                    width: 630,
                    height: 400,
                    padding: '0',		// 内容与边界填充距离
                    ajax: {type: 'get', url: 'menu/fontawesome?'},
                    okVal:null,
                    ok:null,
                    cancelVal: '关闭',
                    cancel: function () {
                    }
                })
            });

            //icon弹出层回调
            window.selectIconCallback = function (val) {
                $inputForm.find('#icon').val(val);
            }
        }) //dom ready
    })//seajs use
</script>
