package org.lework.runner.web.taglib;

import org.apache.commons.lang3.Validate;
import org.lework.runner.mapper.JsonMapper;
import org.lework.runner.utils.Reflections;
import org.lework.runner.utils.Strings;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 属性仿照Struts2标签
 * <code>
 * <s:select label="Pets"
 * name="petIds"
 * list="petDao.pets"
 * listKey="id"
 * listValue="name"
 * multiple="true"
 * size="3"
 * />
 * <p/>
 * <s:select label="Months"
 * name="months"
 * headerKey="-1" headerValue="Select Month"
 * list="{'01':'Jan', '02':'Feb', [...]}"
 * value="selectedMonth"
 * required="true"
 * />
 * </code>
 * User: Gongle
 * Date: 14-1-5
 */
public class SelectTag extends SimpleTagSupport {
    private final static String OPTION_SELECTED = " selected=\"selected\" " ;

    // html attribute
    private String attr;
    // html ID ,Name
    private String name;
    // init value
    private Object value;
  /*  private Boolean multiple;
    private Integer size ;*/
    private String headerKey = Strings.EMPTY;
    private String headerValue = Strings.EMPTY;
    private String listKey;
    private String listValue;
    private Object list; //String or List;

    @Override
    public void doTag() throws JspException, IOException {
        if (list == null) {
            getJspContext()
                    .getOut()
                    .write(String.format("<select name=\"%s\" id=\"%s\" %s >%s</select>", getName(), getName(), getAttr(),Strings.EMPTY));
            return;
        }
        StringBuilder builder = new StringBuilder(String.format("<option value=\"%s\">%s</option> ",  getHeaderValue(),getHeaderKey() ));
        //process json String .
        if (list instanceof String) {
            // as json string
            Map<String, Object> map = JsonMapper.nonEmptyMapper(true).fromJson((String) list, HashMap.class);
            Map.Entry entry;
            Iterator it = map.entrySet().iterator();
            while (it.hasNext()) {
                entry = (Map.Entry) it.next();
                builder.append("<option value=\"")
                        .append(entry.getValue()).append("\" ")
                        .append(entry.getValue().equals(this.value) ? OPTION_SELECTED : Strings.EMPTY)
                        .append(" >")
                        .append(entry.getKey())
                        .append("</option>\n");
            }
        } else if (list instanceof List) {
            //process List Object by Reflect
            Validate.notNull(getListKey());
            Validate.notNull(getListValue());
            List<Object> list = (List) getList();
            Object k;
            Object v;
            for (Object obj : list) {
                k = Reflections.getFieldValue(obj, getListKey());
                v = Reflections.getFieldValue(obj, getListValue());

                builder.append("<option value=\"")
                        .append(v).append("\" ")
                        .append(v.equals(this.value) ? OPTION_SELECTED : Strings.EMPTY)
                        .append(" >")
                        .append(k)
                        .append("</option>\n");
            }

        } else {
            throw new IllegalArgumentException();
        }
        //out print result
        getJspContext()
                .getOut()
                .write(String.format("<select name=\"%s\" id=\"%s\" %s >%s</select>", getName(), getName(), getAttr(), builder.toString()));
    }


    public String getAttr() {
        return attr;
    }

    public void setAttr(String attr) {
        this.attr = attr;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
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

    public String getListKey() {
        return listKey;
    }

    public void setListKey(String listKey) {
        this.listKey = listKey;
    }

    public String getListValue() {
        return listValue;
    }

    public void setListValue(String listValue) {
        this.listValue = listValue;
    }

    public Object getList() {
        return list;
    }

    public void setList(Object list) {
        this.list = list;
    }
}
