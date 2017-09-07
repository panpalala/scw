package com.atguigu.scw.dao;

import com.atguigu.scw.bean.TTicket;
import com.atguigu.scw.bean.TTicketExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TTicketMapper {
    long countByExample(TTicketExample example);

    int deleteByExample(TTicketExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TTicket record);

    int insertSelective(TTicket record);

    List<TTicket> selectByExample(TTicketExample example);

    TTicket selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TTicket record, @Param("example") TTicketExample example);

    int updateByExample(@Param("record") TTicket record, @Param("example") TTicketExample example);

    int updateByPrimaryKeySelective(TTicket record);

    int updateByPrimaryKey(TTicket record);
}