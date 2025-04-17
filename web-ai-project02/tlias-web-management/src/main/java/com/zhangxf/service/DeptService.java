package com.zhangxf.service;

import com.zhangxf.pojo.Dept;
import com.zhangxf.pojo.Result;

import java.util.List;

public interface DeptService {
    /**
     *查询所有部门
     */
    List<Dept> findAll();

    /**
     * 根据id删除部门
     */
    void deleteById(Integer id);

    /**
     *新增部门
     */
    void add(Dept dept);

    /**
     * 根据id查询部门
     */
    Dept findById(Integer id);

    /**
     *根据id修改部门数据
     */
    void update(Dept dept);
}
