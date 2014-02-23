<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div  id="roleInputBody" style="padding:35px 40px 0 5px;/*width: 600px;max-height:600px;*/"  >
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1" >
            <form  method="post" id="inputForm" name="inputForm" class="form-horizontal" role="form">
                <!--隐藏域-->
                <input type="hidden" name="$SiteMesh" value="false">
                <form:hidden path="entity.id" />
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="name" >名称</label>
                    <div class="col-xs-10">
                        <input  class="form-control" type="text" id="name" name="name"   value="${entity.name}" placeholder="输入角色名称">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-xs-2 control-label"  for="code" >编码</label>
                    <div class="col-xs-10">
                        <input  class="form-control" type="text" id="code" name="code"   value="${entity.code}"
                               placeholder="输入角色编码"   data-rule-required="true"    data-rule-maxlength="50"  >
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-2 control-label" for="status">状态</label>
                    <div class="col-xs-10">
                        <form:select path="entity.status" cssClass="form-control"  >
                            <form:options items="${statusList}" itemValue="code" itemLabel="name"/>
                        </form:select>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="type">分类</label>
                    <div class="col-xs-10">

                        <form:select  path="entity.type" cssClass="form-control" >
                            <form:options  items="${typeList}"  itemValue="code" itemLabel="name"/>
                        </form:select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label" for="description">描述</label>

                    <div class="col-xs-10">
                        <textarea  class="form-control" rows="3" id="description" name="description"
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
              $inputForm.find('select,input,textarea').attr('disabled','disabled')
            $('#roleInputBody').slimscroll({
                width: '630px',
                height: '300px'
            }); //slimscroll

        }) //dom ready
    })//seajs use
</script>
