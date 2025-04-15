package com.zhangxf.mapper;

import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ClazzMapper {

    /**
     * 查询所有班级
     */
    List<Clazz> getAllClazz(ClazzQueryParam clazzQueryParam);
}
