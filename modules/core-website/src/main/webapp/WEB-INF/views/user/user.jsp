<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
</head>

<body>
<div id="main-body-content">
    <h3>用户管理 <button class="btn btn-danger btn-sm" hidefocus="true"  id="create-function" >新建</button> </h3>
    <div class="row">

        <div class="col-md-12">

                <div class="tablenav top clearfix" style="padding: 0">

                    <form class="navbar-form" style="padding:10px 0 0 0;" role="form">
                        <select class="form-control" >
                            <option value="-1" selected="selected">批量操作</option>
                            <option value="unapprove">删除</option>
                            <option value="approve">批准</option>
                            <option value="spam">标记为垃圾评论</option>
                            <option value="trash">移至回收站</option>
                        </select>
                        <button type="submit" class="btn btn-white">应用</button>
                        &nbsp;&nbsp;
                      <%--  <div class="pull-right">--%>

                       <le:select list="${list}" name="name"  listKey="code" listValue="name" headerKey="--headerKey--" headerValue="--value--"
                                  attr=" class=\"form-control\" " ></le:select>
                              <le:selectTree attr=" class=\"form-control\" "    value="2c9f84db426eb16801426ee83a9a0002"
                                      treeReuslt="${tree}" name="treeid" headerValue="--treeheaderValue--" headerKey="--treeheaderKey--"></le:selectTree>

                            <select class="form-control">
                                <option selected="selected" value="0">显示所有部门</option>
                                <option value="201312">系统类别</option>
                                <option value="201312">业务类别</option>
                            </select>
                            &nbsp;&nbsp;
                            <select class="form-control">
                                <option value="Code">编号</option>
                                <option value="Account">账户</option>
                                <option value="RealName">姓名</option>
                                <option value="Mobile">手机号码</option>
                                <option value="DepartmentId">部门</option>
                            </select>
                            <div class="form-group" style="margin-left:-5px;">
                                <input type="text" class="form-control" id="cccc" placeholder="搜索">
                            </div>
                            <button type="submit" class="btn btn-white">筛选</button>
                       <%-- </div>--%>


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
        window.actionCallback = function (resp) {
            //关闭弹出层
            //刷新表格
            oTable.fnDraw();
            //操作提示
            notify({content: resp.attributes.message, type: resp.attributes.type })
        };
        //---------jquery datatables --------
        oTable.dataTable({
            'aoColumns': [
                { 'mData': 'id', 'sTitle': '<input type="checkbox" id="toggleCheckAll" >' },
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
                        return   '<input type="checkbox"value="{0}" class="row-checkbox" >'.format(data);
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
            'sAjaxSource': '${ctx}/user/getDatatablesJson',
            'fnInitComplete': function () {     /**datatables ready**/

            },
            fnDrawCallback: function (oSettings) {
                //确认删除弹出层
                  oTable.find('.confirmDelete')
                        .confirmDelete({
                            onConfirm: function () {
                               //TODO 确认删除回调,刷新表格
                            }
                        });

            }
        });//dataTables

        //----------事件定义---------
        //双击编辑行
         oTable.on('dblclick.lework', 'tr', function () {
            // d.showModal();
            //触发编辑
            $(this).find('.edit').trigger('click.lework')
        })
        //编辑

        oTable.on('click.lework', '.edit', function () {
            console.log('edit');
            dialog.ajaxModal({
                lock: true,
                title: '编辑',
                width: 700,
                height: 600,
                okVal: '保存',
                ok: function () {
                    this.title('3秒后自动关闭').time(3);
                    return false;
                },
                cancelVal: '关闭',
                cancel: true, //为true等价于function(){}
                ajax: {type: 'get', url: 'user/update?', data: $(this).data(), ajaxCallback: function () {
                    console.log('ajaxCallback....')
                }}
            })

        })
        //查看
        oTable.on('click.lework', '.view', function () {
            console.log('view');
        })
        //新建
        $('#create-function').on('click.lework', function () {
            console.log('create');
        })


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