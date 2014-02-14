<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>组织机构</title>
    <style>

    </style>
</head>

<body>
<div id="main-body-content" >
<div class="row">

    <div class="col-md-12">
        <div class="tablenav top clearfix" style="padding: 0">

            <form class="navbar-form" style="padding:10px 0 0 0;" role="form" id="tableNavForm">

                <select class="form-control" id="action">
                    <option value="" selected="selected">批量操作</option>
                    <option value="doDelete">删除</option>
                    <option value="doStatusDisable">禁用账号</option>
                    <option value="doStatusEnable">启用账号</option>
                </select>
                <button type="button" class="btn btn-white" id="doAction">应用</button>

            </form>

        </div>
        <div class="clearfix dataTables_wrapper" style="font-size: 18px;" >
            <table id="example-basic-expandable" class="table table-hover table-bordered table-striped dataTable dataTable-nosort clear-both treetable">
                <thead>
                <tr data-tt-id="0">
                    <th>app</th>
                    <th>app</th>
                </tr>
                </thead>
                <tbody>

                <tr data-tt-id="0">
                    <td>app</td>
                    <td>app</td>
                </tr>
                <tr data-tt-id="1" data-tt-parent-id="0">
                    <td>controllers</td>
                    <td>controllers</td>
                </tr>
                <tr data-tt-id="5" data-tt-parent-id="1">
                    <td>application_controller.rb</td>
                    <td>application_controller.rb</td>
                </tr>
                <tr data-tt-id="2" data-tt-parent-id="0">
                    <td>helpers</td>
                    <td>helpers</td>
                </tr>
                <tr data-tt-id="3" data-tt-parent-id="0">
                    <td>models</td>
                    <td>models</td>
                </tr>
                <tr data-tt-id="4" data-tt-parent-id="0">
                    <td>views</td>
                    <td>views</td>
                </tr>
                </tbody>
            </table>

        </div>

    </div>
</div>
 </div>
<script>
    seajs.use([ 'jquery','treetable'], function (  $ ) {
      //  $(function(){
            $("#example-basic-expandable").treetable({ expandable: true });
       // })
    })
</script>
</body>

</html>