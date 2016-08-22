package com.base.service.repository;

import java.util.List;

import com.base.persistence.Test;

/**
 * 
 * TestMapper数据库操作接口类
 * 
 **/

public interface TestMapper{
    public List<Test> showindex();
    public Integer updateshow();
    public Integer updateindex();
}
