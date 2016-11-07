package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.AuthRole;
import com.sunsw.mercury.model.AuthRoleExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuthRoleMapper extends GenericDao<AuthRole, Long> {
	int countByExample(AuthRoleExample example);

    int deleteByExample(AuthRoleExample example);

    int deleteByPrimaryKey(Long id);

    int insert(AuthRole record);

    int insertSelective(AuthRole record);

    List<AuthRole> selectByExample(AuthRoleExample example);

    AuthRole selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") AuthRole record, @Param("example") AuthRoleExample example);

    int updateByExample(@Param("record") AuthRole record, @Param("example") AuthRoleExample example);

    int updateByPrimaryKeySelective(AuthRole record);

    int updateByPrimaryKey(AuthRole record);

    List<AuthRole> selectRolesByUserId(Long userId);

}