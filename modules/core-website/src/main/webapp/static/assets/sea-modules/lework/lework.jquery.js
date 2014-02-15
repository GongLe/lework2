/**
 * ajax GET方式load html
 * @param url
 * @param params
 * @param callback
 * @returns {*}
 */
// CMD模块化 jquery plugin
if (typeof define === "function" && define) {
    define(function (require) {
        var jQuery = require('jquery');

        jQuery.fn.load2 = function (url, params, callback) {

            var selector, response, type,
                self = this,
                off = url.indexOf(" ");

            if (off >= 0) {
                selector = url.slice(off, url.length);
                url = url.slice(0, off);
            }

            // If it's a function
            if (jQuery.isFunction(params)) {

                // We assume that it's the callback
                callback = params;
                params = undefined;

                // Otherwise, build a param string
            } else if (params && typeof params === "object") {
                type = "GET";
            }

            // If we have elements to modify, make the request
            if (self.length > 0) {
                jQuery.ajax({
                    url: url,

                    // if "type" variable is undefined, then "GET" method will be used
                    type: type,
                    dataType: "html",
                    data: params
                }).done(function (responseText) {

                        // Save response for use in complete callback
                        response = arguments;

                        self.html(selector ?

                            // If a selector was specified, locate the right elements in a dummy div
                            // Exclude scripts to avoid IE 'Permission Denied' errors
                            jQuery("<div>").append(jQuery.parseHTML(responseText)).find(selector) :

                            // Otherwise use the full result
                            responseText);

                    }).complete(callback && function (jqXHR, status) {
                        self.each(callback, response || [ jqXHR.responseText, status, jqXHR ]);
                    });
            }

            return this;
        };
        return jQuery;
    });
}