package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.AuthPermission;
import com.sunsw.mercury.model.AuthPermissionExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuthPermissionMapper extends GenericDao<AuthPermission, Long> {
	int countByExample(AuthPermissionExample example);

    int deleteByExample(AuthPermissionExample example);

    int deleteByPrimaryKey(Long id);

    int insert(AuthPermission record);

    int insertSelective(AuthPermission record);

    List<AuthPermission> selectByExample(AuthPermissionExample example);

    AuthPermission selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") AuthPermission record, @Param("example") AuthPermissionExample example);

    int updateByExample(@Param("record") AuthPermission record, @Param("example") AuthPermissionExample example);

    int updateByPrimaryKeySelective(AuthPermission record);

    int updateByPrimaryKey(AuthPermission record);

    List<AuthPermission> selectPermissionsByRoleId(Long roleId);

}