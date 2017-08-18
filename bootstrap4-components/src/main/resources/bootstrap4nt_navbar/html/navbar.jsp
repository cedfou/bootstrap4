<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<template:addResources type="css" resources="bootstrap.min.css"/>
<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources type="javascript" resources="popper.min.js"/>
<template:addResources type="javascript" resources="bootstrap.min.js"/>
<c:if test="${jcr:isNodeType(currentNode, 'bootstrap4mix:customButtonNavbar')}">
    <c:set var="buttonClass" value="${currentNode.properties.buttonClass.string}"/>
    <c:set var="brandImage" value="${currentNode.properties.brandImage.node}"/>
    <c:set var="brandText" value="${currentNode.properties.brandText.string}"/>
</c:if>
<c:if test="${empty buttonClass}">
    <c:set var="buttonClass" value="navbar-toggler navbar-toggler-right"/>
</c:if>


<c:if test="${jcr:isNodeType(currentNode, 'bootstrap4mix:advancedNavbar')}">
    <c:set var="navClass" value="${currentNode.properties.navClass.string}"/>
    <c:set var="divClass" value="${currentNode.properties.divClass.string}"/>
</c:if>
<c:if test="${empty navClass}">
    <c:set var="navClass" value="navbar navbar-expand-lg navbar-light bg-light"/>
</c:if>
<c:if test="${empty divClass}">
    <c:set var="divClass" value="collapse navbar-collapse"/>
</c:if>

<c:set var="root" value="${currentNode.properties.root.string}"/>
<c:set var="curentPageNode" value="${jcr:getMeAndParentsOfType(renderContext.mainResource.node,'jnt:page')}"/>
<c:choose>
    <c:when test="${root eq 'currentPage'}">
        <c:set var="rootNode" value="${curentPageNode}"/>
    </c:when>
    <c:when test="${root eq 'parentPage'}">
        <c:set var="rootNode" value="${curentPageNode.parent}"/>
    </c:when>
    <c:otherwise>
        <c:set var="rootNode" value="${renderContext.site.home}"/>
    </c:otherwise>
</c:choose>
<nav class="${navClass}">
    <c:url var="rootNodeUrl" value="${rootNode.url}"/>
    <a class="navbar-brand" href="${rootNodeUrl}">
        <c:if test="${! empty brandImage}">
            <c:url var="brandImageUrl" value="${brandImage.url}"/>
            <img src="${brandImageUrl}" width="30" height="30" class="d-inline-block align-top" alt="">
        </c:if>
        ${brandText}
    </a>

    <button class="${buttonClass}" type="button" data-toggle="collapse"
            data-target="#navbar-${currentNode.identifier}" aria-controls="navbar-${currentNode.identifier}"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="${divClass}" id="navbar-${currentNode.identifier}">
        <template:include view="basenav"/>
    </div>
</nav>
