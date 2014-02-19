<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<h3>组织机构&nbsp;<button class="btn btn-danger btn-sm" hidefocus="true"  id="create-function" >新建</button> </h3>
<div class="row">
    <div class="col-md-12">
        <div class="tablenav top clearfix" style="padding: 0">

            <%--        <form class="navbar-form" style="padding:10px 0 0 0;" role="form" id="tableNavForm">

                        <select class="form-control" id="action">
                            <option value="" selected="selected">批量操作</option>
                            <option value="doDelete">删除</option>
                            <option value="doStatusDisable">禁用账号</option>
                            <option value="doStatusEnable">启用账号</option>
                        </select>
                        <button type="button" class="btn btn-white" id="doAction">应用</button>

                    </form>--%>

        </div>
        <div class="clearfix dataTables_wrapper" style="font-size: 18px;" >
            <table id="orgTreetable" class="table table-hover table-bordered  dataTable dataTable-nosort clear-both treetable">
                <thead>
                <tr >
                    <th>名称</th>
                    <th>编码</th>
                    <th>机构主管</th>
                    <th>电话</th>
                    <th  class="text-center">序号</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${treeGridDTOs}" varStatus="varStatus" var="treeNode" >
                    <c:set var="node" value="${treeNode}" scope="request"/>
                    <c:import url="/WEB-INF/views/organization/treetable-recurse.jsp"/>
                    <c:remove var="node" scope="request"/>
                </c:forEach>

                </tbody>
            </table>

        </div>

    </div>
</div>

<script>
    seajs.use([ 'jquery', 'notify', 'dialog', 'treetable', 'confirmDelete','blockUI' ], function ($, notify, dialog) {
        $(function () {
            var oTable = $('#orgTreetable');
            //刷新表格
            window.refreshDatatables = function () {
                $.isFunction(loadTreetable) &&  loadTreetable();
            };
            $("#orgTreetable").treetable({
                expandable: true,
                initialState: 'expanded',  //"expanded" or "collapsed".
                onNodeCollapse: function () {
                },
                onNodeExpand: function () {
                }
            });
            //----------事件定义---------
            //确认删除弹出层
            oTable.find('.confirmDelete')
                    .confirmDelete({
                        onConfirm: function () {
                            var id   =  $(this).data('id');
                            $.ajax({
                                url: 'organization/delete',
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
                    title: '编辑组织机构"{name}"'.format(rowData),
                    width: 630,
                    height: 500,
                    padding: '0',		// 内容与边界填充距离
                    ajax: {type: 'get', url: 'organization/update?', data: $(this).data() },
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
                    title: '新建组织机构',
                    width: 630,
                    height: 500,
                    padding: '0',		// 内容与边界填充距离
                    ajax: {type: 'get', url: 'organization/update' },
                    okVal: '保存',
                    cancelVal: '关闭',
                    ok: function () {
                        //提交弹出层form
                        this.DOM.content.find('#inputForm').submit();
                        return false;
                    }
                })
            })
            // 序号调整
            oTable.find('.sortNumAction').on('click', function (event) {
                event.preventDefault();
                var id = $(this).data('id');
                if ($(this).hasClass('up')) {   //上移
                    oTable.block({ message: null });
                    $.ajax({
                        url: 'organization/upSortNum',
                        data: {id: id},
                        cache: false,
                        type: 'post',
                        success: function (resp) {
                            notify({content: resp.msg});
                            refreshDatatables();
                        }
                    })
                } else if ($(this).hasClass('down')) {  //下移
                    oTable.block({ message: null });
                    $.ajax({
                        url: 'organization/downSortNum',
                        data: {id: id},
                        cache: false,
                        type: 'post',
                        success: function (resp) {
                            notify({content: resp.msg});
                            refreshDatatables();
                        }
                    })
                }
            })

        })
    })
</script>

