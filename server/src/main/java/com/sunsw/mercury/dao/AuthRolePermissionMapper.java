package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.AuthRolePermission;
import com.sunsw.mercury.model.AuthRolePermissionExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuthRolePermissionMapper extends GenericDao<AuthRolePermission, Long> {
	int countByExample(AuthRolePermissionExample example);

    int deleteByExample(AuthRolePermissionExample example);

    int deleteByPrimaryKey(Long id);

    int insert(AuthRolePermission record);

    int insertSelective(AuthRolePermission record);

    List<AuthRolePermission> selectByExample(AuthRolePermissionExample example);

    AuthRolePermission selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") AuthRolePermission record, @Param("example") AuthRolePermissionExample example);

    int updateByExample(@Param("record") AuthRolePermission record, @Param("example") AuthRolePermissionExample example);

    int updateByPrimaryKeySelective(AuthRolePermission record);

    int updateByPrimaryKey(AuthRolePermission record);
}