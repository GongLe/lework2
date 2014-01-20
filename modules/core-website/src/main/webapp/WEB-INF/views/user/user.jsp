<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
</head>

<body>
<div id="main-body-content" >
    <h3>用户管理 <button class="btn btn-danger btn-sm" hidefocus="true"  id="create-function" >新建</button> </h3>
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
                            <le:selectTree attr=" class=\"form-control\" " name="search_LIKES_org.name"
                                           treeReuslt="${orgTree}" headerKey="--显示所有部门--" headerValue=""></le:selectTree>

                            &nbsp;&nbsp;
                            <select class="form-control" onchange="$('#searchInput').attr('name',$(this).val() )">
                                <option value="search_LIKES_loginName">用户名</option>
                                <option value="search_LIKES_name">姓名</option>
                                <option value="search_LIKES_mobile">手机号码</option>
                            </select>
                            <div class="form-group" style="margin-left:-5px;width:250px;">
                                <input type="text" id="searchInput" name="search_LIKES_loginName" class="form-control" id="cccc" placeholder="搜索">
                            </div>
                            <button type="button" onclick="refreshDatatables();" class="btn btn-white">筛选</button>

                    </form>

                </div>
                <table id="table-list"
                       class="table table-hover table-striped dataTable dataTable-nosort clear-both">
                </table>
        </div>
    </div>

</div> <!--/#main-body-content -->

<script>

    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete' ], function (mustache, $, notify, dialog) {

        var oTable = $('#table-list'),
                rowActionTpl = $('#tableActionTpl').html();
        //--------全局函数定义--------------
        window.refreshDatatables = function () {
            oTable.fnDraw();     //刷新表格
        };
        //---------jquery datatables --------
        oTable.dataTable({
            'aoColumns': [
                { 'mData': 'id', 'sTitle': '<input type="checkbox" class="row-check-all" >' },
                { 'mData': 'name', 'sTitle': '姓名' },
                { 'mData': 'loginName', 'sTitle': '用户名'}  ,
                { 'mData': 'email', 'sTitle': 'Email'}  ,
                { 'mData': 'orgName', 'sTitle': '所属部门'}  ,
                { 'mData': 'status', 'sTitle': '状态'}
            ],
            'aoColumnDefs': [
                {
                    'sWidth': '5%',
                    'mRender': function (data, type, full) {
                        return   '<input type="checkbox" value="{0}" class="row-check-one" >'.format(data);
                    },
                    'aTargets': [0 ]
                },  {
                    'sWidth': '25%',
                    'mRender': function (data, type, full) {
                        return      mustache.render(rowActionTpl, full);
                    },
                    'aTargets': [1 ]
                },
                {
                    'sWidth': '8%',
                    'mRender': function (data, type, full) {
                        //  console.log(data)
                        if (data == 'enable') {
                            return   '<i class="icon-ok-sign bigger-130 green" title="启用的"></i>';
                        }
                        return    '<i class="icon-remove-circle bigger-130 red" title="禁用的"></i>';
                    },
                    'aTargets': [5 ]
                },
                { bSortable: false,
                    aTargets: [0]
                } ,
                //   { 'bVisible': false,  'aTargets': [ 1 ] },
                { 'sClass': 'center', 'aTargets': [5] }
            ],
            'sDom': 'rt<"table-footer clearfix"ip>',
            'bStateSave': false  , /**state saving **/
            'bProcessing': true ,
            'bServerSide': true,
            'fnServerData': $.springDataJpaPageableAdapter,
            'sAjaxSource': 'user/getDatatablesJson',
            'fnInitComplete': function () {     /**datatables ready**/
            },
            'fnServerParams' :function(aoData ){
                //表头搜索参数
                aoData.pushArray($('#tableNavForm').serializeArray());
            },
            fnDrawCallback: function (oSettings) {
                //确认删除弹出层
                oTable.find('.confirmDelete')
                        .confirmDelete({
                            onConfirm: function () {
                                var id   =  $(this).data('id');
                                $.ajax({
                                    url: 'user/delete',
                                    data: {deleteIds: id},
                                    cache: false,
                                    type:'post',
                                    success: function (resp) {
                                        notify({content: resp.msg});
                                        refreshDatatables();
                                    }
                                })
                            }
                        });//confirmDelete

            }
        });//dataTables

        //----------事件定义---------
        //双击编辑行
         oTable.on('dblclick.lework', 'tr', function () {
            //触发编辑
            $(this).find('.edit').trigger('click.lework')
        })
        //编辑
        oTable.on('click.lework', '.edit', function () {
            var rowData = $(this).data();
            dialog.ajaxModal({
                id: 'UPDATE_DIALOG',
                lock: true,
                title: '编辑用户"{name}"'.format(rowData),
                width: 630,
                height: 500,
                padding: '0',		// 内容与边界填充距离
                ajax: {type: 'get', url: 'user/update?', data: $(this).data() },
                okVal: '保存',
                ok: function () {
                    //提交弹出层form
                    this.DOM.content.find('#inputForm').submit();
                    return false;
                },
                cancelVal: '关闭',
                cancel: function () {
                }
            })

        })
        //查看
        oTable.on('click.lework', '.view', function () {
            console.log('view');
        })
        //新建
        $('#create-function').on('click.lework', function () {
            dialog.ajaxModal({
                id: 'UPDATE_DIALOG',
                lock: true,
                title: '新建用户',
                width: 630,
                height: 500,
                padding: '0',		// 内容与边界填充距离
                ajax: {type: 'get', url: 'user/update' },
                okVal: '保存',
                cancelVal: '关闭',
                ok: function () {
                    //提交弹出层form
                    this.DOM.content.find('#inputForm').submit();
                    return false;
                }
            })
        })
        //--------------多行操作----------------
        //表格checkbox操作
        oTable.on('change.lework', '.row-check-all:checkbox', function () {
            if ($(this).prop('checked')) {
                oTable.find('.row-check-one').prop('checked', true)
            } else {
                oTable.find('.row-check-one').prop('checked', false)
            }
        })
        //批量操作
        $('#doAction').confirmDelete({
            text: '<span class="text-warning" >确认操作？</span>',
            onConfirm: function () {
                var action = $('#action').val(),
                        selectedRowIds = oTable.find('.row-check-one:checked')
                                .map(function () {
                                    return $(this).val();
                                }).get().join(',');
                if (action && selectedRowIds) {
                    $.ajax({
                        url: 'user/doAction',
                        data: {'selectedRowIds': selectedRowIds, 'action': action },
                        cache: false,
                        type: 'post',
                        success: function (resp) {
                            notify({content: resp.msg});
                            refreshDatatables();
                        }
                    })
                } else {
                    notify({content: action ? '请选择行' : '请选择相应操作', type: 'info'});
                }
            }
        }); //confirmDelete

    })  //seajs use



</script>
<!-- ===============Mustache template ===================
    @see https://github.com/janl/mustache.js
-->
<!--table action template-->
<script id="tableActionTpl" type="text/x-mustache">
    {{name}}
    <div class="row-actions">
        <span><a  class="info view" data-id="{{id}}" data-name="{{name}}" href="javascript:;"  title="查看" ><i class="icon-zoom-in"></i></a> | </span>
        <span><a class="info edit" data-id="{{id}}" data-name="{{name}}" href="javascript:;" title="编辑"><i class="icon-edit"></i></a> | </span>
        <span><a class="info confirmDelete" data-id="{{id}}"  data-name="{{name}}"  href="javascript:;" title="删除"><i class="icon-trash"></i></a></span>
    </div>
</script>

</body>
</html>