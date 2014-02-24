package org.lework.core.web.role;

import com.google.common.collect.Lists;
import org.lework.core.common.enumeration.Status;
import org.lework.core.persistence.entity.menu.Menu;
import org.lework.core.persistence.entity.role.Role;
import org.lework.core.persistence.entity.user.User;
import org.lework.core.service.account.AccountService;
import org.lework.core.service.menu.MenuService;
import org.lework.core.service.menu.MenuTreeGridDTO;
import org.lework.core.service.organization.OrganizationService;
import org.lework.core.service.role.RoleService;
import org.lework.runner.mapper.JsonMapper;
import org.lework.runner.utils.Collections3;
import org.lework.runner.utils.Strings;
import org.lework.runner.web.AbstractController;
import org.lework.runner.web.datatables.DataTableResult;
import org.lework.runner.web.vo.JsonResult;
import org.lework.runner.web.vo.TreeResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 角色权限控制 Controller
 *
 * @author Gongle
 */
@Controller
@RequestMapping(value = "roleControl")
public class RoleControlController extends AbstractController {
    public static final String DEFAULT_ROLE_ICON ="tree-user-group";
    @Autowired
    private RoleService roleService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private MenuService menuService;
    /**
     * list页面*
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list() {

        return "role/roleControl";
    }

    /**
     * 角色授权主页面 for ajax load
     */
    @RequestMapping(value = "/tabs", method = {RequestMethod.GET, RequestMethod.POST})
    public String tabs(@RequestParam(value = "roleId") String roleId, Model model) {

        model.addAttribute("role", roleService.getRole(roleId));
        return "role/roleControl-tabs";
    }

    /**
     * 角色成员ajax load页面
     */
    @RequestMapping(value = "/member", method = {RequestMethod.GET, RequestMethod.POST})
    public String member(@RequestParam(value = "roleId") String roleId, Model model) {
        model.addAttribute("role", roleService.getRole(roleId));
        return "role/roleControl-member";
    }

    /**添加成员到角色list页面**/
    @RequestMapping(value = "/addMember", method = {RequestMethod.GET })
    public String addMember(@RequestParam(value = "roleId") String roleId, Model model) {
        model.addAttribute("role", roleService.getRole(roleId));

        return "role/roleControl-addMember";
    }
    /**check user**/
    @RequestMapping(value = "/addMember-checkUser", method = {RequestMethod.GET})
    public String checkUser(@RequestParam(value = "roleId") String roleId,
                            @RequestParam(value = "orgId") String orgId,
                            Model model) {
        model.addAttribute("roleId", roleId);
        model.addAttribute("users", roleService.getRoleRelatedUser(orgId, roleId));
        return "role/roleControl-addMember-checkUser";
    }

