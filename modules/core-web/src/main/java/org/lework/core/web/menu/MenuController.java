package org.lework.core.web.menu;

import com.google.common.collect.Lists;
import org.lework.core.common.enumeration.Status;
import org.lework.core.persistence.entity.menu.Menu;
import org.lework.core.persistence.entity.role.Role;
import org.lework.core.service.menu.MenuService;
import org.lework.core.service.menu.MenuTreeGridDTO;
import org.lework.core.service.role.RoleService;
import org.lework.runner.orm.support.SearchFilter;
import org.lework.runner.utils.Collections3;
import org.lework.runner.utils.Strings;
import org.lework.runner.web.AbstractController;
import org.lework.runner.web.CallbackData;
import org.lework.runner.web.NotificationType;
import org.lework.runner.web.datatables.DataTableResult;
import org.lework.runner.web.vo.JsonResult;
import org.lework.runner.web.vo.TreeResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Menu Controller
 * User: Gongle
 * Date: 13-10-22
 */
@Controller
@RequestMapping(value = "menu")
public class MenuController extends AbstractController {

    @Autowired
    private MenuService menuService;
    @Autowired
    private RoleService roleService;

    /**
     * list页面*
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list() {
        return "menu/menu";
    }

    @RequestMapping(value = "/treetable", method = RequestMethod.GET)
    public String treetable(Model model) throws IOException {

        List<MenuTreeGridDTO>  treeGridDTOs =   menuService.getMenuTreeGrid(null) ;
        model.addAttribute("treeGridDTOs",treeGridDTOs) ;
        return "menu/menu-treetable";
    }

    /**
     * 修改页面
     */
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String update(@ModelAttribute("entity") Menu entity, Model model) {
        model.addAttribute("statusList", Status.values());
        //上级组织
        List<Menu> ingoreNodes = Lists.newArrayList();
        //防止环路,自身不能作为父ID
        ingoreNodes.add(entity);
        List<TreeResult> menuTree = menuService.getMenuTree(ingoreNodes);
        model.addAttribute("menuTree", menuTree);
        return "menu/menu-update";
    }

    /**
     * 保存
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    JsonResult update(@Valid @ModelAttribute("entity") Menu entity, BindingResult result,
                      @RequestParam(value = "parentId", required = false) String parentId ) {
        if (result.hasErrors()) {
            logger.warn(result.toString());
            return JsonResult.failure("数据不合法,保存失败");
        }
        JsonResult jsonResult = JsonResult.failure("菜单&quot;" + entity.getName() + "&quot;保存失败");
        //关联父类
        Menu parent = menuService.getMenu(parentId);
        if (parent != null) {
            entity.setParentMenu(parent);
        } else { //取消关联
            entity.setParentMenu(null);
        }
        try {
            menuService.saveMenu(entity);
            jsonResult = JsonResult.success("菜单&quot;" + entity.getName() + "&quot;保存成功");
        } catch (Exception e) {
            logger.error("菜单保存异常:{}", e);
        }
        return jsonResult;

    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult delete(@RequestParam(value = "deleteId", required = false) String deleteId,
                      @RequestParam(value = "deleteIds", required = false) String deleteIds) {
        JsonResult jsonResult = null;
        try {
            //单个删除
            if (Strings.isNotBlank(deleteId)) {
                Menu entity = menuService.getMenu(deleteId);
                menuService.deleteMenu(entity);
                jsonResult = JsonResult.success("菜单&quot;" + entity.getName() + "&quot;删除成功");
            } else if (Strings.isNotBlank(deleteIds)) {   //多个删除
                String[] ids = Strings.split(deleteIds, ",");
                List<Menu> entities = menuService.getMenusByIds(Arrays.asList(ids));
                List<String> names = Collections3.extractToList(entities, "name");
                menuService.deleteMenus(entities);
                jsonResult = JsonResult.success("菜单&quot;" + Strings.join(names, ",") + "&quot;删除成功");
            }

        } catch (Exception e) {
            logger.error("菜单保存异常:{}", e);
            jsonResult = JsonResult.success("删除失败");
        }
        return jsonResult;
    }
    /**
     * 查看
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view(@ModelAttribute("entity") Menu entity  ,Model model) {
        model.addAttribute("statusList" , Status.values() ) ;
        return "menu/menu-view";
    }

    /**
     * east Menu related  info
     */
    @RequestMapping(value = "/eastMenuRelated", method = {RequestMethod.GET, RequestMethod.POST})
    public String eastMenuRelated(@RequestParam(value = "menuId") String menuId, Model model) {
        Menu entity = menuService.getMenu(menuId) ;
        String status = entity.getStatus();
        if (Strings.isNotBlank(status)) {
            model.addAttribute("statusName", Status.valueOf(status).getName());
        }
        model.addAttribute("menu",entity)  ;
        return "menu/menu-east";
    }

