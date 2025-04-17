package com.zhangxf.service;

import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.EmpQueryParam;
import com.zhangxf.pojo.PageResult;

import java.time.LocalDate;
import java.util.List;

public interface EmpService {

    /**
     *分页查询
     */
    PageResult<Emp> page(EmpQueryParam empQueryParam);

    /**
     * 新增员工
     */
    void save(Emp emp);

    /**
     * 根据id删除员工
     */
    void deleteByIds(List<Integer> ids);

    /**
     * 根据id查询员工
     */
    Emp getEmpById(Integer id);

    /**
     * 修改员工数据
     */
    void updateEmp(Emp emp);

    /**
     *查询所有员工
     */
    List<Emp> findAllEmp();
}
