package org.lework.core.web.organization;

import com.google.common.collect.Lists;
import org.lework.core.common.enumeration.OrgTypes;
import org.lework.core.common.enumeration.Status;
import org.lework.core.persistence.entity.organization.Organization;
import org.lework.core.service.organization.OrgTreeGridDTO;
import org.lework.core.service.organization.OrganizationService;
import org.lework.runner.orm.support.SearchFilter;
import org.lework.runner.utils.Collections3;
import org.lework.runner.utils.Strings;
import org.lework.runner.web.AbstractController;
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

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;

/**
 * Organization Controller
 * User: Gongle
 * Date: 13-10-22
 */
@Controller
@RequestMapping(value = "/organization")
public class OrganizationController extends AbstractController {
    static Logger logger = LoggerFactory.getLogger(OrganizationController.class);
    @Autowired
    private OrganizationService organizationService;

    @RequestMapping(method = RequestMethod.GET)
    public String list() {

        return "organization/organization";
    }

    @RequestMapping(value = "/treetable", method = RequestMethod.GET)
    public String treetable(Model model) {
        List<Organization> entities = organizationService.getAllOrganizations();
        model.addAttribute("entities",entities);
        return "organization/organization-treetable";
    }
    /**
     * 修改页面
     */
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String update(@ModelAttribute("entity") Organization entity ,Model model){
        model.addAttribute("statusList" , Status.values() ) ;
        model.addAttribute("typeList" , OrgTypes.values() ) ;
        //上级组织
        List<Organization> ingoreNodes = Lists.newArrayList();
        if(entity.hasChild()){
            ingoreNodes.addAll(entity.getChildrenOrganizations()) ;
        }
        List<TreeResult> orgTree = organizationService.getOrgTree(ingoreNodes);
        model.addAttribute("orgTree", orgTree);
        return  "organization/organization-update" ;
    }

    /**
     * 保存
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult update(@Valid @ModelAttribute("entity") Organization entity, BindingResult result,
                      @RequestParam(value = "parentId", required = false) String parentId,
                      HttpServletResponse response) {

        if (result.hasErrors()) {
            logger.warn(result.toString());
            return JsonResult.failure("数据不合法,保存失败");
        }
        JsonResult jsonResult = JsonResult.failure("组织机构&quot;" + entity.getName() + "&quot;保存失败");
        //关联父类
        Organization parent = organizationService.getOrganization(parentId);
        if (parent != null) {
            entity.setParentOrganization(parent);
        } else { //取消关联
            entity.setParentOrganization(null);
        }

        try {
            organizationService.saveOrganization(entity);
            jsonResult = JsonResult.success("组织机构&quot;" + entity.getName() + "&quot;保存成功");
        } catch (Exception e) {
            logger.error("组织机构保存异常:{}", e);
        }
        return jsonResult;
    }

    /**
     * 查看
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view(@ModelAttribute("entity") Organization entity ,Model model) {
        model.addAttribute("statusList" , Status.values() ) ;
        model.addAttribute("typeList" , OrgTypes.values() ) ;
        return "organization/organization-view";
    }
    /**
     * 删除
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult delete(@RequestParam(value = "deleteId" ,required = false) String deleteId,
                       @RequestParam(value = "deleteIds" ,required = false) String deleteIds,
                       HttpServletResponse response) {
        JsonResult jsonResult = null ;
        try {
            //单个删除
            if (Strings.isNotBlank(deleteId)) {
                Organization entity = organizationService.getOrganization(deleteId);
                organizationService.deleteOrganization(entity);
                jsonResult = JsonResult.success("组织机构&quot;" + entity.getName() + "&quot;删除成功");
            } else if (Strings.isNotBlank(deleteIds)) {   //多个删除
                String[] ids = Strings.split(deleteIds, ",");

                List<Organization> entities = organizationService.getOrganizationsByIds(Arrays.asList(ids));
                List<String> names = Collections3.extractToList(entities, "name");
                organizationService.deleteOrganization(entities);
                jsonResult = JsonResult.success("组织机构&quot;" + Strings.join(names, ",")  + "&quot;删除成功");
            }

        } catch (Exception e) {
            logger.error("组织机构保存异常:{}", e);
            jsonResult = JsonResult.success("删除失败");
        }
      return jsonResult;
    }


    /**
     * east Organization related  info
     */
    @RequestMapping(value = "/eastOrgRelated", method = {RequestMethod.GET, RequestMethod.POST})
    public String eastOrgRelated(@RequestParam(value = "orgId") String orgId, Model model) {
        Organization entity = organizationService.getOrganization(orgId) ;
        String status = entity.getStatus();
        if (Strings.isNotBlank(status)) {
            model.addAttribute("statusName", Status.valueOf(status).getName());
        }
        model.addAttribute("entity",entity)  ;
        return "organization/organization-east";
    }

