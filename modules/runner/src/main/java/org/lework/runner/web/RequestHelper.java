package org.lework.runner.web;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStreamReader;

public class RequestHelper {

    public static String asString(final HttpServletRequest request) throws IOException {
        InputStreamReader reader = new InputStreamReader(request.getInputStream(), "UTF-8");
        StringBuilder sb = new StringBuilder();
        char[] buff = new char[1024];
        int length = 0;
        while ((length = reader.read(buff)) != -1) {
            sb.append(new String(buff, 0, length));
        }
        return sb.toString();
    }
    
    public static String getHostUIR(final HttpServletRequest request) {

        String host = request.getScheme()
                + "://"
                + request.getServerName()
                + ":"
                + request.getServerPort()
                + request.getContextPath()
                + request.getServletPath();
        return host;
    }
}
