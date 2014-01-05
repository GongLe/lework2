package org.lework.runner.web.taglib;

import org.lework.runner.web.vo.TreeResult;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.util.ArrayList;
import java.util.List;

/**
 * 把TreeResult输出为伪树结构 ,属性仿照Struts2标签
 * User: Gongle
 * Date: 14-1-5
 */
public class SelectTreeTag extends BodyTagSupport {
    private String name ;
    private String value ;
    private String headerKey ;
    private String headerValue ;

    private List<TreeResult> list = new ArrayList<TreeResult>();
    @Override
    public int doAfterBody() throws JspException {

        return SKIP_BODY;
    }

    @Override
    public int doStartTag() throws JspException {
        return super.doStartTag();
    }

}
