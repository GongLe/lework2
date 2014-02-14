package org.lework.core.web.account;

import org.lework.core.persistence.entity.SubjectUtils;
import org.lework.core.persistence.entity.user.User;
import org.lework.core.service.account.AccountService;
import org.lework.runner.utils.Strings;
import org.lework.runner.web.vo.JsonResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;


/**
 * 用户信息Controller
 * 
 * @author Gongle
 * 
 */
@Controller
@RequestMapping(value = "account/profile")
public class ProfileController  {
    static Logger logger = LoggerFactory.getLogger(ProfileController.class);
	@Autowired
	private AccountService accountService;

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model,@ModelAttribute("entity") User user) {
		model.addAttribute("user",   user);
		return "account/profile";
	}


    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    JsonResult update(@Valid @ModelAttribute("entity") User entity, BindingResult result,
                      RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            logger.warn(result.toString());
            return JsonResult.failure("数据不合法,保存失败");
        }

        JsonResult jsonResult = JsonResult.failure("用户&quot;" + entity.getName() + "&quot;保存失败");
        try {
            accountService.updateUser(entity);
            jsonResult = JsonResult.success("用户&quot;" + entity.getName() + "&quot;保存成功");
        } catch (Exception e) {
            logger.error("用户保存异常:{}", e);
        }
        return jsonResult;
    }

    //检测用户email唯一性
    @RequestMapping(value = "validateEmail")
    @ResponseBody
    public String existEmail(@RequestParam("email") String email) {
        if (accountService.getUserByEmail(email) == null) {
            return "true";
        }
        return "false";
    }


    /**
     * 所有RequestMapping方法调用前的Model准备方法, 实现Struts2 Preparable二次部分绑定的效果,先根据form的id从数据库查出User对象,再把Form提交的内容绑定到该对象上。
     * 因为仅update()方法的form中有id属性，因此仅在update时实际执行.
     */
    @ModelAttribute("entity")
    public void prepareModel(Model model) {
        String id = SubjectUtils.getUser().getId() ;
        if (Strings.isNotBlank(id)) {
            model.addAttribute("entity", accountService.getUser(id));
        }
    }

    /**
     * 不自动绑定对象中的roles属性
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("roles");
    }

/*    *//**
     * 取出Shiro中的当前用户Id.
     *//*
    private String getCurrentUserId() {
        ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        return shiroUser.id;
    }*/


}
