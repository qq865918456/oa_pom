package com.qf.oa.controller;

import com.qf.oa.entity.Department;
import com.qf.oa.interceptor.Page;
import com.qf.oa.service.IDepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dep")
public class DepController {

    @Autowired
    private IDepService depService;

    /**
     * 查询全部的方法
     *
     * @param model
     * @return
     */
    @RequestMapping("/queryAll")
    public String queryAll(Model model, Page page) {
        List<Department> deps = depService.queryAll();
        model.addAttribute("deps", deps);
        return "deplist";
    }

    @RequestMapping("/queryDep")
    @ResponseBody
    public List<Department> queryDep() {
        List<Department> departments = depService.queryAll();
        return departments;
    }

    @RequestMapping("/insert")
    public String insert(Department department){
        depService.insertDeo(department);
        return "redirect:/dep/queryAll";
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id){
         depService.deleteDep(id);
        return "redirect:/dep/queryAll";
    }
}
