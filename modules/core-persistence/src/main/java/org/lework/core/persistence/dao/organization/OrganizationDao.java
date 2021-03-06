package org.lework.core.persistence.dao.organization;

import org.lework.core.persistence.entity.organization.Organization;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Organization Dao
 * User: Gongle
 * Date: 13-10-22
 */
public interface OrganizationDao extends PagingAndSortingRepository<Organization, String>, JpaSpecificationExecutor<Organization> {

    public Organization findByCode(String code);

    @Query("from Organization o where 1=1 and o.status=?1 order by o.sortNum")
    public List<Organization> findAllByStatus(String status);

    @Query("from Organization o where 1=1 order by o.sortNum")
    public List<Organization> findAllOrgs();

    public List<Organization> findAllByType(String type);

    @Query("from Organization o where o.parentOrganization is null or o.parentOrganization=''  order by o.sortNum")
    public List<Organization> findRootOrgs();

    @Query("from Organization o where  o.parentOrganization.id=?1 order by o.sortNum")
    public List<Organization> findChildOrgsByParentId(String parentId);


    @Query("select max(o.sortNum) from Organization o where  o.parentOrganization is null or o.parentOrganization='' ")
    public Integer findRootMaxSortNum();

    @Query("select max(o.sortNum) from Organization o where  o.parentOrganization.id=?1 ")
    public Integer findChildMaxSortNum(String parentId);

    @Query("select count(o.id) from Organization o where  o.parentOrganization.id=?1 ")
    public Long findChildSize(String parentId);
}
