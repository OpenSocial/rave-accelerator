
<%@ page language="java" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>
<fmt:setBundle basename="messages"/>
<fmt:message key="page.addwidget.title" var="pagetitle"/>
<rave:navbar pageTitle="${pagetitle}"/>

<div class="container">
    <h2><fmt:message key="page.addwidget.form.header"/></h2>
    <form:errors path="widget" cssClass="error" element="p"/>
    <form:form cssClass="form-horizontal" id="newWidgetForm" action="add?referringPageId=${referringPageId}" commandName="widget" method="POST">
        <fieldset>
            <div class="control-group label label-important"><fmt:message key="form.some.fields.required"/></div>

            <div class="control-group">
                <spring:bind path="url">
                    <label class="control-label" for="url"><fmt:message key="widget.url"/> *</label>
                    <div class="controls"><input class="input-xlarge" type="url" name="url" id="url"
                                                 placeholder="http://example.com/widget.xml" required="required"
                                                 value="<c:out value="${widget.url}"/>"/></div>
                </spring:bind>
                <form:errors path="url" cssClass="error"/>
            </div>

            <div class="control-group" style="display:none">
                <label class="control-label" for="type1"><fmt:message key="widget.type"/> *</label>
            </div>
            <div class="control-group" style="display:none">
                <label class="control-label" for="type1"><fmt:message key="widget.type.OpenSocial"/></label>
                <div class="controls"><form:radiobutton path="type" value="OpenSocial"/></div>
            </div>
            <div class="control-group" style="display:none">
                <label class="control-label" for="type2"><fmt:message key="widget.type.W3C"/></label>

                <div class="controls"><form:radiobutton path="type" value="W3C"/>
                    <a id="w3cBrowseLink" style="margin-left: 10px;" href="#"><fmt:message key="page.general.browse"/></a>
                </div>
                <form:errors path="type" cssClass="error"/>
            </div>

            <a href="#" class="btn btn-primary"
               id="fetchMetadataButton"
               onclick="rave.api.rpc.getWidgetMetadata({
                                url: $('#url').get(0).value,
                                providerType: $('input:radio[name=type]:checked').val(),
                                successCallback: function(result) {
                                    var widget = result.result;
                                    $('#title').val(widget.title);
                                    $('#description').val(widget.description);
                                    $('#thumbnailUrl').val(widget.thumbnailUrl);
                                    $('#screenshotUrl').val(widget.screenshotUrl);
                                    $('#titleUrl').val(widget.titleUrl);
                                    $('#author').val(widget.author);
                                    $('#authorEmail').val(widget.authorEmail);
                                    $('#addWidgetForm').show();
                                    $('#addWidgetFormSubmit').show();
                                    // update this field so we can pass widgets by key
                                    // (soon to be superseeded in wookie by using the guid instead)
                                    // remove when using 0.10.0 of wookie
                                    if($('input[name=type]:checked').val()=='W3C'){
                                        $('#url').val(widget.url);
                                    }
                                }
                            });">
                <fmt:message key="page.getWidgetMetadata.button"/>
            </a>

            <div class="row clearfix" id="addWidgetForm">


                <div class="control-group">
                    <form:label cssClass="control-label" path="title"> <fmt:message key="widget.title"/> *</form:label>
                    <div class="controls">
                        <form:input path="title" cssClass="input-xlarge" required="required" autofocus="autofocus"/></div>
                    <form:errors path="title" cssClass="error"/>
                </div>

                <div class="control-group">
                    <form:label cssClass="control-label" path="description"><fmt:message key="widget.description"/> *</form:label>
                    <div class="controls"><form:textarea path="description" required="required" cssClass="input-xlarge"/></div>
                    <form:errors path="description" cssClass="error"/>
                </div>

                <div class="control-group">
                    <spring:bind path="thumbnailUrl">
                        <label class="control-label" for="thumbnailUrl"><fmt:message key="widget.thumbnailUrl"/></label>
                        <div class="controls"><input type="url" name="thumbnailUrl" id="thumbnailUrl"
                                                     placeholder="http://example.com/thumbnail.png" class="input-xlarge"
                                                     value="<c:out value="${widget.thumbnailUrl}"/>"/></div>
                    </spring:bind>
                    <form:errors path="thumbnailUrl" cssClass="error"/>
                </div>

                <div class="control-group">
                    <spring:bind path="screenshotUrl">
                        <label class="control-label" for="screenshotUrl"><fmt:message key="widget.screenshotUrl"/></label>
                        <div class="controls">
                            <input type="url" name="screenshotUrl" id="screenshotUrl" placeholder="http://example.com/screenshot.png" class="input-xlarge"
                                   value="<c:out value="${widget.screenshotUrl}"/>"/></div>
                    </spring:bind>
                    <form:errors path="screenshotUrl" cssClass="error"/>
                </div>

                <div class="control-group">
                    <spring:bind path="titleUrl">
                        <label class="control-label" for="titleUrl"><fmt:message key="widget.titleUrl"/></label>
                        <div class="controls"><input type="url" name="titleUrl" id="titleUrl"
                                                     class="input-xlarge" value="<c:out value="${widget.titleUrl}"/>"/></div>
                    </spring:bind>
                    <form:errors path="titleUrl" cssClass="error"/>
                </div>

                <div class="control-group">
                    <form:label cssClass="control-label" path="author"><fmt:message key="widget.author"/></form:label>
                    <div class="controls"><form:input path="author" cssClass="input-xlarge"/>
                        <form:errors path="author" cssClass="error"/>
                    </div>

                </div>
                <div class="control-group">
                    <spring:bind path="authorEmail">
                        <label class="control-label" for="authorEmail"><fmt:message key="widget.authorEmail"/></label>
                        <div class="controls"><input type="email" name="authorEmail" id="authorEmail" class="input-xlarge"
                                                     value="<c:out value="${widget.authorEmail}"/>"/></div>
                    </spring:bind>
                    <form:errors path="titleUrl" cssClass="error"/>
                </div>
            </div>
        </fieldset>
        <div id="addWidgetFormSubmit">
            <fieldset>
                <fmt:message key="page.addwidget.form.submit" var="submit"/>
                <button class="btn btn-primary" type="submit" value="${submit}">${submit}</button>
            </fieldset>
        </div>
    </form:form>
