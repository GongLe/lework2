package org.lework.core.web.role;

import com.google.common.collect.Lists;
import org.lework.core.common.enumeration.RoleTypes;
import org.lework.core.common.enumeration.Status;
import org.lework.core.persistence.entity.role.Role;
import org.lework.core.service.auditor.OperatingAudit;
import org.lework.core.service.organization.OrganizationService;
import org.lework.core.service.role.RoleService;
import org.lework.runner.orm.support.SearchFilter;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;

/**
 * 角色Controller
 *
 * @author Gongle
 */
@Controller
@RequestMapping(value = "role")
public class RoleController extends AbstractController {

    @Autowired
    private RoleService roleService;
    @Autowired
    private OrganizationService organizationService;

    /**
     * list页面*
     */
    @OperatingAudit(value = "角色管理",function = "列表")
    @RequestMapping(method = RequestMethod.GET)
    public String list(  Model model ) {
        model.addAttribute("statusList", Status.values());
        model.addAttribute("typeList", RoleTypes.values());
        return "role/role";
    }

    /**
     * 修改页面
     *
     * @param roleGroupId 角色组ID
     */
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String update(@ModelAttribute("entity") Role role, Model model ) {
        model.addAttribute("statusList", Status.values());
        model.addAttribute("typeList", RoleTypes.values());
        model.addAttribute("checkedPermissionIds", null);
        return "role/role-update";
    }

    /**
     * 保存
     */
    @OperatingAudit(value = "角色管理",function = "保存")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult update(@Valid @ModelAttribute("entity") Role entity, BindingResult result ) {

        if (result.hasErrors()) {
            logger.warn(result.toString());
            return JsonResult.failure("数据不合法,保存失败");
        }
        JsonResult jsonResult = JsonResult.failure("角色&quot;" + entity.getName() + "&quot;保存失败");
        try {
            //保存
            roleService.saveRole(entity);
            jsonResult = JsonResult.success("角色&quot;" + entity.getName() + "&quot;保存成功");
        } catch (Exception e) {
            logger.error("角色保存异常:{}", e);
        }
        return jsonResult;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult  delete(@RequestParam(value = "deleteIds", required = true) String deleteIds) {
        JsonResult jsonResult = JsonResult.failure("删除失败"); ;
        try {
            String[] ids = Strings.split(deleteIds, ",");
            //单个删除
            if (ids.length == 1) {
                Role entity = roleService.getRole(ids[0]);
                roleService.deleteRole(entity);
                jsonResult = JsonResult.success("角色&quot;" + entity.getName() + "&quot;删除成功");
            } else if (Strings.isNotBlank(deleteIds)) {   //多个删除
                List<Role> entities = roleService.getRoleByIds(Arrays.asList(ids));
                String names = Collections3.extractToString(entities, "name", ",");
                roleService.deleteRoles(entities);
                jsonResult = JsonResult.success("角色&quot;" + names + "&quot;删除成功");
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("角色删除异常:{}", e);
        }
        return jsonResult;
    }
    /**
     * 查看
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view(@ModelAttribute("entity") Role role, Model model) {
        model.addAttribute("statusList", Status.values());
        model.addAttribute("typeList", RoleTypes.values());
        return "role/role-view";
    }


    /**
     * 验证角色代码是否可用
     *
     * @return JSON true || false
     */
    @RequestMapping(value = "/validateRoleCode", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    Boolean validateRoleCode(@RequestParam(value = "roleId", required = false) String id,
                             @RequestParam(value = "code", required = true) String code) {
        return roleService.validateRoleCode(id, code);
    }


    /**
     * datatables  json result*
     */
    @RequestMapping(value = "/getDatatablesJson", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    DataTableResult<Role> getDatatablesJson(
            @PageableDefault(page = 0, size = 10) Pageable pageable,
            @RequestParam(value = "search", required = false) String search,
            HttpServletRequest request) {

        List<SearchFilter> filters = SearchFilter.buildFromHttpRequest(request);
        Page<Role> page = roleService.searchPageRole(pageable, filters);

        return DataTableResult.build(page);
    }

    /**
     * get Role's   tree json result
     *
     * @param status 过滤出节点状态
     */
    @RequestMapping(value = "/getTree", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    List<TreeResult> getTree(@RequestParam(value = "status", required = false) String status) {
        boolean isFilterStatus = Strings.isNotBlank(status);
        List<Role> entities;
        List<TreeResult> rootNodes = Lists.newArrayList();
        TreeResult temp;
        for (RoleTypes type : RoleTypes.values()) {
            temp = new TreeResult(type.getCode(), type.getName(), null, "typeNode");
            temp.setOpen(true);
            entities = roleService.getAllRoleByType(type.getCode());
            if (Collections3.isNotEmpty(entities)) {
                for (Role r : entities) {
                    if (isFilterStatus && !Strings.equals(status, r.getStatus()))
                        continue;
                    temp.getChildren().add(new TreeResult(r.getId(), r.getName(), null, r.getType()));
                }
            }
            rootNodes.add(temp);
        }

        return rootNodes;
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
