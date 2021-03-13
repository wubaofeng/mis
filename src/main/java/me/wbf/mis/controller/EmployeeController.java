package me.wbf.mis.controller;

import com.github.pagehelper.PageInfo;
import me.wbf.mis.entity.Employee;
import me.wbf.mis.entity.Role;
import me.wbf.mis.service.EmployeeService;
import me.wbf.mis.util.OAResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/emp")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/login")
    public String login(Employee employee, Model model, HttpSession session) {
        boolean flag = employeeService.findUserAndPassword(employee, model, session);
        if (flag) {
            return "main/index";
        } else{
            return "forward:/login.jsp";
        }
    }

    @RequestMapping("/forward/{path}")
    public String forward(@PathVariable("path") String path) {
        return "main/" + path;
    }

    @RequestMapping("/page")
    @ResponseBody
    public PageInfo<Employee> employeePageInfo(@RequestParam(defaultValue = "1") Integer pageNum,
                                               @RequestParam(defaultValue = "5") Integer pageSize,
                                               @RequestParam(defaultValue = "0") Integer typeid,
                                               @RequestParam(defaultValue = "") String search) {
        return employeeService.findEmpByPageAndSearch(pageNum, pageSize, typeid, search);
    }

    @RequestMapping("/allData")
    @ResponseBody
    public Map<String, Object> findDeptAndRoles() {
        return employeeService.findDeptAndRoles();
    }

    @RequestMapping("/add")
    @ResponseBody
    public OAResult addEmp(Employee employee, Integer[] roleids) {
        return employeeService.addEmp(employee, roleids);
    }

    @RequestMapping("/toEdit")
    public String toEdit(Integer eid, Model model) {
        Map<String, Object> map = employeeService.findDeptAndRoles();
        Employee employee = employeeService.findEmpByEid(eid);
        map.put("emp", employee);
        model.addAttribute("map", map);
        List<Role> roles = employeeService.findRoleByEId(eid);
        map.put("rs", roles);
        return "main/edit-employee";
    }

    @RequestMapping("/edit")
    @ResponseBody
    public OAResult editEmpByEid(Employee emp, Integer[] roleids) {
        return employeeService.editEmpByEid(emp, roleids);
    }
}
