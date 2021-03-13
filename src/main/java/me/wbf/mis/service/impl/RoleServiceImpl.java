package me.wbf.mis.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import me.wbf.mis.entity.Role;
import me.wbf.mis.entity.Sources;
import me.wbf.mis.mapper.RoleMapper;
import me.wbf.mis.mapper.SourcesMapper;
import me.wbf.mis.service.RoleService;
import me.wbf.mis.util.OAResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private SourcesMapper sourcesMapper;

    @Override
    public PageInfo<Role> findRolePage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Role> roleList = roleMapper.selectByExample(null);
        return new PageInfo<>(roleList);
    }

    @Override
    public OAResult addRoleOrSources(Role role, String sids) {
        try {
            int i = roleMapper.insertSelective(role);
            if (i == 1) {
                String[] split = sids.split(",");
                Integer[] ids = new Integer[split.length];
                for (int j = 0; j < split.length; j++) {
                    ids[j] = Integer.parseInt(split[j]);
                }
                i = roleMapper.insertSourcesRole(role.getRoleid(), ids);
                return OAResult.build(200, role.getRolename() + "角色添加成功!对应权限的条数为" + ids.length);
            }
            return OAResult.build(400, "角色添加失败");
        } catch (Exception e) {
            return OAResult.build(400, "角色添加失败,原因：" + e.getMessage());
        }
    }

    @Override
    public Map<String, Object> findRoleAndSourcesById(Integer roleid) {
        Map<String, Object> map = new HashMap<>();
        Role role = roleMapper.selectByPrimaryKey(roleid);
        map.put("role", role);
        List<Sources> sourcesList = sourcesMapper.selectSourcesByRoleId(roleid);
        map.put("sources", sourcesList);
        return map;
    }

    @Override
    public OAResult editRole(Role role, String sids) {
        try {
            int i = roleMapper.updateByPrimaryKeySelective(role);
            if (i == 1) {
                String[] split = sids.split(",");
                Integer[] ids = new Integer[split.length];
                for (int j = 0; j < split.length; j++) {
                    ids[j] = Integer.parseInt(split[j]);
                }
                roleMapper.deleteSourcesByRid(role.getRoleid());
                i = roleMapper.insertSourcesRole(role.getRoleid(), ids);
                return OAResult.build(200, role.getRolename() + "角色修改成功!对应权限的条数为" + ids.length);
            }
            return OAResult.build(400, "角色修改失败");
        } catch (Exception e) {
            return OAResult.build(400, "角色修改失败,原因：" + e.getMessage());
        }
    }

    @Override
    public OAResult deleteRoleById(Integer roleid) {
        try {
            roleMapper.deleteSourcesByRid(roleid);
            roleMapper.deleteEmps("" + roleid);
            int i = roleMapper.deleteByPrimaryKey(roleid);
            return OAResult.build(200, i + "角色删除成功");
        } catch (Exception e) {
            return OAResult.build(400, "角色删除失败,原因：" + e.getMessage());
        }
    }

    @Override
    public OAResult deleteRoleByIds(String ids) {
        try {
            roleMapper.deleteSourcesList(ids);
            roleMapper.deleteEmps(ids);
            int i = roleMapper.deleteRoleList(ids);
            return OAResult.build(200, i + "个角色删除成功");
        } catch (Exception e) {
            return OAResult.build(400, "角色删除失败,原因：" + e.getCause());
        }
    }
}
