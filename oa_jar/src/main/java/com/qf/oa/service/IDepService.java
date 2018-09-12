package com.qf.oa.service;

import com.qf.oa.entity.Department;

import java.util.List;

public interface IDepService {

    List<Department> queryAll();

    Integer insertDeo(Department department);

    Integer deleteDep(Integer id);

    List<Department> queryAllDepName();


}
