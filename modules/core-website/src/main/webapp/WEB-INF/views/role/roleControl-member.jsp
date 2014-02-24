<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<div class="dataTables_wrapper_">
    <table class="table  table-condensed_">
        <thead>
        <tr class="active">
            <th>名称</th>
            <th>值</th>
            <th>名称</th>
            <th>值</th>

        </tr>
        </thead>
        <tbody>
        <tr>
            <td>角色名：</td>
            <td>Otto</td>
            <td>所属机构：</td>
            <td>@mdo</td>
        </tr>
        <tr>
            <td>备注：</td>
            <td colspan="3"></td>
        </tr>

        </tbody>
    </table>
</div> <!--/.dataTables_wrapper-->

<div class="row">
    <div class="col-md-12" style="padding:0 15px 10px;" >
        <button type="button" class="btn btn-primary btn-sm" id="addRoleUser">添加角色到用户</button>
        <button type="button" class="btn btn-danger btn-sm" id="removeRoleUser">从角色中删除用户</button>
    </div>
</div>

<table id="roleRelatedUserTable"
       class="table table-hover table-striped dataTable dataTable-nosort clear-both"  >
</table>
<script>
    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete' ], function (mustache, $, notify, dialog) {
        $(function () {
            var oTable = $('#roleRelatedUserTable');
            var roleId = '${role.id}';
            //刷新角色用户Datatables
            window.refreshMemberDatatables = function(){
                oTable.fnDraw();     //刷新表格
            }
            oTable.dataTable({
                'aoColumns': [
                    { 'mData': 'id', 'sTitle': '<input type="checkbox" class="row-check-all" >' },
                    { 'mData': 'name', 'sTitle': '姓名' },
                    { 'mData': 'loginName', 'sTitle': '用户名'}  ,
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
                        'aTargets': [4 ]
                    },
                    {
                        'sWidth': '20%',
                        'aTargets': [2,3]
                    },
                    { bSortable: false,
                        aTargets: [0]
                    } ,
                    //   { 'bVisible': false,  'aTargets': [ 1 ] },
                    { 'sClass': 'center', 'aTargets': [4    ] }
                ],
                'sDom': 'rt<"table-footer clearfix"lip>',
              //  sPaginationType: 'two_button',
                'bStateSave': false  , /**state saving **/
                'bProcessing': true ,
                'bServerSide': true,
                'fnServerData': $.springDataJpaPageableAdapter,
                'sAjaxSource': 'roleControl/getRoleRelateUser',
                'fnInitComplete': function () {     /**datatables ready**/
                },
                'fnServerParams' :function(aoData ){
                    //表头搜索参数
                    aoData.pushArray({name: 'roleId', value: '${role.id}'})
                  //  aoData.pushArray($('#tableNavForm').serializeArray());
                },
                fnDrawCallback: function (oSettings) {
                }
            });//dataTables
            //表格全选,反选操作
            oTable.on('change.lework', '.row-check-all:checkbox', function () {
                if ($(this).prop('checked')) {
                    oTable.find('.row-check-one').prop('checked', true)
                } else {
                    oTable.find('.row-check-one').prop('checked', false)
                }
            })
            //删除成员
            $('#removeRoleUser').confirmDelete({
                onConfirm: function () {
                    var selectedRowIds = oTable.find('.row-check-one:checked')
                            .map(function () {
                                return $(this).val();
                            }).get().join(',');
                    if(selectedRowIds == ''){
                        notify({content: '请选择角色用户','type':'danger'});
                        return ;
                    }

                    $.ajax({
                        url: 'roleControl/removeRelatedUser',
                        data: {'userIds': selectedRowIds, 'roleId': roleId },
                        cache: false,
                        type: 'post',
                        success: function (resp) {
                            notify({content: resp.msg});
                            refreshMemberDatatables();
                        }
                    })
                }
            });//confirmDelete
            //添加人员到角色
            $('#addRoleUser').on('click', function () {
                dialog.ajaxModal({
                    id: 'ADD_USER_DIALOG',
                    lock: true,
                    title: '选择人员' ,
                    width: 800,
                    height: 350,
                    padding: '0',		// 内容与边界填充距离
                    ajax: {type: 'get', url: 'roleControl/addMember', data: {'roleId': roleId}  },
                    cancelVal: '关闭',
                    cancel:function(){ refreshMemberDatatables(); },
                    okVal: null,
                    ok:null
                })
            })
        })  //dom ready
    })  //seajs use

</script>
