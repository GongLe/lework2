package org.lework.core.web.account;

import com.google.common.collect.Lists;
import org.lework.core.common.enumeration.Status;
import org.lework.core.persistence.entity.organization.Organization;
import org.lework.core.persistence.entity.role.Role;
import org.lework.core.persistence.entity.user.User;
import org.lework.core.service.account.AccountService;
import org.lework.core.service.organization.OrganizationService;
import org.lework.core.service.role.RoleService;
import org.lework.runner.mapper.JsonMapper;
import org.lework.runner.orm.support.SearchFilter;
import org.lework.runner.spring.SpringMvcHolder;
import org.lework.runner.utils.Collections3;
import org.lework.runner.utils.Strings;
import org.lework.runner.web.datatables.DataTableResult;
import org.lework.runner.web.vo.JsonResult;
import org.lework.runner.web.vo.TreeResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;

/**
 * 用户Controller
 *
 * @author Gongle
 */
@Controller
@RequestMapping(value = "user")
public class UserController    {
    static Logger logger = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private AccountService accountService ;
    @Autowired
    private RoleService roleService;
    @Autowired
    private OrganizationService organizationService;

    @RequestMapping(value = "/resetPassword", method = RequestMethod.GET)
    public String resetPassword(Model model,
                                @RequestParam(value = "userIds")  String  userIds) {
        List<String> userIdList = Lists.newArrayList(Strings.split(userIds, ","));
        List<User> users = accountService.getUserByIds(userIdList);
        String userNames = Collections3.extractToString(users, "name", ",");
        model.addAttribute("users",users);
        model.addAttribute("userNames",userNames);
        return "user/user-resetPassword";
    }

    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    public void doResetPassword(Model model,
                                @RequestParam(value = "userIds") List<String> userIds,
                                @RequestParam(value = "plainPassword") String plainPassword,
                                @RequestParam(value = "plainPassword2") String plainPassword2,
                                HttpServletResponse response) {

        if (!Strings.equals(plainPassword, plainPassword2)) {
         //   callback(response, CallbackData.build("resetPasswordCallback", "两次密码输入不一致", NotificationType.ERROR));
            return;
        }

        List<User> users = accountService.getUserByIds(userIds);
        String userNames = Collections3.extractToString(users, "name", ",");
        //重置密码
        accountService.resetUserPassword(users, plainPassword);
      //  callback(response, CallbackData.build("resetPasswordCallback", "用户&quot;" + userNames + "&quot;密码重置成功", NotificationType.DEFAULT));
    }
    /**
     * 列表页面*
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list() {
        List<TreeResult> orgTree = organizationService.getOrgTree(null);
        SpringMvcHolder.addAttribute("orgTree",orgTree, RequestAttributes.SCOPE_REQUEST);
        return "user/user";
    }


    /**
     * 修改页面
     */
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String update(@ModelAttribute("entity") User user, Model model) {
        model.addAttribute("statusList", Status.values());
        List<Role> ownRoles = user.getRoles();
        List<String> ids;
        if (Collections3.isNotEmpty(ownRoles)) {
            ids = Collections3.extractToList(ownRoles, "id");
            model.addAttribute("ownRoleIdsArr", JsonMapper.nonDefaultMapper().toJson(ids));
        }
        //model.addAttribute("chosenRoleOptions",roleService.getRoleGroupOptions(ownRoles,true)  );
        //组织树.
        List<TreeResult> orgTree = organizationService.getOrgTree(null);
        model.addAttribute("orgTree", orgTree);
        return "user/user-update";
    }

