<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp"%>


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


    <div class="collapse navbar-collapse" id="topbar-right-dropdown">


        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Link</a></li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <shiro:principal /> <b class="caret"></b></a>
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
                    <li class="divider"></li>
                    <li>
                        <a href="${ctx}/account/profile">
                            <i class="icon-user"></i>
                            个人中心
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/developer/">
                            <i class="icon-book"></i>
                            开发者文档
                        </a>
                    </li>

                    <li class="divider"></li>

                    <li>
                        <a href="${ctx}/logout">
                            <i class="icon-off"></i>
                            注销
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div><!-- /.navbar-collapse -->
</nav>