<%--
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
  --%>
<%@ page language="java" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>
<fmt:setBundle basename="messages"/>
<rave:navbar pageTitle="${pagetitle}"/>

<div class="container-fluid navbar-spacer">
    <div class="row-fluid">
        <section class="span8">
            <c:choose>
                <c:when test="${empty searchTerm and (empty widgets or widgets.totalResults eq 0)}">
                    <%-- Empty db --%>
                    <fmt:message key="page.store.list.noresult" var="listheader"/>
                </c:when>
                <c:when test="${empty searchTerm}">
                    <fmt:message key="page.store.list.result.x.to.y" var="listheader">
                        <fmt:param value="${widgets.offset + 1}"/>
                        <fmt:param value="${widgets.offset + fn:length(widgets.resultSet)}"/>
                        <fmt:param value="${widgets.totalResults}"/>
                    </fmt:message>
                </c:when>
                <c:when test="${not empty searchTerm and widgets.totalResults eq 0}">
                    <fmt:message key="page.store.list.search.noresult" var="listheader">
                        <fmt:param><c:out value="${searchTerm}"/></fmt:param>
                    </fmt:message>
                </c:when>
                <c:otherwise>
                    <fmt:message key="page.store.list.search.result.x.to.y" var="listheader">
                        <fmt:param value="${widgets.offset + 1}"/>
                        <fmt:param value="${widgets.offset + fn:length(widgets.resultSet)}"/>
                        <fmt:param value="${widgets.totalResults}"/>
                        <fmt:param><c:out value="${searchTerm}"/></fmt:param>
                    </fmt:message>
                </c:otherwise>
            </c:choose>
            <h2>${listheader}</h2>
            <%--@elvariable id="widgets" type="org.apache.rave.portal.model.util.SearchResult"--%>
            <c:if test="${widgets.totalResults gt 0}">
                <c:if test="${widgets.numberOfPages gt 1}">
                    <div>
                        <ul class="pagination">
                            <c:forEach var="i" begin="1" end="${widgets.numberOfPages}">
                                <c:url var="pageUrl" value="">
                                    <c:param name="referringPageId" value="${referringPageId}"/>
                                    <c:param name="searchTerm" value="${searchTerm}"/>
                                    <c:param name="offset" value="${(i - 1) * widgets.pageSize}"/>
                                </c:url>
                                <c:choose>
                                    <c:when test="${i eq widgets.currentPage}">
                                        <li class="active"><a href="#">${i}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="<c:out value="${pageUrl}"/>">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                        </ul>
                    </div>

                </c:if>
                <ul class="storeItems">
                        <%--@elvariable id="widget" type="org.apache.rave.portal.model.JpaWidget"--%>
                    <c:forEach var="widget" items="${widgets.resultSet}">
                        <%--@elvariable id="widgetsStatistics" type="org.apache.rave.portal.model.util.WidgetStatistics"--%>
                        <c:set var="widgetStatistics" value="${widgetsStatistics[widget.id]}"/>
                        <c:choose>
                            <c:when test='${widget.featured == "true"}'>
                                <li class="storeItem storeItemFeatured">
                            </c:when>
                            <c:otherwise>
                                <li class="storeItem">
                            </c:otherwise>
                        </c:choose>

                        <div class="storeItemLeft">
                            <c:if test="${not empty widget.thumbnailUrl}">
                                <img class="storeWidgetThumbnail" src="${widget.thumbnailUrl}"
                                     title="<c:out value="${widget.title}"/>" alt=""
                                     width="120" height="60"/>
                            </c:if>

                            <div id="widgetAdded_${widget.id}" class="storeButton">
                                <button class="btn btn-small btn-primary" id="addWidget_${widget.id}"
                                        onclick="rave.api.rpc.addWidgetToPage({widgetId: ${widget.id}, pageId: ${referringPageId}, buttonId: this.id});">
                                    <fmt:message key="page.widget.addToPage"/>
                                </button>
                            </div>

                        </div>

                        <div class="storeItemCenter">
                            <a id="widget-${widget.id}-title"
                               class="secondaryPageItemTitle"
                               href="<spring:url value="/app/store/widget/${widget.id}" />?referringPageId=${referringPageId}">
                                <c:out value="${widget.title}"/>
                            </a>
                            <c:if test="${widget.disableRendering}">
                                <div class="storeWidgetDisabled">
                                            <span class="widget-disabled-icon-store ui-icon ui-icon-alert"
                                                  title="<fmt:message key="widget.chrome.disabled"/>"></span>
                                    <c:out value="${widget.disableRenderingMessage}" escapeXml="true"/>
                                </div>
                            </c:if>
                            <c:if test="${not empty widget.author}">
                                <div class="storeWidgetAuthor"><fmt:message key="widget.author"/>: <c:out
                                        value="${widget.author}"/></div>
                            </c:if>
                            <c:if test="${not empty widget.description}">
                                <div class="storeWidgetDesc"><c:out
                                        value="${fn:substring(widget.description, 0, 200)}..."/></div>
                            </c:if>
                            <div class="widgetRating">
                                <strong><fmt:message key="page.widget.rate"/></strong>
                                <form class="hidden">
                                    <input type="hidden" id="rate-${widget.id}"
                                           value="${widgetsStatistics[widget.id]!=null?widgetsStatistics[widget.id].userRating:"-1"}">
                                </form>

                                <div class="ratingCounts">
                            		<span class="widgetLikeCount">
		                                <c:set var="widgetLikes">
		                                    ${widgetsStatistics[widget.id]!=null?widgetsStatistics[widget.id].totalLike:"0"}
		                                </c:set>
		                                <span id="totalLikes-${widget.id}" data-rave-widget-likes="${widgetLikes}">
		                                    <span class="like-text">${widgetLikes}</span>
		                                </span>
		                                <i class="icon-thumbs-up" title="${widgetLikes}&nbsp;<fmt:message key="page.widget.rate.likes"/>"></i>
                            		</span> 
                                	 <span class="widgetDislikeCount">
		                                <c:set var="widgetDislikes">
		                                    ${widgetsStatistics[widget.id]!=null?widgetsStatistics[widget.id].totalDislike:"0"}
		                                </c:set>

		                                <span id="totalDislikes-${widget.id}" data-rave-widget-dislikes="${widgetDislikes}">
		                                    <span class="dislike-text">${widgetDislikes}</span>
		                                </span>
		                                <i class="icon-thumbs-down" title="${widgetDislikes}&nbsp;<fmt:message key="page.widget.rate.dislikes"/>"></i>
		                            </span>
                                </div>
                                <div id="rating-${widget.id}" class="ratingButtons" data-toggle="buttons-radio">
	                            	<button id="like-${widget.id}" class="widgetLikeButton btn btn-mini ${widgetsStatistics[widget.id].userRating==10? 'active btn-success':''}"
                                            ${widgetsStatistics[widget.id].userRating==10 ? " checked='true'":""} name="rating-${widget.id}">
                                        <fmt:message key="page.widget.rate.likebtn"/> 
                                    </button>

                                    <button id="dislike-${widget.id}" class="widgetDislikeButton btn btn-mini ${widgetsStatistics[widget.id].userRating==0? 'active btn-danger':''}"
                                        ${widgetsStatistics[widget.id].userRating==0 ? " checked='true'":""} name="rating-${widget.id}">
                                        <fmt:message key="page.widget.rate.dislikebtn"/>
                                    </button>
                                    <!-- Displaying the likes and dislikes rating along with total votes -->
                                </div>
                            </div>
                            <c:if test="${not empty widget.tags}">
                                <table class="widgetTags">
                                    <tr>
                                        <td>
                                            <fmt:message key="page.widget.tags.title"/>
                                        </td>
                                        <c:forEach var="tag" items="${widget.tags}">
                                            <td class="storeWidgetDesc"><c:out value="${tag.tag.keyword}"/></td>
                                        </c:forEach>
                                    </tr>
                                </table>
                            </c:if>
                            <c:if test="${not empty widget.categories}">
                                <table class="widgetCategories">
                                    <tr>
                                        <td>
                                            <fmt:message key="widget.categories"/>
                                        </td>
                                        <c:forEach var="category" items="${widget.categories}">
                                            <td class="storeWidgetDesc"><c:out value="${category.text}"/></td>
                                        </c:forEach>
                                    </tr>
                                </table>
                            </c:if>

                            <span class="widgetUserCount">
                                <c:set var="widgetUserCountGreaterThanZero"
                                       value="${widgetStatistics != null && widgetStatistics.totalUserCount > 0}"/>
                                <c:if test="${widgetUserCountGreaterThanZero}">
                                    <a href="javascript:void(0);" onclick="rave.displayUsersOfWidget(${widget.id});">
                                </c:if>
                                <fmt:formatNumber groupingUsed="true"
                                                  value="${widgetStatistics!=null?widgetStatistics.totalUserCount:0}"/>&nbsp;<fmt:message key="page.widget.usercount"/>
                                <c:if test="${widgetUserCountGreaterThanZero}"></a></c:if>
                            </span>
                        </div>

                        <div class="clear-float"></div>
                        </li>
                    </c:forEach>
                </ul>

                <c:if test="${widgets.numberOfPages gt 1}">
                    <div >
                        <ul class="pagination">
                            <c:forEach var="i" begin="1" end="${widgets.numberOfPages}">
                                <c:url var="pageUrl" value="">
                                    <c:param name="referringPageId" value="${referringPageId}"/>
                                    <c:param name="searchTerm" value="${searchTerm}"/>
                                    <c:param name="offset" value="${(i - 1) * widgets.pageSize}"/>
                                </c:url>
                                <c:choose>
                                    <c:when test="${i eq widgets.currentPage}">
                                        <li class="active"><a href="#">${i}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li> <a href="<c:out value="${pageUrl}"/>">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </c:if>
        </section>
        <section class="span4">
            <form class="form-inline" action="<c:url value="/app/store/search"/>" method="GET">
                <fieldset>
                    <input type="hidden" name="referringPageId" value="${referringPageId}">
                    <legend style="margin-bottom: 0;"><fmt:message key="page.store.search"/></legend>
                    <div class="control-group" style="margin-bottom: 18px;">
                        <div class="input-append">
                            <fmt:message key="page.store.search.button" var="searchButtonText"/>
                            <input type="search" id="searchTerm" name="searchTerm" value="<c:out value="${searchTerm}"/>"/>
                            <button class="btn btn-primary" type="submit" value="${searchButtonText}">${searchButtonText}</button>
                        </div>
                    </div>
                    <legend></legend>
                    <c:if test="${not empty tags}">
                        <div class="control-group">
                            <label class="control-label" for="categoryList"><fmt:message key="page.store.list.widgets.tag"/></label>
                            <div class="controls">
                                <select name="tagList" id="tagList" class="span4">
                                <option value=""></option>
                                <c:forEach var="tag" items="${tags}">
                                    <c:choose>
                                        <c:when test="${selectedTag==tag.keyword}">
                                            <option selected>
                                        </c:when>
                                        <c:otherwise>
                                            <option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:out value="${tag.keyword}"/>
                                    </option>
                                </c:forEach>
                            </select>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty categories}">
                        <div class="control-group">
                            <label class="control-label" for="categoryList"><fmt:message key="page.store.list.widgets.category"/></label>
                            <div class="controls">
                                <select name="categoryList" id="categoryList" class="span4">
                                    <option value="0"></option>
                                    <c:forEach var="category" items="${categories}">
                                        <c:choose>
                                            <c:when test="${selectedCategory==category.id}">
                                                <option value="${category.id}" selected>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${category.id}">
                                            </c:otherwise>
                                        </c:choose>
                                        <c:out value="${category.text}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </c:if>
                </fieldset>
            </form>
            <a class="btn btn-info" href="<spring:url value="/app/store/mine?referringPageId=${referringPageId}"/>"><fmt:message key="page.store.list.widgets.mine"/></a>
            <a class="btn btn-info" href="<spring:url value="/app/store?referringPageId=${referringPageId}"/>"><fmt:message key="page.store.list.widgets.all"/></a>
        </section>
    </div>
</div>

<portal:register-init-script location="${'AFTER_RAVE'}">
    <script>
        $(function () {
            rave.store.init('<c:out value="${referringPageId}"/>');
        });
    </script>
</portal:register-init-script>
