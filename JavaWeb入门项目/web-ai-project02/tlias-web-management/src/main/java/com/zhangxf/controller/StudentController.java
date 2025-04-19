package com.zhangxf.controller;

import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Result;
import com.zhangxf.pojo.Student;
import com.zhangxf.pojo.StudentQueryParam;
import com.zhangxf.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    /**
     * 添加学生
     */
    @PostMapping
    public Result addStudent(@RequestBody Student student){
        log.info("添加学生: {}", student);
        studentService.addStudent(student);
        return Result.success();
    }

    /**
     * 根据id查询学生
     */
    @GetMapping("/{id}")
    public Result getStudentById(@PathVariable Integer id){
        log.info("根据id查询学生: {}", id);
        Student student  = studentService.getStudentById(id);
        return Result.success(student);
    }

    /**
     * 根据id修改学生
     */
    @PutMapping
    public Result updateStudent(@RequestBody Student student){
        log.info("修改学生: {}", student);
        studentService.updateStudent(student);
        return Result.success();
    }

    /**
     * 根据id删除学生
     */
    @DeleteMapping("/{ids}")
    public Result deleteStudent(@PathVariable List<Integer> ids){
        log.info("根据id删除学生: {}", ids);
        studentService.deleteStudentById(ids);
        return Result.success();
    }

}
