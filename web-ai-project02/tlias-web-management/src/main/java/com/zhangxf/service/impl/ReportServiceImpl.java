package com.zhangxf.service.impl;

import com.zhangxf.mapper.EmpMapper;
import com.zhangxf.pojo.JobOption;
import com.zhangxf.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private EmpMapper empMapper;

    /**
     * 统计员工各个职业人数
     */
    @Override
    public JobOption getEmpJobData() {
        List<Map<String, Object>> list = empMapper. countEmpJobData();
        List<Object> jobList = list.stream().map(dataMap -> dataMap.get("pos")).toList();
        List<Object> dataList = list.stream().map(dataMap -> dataMap.get("total")).toList();
        return new JobOption(jobList, dataList);
    }

    /**
     * 统计员工性别
     */
    @Override
    public List<Map> getEmpGenderData() {
        return empMapper.countEmpGenderData();
    }
}
