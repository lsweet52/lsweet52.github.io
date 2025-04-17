package com.zhangxf.service.impl;

import com.zhangxf.mapper.StudentMapper;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;
import com.zhangxf.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    /**
     * 学生分页查询
     */
    @Override
    public PageResult<Student> getStudent(StudentQueryParam studentQueryParam) {
        return new PageResult<>();
    }
}
