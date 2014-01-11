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
        <div class="col-md-2" style="padding:23px 0 0 0">
            <div class="panel panel-default">
                <div class="panel-body">
                    <ul id="orgTree" style="padding:10px 10px 0 5px;" ></ul>
                </div>
            </div>
        </div>
        <div class="col-md-10">

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
                        <div class="pull-right">
                          <input class="easyui-combotree" data-options="url:'organization/getTree',method:'get'" style="width:200px;height:30px">

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
                        </div>


                    </form>

                </div>
                <table id="table-list"
                       class="table table-hover table-striped dataTable dataTable-nosort clear-both">
                </table>
        </div>
    </div>

</div> <!--/#main-body-content -->

<script>
    seajs.use(['dialog','jquery' ], function (dialog,$) {
        var d = dialog({
            title: '欢迎',
            content: '欢迎使用 artDialog 对话框组件！',
            ok: function () {
                var that = this;
                this.title('正在提交..');
                setTimeout(function () {
                    that.close().remove();
                }, 2000);
                return false;
            }
        });
        d.show();
    });   //seajs use

    seajs.use(['mustache','jquery','datatables','easyui'], function (mustache,$) {
        var $orgTree =  $('#orgTree') ,
                oTable = $('#table-list');
        oTable.dataTable({
            'aoColumns': [
                { 'mData': 'id', 'sTitle': '<input type="checkbox" id="toggleCheckAll" >' },
                { 'mData': 'name', 'sTitle': '姓名' },
                { 'mData': 'loginName', 'sTitle': '用户名'}  ,
                { 'mData': 'email', 'sTitle': 'Email'}  ,
                { 'mData': 'orgName', 'sTitle': '所属部门'}  ,
                { 'mData': 'status', 'sTitle': '状态'}  ,
                { 'mData': 'id', 'sTitle': '操作'}
            ],
            'aoColumnDefs': [
                {
                    "sWidth": "5%",
                    'mRender': function (data, type, full) {
                        return    '<input type="checkbox" data-id="{0}" class="checkbox-row" >'.format(data);
                    },
                    'aTargets': [0 ]
                }, {
                    "sWidth": "8%",
                    'mRender': function (data, type, full) {
                        //  console.log(data)
                        if (data == 'enable') {
                            return   '<i class="icon-ok-sign bigger-130 green" title="启用的"></i>';
                        }
                        return    '<i class="icon-remove-circle bigger-130 red" title="禁用的"></i>';
                    },
                    'aTargets': [5 ]
                },
                {
                    'mRender': function (data, type, full) {
                        //  console.log(data)
                       // return  $('#tableActionTpl').render({id: data});
                        return   '' ;
                    },
                    'aTargets': [6 ]
                },
                { bSortable: false,
                    aTargets: [0,6]
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

            }
        });//dataTables
        //easy ui org tree

           $('#orgTree').tree({
               url: 'organization/getTree',
               method: 'get',
               checkbox: false,
               onLoadSuccess: function (node, data) {
               },
               onSelect : function (node) {
                   //oTable.fnDraw();
               }
           });

    })  //seajs use



</script>
<%--<script src="${ctx}/static/assets/sea-modules/lework/lework.convert.js"></script>--%>
<!-- ===============Mustache template ===================
    @see https://github.com/janl/mustache.js
-->
<!--table action template-->
<script id="tableActionTpl" type="text/x-mustache">
    <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
        <a class="green tooltips view"  href="user/view?id={{:id}}&$SiteMesh=false"   data-original-title="查看"
           onclick="$(this).colorbox({adjustY:'40%',width:'900px',overlayClose:false,scrolling:true,scrolling:false });" >
            <i class="icon-zoom-in bigger-140 filterSelected"></i>
        </a>
        <a class="blue tooltips update" href="user/update?id={{:id}}&$SiteMesh=false" data-original-title="编辑"
           onclick="$(this).colorbox({ adjustY:'40%',width:'700px',overlayClose:false,scrolling:false });" >
            <i class="icon-edit bigger-140 filterSelected"></i>
        </a>
        <a class="red tooltips confirmDelete" href="javascript:;" data-id="{{:id}}"  data-original-title="删除">
            <i class="icon-trash bigger-140 filterSelected"></i>
        </a>
    </div>
</script>

</body>
</html>