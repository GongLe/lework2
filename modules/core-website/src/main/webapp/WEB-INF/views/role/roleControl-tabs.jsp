<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<div class="panel panel-default" id="westPanel">
    <div class="panel-body">
    <ul  class="nav nav-pills" id="roleControlTabs">
        <li>
            <a data-toggle="tab" data-url="roleControl/member" href="#member">
                角色成员
            </a>
        </li>

        <li>
            <a data-toggle="tab" data-url="roleControl/menu" href="#menu">
                菜单权限
            </a>
        </li>

    </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="member" style="padding: 15px 0 5px;">
                <div class="alert alert-warning alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <strong>Warning!</strong> Better check yourself, you're not looking too good.
                </div>
            </div>
            <div class="tab-pane" id="menu" style="padding: 15px 0 5px;">...</div>
        </div>
  </div>
 </div>
<script>
    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete','blockUI'  ], function (mustache, $, notify, dialog) {
       $(function(){
            var roleId = '${role.id}' ,$roleControlTabs = $('#roleControlTabs') ;
            $('a[data-toggle="tab"]',$roleControlTabs[0]).on('show.bs.tab', function (e) {
                //ajax load tab content
                $('#shouQuan').block();
                $($(this).attr('href')).load($(this).data('url'), {'roleId': roleId, '$SiteMesh': 'false'}, function () {
                    $('#shouQuan').unblock();
                });//load
            })
            //active tab
         //   $('a[data-toggle="tab"]:first', $roleControlTabs[0]).tab('show');


        }); //dom ready
    })  //seajs use
</script>
