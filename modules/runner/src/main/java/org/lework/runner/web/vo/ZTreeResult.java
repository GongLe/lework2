package org.lework.runner.web.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * easyui Tree DTO
 *
 * @author Gongle
 * <pre>
 *       Every node can contains following properties:
*         id: node id, which is important to load remote data
*         text: node text to show
*         state: node state, 'open' or 'closed', default is 'open'. When set to 'closed', the node have children nodes and will load them from remote site
*         checked: Indicate whether the node is checked selected.
*         attributes: custom attributes can be added to a node
*         children: an array nodes defines some children nodes
 * </pre>
 */
public class ZTreeResult implements Serializable {


    public ZTreeResult() {
    }

    public ZTreeResult(String id, String text, String iconCls, String type) {
        this.id = id;
        this.text = text;
        this.iconCls = iconCls;
        this.attributes.put("type", type);
    }

    private String id;

    private String text;

    private String state;

    private Boolean checked = false;
    private String iconCls;
    private Map attributes = new HashMap();

    private List<ZTreeResult> children = new ArrayList<ZTreeResult>();

    /**
     * 添加属性
     *
     * @param name
     * @param value
     * @return 返回this 当前对象实例,可继续使用其它API, 链式操作.
     */
    public ZTreeResult addAttribute(String name, Object value) {
        getAttributes().put(name, value);
        return this;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }

    public Map getAttributes() {
        return attributes;
    }

    public void setAttributes(Map attributes) {
        this.attributes = attributes;
    }

    public List<ZTreeResult> getChildren() {
        return children;
    }

    public void setChildren(List<ZTreeResult> children) {
        this.children = children;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }


}
