package com.atguigu.scw.dao;

import com.atguigu.scw.bean.TPwdToken;
import com.atguigu.scw.bean.TPwdTokenExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TPwdTokenMapper {
    long countByExample(TPwdTokenExample example);

    int deleteByExample(TPwdTokenExample example);

    int deleteByPrimaryKey(Integer userid);

    int insert(TPwdToken record);

    int insertSelective(TPwdToken record);

    List<TPwdToken> selectByExample(TPwdTokenExample example);

    TPwdToken selectByPrimaryKey(Integer userid);

    int updateByExampleSelective(@Param("record") TPwdToken record, @Param("example") TPwdTokenExample example);

    int updateByExample(@Param("record") TPwdToken record, @Param("example") TPwdTokenExample example);

    int updateByPrimaryKeySelective(TPwdToken record);

    int updateByPrimaryKey(TPwdToken record);
}