<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="resource.jsp" %>
    <title>dashboard</title>
</head>
<body>

<div id="main-wrap">
<%@include file="sidebar.jsp" %>

    <div id="main-content">
        <div id="main-topbar">
            <nav class="navbar navbar-default" role="navigation" style="border-radius:0;">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">lework <span class="badge" style="background: #fff;color: dodgerblue">2.0</span></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">


                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">Link</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Gongle <b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu">
                                <li>
                                    <a href="javascript:;" style="padding:3px 5px">
                                     <ul id="colorSelect" class="clearfix">
                                         <li class="default"></li>
                                         <li class="black"></li>
                                         <li class="midnight"></li>
                                         <li class="coffee"></li>
                                         <li class="blue"></li>
                                     </ul>
                                     </a>
                                </li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </nav>
        </div>
        <div id="main-body">
            <div id="main-body-content">
                <h3>标题title <button class="btn btn-danger btn-sm" hidefocus="true" >新建</button> </h3>

        <%--        <div class="row">
                    <div class="col-md-12">
                        <div class="pull-right" style="width:250px;">
                            <div class="input-group">
                                <input type="text" class="form-control">
                                <span class="input-group-addon"><i class="icon-search"></i></span>
                            </div>
                        </div>
                    </div>
                </div>--%>

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
                                  <div class="pull-right">
                                      <select class="form-control">
                                          <option selected="selected" value="0">显示所有类别</option>
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
                                          <input type="text" class="form-control" id="exampleInputPassword2" placeholder="搜索">
                                      </div>
                                      <%--   <label class="checkbox-inline">
                                             <input type="checkbox" id="inlineCheckbox1" value="option1"> 1
                                         </label>
                                         <label class="checkbox-inline">
                                             <input type="checkbox" id="inlineCheckbox2" value="option2"> 2
                                         </label>
                                         <label class="checkbox-inline">
                                             <input type="checkbox" id="inlineCheckbox3" value="option3"> 3
                                         </label>--%>
                                      <button type="submit" class="btn btn-white">筛选</button>
                                      <button type="submit" class="btn btn-link">更多筛选<i class="icon-angle-down"></i></button>
                                  </div>
                              <%--     <button type="submit" class="btn btn-white">查询</button>
                                   <button type="submit" class="btn btn-info">查询</button>
                                   <button type="submit" class="btn btn-primary">查询</button>
                                   <button type="submit" class="btn btn-danger">查询</button>
                                   <button type="submit" class="btn btn-warning">查询</button>
                                   <button type="button" class="btn btn-link">Link</button>--%>

                               </form>

                        </div>
                        <div id="table-list_wrapper" class="dataTables_wrapper dataTable-box" role="grid"><div id="table-list_processing" class="dataTables_processing" style="visibility: hidden;">&nbsp;</div>
                            <table id="table-list" class="table table-hover  table-nomargin table-striped -table-bordered dataTable dataTable-nosort clear-both" aria-describedby="table-list_info">
                            <thead>
                            <tr role="row"><th class="sorting_asc" tabindex="0" rowspan="1" colspan="1" aria-label="角色名称: activate to sort column ascending" style="width: 255px;">角色名称</th><th class="sorting" tabindex="0" rowspan="1" colspan="1" aria-label="角色代码: activate to sort column ascending" style="width: 255px;">角色代码</th><th class="sorting" tabindex="0" rowspan="1" colspan="1" aria-label="类别: activate to sort column ascending" style="width: 173px;">类别</th><th class="center sorting" tabindex="0" rowspan="1" colspan="1" aria-label="状态: activate to sort column ascending" style="width: 173px;">状态</th><th class="sorting_disabled" tabindex="0" rowspan="1" colspan="1" aria-label="操作" style="width: 125px;">操作</th></tr></thead><tbody role="alert" aria-live="polite" aria-relevant="all"><tr class="odd"><td class=" sorting_1">管理员</td><td class="">admin</td><td class="">系统角色</td><td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td><td class="">
                            <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                <a class="green tooltips view" href="role/view?id=402881e742e019660142e0248f260007&amp;$SiteMesh=false" data-original-title="查看" onclick="$(this).colorbox({adjustY:'40%',width:'650px',overlayClose:false,scrolling:true,scrolling:false });">
                                    <i class="icon-zoom-in bigger-140 filterSelected"></i>
                                </a>
                                <a class="blue tooltips update" href="role/update?id=402881e742e019660142e0248f260007&amp;$SiteMesh=false" data-original-title="编辑" onclick="$(this).colorbox({ adjustY:'40%',width:'700px',overlayClose:false,scrolling:false });">
                                    <i class="icon-edit bigger-140 filterSelected"></i>
                                </a>
                                <a class="red tooltips confirmDelete" href="javascript:;" data-id="402881e742e019660142e0248f260007" data-original-title="删除" data-hasqtip="1">
                                    <i class="icon-trash bigger-140 filterSelected"></i>
                                </a>
                            </div>
                        </td></tr><tr class="even"><td class=" sorting_1">普通用户</td><td class="">normalRole</td><td class="">系统角色</td><td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td><td class="">
                            <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                <a class="green tooltips view" href="role/view?id=402881e742e019660142e02d11b5000b&amp;$SiteMesh=false" data-original-title="查看" onclick="$(this).colorbox({adjustY:'40%',width:'650px',overlayClose:false,scrolling:true,scrolling:false });">
                                    <i class="icon-zoom-in bigger-140 filterSelected"></i>
                                </a>
                                <a class="blue tooltips update" href="role/update?id=402881e742e019660142e02d11b5000b&amp;$SiteMesh=false" data-original-title="编辑" onclick="$(this).colorbox({ adjustY:'40%',width:'700px',overlayClose:false,scrolling:false });">
                                    <i class="icon-edit bigger-140 filterSelected"></i>
                                </a>
                                <a class="red tooltips confirmDelete" href="javascript:;" data-id="402881e742e019660142e02d11b5000b" data-original-title="删除" data-hasqtip="2">
                                    <i class="icon-trash bigger-140 filterSelected"></i>
                                </a>
                            </div>
                        </td></tr><tr class="odd"><td class=" sorting_1">测试角色-上海分公司01</td><td class="">02</td><td class="">系统角色</td><td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td><td class="">
                            <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                <a class="green tooltips view" href="role/view?id=402882ee42b34ff50142b358eeba0001&amp;$SiteMesh=false" data-original-title="查看" onclick="$(this).colorbox({adjustY:'40%',width:'650px',overlayClose:false,scrolling:true,scrolling:false });">
                                    <i class="icon-zoom-in bigger-140 filterSelected"></i>
                                </a>
                                <a class="blue tooltips update" href="role/update?id=402882ee42b34ff50142b358eeba0001&amp;$SiteMesh=false" data-original-title="编辑" onclick="$(this).colorbox({ adjustY:'40%',width:'700px',overlayClose:false,scrolling:false });">
                                    <i class="icon-edit bigger-140 filterSelected"></i>
                                </a>
                                <a class="red tooltips confirmDelete" href="javascript:;" data-id="402882ee42b34ff50142b358eeba0001" data-original-title="删除" data-hasqtip="3">
                                    <i class="icon-trash bigger-140 filterSelected"></i>
                                </a>
                            </div>
                        </td></tr><tr class="even"><td class=" sorting_1">测试角色-上海分公司03</td><td class="">03</td><td class="">系统角色</td><td class="center"><i class="icon-ok-sign bigger-130 red" title="禁用的"></i></td><td class="">
                            <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                <a class="green tooltips view" href="role/view?id=402882ee42b34ff50142b3590a6c0002&amp;$SiteMesh=false" data-original-title="查看" onclick="$(this).colorbox({adjustY:'40%',width:'650px',overlayClose:false,scrolling:true,scrolling:false });">
                                    <i class="icon-zoom-in bigger-140 filterSelected"></i>
                                </a>
                                <a class="blue tooltips update" href="role/update?id=402882ee42b34ff50142b3590a6c0002&amp;$SiteMesh=false" data-original-title="编辑" onclick="$(this).colorbox({ adjustY:'40%',width:'700px',overlayClose:false,scrolling:false });">
                                    <i class="icon-edit bigger-140 filterSelected"></i>
                                </a>
                                <a class="red tooltips confirmDelete" href="javascript:;" data-id="402882ee42b34ff50142b3590a6c0002" data-original-title="删除" data-hasqtip="4">
                                    <i class="icon-trash bigger-140 filterSelected"></i>
                                </a>
                            </div>
                        </td></tr></tbody></table><div class="table-footer clearfix"><div class="dataTables_info" id="table-list_info">显示1到4条,共4条记录</div><div class="dataTables_paginate paging_full_numbers" id="table-list_paginate"><a tabindex="0" class="first paginate_button paginate_button_disabled" id="table-list_first">首页</a><a tabindex="0" class="previous paginate_button paginate_button_disabled" id="table-list_previous"> 上一页 </a><span><a tabindex="0" class="paginate_active">1</a></span><a tabindex="0" class="next paginate_button paginate_button_disabled" id="table-list_next"> 下一页 </a><a tabindex="0" class="last paginate_button paginate_button_disabled" id="table-list_last"> 尾页 </a></div></div></div>

                    </div>
                </div>

      <div class="row">

          <div class="col-md-12">
              <p>&nbsp;&nbsp;</p>

              <div id="table-list_wrapper2" class="dataTables_wrapper  " role="grid">
                  <div id="table-list_processing1" class="dataTables_processing" style="visibility: hidden;">&nbsp;</div>
                  <table id="table-list2"
                         class="table table-nomargin table-striped -table-bordered dataTable dataTable-nosort clear-both"
                         aria-describedby="table-list_info">
                      <thead>
                      <tr role="row">
                          <th  tabindex="0" rowspan="1" colspan="1"  style="width:20px;"  >
                              <input type="checkbox" >
                          </th>
                          <th class="sorting" tabindex="0" rowspan="1" colspan="1"
                              aria-label="角色名称: activate to sort column ascending" style="width: 255px;">角色名称
                          </th>
                          <th class="sorting" tabindex="0" rowspan="1" colspan="1"
                              aria-label="角色代码: activate to sort column ascending" style="width: 255px;">角色代码
                          </th>
                          <th class="sorting" tabindex="0" rowspan="1" colspan="1"
                              aria-label="类别: activate to sort column ascending" style="width: 173px;">类别
                          </th>
                          <th class="center sorting" tabindex="0" rowspan="1" colspan="1"
                              aria-label="状态: activate to sort column ascending" style="width: 173px;">状态
                          </th>
                      </tr>
                      </thead>
                      <tbody role="alert" aria-live="polite" aria-relevant="all">
                      <tr class="odd">
                          <td class=" sorting_1">
                              <input type="checkbox" >
                          </td>
                          <td class=" sorting_1">管理员>>
                              <div class="row-actions">
                                  <span><a href="#" class="info"  >查看</a> | </span>
                                  <span><a class="info" href="#" title="编辑此项目">编辑</a> | </span>
                                  <span><a class="danger" href="#">删除</a></span>

                              </div>
                          </td>
                          <td class="">admin</td>
                          <td class="">系统角色</td>
                          <td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td>

                      </tr>
                      <tr class="odd">
                          <td class=" sorting_1">
                              <input type="checkbox" >
                          </td>
                          <td class=" sorting_1">管理员>>
                              <div class="row-actions">
                                  <span><a href="#" class="info"  >查看</a> | </span>
                                  <span><a class="info" href="#" title="编辑此项目">编辑</a> | </span>
                                  <span><a class="danger" href="#">删除</a></span>

                              </div>
                          </td>
                          <td class="">admin</td>
                          <td class="">系统角色</td>
                          <td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td>

                      </tr>
                      <tr class="odd">
                          <td class=" sorting_1">
                              <input type="checkbox" >
                          </td>
                          <td class=" sorting_1">管理员>>
                              <div class="row-actions">
                                  <span><a href="#" class="info"  >查看</a> | </span>
                                  <span><a class="info" href="#" title="编辑此项目">编辑</a> | </span>
                                  <span><a class="danger" href="#">删除</a></span>

                              </div>
                          </td>
                          <td class="">admin</td>
                          <td class="">系统角色</td>
                          <td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td>

                      </tr>
                      <tr class="odd">
                          <td class=" sorting_1">
                              <input type="checkbox" >
                          </td>
                          <td class=" sorting_1">管理员>>
                              <div class="row-actions">
                                  <span><a href="#" class="info"  >查看</a> | </span>
                                  <span><a class="info" href="#" title="编辑此项目">编辑</a> | </span>
                                  <span><a class="danger" href="#">删除</a></span>

                              </div>
                          </td>
                          <td class="">admin</td>
                          <td class="">系统角色</td>
                          <td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td>

                      </tr>
                      <tr class="odd">
                          <td class=" sorting_1">
                              <input type="checkbox" >
                          </td>
                          <td class=" sorting_1">管理员>>
                              <div class="row-actions">
                                  <span><a href="#" class="info"  >查看</a> | </span>
                                  <span><a class="info" href="#" title="编辑此项目">编辑</a> | </span>
                                  <span><a class="danger" href="#">删除</a></span>

                              </div>
                          </td>
                          <td class="">admin</td>
                          <td class="">系统角色</td>
                          <td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td>

                      </tr>
                      <tr class="odd">
                          <td class=" sorting_1">
                              <input type="checkbox" >
                          </td>
                          <td class=" sorting_1">管理员>>
                              <div class="row-actions">
                                  <span><a href="#" class="info"  >查看</a> | </span>
                                  <span><a class="info" href="#" title="编辑此项目">编辑</a> | </span>
                                  <span><a class="danger" href="#">删除</a></span>

                              </div>
                          </td>
                          <td class="">admin</td>
                          <td class="">系统角色</td>
                          <td class="center"><i class="icon-ok-sign bigger-130 green" title="启用的"></i></td>

                      </tr>

                      </tbody>
                  </table>
                  <div class="table-footer clearfix">
                      <div class="dataTables_info" id="table-list_info">显示1到4条,共4条记录</div>
                      <div class="dataTables_paginate paging_full_numbers" id="table-list_paginate"><a tabindex="0"
                                                                                                       class="first paginate_button paginate_button_disabled"
                                                                                                       id="table-list_first">首页</a><a
                              tabindex="0" class="previous paginate_button paginate_button_disabled"
                              id="table-list_previous"> 上一页 </a><span><a tabindex="0"
                                                                         class="paginate_active">1</a></span><a
                              tabindex="0" class="next paginate_button paginate_button_disabled" id="table-list_next">
                          下一页 </a><a tabindex="0" class="last paginate_button paginate_button_disabled"
                                     id="table-list_last"> 尾页 </a></div>
                  </div>
              </div>


          </div>

      </div>
      <div class="row">
          <div class="col-md-6">
              <p>&nbsp;</p>
              <form class="form-horizontal" role="form">
                  <div class="form-group">
                      <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
                      <div class="col-sm-10">
                          <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
                      </div>
                  </div>
                  <div class="form-group">
                      <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
                      <div class="col-sm-10">
                          <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
                      </div>
                  </div>
                  <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-10">
                          <div class="checkbox">
                              <label>
                                  <input type="checkbox"> Remember me
                              </label>
                          </div>
                      </div>
                  </div>
                  <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-10">
                          <button type="submit" class="btn btn-default">Sign in</button>
                      </div>
                  </div>
              </form>
          </div>
      </div>
      <div class="row">
          <div class="col-md-7">
              <div class="bs-example">
                  <div class="alert alert-success">
                      <strong>Well done!</strong> You successfully read this important alert message.
                  </div>
                  <div class="alert alert-info">
                      <strong>Heads up!</strong> This alert needs your attention, but it's not super important.
                  </div>
                  <div class="alert alert-warning">
                      <strong>Warning!</strong> Best check yo self, you're not looking too good.
                  </div>
                  <div class="alert alert-danger">
                      <strong>Oh snap!</strong> Change a few things up and try submitting again.
                  </div>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-7">
              <div class="bs-example">
                  <div class="progress progress-striped">
                      <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                          <span class="sr-only">40% Complete (success)</span>
                      </div>
                  </div>
                  <div class="progress progress-striped">
                      <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                          <span class="sr-only">20% Complete</span>
                      </div>
                  </div>
                  <div class="progress progress-striped">
                      <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                          <span class="sr-only">60% Complete (warning)</span>
                      </div>
                  </div>
                  <div class="progress progress-striped">
                      <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                          <span class="sr-only">80% Complete (danger)</span>
                      </div>
                  </div>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-6">
              <ul class="nav nav-tabs">
                  <li class="active"><a href="#">Home</a></li>
                  <li><a href="#">Help</a></li>
                  <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                          Dropdown <span class="caret"></span>
                      </a>
                      <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Action</a></li>
                          <li><a href="#">Another action</a></li>
                          <li><a href="#">Something else here</a></li>
                          <li class="divider"></li>
                          <li><a href="#">Separated link</a></li>
                      </ul>
                  </li>
              </ul>
              <div class="tabbable tabs-below">
                  <div class="tab-content">
                      <div id="home2" class="tab-pane">
                          <p>Raw denim you probably haven't heard of them jean shorts Austin.</p>
                      </div>

                      <div id="profile2" class="tab-pane active">
                          <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid.</p>
                      </div>

                      <div id="dropdown12" class="tab-pane">
                          <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade.</p>
                      </div>
                  </div>

                  <ul class="nav nav-tabs" id="myTab2">
                      <li class="">
                          <a data-toggle="tab" href="#home2">Home</a>
                      </li>

                      <li class="active">
                          <a data-toggle="tab" href="#profile2">Profile</a>
                      </li>

                      <li class="">
                          <a data-toggle="tab" href="#dropdown12">More</a>
                      </li>
                  </ul>

              </div>

          </div>
          <div class="col-sm-6">
              <div class="tabbable tabs-left">
                  <ul class="nav nav-tabs" id="myTab3">
                      <li class="">
                          <a data-toggle="tab" href="#home3">
                              <i class="pink icon-dashboard bigger-110"></i>
                              Home
                          </a>
                      </li>

                      <li class="active">
                          <a data-toggle="tab" href="#profile3">
                              <i class="blue icon-user bigger-110"></i>
                              Profile
                          </a>
                      </li>

                      <li class="">
                          <a data-toggle="tab" href="#dropdown13">
                              <i class="icon-rocket"></i>
                              More
                          </a>
                      </li>
                  </ul>

                  <div class="tab-content">
                      <div id="home3" class="tab-pane">
                          <p>Raw denim you probably haven't heard of them jean shorts Austin.</p>
                          <p>Raw denim you probably haven't heard of them jean shorts Austin.</p>
                      </div>

                      <div id="profile3" class="tab-pane active">
                          <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid.</p>
                          <p>Raw denim you probably haven't heard of them jean shorts Austin.</p>
                      </div>

                      <div id="dropdown13" class="tab-pane">
                          <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade.</p>
                          <p>Raw denim you probably haven't heard of them jean shorts Austin.</p>
                      </div>
                  </div>
              </div>
              <p> </p>
              <div class="tabbable">
                  <ul class="nav nav-tabs padding-12 tab-color-blue background-blue" id="myTab4">
                      <li class="active">
                          <a data-toggle="tab" href="#home4">Home</a>
                      </li>

                      <li>
                          <a data-toggle="tab" href="#profile4">Profile</a>
                      </li>

                      <li>
                          <a data-toggle="tab" href="#dropdown14">More</a>
                      </li>
                  </ul>

                  <div class="tab-content">
                      <div id="home4" class="tab-pane in active">
                          <p>Raw denim you probably haven't heard of them jean shorts Austin.</p>
                      </div>

                      <div id="profile4" class="tab-pane">
                          <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid.</p>
                      </div>

                      <div id="dropdown14" class="tab-pane">
                          <p>Etsy mixtape wayfarers, ethical wes anderson tofu before they sold out mcsweeney's organic lomo retro fanny pack lo-fi farm-to-table readymade.</p>
                      </div>
                  </div>
              </div>
          </div>
      </div>
      <div class="row">
          <div class="col-md-7"  >
               <p>
              <div class="bs-example">
                  <div class="panel panel-primary">
                      <div class="panel-heading">
                          <h3 class="panel-title">Panel title</h3>
                      </div>
                      <div class="panel-body">
                          Panel content
                      </div>
                  </div>
                  <div class="panel panel-success">
                      <div class="panel-heading">
                          <h3 class="panel-title">Panel title</h3>
                      </div>
                      <div class="panel-body">
                          Panel content
                      </div>
                  </div>
                  <div class="panel panel-info">
                      <div class="panel-heading">
                          <h3 class="panel-title">Panel title</h3>
                      </div>
                      <div class="panel-body">
                          Panel content
                      </div>
                  </div>
                  <div class="panel panel-warning">
                      <div class="panel-heading">
                          <h3 class="panel-title">Panel title</h3>
                      </div>
                      <div class="panel-body">
                          Panel content
                      </div>
                  </div>
                  <div class="panel panel-danger">
                      <div class="panel-heading">
                          <h3 class="panel-title">Panel title</h3>
                      </div>
                      <div class="panel-body">
                          Panel content
                      </div>
                  </div>
              </div>
               </p>

          </div>

      </div>
      <div class="row">
          <div class="col-md-7"  >
               <p>
                <div class="panel panel-default">
                  <div class="panel-heading panel-body-noborder">
                      <h5 class="panel-title">Panel title</h5>
                  </div>

                        <div class="panel-body">
                            <form role="form">
                                <fieldset disabled="">
                                    <div class="form-group">
                                        <label for="disabledTextInput">Disabled input</label>
                                        <input type="text" id="disabledTextInput" class="form-control" placeholder="Disabled input">
                                    </div>
                                    <div class="form-group">
                                        <label for="disabledSelect">Disabled select menu</label>
                                        <select id="disabledSelect" class="form-control">
                                            <option>Disabled select</option>
                                        </select>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox"> Can't check this
                                        </label>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </fieldset>
                            </form>
                        </div>
                </div>
               </p>

          </div>

      </div>

</div>
 </div>
  </div>
</body>
</html>