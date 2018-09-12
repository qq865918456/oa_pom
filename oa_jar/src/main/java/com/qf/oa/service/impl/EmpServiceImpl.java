package com.qf.oa.service.impl;

import com.qf.oa.dao.EmployeeMapper;
import com.qf.oa.entity.Employee;
import com.qf.oa.entity.MyCount;
import com.qf.oa.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class EmpServiceImpl implements IEmpService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> queryEmp() {
        return employeeMapper.queryEmp();
    }


    @Override
    @Transactional
    public int insert(Employee employee) {
        if(employee.getId()==null){
           return employeeMapper.insert(employee);
        }else {
            return employeeMapper.updateByPrimaryKeySelective(employee);
        }

    }

    @Override
    public Employee queryById(Integer eid) {
        return employeeMapper.selectByPrimaryKey(eid);
    }

    @Transactional
    @Override
    public int addRole(Integer eid, Integer[] rid) {
        employeeMapper.deleteRole(eid);
        return employeeMapper.addRole(eid,rid);
    }

    @Override
    @Transactional
    public Employee queryByEmail(String email) {
        return employeeMapper.queryByEmail(email);
    }

    @Override
    public int menCount() {
        return employeeMapper.mentCount();
    }

    @Override
    public int womenCount() {
        return employeeMapper.womentCount();
    }

    @Override
    public List<MyCount> queryAllDepNumb() {
        return employeeMapper.queryAllDepNumb();
    }

    @Override
    public List<Employee> excelEmp() {
        return employeeMapper.excelEmp();
    }
}