    /**
     * 解除菜单与角色关联关系
     *
     * @param menuId
     * @param roleId
     * @param response
     */
    @RequestMapping(value = "/removeRelatedRole", method = RequestMethod.POST)
    public void removeRelatedRole(@RequestParam(value = "menuId") String menuId,
                              @RequestParam(value = "roleId") String roleId,
                              @RequestParam(value = "roleName", required = false) String roleName,
                              HttpServletResponse response) {
        Menu entity = menuService.getMenu(menuId);
        menuService.removeRelatedRole(entity, roleId);
        callback(response, CallbackData.build("removeRelatedCallback", "解除关联&quot;" + roleName + " &quot;关联成功",
                NotificationType.DEFAULT));
    }
    /**
     * 创建菜单与角色关联关系
     *
     * @param menuId
     * @param roleId
     * @param response
     */
    @RequestMapping(value = "/createRelateRole", method = RequestMethod.POST)
    public void createRelateRole(@RequestParam(value = "menuId") String menuId,
                              @RequestParam(value = "roleId") String roleId,
                              @RequestParam(value = "roleName", required = false) String roleName,
                              HttpServletResponse response) {
        Menu entity = menuService.getMenu(menuId);
        menuService.createRelateRole(entity, roleId);
        callback(response, CallbackData.build("createRelateCallback", "创建关联&quot;" + roleName + " &quot;关联成功",
                NotificationType.DEFAULT));
    }
    /**
     * 添加菜单到角色
     */
    @RequestMapping(value = "/addMenuToRole", method = RequestMethod.GET)
    public String addMenuToRole(@RequestParam(value = "menuId") String menuId, Model model) {
        Menu entity = menuService.getMenu(menuId) ;
        model.addAttribute("menu",entity)  ;
        return "menu/menu-addToRole";
    }
    /**
     * 菜单关联角色 ajax load 页面
     */
    @RequestMapping(value = "/relatedRole", method = RequestMethod.GET)
    public String checkRole(@RequestParam(value = "menuId") String menuId,
                               @RequestParam(value = "roleGroupId",required = false) String roleGroupId,Model model) {
        //菜单关联的角色
        //当前角色组的角色
        //转换成VO
        model.addAttribute("roles",menuService.getMenuRelatedRole(roleGroupId, menuId)) ;
        model.addAttribute("menuId",menuId) ;
        return "menu/menu-addToRole-relatedRole";
    }

    /**
     * 获取菜单关联的角色
     *
     * @param pageable
     * @param menuId   菜单ID
     * @return Datatables Json Data
     */
    @RequestMapping(value = "/getMenuRelatedRoleJson", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    DataTableResult<Role> getMenuRelatedRoleJson(@PageableDefault(page = 0, size = 10) Pageable pageable,
                                                 @RequestParam(value = "menuId") String menuId,
                                                 @RequestParam(value = "search", required = false) String search) {

        Page<Role> page = roleService.searchRolePageByMenu(pageable, menuId, search);
        return DataTableResult.build(page);
    }


    /**
     * ajax上移序号
     */
    @RequestMapping(value = "/upSortNum", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult upSortNum(@Valid @ModelAttribute("entity") Menu entity) {
        menuService.upSortNum(entity);
        return JsonResult.success("菜单&quot;" + entity.getName() + "&quot;序号上移成功");
    }

    /**
     * ajax下移序号
     */
    @RequestMapping(value = "/downSortNum", method = RequestMethod.POST)
    @ResponseBody
    JsonResult downSortNum(@Valid @ModelAttribute("entity") Menu entity) {
        menuService.downSortNum(entity);
        return JsonResult.success( "菜单&quot;" + entity.getName() + "&quot;序号下移成功");
    }

    /**
     * ajax验证角色代码是否可用
     *
     * @return JSON true || false
     */
    @RequestMapping(value = "/validateMenuCode", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    Boolean validateMenuCode(@RequestParam(value = "menuId", required = false) String id,
                             @RequestParam(value = "code", required = true) String code) {
        return menuService.validateMenuCode(id, code);
    }


    /**
     * ajax : datatables  json result*
     */
    @RequestMapping(value = "/getDatatablesJson", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    DataTableResult<Menu> getDatatablesJson(
            @PageableDefault(page = 0, size = 10)  Pageable pageable,
            @RequestParam(value = "sSearch", required = false) String sSearch) {

        List<SearchFilter> filters = Lists.newArrayList();
        if (Strings.isNotBlank(sSearch)) {
            filters.add(new SearchFilter("LIKES_name_OR_code", sSearch));
        }

        Page<Menu> page = menuService.searchPageMenu(pageable, filters);

        return DataTableResult.build(page);
    }

    /**
     * get  easyui treeGrid json
     *
     * @param ignoreNodeId 隐藏节点,和子节点
     */
    @RequestMapping(value = "/getTreeGrid", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    List<MenuTreeGridDTO> getTreeGrid(@RequestParam(value = "ignoreNodeId", required = false) String ignoreNodeId) {
        List<Menu> ignoreNodes = menuService.getSelfAndChildMenus(ignoreNodeId);
        return menuService.getMenuTreeGrid(ignoreNodes);
    }

    /**
     * get  easyui tree json
     *
     * @param ignoreNodeId 隐藏节点,和子节点
     */
    @RequestMapping(value = "/getTree", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
     List<TreeResult>  getTree(@RequestParam(value = "ignoreNodeId", required = false) String ignoreNodeId) {
        List<Menu> ignoreNodes = menuService.getSelfAndChildMenus(ignoreNodeId);
       /* TreeResult root = new TreeResult("root","上级菜单",Strings.EMPTY,"root") ;
        root.getChildren().addAll( menuService.getMenuTree(ignoreNodes))  ;*/
        return  menuService.getMenuTree(ignoreNodes) ;
    }

    /**
     * fontawesome icon 3.2
     * http://fontawesome.io/3.2.1/icons/
     */
    @RequestMapping(value = "/fontawesome", method = RequestMethod.GET)
    public String fontawesome() {
        return "menu/fontawesome";
    }

    /**
     * Preparable二次部分绑定的效果
     */
    @ModelAttribute("entity")
    public void prepareModel(Model model, @RequestParam(value = "id", required = false) String id) {
        if (Strings.isNotBlank(id)) {
            model.addAttribute("entity", menuService.getMenu(id));
        } else {
            model.addAttribute("entity", new Menu());
        }
    }

    /**
     * 不自动绑定对象中的属性
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("childrenMenus");
        binder.setDisallowedFields("roles");
        binder.setDisallowedFields("parentMenu");
    }

}
