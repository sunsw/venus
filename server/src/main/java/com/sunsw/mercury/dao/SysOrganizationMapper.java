package com.sunsw.mercury.dao;

import com.sunsw.mercury.core.generic.GenericDao;
import com.sunsw.mercury.model.SysOrganization;
import com.sunsw.mercury.model.SysOrganizationExample;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysOrganizationMapper extends GenericDao<SysOrganization, Long> {
	int countByExample(SysOrganizationExample example);

	int deleteByExample(SysOrganizationExample example);

	int deleteByPrimaryKey(Long id);

	int insert(SysOrganization record);

	int insertSelective(SysOrganization record);

	List<SysOrganization> selectByExample(SysOrganizationExample example);

	SysOrganization selectByPrimaryKey(Long id);

	int updateByExampleSelective(@Param("record") SysOrganization record, @Param("example") SysOrganizationExample example);

	int updateByExample(@Param("record") SysOrganization record, @Param("example") SysOrganizationExample example);

	int updateByPrimaryKeySelective(SysOrganization record);

	int updateByPrimaryKey(SysOrganization record);

	List<Long> selectByParentId(Long pid);
}