</div>
<div id="w3cBrowseForm" title="<fmt:message key="page.general.browse"/>">
    <ul id="w3cwidgetsList" class="storeItems">
    </ul>
</div>

<portal:register-init-script location="${'AFTER_RAVE'}">
<script>
    $(function() {
        if ($('#url').val().length === 0) {
            $('#addWidgetForm').hide();
            $('#addWidgetFormSubmit').hide();
            $('input[name=type]:first').attr('checked', true);
        }
        if ($('input[name=type]:checked').val() != 'W3C') {
            $('#w3cBrowseLink').hide();
        }
        $('input[name=type]').change(function(){
            if($('input[name=type]:checked').val()=='W3C'){
                $('#w3cBrowseLink').show();
            }
            else{
                $('#w3cBrowseLink').hide();
            }
        });

        $("#w3cBrowseForm").dialog({
            autoOpen: false,
            height: 300,
            width: 350,
            modal: true,
            buttons: {
                Cancel: function(){
                    $(this).dialog("close");
                }
            },
            close: function(){
                // clear contents
                $('#w3cwidgetsList').empty();
            }
        });

        $("#w3cBrowseLink").click(function() {
            rave.api.rpc.getWidgetMetadataGroup({
                url: "?all=true",
                providerType: "W3C",
                successCallback: function(result) {
                var i=0;
                var widgets = result.result;
                PostLoadW3cWidgets.setList(widgets);
                jQuery.each(widgets, function() {
                    $('#w3cwidgetsList')
                        .append(
                            $("<li/>")
                            .addClass("storeItem")
                            .append( // container
                                $("<div/>")
                                .css('overflow','hidden')
                                .append(
                                    $("<div/>")
                                    .css('float','left')
                                    .css('width','50%')
                                    .append(
                                        $("<div/>")
                                        .attr("id", "w3cImageHolder"+i)
                                    )
                                    .append(
                                        $("<div/>")
                                        .attr("id", "widgetAdded")
                                        .addClass("storeButton")
                                        .append(
                                            $("<button/>")
                                            .addClass("btn btn-small btn-primary")
                                            .attr("id", this.url)
                                            .attr("onclick", "updateRaveMetadata("+i+");")
                                            .text(rave.getClientMessage("get.metadata"))
                                        )
                                    )
                                )
                                .append(
                                    $("<div/>")
                                    .css('float','left')
                                    .css('width','50%')
                                    .css('margin-right','-1px')
                                    .append(
                                        $("<div/>")
                                        .addClass("secondaryPageItemTitle")
                                        .css('padding', '2px')
                                        .text(this.title)
                                    )
                                    .append(
                                        $("<div/>")
                                        .addClass("storeWidgetAuthor")
                                        .css('padding', '2px')
                                        .text(this.author)
                                    )
                                    .append(
                                        $("<div/>")
                                        .addClass("storeWidgetDesc")
                                        .css('padding', '2px')
                                        .text(this.description)
                                    )
                                )
                                .append(
                                    $("<div/>")
                                    .addClass("clear-float")
                                )
                            )
                        )
                        // add the thumbnail image if found
                        if(this.thumbnailUrl!=null){
                            $('#w3cImageHolder'+i)
                            .append(
                                $("<img/>")
                                .addClass("storeWidgetThumbnail")
                                .attr("src", this.thumbnailUrl)
                                .attr("title", this.title)
                                .attr("alt", "")
                                .attr("width", "80")
                                .attr("height", "80")
                            )
                        }
                    i++;
                    });
                    $("#w3cBrowseForm").dialog("open");
                }
            })
        });
    });

   // use this object to hold the choices of w3c widgets after the page has loaded.
    var PostLoadW3cWidgets = new function PostLoadW3cWidgets() {
        this.list = null;
        this.setList = function (list) {
            this.list = list;
        }
        this.getList = function () {
            return this.list;
        }
        this.getListItemByIndex = function(idx){
            return this.list[idx];
        }
    }

    function updateRaveMetadata(id){
        if(id != null){
            widget = PostLoadW3cWidgets.getListItemByIndex(id);
            $('#title').val(widget.title);
            $('#description').val(widget.description);
            $('#thumbnailUrl').val(widget.thumbnailUrl);
            $('#screenshotUrl').val(widget.screenshotUrl);
            $('#titleUrl').val(widget.titleUrl);
            $('#author').val(widget.author);
            $('#authorEmail').val(widget.authorEmail);
            $('#url').val(widget.url);
            $('#addWidgetForm').show();
            $('#addWidgetFormSubmit').show();
        }
        $("#w3cBrowseForm").dialog("close");
    }
</script>
</portal:register-init-script>

