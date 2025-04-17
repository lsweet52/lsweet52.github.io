package com.zhangxf.service;

import com.github.pagehelper.PageHelper;
import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import com.zhangxf.pojo.PageResult;

import java.util.List;

public interface ClazzService {

    /**
     * 查询所有班级
     */
    PageResult<Clazz> getAllClazz(ClazzQueryParam clazzQueryParam);

    /**
     * 新增班级
     */
    void addClazz(Clazz clazz);

    /**
     * 根据id查询班级
     */
    Clazz findClazzById(Integer id);

    /**
     * 修改班级
     */
    void updateClazz(Clazz clazz);
}
