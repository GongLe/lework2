<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>


<table id="roleRelatedUserTable"
       class="table table-hover table-striped dataTable dataTable-nosort clear-both"  >
</table>
<script>
    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete' ], function (mustache, $, notify, dialog) {
        $(function () {
            var oTable = $('#roleRelatedUserTable');
            var roleId = '${role.id}';
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
                            return    ''
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
                'sDom': 'rt<"table-footer clearfix"lip>',
                sPaginationType: 'two_button',
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

        })  //dom ready
    })  //seajs use

</script>
