package org.lework.runner.web.taglib;

import org.lework.runner.utils.Collections3;
import org.lework.runner.utils.Strings;
import org.lework.runner.web.vo.TreeResult;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 把TreeResult输出为伪树结构 ,属性仿照Struts2标签
 * User: Gongle
 * Date: 14-1-5
 */
public class SelectTreeTag extends SimpleTagSupport {
    private final static String OPTION_SELECTED = " selected=\"selected\" ";

    // html ID ,Name
    private String name;
    private Boolean multiple = false;
    private Integer size;
    // html attribute
    private String attr;
    //init String ,List
    private String value;
    private Object treeReuslt;
    private String headerKey = Strings.EMPTY;
    private String headerValue = Strings.EMPTY;
    //子节点缩进符号
    private String indentStr = "&nbsp;&nbsp;&nbsp;&nbsp;";
    private List<String> _values = new ArrayList<String>();

    @Override
    public void doTag() throws JspException, IOException {

        // except null
        if (treeReuslt == null) {
            getJspContext()
                    .getOut()
                    .write(String.format("<select name=\"%s\" id=\"%s\" %s >%s</select>", getName(), getName(), getAttr(), Strings.EMPTY));
            return;
        }
        if (multiple && Strings.isNotEmpty(value)) {
            _values = Arrays.asList(Strings.split(getValue(), ","));
        } else if (Strings.isNotEmpty(value)) {
            _values = Arrays.asList(value);
        }
        StringBuilder builder = new StringBuilder(String.format("<option value=\"%s\">%s</option> ", getHeaderValue(), getHeaderKey()));
        List<TreeResult> treeList = (List<TreeResult>) treeReuslt;
        TreeResult node;
        for (int i = 0; i < treeList.size(); i++) {
            node = treeList.get(i);
            builder.append("<option value=\"")
                    .append(node.getId()).append("\" ")
                    .append(_values.contains(node.getId()) ? OPTION_SELECTED : Strings.EMPTY)
                    .append(" >")
                    .append(node.getText())
                    .append("</option>\n");
            //has child
            if (Collections3.isNotEmpty(node.getChildren())) {
                //output child node
                outputChild(node, builder, this.indentStr, i);
            }
        }

        //out print result
        getJspContext()
                .getOut()
                .write(String.format("<select name=\"%s\" id=\"%s\" %s >%s</select>", getName(), getName(), getAttr(), builder.toString()));
    }

    private void outputChild(TreeResult parentNode, StringBuilder builder, String rangeStr, int level) {
        List<TreeResult> childNodes = parentNode.getChildren();
        TreeResult node;
        for (int i = 0; i < childNodes.size(); i++) {
            node = childNodes.get(i);
            builder.append("<option value=\"")
                    .append(node.getId()).append("\" ")
                    .append(_values.contains(node.getId()) ? OPTION_SELECTED : Strings.EMPTY)
                    .append(" >")
                    .append(rangeStr + node.getText())
                    .append("</option>\n");
            //has child
            if (Collections3.isNotEmpty(node.getChildren())) {
                //output child node
                outputChild(node, builder, rangeStr += rangeStr, level + 1);
            }
        }
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getMultiple() {
        return multiple;
    }

    public void setMultiple(Boolean multiple) {
        this.multiple = multiple;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public String getAttr() {
        return attr;
    }

    public void setAttr(String attr) {
        this.attr = attr;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Object getTreeReuslt() {
        return treeReuslt;
    }

    public void setTreeReuslt(Object treeReuslt) {
        this.treeReuslt = treeReuslt;
    }

    public String getHeaderKey() {
        return headerKey;
    }

    public void setHeaderKey(String headerKey) {
        this.headerKey = headerKey;
    }

    public String getHeaderValue() {
        return headerValue;
    }

    public void setHeaderValue(String headerValue) {
        this.headerValue = headerValue;
    }

    public String getIndentStr() {
        return indentStr;
    }

    public void setIndentStr(String indentStr) {
        this.indentStr = indentStr;
    }
}
