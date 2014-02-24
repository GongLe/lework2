<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>角色权限控制</title>
</head>

<body>
<div id="main-body-content">
    <h3>角色权限控制 </h3>

    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-default">
                <div class="panel-heading">角色列表</div>
                <div class="panel-body">
                    <ul id="roleTypeTree" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-8" id="roleControlTabsContainer"> </div>
    </div>

</div>
<!--/#main-body-content -->

<script>
    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete', 'ztree' ], function (mustache, $, notify, dialog) {
        $(document).ready(function () {
            var setting = {
                callback: {
                    beforeClick: zTreeBeforeClick
                }
            } , zNodes = [] , treeObj;
            $.ajax({
                url: '${ctx}/role/getTree',
                data: {'_': (new Date()).getTime() },
                cache: false,
                type: 'post',
                success: function (resp) {
                    treeObj=  $.fn.zTree.init($("#roleTypeTree"), setting, resp);
                    onloadActiveOneNode();
                }
            })

            function zTreeBeforeClick(treeId, treeNode, clickFlag) {
                //加载tab页
                if (treeNode['attributes']['type'] == 'typeNode') {
                    notify({content: '请选择角色节点', type: 'info'})
                    return false;
                }
                 $('#roleControlTabsContainer').load2('roleControl/tabs', {'roleId': treeNode.id, '$SiteMesh': 'false'})
                return  true;
            };
            /**
            *加载完成后激活第一个节点.
             */
            function onloadActiveOneNode(){
                var nodes = treeObj.getNodes(),selectNode ;
                if (nodes.length > 0) {
                    for (var i = 0; i < nodes.length; i++) {
                        if (nodes[i]['children'] && nodes[i]['children'].length>0){
                            selectNode=nodes[i]['children'][0]
                            //ztree 节点触发点击事件
                            $('#' + selectNode.tId+'_a').trigger('click')
                            break;
                        }

                    }
                }
            }


        }); //dom ready
    })  //seajs use
</script>


</body>
</html>