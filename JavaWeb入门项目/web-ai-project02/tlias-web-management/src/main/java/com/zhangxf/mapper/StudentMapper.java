package com.zhangxf.mapper;

import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface StudentMapper {

    /**
     * 分页查询
     */
    List<Student> getStudent(StudentQueryParam studentQueryParam);

    /**
     * 添加学生
     */
    void addStudent(Student student);

    /**
     * 根据id查询学生
     */
    Student getStudentById(Integer id);

    /**
     * 根据id修改学生
     */
    void updateStudent(Student student);

    /**
     * 根据id批量删除学生
     */
    void deleteStudentById(List<Integer> ids);
}
