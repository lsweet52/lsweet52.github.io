package com.zhangxf.service;

import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;

import java.util.List;

public interface StudentService {

    /**
     * 学生分页查询
     */
    PageResult<Student> getStudent(StudentQueryParam studentQueryParam);

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
