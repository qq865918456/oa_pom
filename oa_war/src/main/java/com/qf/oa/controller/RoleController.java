package com.qf.oa.controller;

import com.qf.oa.entity.Role;
import com.qf.oa.service.IEmpService;
import com.qf.oa.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;
    @Autowired
    private IEmpService empService;

    @RequestMapping("/queryRole")
    public String queryRole(Model model){
        List<Role> roles = roleService.queryRole();
        model.addAttribute("roles",roles);
        return "rolelist";
    }

    @RequestMapping("/queryall")
    @ResponseBody
    public List<Role> queryall(Integer eid){
        List<Role> roleList =  roleService.queryByEid(eid);
        return roleList;
    }

    @RequestMapping("/selectroles")
    public String selectroles(Integer eid,Integer[] rid){
         empService.addRole(eid,rid);
        return "redirect:/emp/queryEmp";
    }

    @RequestMapping("/insert")
    public String roleInsert(Role role){
        int index = roleService.insert(role);
        return "redirect:/role/queryRole";
    }

}
