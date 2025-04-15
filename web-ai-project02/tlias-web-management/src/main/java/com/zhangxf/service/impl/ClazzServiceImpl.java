package com.zhangxf.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zhangxf.mapper.ClazzMapper;
import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
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
}