    /**
     * 保存
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult update(@Valid @ModelAttribute("entity") User entity, BindingResult result,
                      @RequestParam(value = "orgId", required = false) String orgId,
                      @RequestParam(value = "roleIds", required = false) List<String> roleIds) {
        if (result.hasErrors()) {
            logger.warn(result.toString());
            return JsonResult.failure("数据不合法,保存失败");
        }
        JsonResult jsonResult = JsonResult.failure("用户&quot;" + entity.getName() + "&quot;保存失败");
        try {
            //关联角色
            if (Collections3.isEmpty(roleIds)) {
                entity.setRoles(null);
            } else {
                List<Role> ownRoles = roleService.getRolesByIds(roleIds);
                entity.setRoles(ownRoles);
            }
            //关联组织机构
            if (Strings.isBlank(orgId)) {
                entity.setOrg(null);
                entity.setOrgName(null);
            } else {
                Organization ownOrg = organizationService.getOrganization(orgId);
                entity.setOrgName(ownOrg.getName());
                entity.setOrg(ownOrg);
            }
            accountService.saveUser(entity);
            jsonResult = JsonResult.success("用户&quot;" + entity.getName() + "&quot;保存成功");
        } catch (Exception e) {
            logger.error("用户保存异常:{}", e);
        }
        return jsonResult;
    }


    /**
     * 删除
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult delete(@RequestParam(value = "deleteIds", required = true) String deleteIds) {
        JsonResult jsonResult = JsonResult.failure("删除失败"); ;
        try {
            String[] ids = Strings.split(deleteIds, ",");
            //单个删除
            if (ids.length == 1) {
                User entity = accountService.getUser(ids[0]);
                accountService.deleteUser(entity);
                jsonResult = JsonResult.success("用户&quot;" + entity.getName() + "&quot;删除成功");
            } else if (Strings.isNotBlank(deleteIds)) {   //多个删除
                List<User> entities = accountService.getUserByIds(Arrays.asList(ids));
                String names = Collections3.extractToString(entities, "name", ",");
                accountService.deleteUsers(entities);
                jsonResult = JsonResult.success("用户&quot;" + names + "&quot;删除成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("用户删除异常:{}", e);
        }
        return jsonResult;
    }

    /**
     * 查看
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view(@ModelAttribute("entity") User user ,Model model) {
        model.addAttribute("statusList" , Status.values() ) ;
        return "user/user-view";
    }

    /**
     * 批量操作处理
     * <code>
     * <option value="doDelete">删除</option>
     * <option value="doStatusDisable">禁用账号</option>
     * <option value="doStatusEnable">启用账号</option>
     * </code>
     */
    @RequestMapping(value = "/doAction", method = {RequestMethod.POST})
    public
    @ResponseBody
    JsonResult doAction(@RequestParam(value = "selectedRowIds") String selectedRowIds,
                        @RequestParam(value = "action") String action) {
        JsonResult jsonResult = null;
        String[] ids = Strings.split(selectedRowIds, ",");
        List<User> entities = accountService.getUserByIds(Arrays.asList(ids));
        String  names = Collections3.extractToString(entities, "name", ",");
        if (action.equals("doDelete")) {
            accountService.deleteUsers(entities);
            jsonResult = JsonResult.success("用户&quot;" +names + "&quot;删除成功");
        } else if (action.equals("doStatusDisable")) {
            accountService.changeStatus(entities, Status.disable);
            jsonResult = JsonResult.success("用户&quot;" +names + "&quot;置为" + Status.disable.getName());
        } else if (action.equals("doStatusEnable")) {
            accountService.changeStatus(entities, Status.enable);
            jsonResult = JsonResult.success("用户&quot;" +names + "&quot;置为" + Status.enable.getName());
        }
        return jsonResult;
    }

    /**
     * datatables  json result
     */
    @RequestMapping(value = "/getDatatablesJson", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    DataTableResult<User> getDatatablesJson(
            @PageableDefault(page = 0, size = 10)  Pageable pageable,
            HttpServletRequest request ) {

        List<SearchFilter> filters =SearchFilter.buildFromHttpRequest(request)      ;
      /*  if (Strings.isNotBlank(search)) {
            //匹配用户名 or 姓名
            filters.add(new SearchFilter("LIKES_loginName_OR_name", search));
        }*/
        Page<User> page = accountService.searchPageUser(pageable, filters);

        return DataTableResult.build(page);
    }

    /**
     * 验证用户Email是否可用
     *
     * @return JSON true || false
     */
    @RequestMapping(value = "/validateEmail", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    Boolean validateUserEmail(@RequestParam(value = "userId", required = false) String id,
                              @RequestParam(value = "email", required = true) String email) {

        return accountService.validateEmail(id, email);
    }

    /**
     * 验证用户登录名是否可用
     *
     * @return JSON true || false
     */
    @RequestMapping(value = "/validateLoginName", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    Boolean validateUserLoginName(@RequestParam(value = "userId", required = false) String id,
                                  @RequestParam(value = "loginName", required = true) String loginName) {

        return accountService.validateLoginName(id, loginName);
    }

    /**
     * Preparable二次部分绑定的效果
     */
    @ModelAttribute("entity")
    public void prepareModel(Model model, @RequestParam(value = "id", required = false) String id) {
        if (Strings.isNotBlank(id)) {
            model.addAttribute("entity", accountService.getUser(id));
        } else {
            model.addAttribute("entity", new User());
        }
    }

    /**
     * 不自动绑定对象中的roles属性
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("roles");
    }

}
