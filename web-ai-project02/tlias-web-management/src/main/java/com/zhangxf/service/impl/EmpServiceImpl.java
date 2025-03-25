package com.zhangxf.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zhangxf.mapper.EmpMapper;
import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.EmpQueryParam;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpMapper empMapper;

//=============原始方式===============
    /*@Override
    public PageResult<Emp> page(Integer page, Integer pageSize) {

        Long total = empMapper.total();

        int start = (page - 1) * pageSize;

        List<Emp> empList = empMapper.page(page, pageSize);

        return new PageResult<Emp>(total, empList);
    }*/

    /**
     * pageHelper实现分页查询
     * 1: 只能对其后面的一条语句生效
     * 2: SQL语句不能加分号，pageHelper的实现是在末尾加limit
     */
    @Override
    public PageResult<Emp> page(EmpQueryParam empQueryParam) {

        PageHelper.startPage(empQueryParam.getPage(), empQueryParam.getPageSize());

        List<Emp> list = empMapper.list(empQueryParam);
        Page<Emp> p = (Page<Emp>) list;
        return new PageResult<Emp>(p.getTotal(), p.getResult());
    }
}
