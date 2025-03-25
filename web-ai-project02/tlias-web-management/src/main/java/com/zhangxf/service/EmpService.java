package com.zhangxf.service;

import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.EmpQueryParam;
import com.zhangxf.pojo.PageResult;

import java.time.LocalDate;

public interface EmpService {

    /**
     *分页查询
     */
    PageResult<Emp> page(EmpQueryParam empQueryParam);
}
