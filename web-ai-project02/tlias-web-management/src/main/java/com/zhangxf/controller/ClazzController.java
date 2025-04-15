package com.zhangxf.controller;

import com.github.pagehelper.PageHelper;
import com.zhangxf.pojo.Clazz;
import com.zhangxf.pojo.ClazzQueryParam;
import com.zhangxf.pojo.PageResult;
import com.zhangxf.pojo.Result;
import com.zhangxf.service.ClazzService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping("/clazzs")
@RestController
public class ClazzController {

    @Autowired
    private ClazzService clazzService;

    @GetMapping
    public Result getClazz(ClazzQueryParam clazzQueryParam) {
        log.info("查询请求参数: {}", clazzQueryParam);
        PageResult<Clazz> pageResult = clazzService.getAllClazz(clazzQueryParam);
        return Result.success(pageResult);
    }

    

}
