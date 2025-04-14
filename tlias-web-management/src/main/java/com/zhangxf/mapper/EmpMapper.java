package com.zhangxf.mapper;

import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.EmpQueryParam;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
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
     *分页查询(原始)
     */
    /*@Select("select e.*, d.name from emp e left join dept d on e.dept_id = d.id order by e.update_time desc limit #{page},#{pageSize}")
    List<Emp> page(Integer page, Integer pageSize);*/
//==============pageHelper===========


    //@Select("select e.*, d.name from emp e left join dept d on e.dept_id = d.id order by e.update_time desc")
    //@Select("select e.*, d.name from emp e left join dept d on e.dept_id = d.id where e.name like concat('%',#{name},'%') and e.gender = #{gender} and e.entry_date between #{begin} and #{end} order by e.update_time")

    /**
     * 分页查询
     */
    List<Emp> list(EmpQueryParam empQueryParam);

    /**
     * 新增员工信息
     * @ptions 主键回显
     */
    @Options(useGeneratedKeys = true, keyProperty = "id")
    @Insert("insert into emp(username, name, gender, phone, job, salary, image, entry_date, dept_id, create_time, update_time)" +
            "    values(#{username},#{name}, #{gender}, #{phone}, #{job}, #{salary}, #{image}, #{entryDate}, #{deptId}, #{createTime}, #{updateTime})")
    void insert(Emp emp);

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
    void updateEmpById(Emp emp);
}
