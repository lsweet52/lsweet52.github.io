package com.zhangxf.mapper;

import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ClazzMapper {

    /**
     * 查询所有班级
     */
    List<Clazz> getAllClazz(ClazzQueryParam clazzQueryParam);

    /**
     * 新增班级
     */
    @Insert("insert into clazz values(null, #{name}, #{room}, #{beginDate}, #{endDate}, #{masterId}, #{subject}, #{createTime}, #{updateTime})")
    void addClazz(Clazz clazz);

    /**
     * 根据id查询班级
     */
    @Select("select * from clazz where id = #{id}")
    Clazz findClazzById(Integer id);

    /**
     * 修改班级
     */
    void updateClazz(Clazz clazz);
}
