package com.qf.oa.controller;

import com.qf.oa.entity.Resc;
import com.qf.oa.service.IRescService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/resc")
public class RescController {

    @Autowired
    private IRescService rescService;

    @RequestMapping("/queryResc")
    public String queryResc(Model model){

        List<Resc> rescs = rescService.queryResc();
        model.addAttribute("rescs" ,rescs);
        return "resclist";
    }

    @RequestMapping("/queryall")
    @ResponseBody
    public List<Resc> queryall(){
        List<Resc> rescs = rescService.queryResc();
        return rescs;
    }

    @RequestMapping("/insert")
    public String insert(Resc resc){
        System.out.println(resc);
        int index = rescService.insert(resc);
        return "redirect:/resc/queryResc";
    }

    @RequestMapping("/selectresc")
    @ResponseBody
    public Integer selectresc(Integer rid,Integer[] reids){
        System.out.println(rid+ Arrays.toString(reids));
        int resoult =  rescService.updataRescAndRole(rid,reids);
        return resoult;
    }
}