    /**
     * 添加角色成员
     *
     * @param roleId   角色ID
     * @param userId   用户ID
     */
    @RequestMapping(value = "/createRelateUser", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult createRelateUser(@RequestParam(value = "roleId") String roleId,
                                @RequestParam(value = "userId") String userId,
                                @RequestParam(value = "userName", required = false) String userName ) {

        JsonResult jsonResult = JsonResult.failure("添加成员&quot;" + userName + " &quot;失败");
        try {
            Role role = roleService.getRole(roleId);
            roleService.createRelateUser(role, userId);
            jsonResult = JsonResult.success("添加成员&quot;" + userName + " &quot;成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("删除异常:{}", e);
        }
        return jsonResult;
    }

    /**
     * 解除角色成员
     *
     * @param roleId   角色ID
     * @param userId   用户ID
     */
    @RequestMapping(value = "/removeRelatedUser", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult removeRelatedUser(@RequestParam(value = "roleId") String roleId,
                                 @RequestParam(value = "userIds") String userIds,
                                 @RequestParam(value = "userName", required = false) String userName) {
        JsonResult jsonResult = JsonResult.failure("解除成员&quot;" + userName + " &quot;失败");
        try {
            String[] ids = Strings.split(userIds, ",");
            Role role = roleService.getRole(roleId);
            for (String id : ids) {
                roleService.removeRelatedUser(role, id);
            }
            if(Strings.isNotBlank(userName)){
                jsonResult = JsonResult.success("解除成员&quot;" + userName + " &quot;成功");
            }else{
                jsonResult = JsonResult.success("解除成员成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("删除异常:{}", e);
        }
        return jsonResult;
    }

    /**
     * 角色模块权限 ajax load页面
     */
    @RequestMapping(value = "/menu", method = {RequestMethod.GET, RequestMethod.POST})
    public String menu(@RequestParam(value = "roleId") String roleId, Model model) {
        List<String > checkedIds = Collections3.extractToList(menuService.getRoleMenus(roleId), "id");
        model.addAttribute("checkedIds", new JsonMapper().toJson(checkedIds));
        model.addAttribute("roleId",roleId );
        List<MenuTreeGridDTO>  treeGridDTOs =   menuService.getMenuTreeGrid(null) ;
        model.addAttribute("treeGridDTOs",treeGridDTOs) ;

        return "role/roleControl-menu";
    }


    /**
     * 授权角色菜单给角色.
     *
     * @param roleId         角色ID
     * @param checkedMenuIds 选中的菜单IDs
     * @param response
     */
    @RequestMapping(value = "/saveRelatedMenu", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult saveRelatedMenu(@RequestParam(value = "roleId",required = true) String roleId,
                              @RequestParam(value = "checkedMenuIds", required = false) String checkedMenuIds) {
        JsonResult jsonResult = JsonResult.failure("授权菜单失败");
        //关联菜单
        try {
            Role role = roleService.getRole(roleId);
            //关联菜单
            if (Strings.isNotBlank(checkedMenuIds)) {
                List<String> menuIds = Arrays.asList(Strings.split(checkedMenuIds, ","));
                List<Menu> menus = menuService.getMenusByIds(menuIds);
                role.getMenus().clear();
                role.getMenus().addAll(menus);
            } else {
                role.setMenus(null);
            }
            roleService.saveRole(role);
            jsonResult = JsonResult.success("授权&quot;\"" + role.getName() + "\" &quot;菜单成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("删除异常:{}", e);
        }
        return jsonResult;
    }


    /**
     * 根据角色组ID加载所属角色
     * return easyui tree json result
     */
    @RequestMapping(value = "/getRoleTreeByGroupId", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    List<TreeResult>  getRoleTreeByGroupId(@RequestParam(value = "groupId", required = true) String groupId) {


        boolean disable; //高亮状态
        List<Role> entities;
        List<TreeResult> nodeList = Lists.newArrayList();
        entities = roleService.getAllRoleByGroupId(groupId);
        if (!Collections3.isEmpty(entities)) {
            for (Role r : entities) {
                disable = Strings.equals(r.getStatus(), Status.disable.getCode());
                nodeList.add(new TreeResult(r.getId(), r.getName(),  DEFAULT_ROLE_ICON  , Strings.EMPTY));
            }
        }

        return nodeList;
    }

    /**
     * ====================================
     *    获取角色成员 Datatables JSON
     * ====================================
     */
    /**
     * 获取角色关联的用户
     *
     * @param pageable
     * @param roleId   菜单ID
     * @param search   用户名||登录名
     * @return Datatables Json Data
     */
    @RequestMapping(value = "/getRoleRelateUser", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    DataTableResult<User> getRoleRelateUser(@PageableDefault(page = 0, size = 15) Pageable pageable,
                                                @RequestParam(value = "roleId") String roleId,
                                                @RequestParam(value = "search", required = false) String search) {

        Page<User> page = accountService.searchUserPageByRoleId(pageable, roleId, search);
        return DataTableResult.build(page);
    }



    /**
     * Preparable二次部分绑定的效果
     */
    @ModelAttribute("entity")
    public void prepareModel(Model model, @RequestParam(value = "id", required = false) String id) {
        if (Strings.isNotBlank(id)) {
            model.addAttribute("entity", roleService.getRole(id));
        } else {
            model.addAttribute("entity", new Role());
        }
    }

    /**
     * 不自动绑定对象中的roles属性
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("users");
        binder.setDisallowedFields("permissions");
    }


}
