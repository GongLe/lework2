<%--
  jstl递归输出
  User: Gongle
  Date: 14-2-19
  Time: 下午2:53
--%>
<%@ include file="/WEB-INF/included/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="recurseNode" value="${requestScope.node}"/>
<tr data-tt-id="${recurseNode.id}" <c:if  test="${ not empty recurseNode.parentId}"> data-tt-parent-id="${recurseNode.parentId}"</c:if>  >
    <td><input type="checkbox" value="${recurseNode.id}" class="row-check-one"></td>
    <td><c:if test="${not empty recurseNode.icon}"><i class="${recurseNode.icon}"></i></c:if></td>
    <td>${recurseNode.name} </td>
    <td>${recurseNode.code}</td>
 <td>${recurseNode.url}</td>
<td class="text-center">
    <c:choose>
        <c:when test="${recurseNode.status == 'enable'}">
            <i class="icon-ok-sign bigger-130 green" title="启用的"></i>
        </c:when>
        <c:otherwise>
            <i class="icon-remove-circle bigger-130 red" title="禁用的"></i>
        </c:otherwise>
    </c:choose>
</td>

</tr>
<%--开始递归子节点--%>
<c:if test="${not empty recurseNode.children }">
    <c:forEach items="${recurseNode.children}" varStatus="varStatus" var="treeNode">
        <c:set var="node" value="${treeNode}" scope="request"/>
        <c:import url="/WEB-INF/views/role/roleControl-treetable-recurse.jsp"/>
    </c:forEach>
</c:if>