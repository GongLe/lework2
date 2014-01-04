<%@ page import="org.lework.core.persistence.entity.ShiroUser" %>
<%@ page import="org.lework.core.persistence.entity.SubjectUtils" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/included/taglibs.jsp"%>
<%
    //菜单保存到session
    ShiroUser user = SubjectUtils.getUser();
    if (session.getAttribute("USER_MENU_LIST") == null) {
        if (user != null) {
            session.setAttribute("USER_MENU_LIST", user.getMenus());
        }
    }
%>
<div class="sidebar" id="sidebar">


<ul class="nav-list" role="navigation">
    <%-- 三级级菜单循环输出--%>
    <c:forEach items="${sessionScope.USER_MENU_LIST}" var="menu">
        <li>
            <a  <c:if   test="${ not empty menu.url }">  href="${ctx}${menu.url}"  </c:if>
                    data-menu-id="${menu.id}"  id="${menu.id}"  <c:if test="${  menu.hasChild eq 'true' }">class="dropdown-toggle" </c:if> >
                <c:if test="${not empty menu.icon}">
                    <i class="${menu.icon}"></i>
                </c:if>
                <span class="menu-text-in"> ${menu.name} </span>
                <c:if test="${menu.hasChild eq  true }">
                    <b class="arrow icon-angle-down"></b>
                </c:if>
            </a>
            <c:if test="${menu.hasChild == true }">

                <ul class="submenu">
                    <c:forEach items="${menu.childrenMenus}" var="subMenu">

                        <li>
                            <a href="${ctx}${subMenu.url}" data-menu-id="${subMenu.id}"  id="${subMenu.id}"
                               <c:if test="${not empty subMenu.childrenMenus }">class="dropdown-toggle" </c:if> >
                                <c:if test="${not empty subMenu.icon}">
                                    <i class="${subMenu.icon}"></i>
                                </c:if>
                                <span class="menu-text-in"> ${subMenu.name} </span>

                                <c:if test="${subMenu.hasChild eq  true}">
                                    <b class="arrow icon-angle-down"></b>
                                </c:if>
                            </a>
                            <c:if test="${ subMenu.childrenMenus !=null}">
                                <ul class="submenu">
                                    <c:forEach items="${subMenu.childrenMenus}" var="subMenu3">
                                        <li>
                                            <a href="${ctx}${subMenu3.url}" data-menu-id="${subMenu3.id}"  id="${subMenu3.id}"
                                               <c:if test="${subMenu3.hasChild == true}">class="dropdown-toggle" </c:if> >
                                                <c:if test="${not empty subMenu3.icon}">
                                                    <i class="${subMenu3.icon}"></i>
                                                </c:if>
                                                <span class="menu-text-in"> ${subMenu3.name} </span>
                                                <c:if test="${subMenu3.hasChild eq  true }">
                                                    <b class="arrow icon-angle-down"></b>
                                                </c:if>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </li>
    </c:forEach>
</ul>
<!-- /.nav-list -->

<div class="sidebar-collapse" id="sidebar-collapse">
    <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
</div>


</div>
<script>
    seajs.use(['jquery' , 'cookie'  ], function ($) {
        $(function () {
            //设置当前菜单ID
            $('#sidebar').on('click', 'a', function () {
                //写入大概二十分钟cookie
                $(this).data('menuId') && $.cookie('CUR_MENU_ID', $(this).data('menuId'), {expires: 0.015})
            })
            //激活当前页面菜单.
            var curMenuId = $.cookie('CUR_MENU_ID') , $this , $submenu;
            if (curMenuId) {
                $this = $('#' + curMenuId);
                $this.parent('li').addClass('active')
                $submenu = $this.parents('ul.submenu');
                $submenu.length > 0 && $submenu.parent('li').addClass('active open')
            }

        }) //dom ready
    }) //seajs.use
</script>