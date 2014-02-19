<%--
  jstl递归输出
  User: Gongle
  Date: 14-2-19
  Time: 下午2:53
--%>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="recurseNode" value="${requestScope.node}"/>
<tr data-tt-id="${recurseNode.id}" <c:if test="${ not empty recurseNode.parentId}">  data-tt-parent-id="${recurseNode.parentId}"</c:if>  >
<td>${recurseNode.name}
    <div class="row-actions">
        <span class="no-padding">
            <a class="info edit" data-id="${recurseNode.id}" data-name="${recurseNode.name}" href="javascript:;" title="编辑"><i class="icon-edit"></i></a> |
        </span>
        <span class="no-padding">
            <a class="info confirmDelete" data-id="${recurseNode.id}"  data-name="${recurseNode.name}"  href="javascript:;" title="删除"><i class="icon-trash"></i></a>
        </span>
    </div>
</td>
<td>${recurseNode.code}</td>
 <td>${recurseNode.manager}</td>
<td>${recurseNode.phone}</td>
 <td class="text-center">

    <c:choose>
        <c:when test="${recurseNode.siblingSize>0}">
            <a href="javascript:;" class="sortNumAction up" data-id="${recurseNode.id}"
               title="上移序号"><i class="icon-chevron-up"></i></a>
            &nbsp;
        </c:when>
        <c:otherwise>
            <a href="javascript:;" class="sortNumAction" style="color:#c0c0c0;"
               title="上移序号"><i class="icon-chevron-up"></i></a>
            &nbsp;
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${recurseNode.siblingSize>0}">
            <a href="javascript:;" class="sortNumAction down" data-id="${recurseNode.id}"
               title="下移序号"><i
                    class="icon-chevron-down"></i></a>
        </c:when>
        <c:otherwise>
            <a href="javascript:;" class="sortNumAction"style="color:#c0c0c0;"
               title="下移序号"><i
                    class="icon-chevron-down"></i></a>
        </c:otherwise>
    </c:choose>


</td>
</tr>
<%--开始递归子节点--%>
<c:if test="${not empty recurseNode.children }">
    <c:forEach items="${recurseNode.children}" varStatus="varStatus" var="treeNode">
        <c:set var="node" value="${treeNode}" scope="request"/>
        <c:import url="/WEB-INF/views/organization/org-treetable-recurse.jsp"/>
    </c:forEach>
</c:if>