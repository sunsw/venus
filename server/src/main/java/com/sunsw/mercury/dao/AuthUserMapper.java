package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.AuthUser;
import com.sunsw.mercury.model.AuthUserExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuthUserMapper extends GenericDao<AuthUser, Long> {
	int countByExample(AuthUserExample example);

    int deleteByExample(AuthUserExample example);

    int deleteByPrimaryKey(Long id);

    int insert(AuthUser record);

    int insertSelective(AuthUser record);

    List<AuthUser> selectByExample(AuthUserExample example);

    AuthUser selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") AuthUser record, @Param("example") AuthUserExample example);

    int updateByExample(@Param("record") AuthUser record, @Param("example") AuthUserExample example);

    int updateByPrimaryKeySelective(AuthUser record);

    int updateByPrimaryKey(AuthUser record);
}