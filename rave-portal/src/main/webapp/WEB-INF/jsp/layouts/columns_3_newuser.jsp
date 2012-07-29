<%@ include file="/WEB-INF/jsp/includes/taglibs.jsp" %>
<%--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~   http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<fmt:setBundle basename="messages"/>
<%--@elvariable id="page" type="org.apache.rave.portal.model.Page"--%>
<div class="columns_3_newuser_static">
    <fmt:message key="page.layout.newuser.introtext"/>
    <div>
    <p>Alternatively, you can open a gadget by entering the URL in the following text box and clicking
        <b>navigate</b>.</p>

    <p><i>NOTE: This method will only temporarily add the gadget to the accelerator and not all features may be available.  Please follow the above steps if you are having issues with rendering the gadget.</i></p>

    <div>
        <div>
            <label for="gadget_url">URL</label>
            <input class="input-xlarge" type="url" name="gadget_url" id="gadget_url"
                   placeholder="http://example.com/widget.xml" required="required"/>
        </div>
        <div>
            <label for="gadget_view">(optional) View</label>
            <input class="input-xlarge" type="text" name="gadget_url" id="gadget_view" required="false"
                   placeholder="CANVAS" />
        </div>
        <div>
            <a href="#" class="btn btn-primary"
               id="fetchMetadataButton" onclick="accelerator.navigateUrl()">Navigate</a>
        </div>

    </div>
</div>
</div>

<div class="columns_3_newuser_widgets">
    <div class="columns_3_newuser_subtitle"><fmt:message key="page.layout.newuser.subtitle"/></div>
    <div class="widgetRow upperRow">
        <rave:region region="${page.regions[0]}" regionIdx="1"/>
        <rave:region region="${page.regions[1]}" regionIdx="2"/>
    </div>
    <div class="widgetRow bottomRow">
        <rave:region region="${page.regions[2]}" regionIdx="3"/>
    </div>
</div>
<script>
    var accelerator = accelerator || {};
    accelerator.navigateUrl = function () {
        accelerator._current_url = $("#gadget_url").val();
        accelerator._current_view = $("#gadget_view").val();
        $.getJSON(rave.getContext() + "opensocial/token/create?url=" + encodeURI(accelerator._current_url),accelerator._handleTokenResponse);
    };

    accelerator.render = function (dialog) {
        var container = rave.opensocial.container();
        accelerator._current_site = container.newGadgetSite(dialog);
        var renderParams = {};
        var view = accelerator._current_view == "" ? rave.opensocial.VIEW_NAMES.HOME : accelerator._current_view;
        renderParams[osapi.container.RenderParam.VIEW] = view;
        renderParams[osapi.container.RenderParam.WIDTH] = "100%";
        container.navigateGadget(accelerator._current_site, accelerator._current_url, view, renderParams);
    } ;

    accelerator._handleTokenResponse = function(response) {
        accelerator._loadSecurityToken(response);
        accelerator._addCanvasOverlay($("#pageContent"));
        var div = $("<div />").attr("id", "temp-gadget").addClass("widget-wrapper-canvas").css("background", "white").css("top", "125px").css("padding", "10px");
        $("#pageContent").append(div);
        accelerator.render(div.get(0));
    };

    accelerator._loadSecurityToken = function (response) {
        var commonContainerTokenData = {}, preloadConfig = {}, commonContainerTokenWrapper = {};
        commonContainerTokenData[osapi.container.TokenResponse.TOKEN] = response[accelerator._current_url];
        commonContainerTokenData[osapi.container.MetadataResponse.RESPONSE_TIME_MS] = new Date().getTime();
        commonContainerTokenWrapper[accelerator._current_url] = commonContainerTokenData;
        preloadConfig[osapi.container.ContainerConfig.PRELOAD_TOKENS] = commonContainerTokenWrapper;
        rave.opensocial.container().preloadCaches(preloadConfig);
    };

    accelerator._addCanvasOverlay = function(jqElm){
        var $overlay = $('<div></div>');
        var styleMap = {
            height:$('body').height()-40
        };

        // style it and give it the marker class
        $overlay.css(styleMap);
        $overlay.addClass("canvas-overlay");
        $overlay.click(accelerator._closeGadget);
        // add it to the dom before the iframe so it covers it
        jqElm.prepend($overlay[0]);
    };
    accelerator._closeGadget = function() {
        accelerator._current_site.close();
        accelerator._current_site = null;
        accelerator._current_url = null;
        accelerator._current_view = null;
        $("#temp-gadget").remove();
        $(".canvas-overlay").remove();
    }
</script>