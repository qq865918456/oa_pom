package com.qf.oa.service.impl;

import com.qf.oa.dao.RoleMapper;
import com.qf.oa.entity.Role;
import com.qf.oa.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private RoleMapper roleMapper;
    @Override
    public List<Role> queryRole() {
        return roleMapper.queryRole();
    }

    @Override
    public List<Role> queryByEid(Integer eid) {
        return roleMapper.queryByEid(eid);
    }

    @Override
    public int insert(Role role) {
        return roleMapper.insert(role);
    }
}
