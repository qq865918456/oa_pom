package com.qf.oa.service;

import com.qf.oa.entity.Employee;
import com.qf.oa.entity.MyCount;

import java.util.List;

public interface IEmpService {
    List<Employee> queryEmp();

    int insert(Employee employee);

    Employee queryById(Integer eid);

    int addRole(Integer eid, Integer[] rid);

    Employee queryByEmail(String email);

    int menCount();

    int womenCount();

    List<MyCount> queryAllDepNumb();

    List<Employee> excelEmp();
}
