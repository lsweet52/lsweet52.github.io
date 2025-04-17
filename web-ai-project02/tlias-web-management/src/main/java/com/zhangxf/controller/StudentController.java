package com.zhangxf.controller;

import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Result;
import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;
import com.zhangxf.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/students")
public class StudentController {

    @Autowired
    private StudentService studentService;

    /**
     * 分页查询学生
     */
    @GetMapping
    public Result getStudent(StudentQueryParam studentQueryParam){
        log.info("查询请求参数: {}", studentQueryParam);
        PageResult<Student> pageResult = studentService.getStudent(studentQueryParam);
        return Result.success(pageResult);
    }

}
