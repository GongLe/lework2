<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
 <div id="memberContainer" style="width:800px;min-height: 350px;padding: 10px 20px 0px 20px;">
     <div class="row ">
         <div class="col-sm-12">
             <div class="alert alert-info " style="margin-bottom: 5px;">${role.name}(${role.code})</div>
         </div>
         <div class="col-sm-4" style="height: 400px;border-right:1px solid #c0c0c0;" >
             <h6  class="smaller lighter blue">部门</h6>
             <ul id="orgTree" class="ztree"></ul>
         </div>
         <div class="col-sm-8">
             <h6  class="smaller lighter blue text-left">成员</h6>
             <div id="userItems">
                 加载中...
             </div>
         </div>

     </div>  <!--/.row-->
 </div>
<script>
    seajs.use(['mustache', 'jquery', 'notify', 'dialog', 'datatables', 'confirmDelete', 'ztree' ], function (mustache, $, notify, dialog) {

        $(function () {
            var roleId = '${role.id}',$orgTree  = $('#orgTree')  ;
            //ztree
            var setting = {
                callback: {
                    beforeClick: zTreeBeforeClick
                }
            } , zNodes = [] , treeObj;
            $.ajax({
                url: 'organization/getTree',
                data: {'_': (new Date()).getTime() },
                cache: false,
                type: 'post',
                success: function (resp) {
                    treeObj=  $.fn.zTree.init($orgTree, setting, resp);
                   onloadActiveOneNode();
                }
            })

            function zTreeBeforeClick(treeId, treeNode, clickFlag) {
                loadCheckUserItems(treeNode.id,roleId) ;
                return  true;
            };
            /**
             *加载完成后激活第一个节点.
             */
            function onloadActiveOneNode(){
                var nodes = treeObj.getNodes() ;
                if (nodes.length > 0) {
                    $('#' + nodes[0].tId+'_a').trigger('click')
                }
            }

            //对应的User选项列表
            function loadCheckUserItems(orgId, roleId) {
                $('#userItems').load2('roleControl/addMember-checkUser?',{
                    '$SiteMesh': false,
                    roleId: roleId,
                    orgId: orgId
                } );
            }
        }) //dom ready
    })//seajs use


</script>
