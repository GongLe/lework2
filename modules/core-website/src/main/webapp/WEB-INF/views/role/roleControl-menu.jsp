<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div class="row">

    <div class="col-md-12">
        <button type="button" class="btn btn-danger btn-sm" id="saveRoleMenu"
                style="margin-bottom:10px;"><i class="icon-save"></i> 保存</button>
    </div>
    <div class="col-md-12">
        <div class="clearfix dataTables_wrapper" style="font-size: 18px;" >
            <table id="menuTreetable" class="table table-hover  dataTable dataTable-nosort clear-both treetable">
                <thead>
                <tr >
                    <th ><input type="checkbox" class="row-check-all" ></th>
                    <th>icon</th>
                    <th>名称</th>
                    <th>编码</th>
                    <th>UIR</th>
                    <th class="text-center">状态</th>
                </tr>
                </thead>
                <tbody>
                <!--jstl递归输出tree grid result-->
                <c:forEach items="${treeGridDTOs}" varStatus="varStatus" var="treeNode">
                    <c:set var="node" value="${treeNode}" scope="request"/>
                    <c:import url="/WEB-INF/views/role/roleControl-treetable-recurse.jsp"/>
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
            var oTable = $('#menuTreetable') ,checkedIdsArr = ${checkedIds};
            var roleId = '${roleId}';
            //刷新表格
            window.refreshDatatables = function () {
              //  $.isFunction(loadTreetable) &&  loadTreetable();
            };
            var  initCheckbox = function(){
                oTable.find('.row-check-one:checkbox').each(function(){
                    if (checkedIdsArr.indexOf($(this).val()) !=-1 ) {
                        $(this).prop('checked', true)
                    }
                })
            }
            oTable.treetable({
                expandable: true,
                initialState: 'expanded',  //"expanded" or "collapsed".
                onInitialized:function(){
                    initCheckbox();
                },
                onNodeCollapse: function () {
                },
                onNodeExpand: function () {
                }
            });
            //表格全选,反选操作
            oTable.on('change.lework', '.row-check-all:checkbox', function () {
                if ($(this).prop('checked')) {
                    oTable.find('.row-check-one').prop('checked', true)
                } else {
                    oTable.find('.row-check-one').prop('checked', false)
                }
            })
            $('#saveRoleMenu').confirmDelete({
                text:' 确认保存？',
                onConfirm: function () {
                    var selectedRowIds = oTable.find('.row-check-one:checked')
                            .map(function () {
                                return $(this).val();
                            }).get().join(',');

                    $.ajax({
                        url: 'roleControl/saveRelatedMenu',
                        data: {'checkedMenuIds': selectedRowIds, 'roleId': roleId },
                        cache: false,
                        type: 'post',
                        success: function (resp) {
                            notify({content: resp.msg});
                        }
                    })
                }
            });//confirmDelete

        })
    })
</script>

