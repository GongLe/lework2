package org.lework.runner.web.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;


/**
 * @author Gongle
 *  通用json对象,不完全遵守java bean规范,setter方法返回当前对象,可以链式操作,使得代码可以更加简洁.
 */
public class JsonResult implements Serializable {

    public JsonResult() {
    }

    private Boolean status;

    private HttpStatus httpStatus;

    /**
     * 操作信息*
     */
    private String msg;

    /**
     * 额外附带信息*
     */
    private Map attributes = new HashMap();

    /**
     * 操作完成，返回状态信息
     *
     * @param message
     * @return
     */
    @JsonIgnore
    public static JsonResult ok(String message) {
        JsonResult result = new JsonResult();
        result.setStatus(true);
        result.setMsg(message);
        return result;
    }

    /**
     * 获得失败的操作结果
     *
     * @param message
     * @return
     */
    @JsonIgnore
    public static JsonResult bad(String message) {
        JsonResult result = new JsonResult();
        result.setStatus(false);
        result.setMsg(message);
        return result;
    }

    /**
     * 附加属性
     *
     * @param key key
     * @param val value
     * @return 返回JsonResult可继续使用其它API, 链式操作.
     */
    @JsonIgnore
    public JsonResult addAttribute(String key, Object val) {
        attributes.put(key, val);
        return this;
    }

    public Map getAttributes() {
        return attributes;
    }

    public void setAttributes(Map attributes) {
        this.attributes = attributes;
    }

    public String getMsg() {
        return msg;
    }

    public JsonResult setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public Boolean getStatus() {
        return status;
    }

    public JsonResult setStatus(Boolean status) {
        this.status = status;
        return this;
    }

    public Integer getHttpStatusCode() {
        return this.httpStatus != null ? this.httpStatus.value() : null;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }

    public JsonResult setHttpStatus(HttpStatus httpStatus) {
        this.httpStatus = httpStatus;
        return this;
    }

}
