package com.qf.oa.service;

import com.qf.oa.entity.Resc;

import java.util.List;

public interface IRescService {

    List<Resc> queryResc();

    int insert(Resc resc);

    int updataRescAndRole(Integer rid, Integer[] reids);
}
