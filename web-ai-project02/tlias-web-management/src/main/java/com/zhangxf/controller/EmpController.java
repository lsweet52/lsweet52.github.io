package com.zhangxf.controller;


import com.zhangxf.pojo.Emp;
import com.zhangxf.pojo.EmpQueryParam;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Result;
import com.zhangxf.service.EmpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

/**
 * 员工管理Controller
 */
@Slf4j
@RestController
@RequestMapping("/emps")
public class EmpController {

    @Autowired
    private EmpService empService;


    /*@GetMapping
    public Result find(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "10") Integer pageSize,
                       String name, Integer gender,
                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
                       @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        log.info("查询请求参数: {} {} {} {} {} {}", page, pageSize, name, gender, begin, end);
        PageResult<Emp> pageResult = empService.page(page, pageSize, name, gender, begin, end);
        return Result.success(pageResult);
    }*/

    /**
     *分页查询
     */
    @GetMapping
    public Result find(EmpQueryParam empQueryParam) {
        log.info("查询请求参数: {}", empQueryParam);
        PageResult<Emp> pageResult = empService.page(empQueryParam);
        return Result.success(pageResult);
    }

    /**
     *新增员工
     */
    @PostMapping
    public Result save(@RequestBody Emp emp){
        log.info("新增员工：{}", emp);
        empService.save(emp);
        return Result.success();
    }

    /**
     * 根据id批量删除员工
     */
    @DeleteMapping
    public Result delete(@RequestParam List<Integer> ids){
        log.info("根据id删除员工: {}", ids);
        empService.deleteByIds(ids);
        return Result.success();
    }

}
