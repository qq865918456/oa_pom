package com.qf.oa.controller;

import com.qf.oa.entity.Employee;
import com.qf.oa.service.IEmpService;
import com.qf.oa.utils.ExcleImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequestMapping("/excel")
public class ExcelController {

    @Autowired
    private IEmpService empService;
    ExcleImpl excleImpl = new ExcleImpl();


    @RequestMapping("/emp")
    public String outPutEmpByExcel(HttpServletResponse response){
       //设置编码
        response.setContentType("application/binary;charset=UTF-8");
        ServletOutputStream outputStream = null;
        //活的相应流
        try {
            outputStream = response.getOutputStream();
            response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode("emp.xls", "UTF-8"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        List<Employee> employees = empService.excelEmp();
        System.out.println(employees);
       excleImpl.export(outputStream,employees);

        return "success";
    }
}
