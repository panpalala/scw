package com.atguigu.scw.dao;

import com.atguigu.scw.bean.TUser;
import com.atguigu.scw.bean.TUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TUserMapper {
    long countByExample(TUserExample example);
    
    int deleteByExample(TUserExample example);

    int deleteBatchByPrimaryKey(@Param("ids")Integer...ids);
    
    int deleteByPrimaryKey(Integer id);

    int insert(TUser record);

    int insertSelective(TUser record);

    List<TUser> selectByExample(TUserExample example);

    TUser selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TUser record, @Param("example") TUserExample example);

    int updateByExample(@Param("record") TUser record, @Param("example") TUserExample example);

    int updateByPrimaryKeySelective(TUser record);

    int updateByPrimaryKey(TUser record);
    
    List<TUser> selectUsersByCondition(@Param("condition")String condition);
}