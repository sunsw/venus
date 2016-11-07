package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.SysMenu;
import com.sunsw.mercury.model.SysRoleMenu;
import com.sunsw.mercury.model.SysRoleMenuExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SysRoleMenuMapper extends GenericDao<SysRoleMenu, Long> {
	int countByExample(SysRoleMenuExample example);

	int deleteByExample(SysRoleMenuExample example);

	int deleteByPrimaryKey(Long id);

	int insert(SysRoleMenu record);

	int insertSelective(SysRoleMenu record);

	List<SysRoleMenu> selectByExample(SysRoleMenuExample example);

	SysRoleMenu selectByPrimaryKey(Long id);

	int updateByExampleSelective(@Param("record") SysRoleMenu record, @Param("example") SysRoleMenuExample example);

	int updateByExample(@Param("record") SysRoleMenu record, @Param("example") SysRoleMenuExample example);

	int updateByPrimaryKeySelective(SysRoleMenu record);

	int updateByPrimaryKey(SysRoleMenu record);

}