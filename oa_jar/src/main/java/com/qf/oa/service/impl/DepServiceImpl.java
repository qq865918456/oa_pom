package com.qf.oa.service.impl;

import com.qf.oa.dao.DepartmentMapper;
import com.qf.oa.entity.Department;
import com.qf.oa.entity.Employee;
import com.qf.oa.service.IDepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepServiceImpl implements IDepService {

    @Autowired
    private DepartmentMapper departmentMapper;


    @Override
    public List<Department> queryAll() {
        return departmentMapper.queryAll();
    }

    @Override
    public Integer insertDeo(Department department) {
        return departmentMapper.insert(department);
    }

    @Override
    public Integer deleteDep(Integer id) {
        return departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Department> queryAllDepName() {
        return departmentMapper.queryAllDepName();
    }


}
