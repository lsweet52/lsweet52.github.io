package com.zhangxf.controller;

import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Result;
import com.zhangxf.service.ClazzService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RequestMapping("/clazzs")
@RestController
public class ClazzController {

    @Autowired
    private ClazzService clazzService;

    /**
     * 分页查询所有班级
     */
    @GetMapping
    public Result getClazz(ClazzQueryParam clazzQueryParam) {
        log.info("查询请求参数: {}", clazzQueryParam);
        PageResult<Clazz> pageResult = clazzService.getAllClazz(clazzQueryParam);
        return Result.success(pageResult);
    }

    /**
     * 新增班级
     */
    @PostMapping
    public Result addClazz(@RequestBody Clazz clazz){
        log.info("新增班级: {}", clazz);
        clazzService.addClazz(clazz);
        return Result.success();
    }

    /**
     * 根据id查询班级
     */
    @GetMapping("/{id}")
    public Result findClazzById(@PathVariable Integer id){
        log.info("根据id查询班级: {}", id);
        Clazz clazz = clazzService.findClazzById(id);
        return Result.success(clazz);
    }

    /**
     * 修改班级
     */
    @PutMapping
    public Result updateClazz(@RequestBody Clazz clazz){
        log.info("修改班级: {}", clazz);
        clazzService.updateClazz(clazz);
        return Result.success();
    }

}
