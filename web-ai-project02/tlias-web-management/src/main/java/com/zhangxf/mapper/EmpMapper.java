package com.zhangxf.mapper;

import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.EmpQueryParam;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDate;
import java.util.List;

/**
 * 员工信息
 */
@Mapper
public interface EmpMapper {

//===========原始方式=================
    /**
     *查询总记录数
    /*@Select("select count(*) from emp e left join dept d on e.dept_id = d.id ")
    Long total();
*/
    /**
     *分页查询
     */
    /*@Select("select e.*, d.name from emp e left join dept d on e.dept_id = d.id order by e.update_time desc limit #{page},#{pageSize}")
    List<Emp> page(Integer page, Integer pageSize);*/
//==============pageHelper===========

    /**
     * 分页查询
     */
    //@Select("select e.*, d.name from emp e left join dept d on e.dept_id = d.id order by e.update_time desc")
    //@Select("select e.*, d.name from emp e left join dept d on e.dept_id = d.id where e.name like concat('%',#{name},'%') and e.gender = #{gender} and e.entry_date between #{begin} and #{end} order by e.update_time")

    List<Emp> list(EmpQueryParam empQueryParam);
}
