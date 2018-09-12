package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import com.qf.oa.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/emp")
public class EmpController {
    @Autowired
    private IEmpService empService;

    @RequestMapping("/queryEmp")
    public String queryEmp(Model model){
        List<Employee> employees = empService.queryEmp();
        model.addAttribute("emps",employees);
        return "emplist";
    }

    @RequestMapping("/insert")
    public String insert(Employee employee){
        empService.insert(employee);
        return "redirect:/emp/queryEmp";
    }

    @RequestMapping("/queryById")
    @ResponseBody
    public Employee queryByid(Integer eid){
        System.out.println(eid);
        Employee employee =  empService.queryById(eid);
        return employee;
    }

}