    /**
     * 验证org代码是否可用
     *
     * @return JSON true || false
     */
    @RequestMapping(value = "/validateOrgCode", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    Boolean validateOrgCode(@RequestParam(value = "orgId", required = false) String id,
                             @RequestParam(value = "code", required = true) String code) {
        return organizationService.validateOrgCode(id, code);
    }


    /**
     * ajax上移序号
     */
    @RequestMapping(value = "/upSortNum", method = RequestMethod.POST)
    public
    @ResponseBody
    JsonResult upSortNum(@Valid @ModelAttribute("entity") Organization entity) {
        organizationService.upSortNum(entity);
        return JsonResult.success( "组织机构&quot;" + entity.getName() + "&quot;序号上移成功");
    }

    /**
     * ajax下移序号
     */
    @RequestMapping(value = "/downSortNum", method = RequestMethod.POST)
    @ResponseBody
    JsonResult downSortNum(@Valid @ModelAttribute("entity") Organization entity) {
        organizationService.downSortNum(entity);
        return JsonResult.success( "组织机构&quot;" + entity.getName() + "&quot;序号下移成功");
    }


    /**
     * ajax : datatables  json result*
     */
    @RequestMapping(value = "/getDatatablesJson", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    DataTableResult<Organization> getDatatablesJson(
            @PageableDefault(page = 0, size = 10)  Pageable pageable,
            @RequestParam(value = "sSearch", required = false) String sSearch) {

        List<SearchFilter> filters = Lists.newArrayList();
        if (Strings.isNotBlank(sSearch)) {
            filters.add(new SearchFilter("LIKES_name_OR_code", sSearch));
        }

        Page<Organization> page = organizationService.searchPageOrganization(pageable, filters);

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
    List<OrgTreeGridDTO> getTreeGrid(@RequestParam(value = "ignoreNodeId", required = false) String ignoreNodeId) {
        List<Organization> ignoreNodes = organizationService.getSelfAndChildOrgs(ignoreNodeId);
        return organizationService.getOrgTreeGrid(ignoreNodes);
    }
    /**
     * get  easyui tree json
     *
     * @param ignoreNodeId 隐藏节点,和子节点
     * @param ignoreType 隐藏的类型
     *
     */
    @RequestMapping(value = "/getTree", method = {RequestMethod.GET, RequestMethod.POST})
    public
    @ResponseBody
    List<TreeResult>  getTree(@RequestParam(value = "ignoreNodeId", required = false) String ignoreNodeId,
                              @RequestParam(value = "ignoreType", required = false) String ignoreType ) {
        List<Organization> ignoreNodes = organizationService.getSelfAndChildOrgs(ignoreNodeId);
        if (Strings.isNotBlank(ignoreType)) {
            List<Organization> typeNodes = organizationService.getAllOrgByType(OrgTypes.valueOf(ignoreType));
            ignoreNodes.addAll(typeNodes);
        }
        return  organizationService.getOrgTree(ignoreNodes) ;
    }

    /**
     * Preparable二次部分绑定的效果
     */
    @ModelAttribute
    public void prepareModel(Model model, @RequestParam(value = "id", required = false) String id) {
        if (Strings.isNotBlank(id)) {
            model.addAttribute("entity", organizationService.getOrganization(id));
        } else {
            model.addAttribute("entity", new Organization());
        }
    }

    /**
     * 不自动绑定对象中的属性
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("childrenOrganizations");
        binder.setDisallowedFields("parentOrganization");
    }
}
