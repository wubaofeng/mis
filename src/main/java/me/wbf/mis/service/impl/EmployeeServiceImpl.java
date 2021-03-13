package me.wbf.mis.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import me.wbf.mis.entity.*;
import me.wbf.mis.mapper.DeptMapper;
import me.wbf.mis.mapper.EmployeeMapper;
import me.wbf.mis.mapper.RoleMapper;
import me.wbf.mis.service.EmployeeService;
import me.wbf.mis.util.OAResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private DeptMapper deptMapper;
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public PageInfo<Employee> findEmpByPageAndSearch(Integer pageNum, Integer pageSize, Integer typeid, String search) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        if (typeid == 2) {
            criteria.andEnameLike("%" + search + "%");
        } else if (typeid == 1) {
            List<Integer> deptIds = findDeptByDname(search);
            criteria.andDfkIn(deptIds);
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Employee> employeeList = employeeMapper.selectByExample(employeeExample);
        return new PageInfo<>(employeeList);
    }

    @Override
    public Map<String, Object> findDeptAndRoles() {
        Map<String, Object> map = new HashMap<>();
        List<Dept> deptList = deptMapper.selectByExample(null);
        map.put("depts", deptList);
        RoleExample roleExample = new RoleExample();
        RoleExample.Criteria criteria = roleExample.createCriteria();
        criteria.andStatusEqualTo(1);
        List<Role> roleList = roleMapper.selectByExample(roleExample);
        map.put("roles", roleList);
        return map;
    }

    @Override
    public OAResult addEmp(Employee employee, Integer[] roleids) {
        try {
            employee.setPassword(DigestUtils.md5DigestAsHex(employee.getPassword().getBytes()));
            employeeMapper.insertSelective(employee);
            HashMap<String, Object> map = new HashMap<>();
            map.put("eid", employee.getEid());
            map.put("roleids", roleids);
            employeeMapper.insertRoleAndEmp(map);
            return OAResult.build(200, "用户：" + employee.getEname() + "添加成功");
        } catch (Exception e) {
            return OAResult.build(400, "用户：" + employee.getEname() + "添加失败");
        }
    }

    @Override
    public Employee findEmpByEid(Integer eid) {
        return employeeMapper.selectByPrimaryKey(eid);
    }

    @Override
    public OAResult editEmpByEid(Employee emp, Integer[] roleids) {
        try {
            employeeMapper.deleteRoleByEid(emp.getEid());
            if (!emp.getPassword().equals("********")) {
                emp.setPassword(DigestUtils.md5DigestAsHex(emp.getPassword().getBytes()));
            } else {
                emp.setPassword(null);
            }
            employeeMapper.updateByPrimaryKeySelective(emp);
            Map<String, Object> map = new HashMap<>();
            map.put("eid", emp.getEid());
            map.put("roleids", roleids);
            employeeMapper.insertRoleAndEmp(map);
            return OAResult.build(200, "用户：" + emp.getEname() + "修改成功");
        } catch (Exception e) {
            return OAResult.build(400, "用户：" + emp.getEname() + "修改失败");
        }
    }

    @Override
    public List<Role> findRoleByEId(Integer eid) {
        return roleMapper.selectRoleByEid(eid);
    }

    @Override
    public boolean findUserAndPassword(Employee employee, Model model, HttpSession session) {
        try {
            EmployeeExample employeeExample = new EmployeeExample();
            EmployeeExample.Criteria criteria = employeeExample.createCriteria();
            criteria.andUsernameEqualTo(employee.getUsername());
            List<Employee> employees = employeeMapper.selectByExample(employeeExample);
            if (!employees.isEmpty()) {
                Employee employee1 = employees.get(0);
                if (employee1.getPassword().equals(DigestUtils.md5DigestAsHex(employee.getPassword().getBytes()))) {
                    session.setAttribute("login", employee1);
                    return true;
                } else {
                    model.addAttribute("message", "密码错误，请重试！");
                }
            } else {
                model.addAttribute("message", "没有这个用户名，请联系人力部门");
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "系统出现异常，请联系管理员");
            return false;
        }
    }

    public List<Integer> findDeptByDname(String dname) {
        DeptExample deptExample = new DeptExample();
        DeptExample.Criteria criteria = deptExample.createCriteria();
        criteria.andDnameLike("%" + dname + "%");
        List<Dept> deptList = deptMapper.selectByExample(deptExample);
        List<Integer> ids = new ArrayList<>();
        for (Dept dept : deptList) {
            ids.add(dept.getDeptno());
        }
        return ids;
    }
}
