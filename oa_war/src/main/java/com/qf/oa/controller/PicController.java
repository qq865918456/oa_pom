package com.qf.oa.controller;

import com.qf.oa.entity.Department;
import com.qf.oa.entity.MyCount;
import com.qf.oa.service.IDepService;
import com.qf.oa.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/pic")
public class PicController {

    @Autowired
    private IEmpService empService;
    @Autowired
    private IDepService depService;

    @RequestMapping("/picsex")
    public String picSex(Model model){

        int men = empService.menCount();
        int women = empService.womenCount();
        model.addAttribute("men",men);
        model.addAttribute("women",women);
        return "picemp";
    }

    @RequestMapping("/picemp")
    public String picEmp(Model model){

        List<Department> departments =  depService.queryAllDepName();
        List<MyCount> myCounts =  empService.queryAllDepNumb();
        System.out.println(myCounts);
        model.addAttribute("mycounts",myCounts);
        return "picemp2";
    }
}
