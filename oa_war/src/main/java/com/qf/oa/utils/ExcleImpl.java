package com.qf.oa.utils;

import com.qf.oa.entity.Employee;
import org.apache.poi.hssf.usermodel.*;

import javax.servlet.ServletOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class ExcleImpl {

    public void export(ServletOutputStream out, List<Employee> employees){

        //创建一个workbook对象 对应一个excel文件
        HSSFWorkbook workbook = new HSSFWorkbook();

        //创建一个页面从workbook创建
        HSSFSheet sheet = workbook.createSheet();

        //在sheet中添加表头第0行，
        HSSFRow row = sheet.createRow(0);

        //设置样式居中
        HSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        HSSFCell hssfCell = null;
       /* for(int i=0;i<employees.size();i++){
            hssfCell = row.createCell(i);//列索引从0开始
            hssfCell.setCellValue(employees[i]);//列名1
            hssfCell.setCellStyle(cellStyle);//列居中显示
        }*/
        for (Employee emp:
             employees) {
            hssfCell = row.createCell(0);//列索引从0开始
            hssfCell.setCellValue(emp.getName());//列名1
            hssfCell.setCellStyle(cellStyle);//列居中显示
        }

        for (int i = 0; i < employees.size(); i++) {
            row = sheet.createRow(i+1);
            Employee employee= employees.get(i);

            // 第六步，创建单元格，并设置值
            Integer id = null;
            if(employee.getId() != null){
                id = employee.getId();
            }
            row.createCell(0).setCellValue(id);

            String email = "";
            if(employee.getEmail() != null){
                email = employee.getEmail();
            }
            row.createCell(1).setCellValue(email);

            String password = "";
            if(employee.getPassword() != null){
                password = employee.getPassword();
            }
            row.createCell(2).setCellValue(password);

            String name = "";
            if(employee.getName() != null){
                name = employee.getName();
            }
            row.createCell(3).setCellValue(name);

            String phone = "";
            if(employee.getPhone() != null){
                phone = employee.getPhone();
            }
            row.createCell(4).setCellValue(phone);

            Integer sex = null;
            if(employee.getSex() != null){
                sex = employee.getSex();
            }
            row.createCell(5).setCellValue(sex);

            Date birthday = null;
            if(employee.getBirthday() != null){
                birthday = employee.getBirthday();
            }
            row.createCell(6).setCellValue(birthday);

            Date entrytime = null;
            if(employee.getEntrytime() != null){
                entrytime = employee.getEntrytime();
            }
            row.createCell(7).setCellValue(entrytime);

            String dname = "";
            if(employee.getDname() != null){
                dname = employee.getDname();
            }
            row.createCell(8).setCellValue(dname);
        }

        try {
            workbook.write(out);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
