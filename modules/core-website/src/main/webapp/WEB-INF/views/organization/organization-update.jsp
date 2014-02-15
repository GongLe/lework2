<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div  id="modalWrap" style="padding:15px 40px 0 5px;/*width: 600px;max-height:600px;*/"  >
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1" >
            <form action="organization/update"  method="post" id="inputForm" name="inputForm" class="form-horizontal" role="form">
                <!--隐藏域-->
                <input type="hidden" name="$SiteMesh" value="false">
                <form:hidden path="entity.id" />
                <div class="form-group">
                    <label   class="col-xs-2 control-label" for="parentOrgId">上级组织</label>

                    <div class="col-xs-10">
                        <le:selectTree attr=" class=\"form-control\" " value="${entity.parentId}"
                                       treeReuslt="${orgTree}" name="parentOrgId" headerKey="--选择部门--"
                                       headerValue=""></le:selectTree>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label" for="name"> 名称</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="name" name="name"   value="${entity.name}" placeholder="输入组织名称">
                    </div>
                </div>
                <div class="form-group">
                    <label   class="col-xs-2 control-label" for="code">编码</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="code" name="code" value="${entity.code}" placeholder="输入组织代码" >
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="shortName">简称</label>
                    <div class="col-xs-10">
                        <input class="form-control"  type="text" id="shortName" name="shortName"   value="${entity.shortName}"
                               data-rule-required="false" placeholder="输入简称">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label"   for="manager">负责人</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="manager" name="manager"   value="${entity.manager}"
                               data-rule-required="false"    data-rule-maxlength="50" placeholder="输入负责人">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="shortName">联系电话</label>
                    <div class="col-xs-10">
                        <input class="form-control"  type="text" id="phone" name="phone"   value="${entity.phone}"
                               data-rule-required="false"     data-rule-maxlength="50"  data-rule-isTel="true" placeholder="输入联系电话">
                    </div>
                </div>

                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="shortName">内线</label>
                    <div class="col-xs-10">
                        <input class="form-control"  type="text" id="innerPhone" name="innerPhone"   value="${entity.innerPhone}"
                               data-rule-required="false"    data-rule-maxlength="50" placeholder="输入内线电话">
                    </div>
                </div>

                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="shortName">传真</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="fax" name="fax"   value="${entity.fax}"
                               data-rule-required="false"     data-rule-maxlength="50" placeholder="输入传真">
                    </div>
                </div>

                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="shortName">地址</label>
                    <div class="col-xs-10">
                        <input class="form-control"  type="text" id="address" name="address"   value="${entity.address}"
                               data-rule-required="false"     data-rule-maxlength="100" placeholder="输入地址">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="shortName">网址</label>
                    <div class="col-xs-10">
                        <input class="form-control" type="text" id="url" name="url"   value="${entity.url}"
                               data-rule-required="false"    data-rule-maxlength="100" data-rule-url="true" placeholder="输入网址">
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
                    }
                }, messages: {

                }
            }); //end validate

        }) //dom ready
    })//seajs use
</script>
