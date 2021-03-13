package me.wbf.mis.controller;

import com.github.pagehelper.PageInfo;
import me.wbf.mis.entity.Role;
import me.wbf.mis.service.RoleService;
import me.wbf.mis.util.OAResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;

    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Role> rolePageInfo(@RequestParam(defaultValue = "1") int pageNum,
                                       @RequestParam(defaultValue = "10") int pageSize) {
        PageInfo<Role> rolePageInfo = roleService.findRolePage(pageNum, pageSize);
        return rolePageInfo;
    }

    @RequestMapping("/add")
    @ResponseBody
    public OAResult addRole(Role role, String sids) {
        return roleService.addRoleOrSources(role, sids);
    }

    @RequestMapping("/toEdit")
    @ResponseBody
    public Map<String, Object> toEdit(Integer roleid) {
        return roleService.findRoleAndSourcesById(roleid);
    }

    @RequestMapping("/edit")
    @ResponseBody
    public OAResult edit(Role role, String sids) {
        return roleService.editRole(role, sids);
    }

    @RequestMapping("del")
    @ResponseBody
    public OAResult deleteRole(Integer roleid) {
        return roleService.deleteRoleById(roleid);
    }

    @RequestMapping("delList")
    @ResponseBody
    public OAResult deleteRoleList(String ids) {
        return roleService.deleteRoleByIds(ids);
    }
}
