package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

    @RequestMapping("/login")
    public String login(String email, String password, Model model){
        Subject subject = SecurityUtils.getSubject();
        if(!subject.isAuthenticated()){
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(email,password);
            try {
                subject.login(usernamePasswordToken);
            }catch (Exception e){
                return "login";
            }
        }

        Employee employee = (Employee) subject.getPrincipal();
        System.out.println(employee);
        model.addAttribute("emp",employee);
        return "index";
    }
}
