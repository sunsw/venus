package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.AuthUserRole;
import com.sunsw.mercury.model.AuthUserRoleExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuthUserRoleMapper extends GenericDao<AuthUserRole, Long> {
	int countByExample(AuthUserRoleExample example);

    int deleteByExample(AuthUserRoleExample example);

    int deleteByPrimaryKey(Long id);

    int insert(AuthUserRole record);

    int insertSelective(AuthUserRole record);

    List<AuthUserRole> selectByExample(AuthUserRoleExample example);

    AuthUserRole selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") AuthUserRole record, @Param("example") AuthUserRoleExample example);

    int updateByExample(@Param("record") AuthUserRole record, @Param("example") AuthUserRoleExample example);

    int updateByPrimaryKeySelective(AuthUserRole record);

    int updateByPrimaryKey(AuthUserRole record);
}