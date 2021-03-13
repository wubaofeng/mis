package me.wbf.mis.service;

import com.github.pagehelper.PageInfo;
import me.wbf.mis.entity.Role;
import me.wbf.mis.util.OAResult;

import java.util.Map;

public interface RoleService {
    PageInfo<Role> findRolePage(int pageNum, int pageSize);

    OAResult addRoleOrSources(Role role, String sids);

    Map<String, Object> findRoleAndSourcesById(Integer roleid);

    OAResult editRole(Role role, String sids);

    OAResult deleteRoleById(Integer roleid);

    OAResult deleteRoleByIds(String ids);
}
