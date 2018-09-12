package com.qf.oa.service;

import com.qf.oa.entity.Role;

import java.util.List;

public interface IRoleService {

    List<Role> queryRole();

    List<Role> queryByEid(Integer eid);

    int insert(Role role);
}
