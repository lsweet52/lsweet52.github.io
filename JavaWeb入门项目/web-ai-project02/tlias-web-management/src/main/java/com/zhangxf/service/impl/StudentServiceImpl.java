package com.zhangxf.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zhangxf.mapper.StudentMapper;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;
import com.zhangxf.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    /**
     * 学生分页查询
     */
    @Override
    public PageResult<Student> getStudent(StudentQueryParam studentQueryParam) {
        PageHelper.startPage(studentQueryParam.getPage(), studentQueryParam.getPageSize());
        List<Student> studentList = studentMapper.getStudent(studentQueryParam);
        Page<Student> page = (Page<Student>)studentList;
        return new PageResult<Student>(page.getTotal(), page.getResult());
    }

    /**
     * 添加学生
     */
    @Override
    public void addStudent(Student student) {
        //补全基础属性
        student.setCreateTime(LocalDateTime.now());
        student.setUpdateTime(LocalDateTime.now());
        studentMapper.addStudent(student);
    }

    /**
     * 根据id查询学生
     */
    @Override
    public Student getStudentById(Integer id) {
        return studentMapper.getStudentById(id);
    }

    /**
     * 根据id修改学生
     */
    @Override
    public void updateStudent(Student student) {
        //补全基本属性
        student.setUpdateTime(LocalDateTime.now());

        studentMapper.updateStudent(student);
    }

    /**
     * 根据id批量删除学生
     */
    @Override
    public void deleteStudentById(List<Integer> ids) {
        studentMapper.deleteStudentById(ids);
    }


}
