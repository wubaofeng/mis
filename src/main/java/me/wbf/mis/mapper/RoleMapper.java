package me.wbf.mis.mapper;

import java.util.List;
import me.wbf.mis.entity.Role;
import me.wbf.mis.entity.RoleExample;
import org.apache.ibatis.annotations.Param;

public interface RoleMapper {
    long countByExample(RoleExample example);

    int deleteByExample(RoleExample example);

    int deleteByPrimaryKey(Integer roleid);

    int insert(Role record);

    int insertSelective(Role record);

    List<Role> selectByExample(RoleExample example);

    Role selectByPrimaryKey(Integer roleid);

    int updateByExampleSelective(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByExample(@Param("record") Role record, @Param("example") RoleExample example);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

    int insertSourcesRole(@Param("rid") Integer roleId, @Param("sids") Integer[] ids);

    int deleteSourcesByRid(Integer roleid);

    int deleteSourcesList(String ids);

    int deleteEmps(String ids);

    int deleteRoleList(String ids);

    List<Role> selectRoleByEid(Integer eid);
}