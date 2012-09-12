package org.apache.rave.portal.web.api;

import org.apache.rave.portal.model.Page;
import org.apache.rave.portal.model.Region;
import org.apache.rave.portal.model.RegionWidget;
import org.apache.rave.portal.model.Widget;
import org.apache.rave.portal.model.impl.PageImpl;
import org.apache.rave.portal.model.impl.RegionImpl;
import org.apache.rave.portal.model.impl.RegionWidgetImpl;
import org.apache.rave.portal.model.impl.WidgetImpl;
import org.apache.rave.portal.service.UserService;
import org.apache.rave.provider.opensocial.service.OpenSocialService;
import org.apache.rave.provider.opensocial.service.SecurityTokenService;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Rave currently doesn't expose the security token generation endpoint
 */
@Controller
public class OpenSocialEndpoint {

    private Logger log = org.slf4j.LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SecurityTokenService tokenService;

    @Autowired
    private UserService userService;

    @Autowired
    private OpenSocialService openSocialService;

    @ResponseBody
    @RequestMapping(value="/opensocial/metadata", method = RequestMethod.GET)
    public Map<String, ?> getToken(@RequestParam(required = true) String url) {
        log.debug("Getting metadata & token for " + url);
        RegionWidget temporaryWidget = getTemporaryRegionWidget(url);
        Map<String, Object> returnVal = new HashMap<String, Object>();
        returnVal.put("token", tokenService.getEncryptedSecurityToken(temporaryWidget));
        returnVal.put("metadata", openSocialService.getGadgetMetadata(url));
        return returnVal;
    }

    private RegionWidget getTemporaryRegionWidget(String url) {
        RegionWidget temporaryWidget = new RegionWidgetImpl(-100L);
        Widget widget = new WidgetImpl(-100L, url);
        Region fakeRegion = new RegionImpl();
        Page fakePage = new PageImpl(-100L, userService.getAuthenticatedUser());
        temporaryWidget.setRegion(fakeRegion);
        temporaryWidget.setWidget(widget);
        fakeRegion.setPage(fakePage);
        return temporaryWidget;
    }
}
