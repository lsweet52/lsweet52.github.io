package com.zhangxf.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zhangxf.mapper.ClazzMapper;
import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Service
public class ClazzServiceImpl implements ClazzService {

    @Autowired
    private ClazzMapper clazzMapper;

    /**
     *分页查询所有班级
     */
    @Override
    public PageResult<Clazz> getAllClazz(ClazzQueryParam clazzQueryParam) {
        PageHelper.startPage(clazzQueryParam.getPage(), clazzQueryParam.getPageSize());
        List<Clazz> clazzList = clazzMapper.getAllClazz(clazzQueryParam);

        //补全属性：状态
        if(!CollectionUtils.isEmpty(clazzList)){
            clazzList.forEach(clazz -> {
                if(clazz.getEndDate().isBefore(LocalDate.now())) {
                    clazz.setStatus("已结课");
                }
                if(clazz.getBeginDate().isBefore(LocalDate.now()) && clazz.getEndDate().isAfter(LocalDate.now())) {
                    clazz.setStatus("在读");
                }
                if(clazz.getBeginDate().isAfter(LocalDate.now())){
                    clazz.setStatus("未开班");
                }
            });
        }
        Page<Clazz> p = (Page<Clazz>) clazzList;
        return new PageResult<Clazz>(p.getTotal(), p.getResult());
    }

    /**
     * 新增班级
     */
    @Override
    public void addClazz(Clazz clazz) {
        clazz.setCreateTime(LocalDateTime.now());
        clazz.setUpdateTime(LocalDateTime.now());
        clazzMapper.addClazz(clazz);
    }

    /**
     * 根据id查询班级
     */
    @Override
    public Clazz findClazzById(Integer id) {
        return clazzMapper.findClazzById(id);
    }

    /**
     * 修改班级
     */
    @Override
    public void updateClazz(Clazz clazz) {
        //补全基础属性updateTIme
        clazz.setUpdateTime(LocalDateTime.now());
        clazzMapper.updateClazz(clazz);
    }


}
