package com.zhangxf.mapper;

import com.zhangxf.pojo.EmpExpr;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 员工工作经历
 */
@Mapper
public interface EmpExprMapper {

    /**
     *添加工作经历
     */
    void insertBatch(List<EmpExpr> exprList);

    /**
     * 根据id删除工作经历
     */
    void deleteByEmpIds(List<Integer> empIds);
}
