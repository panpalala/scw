package com.atguigu.scw.dao;

import com.atguigu.scw.bean.TUserRole;
import com.atguigu.scw.bean.TUserRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TUserRoleMapper {
    long countByExample(TUserRoleExample example);

    int deleteByExample(TUserRoleExample example);
    
    int deleteBatchRoles(@Param("userId")Integer userId,@Param("roleList")List<Integer> roleList);

    int deleteByPrimaryKey(Integer id);

    int insert(TUserRole record);

    int insertSelective(TUserRole record);
    
    int insertBatchSelective(@Param("userId")Integer userId,@Param("roleList")List
    		
    		<Integer> roleList);

    List<TUserRole> selectByExample(TUserRoleExample example);

    TUserRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TUserRole record, @Param("example") TUserRoleExample example);

    int updateByExample(@Param("record") TUserRole record, @Param("example") TUserRoleExample example);

    int updateByPrimaryKeySelective(TUserRole record);

    int updateByPrimaryKey(TUserRole record);
}