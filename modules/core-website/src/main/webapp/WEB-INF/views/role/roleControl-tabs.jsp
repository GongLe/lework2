<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<div class="panel panel-default" id="westPanel">
    <div class="panel-body">
    <ul  class="nav nav-tabs" id="roleControlTabs">
        <li>
            <a data-toggle="tab" data-url="roleControl/member?roleId=${role.id}" href="#member">
               基本信息
            </a>
        </li>

        <li>
            <a data-toggle="tab" data-url="roleControl/menu?roleId=${role.id}" href="#menu">
                菜单权限
            </a>
        </li>

    </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="member" style="padding: 15px 0 5px;">
                加载中...
            </div>
            <div class="tab-pane" id="menu" style="padding: 15px 0 5px;">   加载中...</div>
        </div>
  </div>
 </div>
<script>
    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete', 'blockUI'  ], function (mustache, $, notify, dialog) {
        $(function () {
            var $roleControlTabs = $('#roleControlTabs'),
                    $westPanel = $('#westPanel');
            $('a[data-toggle="tab"]', $roleControlTabs[0]).on('show.bs.tab', function (e) {
                //ajax load tab content
                $westPanel.block();
                $($(this).attr('href')).load($(this).data('url'), { '$SiteMesh': 'false'}, function () {
                    $westPanel.unblock();
                });//load
                window.location.hash = $(this).attr('href').split('#')[1];
            })
            //active tab
            $('a[data-toggle="tab"]:first', $roleControlTabs[0]).tab('show');

        }); //dom ready
    })  //seajs use
</script>
