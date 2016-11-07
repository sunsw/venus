package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.SysMenu;
import com.sunsw.mercury.model.SysMenuExample;
import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SysMenuMapper extends GenericDao<SysMenu, Long> {
	int countByExample(SysMenuExample example);

	int deleteByExample(SysMenuExample example);

	int deleteByPrimaryKey(Long id);

	int insert(SysMenu record);

	int insertSelective(SysMenu record);

	List<SysMenu> selectByExample(SysMenuExample example);

	SysMenu selectByPrimaryKey(Long id);

	int updateByExampleSelective(@Param("record") SysMenu record, @Param("example") SysMenuExample example);

	int updateByExample(@Param("record") SysMenu record, @Param("example") SysMenuExample example);

	int updateByPrimaryKeySelective(SysMenu record);

	int updateByPrimaryKey(SysMenu record);

	List<SysMenu> selectByUserId(Long userId);

	List<Map> selectRoleMenuMap();

}