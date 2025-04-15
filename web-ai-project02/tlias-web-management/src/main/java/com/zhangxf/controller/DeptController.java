package com.zhangxf.controller;

import com.zhangxf.pojo.Dept;
import com.zhangxf.pojo.Result;
import com.zhangxf.service.DeptService;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.ibatis.annotations.Delete;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/depts")
@RestController
public class DeptController {

    private static final Logger logger = LoggerFactory.getLogger(DeptController.class);

    @Autowired
    private DeptService deptService;

//    @RequestMapping(value = "/depts", method = RequestMethod.GET)

    /**
     *获取全部部门
     */
    @GetMapping
    public Result list(){
//        System.out.println("查询所有部门数据");
        logger.info("查询所有部门");
        List<Dept> deptList = deptService.findAll();
        return Result.success(deptList);
    }

    /**
     *删除部门-方式一：HttpServletRequest 获取请求参数
     */
    /*@DeleteMapping("/depts")
    public Result delete(HttpServletRequest request){
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);
        System.out.println("根据ID删除部门：" + id);
        return Result.success();
    }*/

    /**
     *删除部门-方式二：@RequestParam
     * 必须传递参数，如果不传递参数会报错，(默认required = true)
     */
    /*@DeleteMapping("/depts")
    public Result delete(@RequestParam(value = "id", required = false) Integer deptId){
        System.out.println("根据ID删除部门：" + deptId);
        return Result.success();
    }*/

    /**
     *删除部门-方式二：省略@RequestParam，(前端传递的请求参数名与服务器方法参数名一致)[推荐]
     */
    @DeleteMapping
    public Result delete(Integer id){
//        System.out.println("根据ID删除部门：" + id);
        logger.info("根据id删除部门: {}", id);
        deptService.deleteById(id);
        return Result.success();
    }

    /**
     * 添加部门
     *@RequestBody
     */
    @PostMapping
    public Result add(@RequestBody Dept dept){
//        System.out.println("新增部门：" + dept);
        logger.info("新增部门: {}",dept);
        deptService.add(dept);
        return Result.success();
    }

    /**
     * 根据id查询部门
     * @PathVariable 参数路径 ! 参数路径名和参数名一致
     */
    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
//        System.out.println("根据id查询部门" + id);
        logger.info("根据id查询部门: {}", id);
        Dept dept = deptService.findById(id);
        return Result.success(dept);
    }

    /**
     * 修改部门数据
     */
    @PutMapping
    public Result update(@RequestBody Dept dept){
//        System.out.println("根据id修改部门" + dept);
        logger.info("根据id修改部门: {}", dept);
        deptService.update(dept);
        return Result.success();
    }
}
