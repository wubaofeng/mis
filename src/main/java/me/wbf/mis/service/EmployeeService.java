package me.wbf.mis.service;

import com.github.pagehelper.PageInfo;
import me.wbf.mis.entity.Employee;
import me.wbf.mis.entity.Role;
import me.wbf.mis.util.OAResult;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public interface EmployeeService {
    PageInfo<Employee> findEmpByPageAndSearch(Integer pageNum, Integer pageSize, Integer typeid, String search);

    Map<String, Object> findDeptAndRoles();

    OAResult addEmp(Employee employee, Integer[] roleids);

    Employee findEmpByEid(Integer eid);

    OAResult editEmpByEid(Employee emp, Integer[] roleids);

    List<Role> findRoleByEId(Integer eid);

    boolean findUserAndPassword(Employee employee, Model model, HttpSession session);
}
