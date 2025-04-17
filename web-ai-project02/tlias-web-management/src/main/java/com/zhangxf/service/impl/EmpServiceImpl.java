package com.zhangxf.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zhangxf.mapper.EmpExprMapper;
import com.zhangxf.mapper.EmpMapper;
import com.zhangxf.pojo.*;
import com.zhangxf.service.EmpLogService;
import com.zhangxf.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Service
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private EmpExprMapper empExprMapper;
    @Autowired
    private EmpLogService empLogService;

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

    /**
     *添加员工
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void save(Emp emp) {
        try {
            //1.保存员工的基本信息
            emp.setCreateTime(LocalDateTime.now());
            emp.setUpdateTime(LocalDateTime.now());
            empMapper.insert(emp);
   
            //2.保存员工的工作经历信息
            List<EmpExpr> exprList = emp.getExprList();
            if(!CollectionUtils.isEmpty(exprList)){
                exprList.forEach(empExpr -> {
                    empExpr.setEmpId(emp.getId());
                });
                empExprMapper.insertBatch(exprList);
            }
        } finally {
            //记录操作日志
            EmpLog empLog = new EmpLog(null, LocalDateTime.now(), "新增员工" + emp);
            empLogService.insertLog(empLog);
        }
    }

    /**
     * 根据id删除员工
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteByIds(List<Integer> ids) {
        //1.删除员工基本信息
        empMapper.deleteByIds(ids);

        //2.删除员工工作经历信息
        empExprMapper.deleteByEmpIds(ids);
    }

    /**
     *根据id查询员工
     */
    @Override
    public Emp getEmpById(Integer id) {
        return empMapper.getEmpById(id);
    }

    /**
     * 修改员工数据
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateEmp(Emp emp) {
        //补全基础属性, 修改时间
        emp.setUpdateTime(LocalDateTime.now());
        empMapper.updateEmpById(emp);

        //根据id删除员工工作经历
        empExprMapper.deleteByEmpIds(Arrays.asList(emp.getId()));

        //添加工作经历
        Integer id = emp.getId();
        List<EmpExpr> exprList = emp.getExprList();
        if(!CollectionUtils.isEmpty(exprList)){
            exprList.forEach(empExpr -> empExpr.setEmpId(id));
            empExprMapper.insertBatch(exprList);
        }
    }

    /**
     * 查询所有员工
     */
    @Override
    public List<Emp> findAllEmp() {
        return empMapper.findAllEmp();
    }
}
