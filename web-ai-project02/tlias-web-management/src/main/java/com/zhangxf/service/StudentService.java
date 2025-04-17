package com.zhangxf.service;

import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;

public interface StudentService {

    /**
     * 学生分页查询
     */
    PageResult<Student> getStudent(StudentQueryParam studentQueryParam);
}
