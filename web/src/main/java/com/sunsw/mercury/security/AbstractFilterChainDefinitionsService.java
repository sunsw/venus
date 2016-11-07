package com.sunsw.mercury.security;

import org.apache.shiro.config.Ini;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.util.CollectionUtils;
import org.apache.shiro.web.config.IniFilterChainResolverFactory;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.filter.mgt.PathMatchingFilterChainResolver;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

/**
 * 安全框架角色资源配置服务类
 * Created by sunsw on 2016/4/13.
 */
public abstract class AbstractFilterChainDefinitionsService implements FilterChainDefinitionsService {

	private final static Logger logger = LoggerFactory.getLogger(AbstractFilterChainDefinitionsService.class);

	private String definitions;

	@Autowired
	private ShiroFilterFactoryBean shiroFilterFactoryBean;

	@Override
	public Ini.Section loadFilterChainDefinitions() {
		logger.info("loading FilterChainDefinitions...");
		Ini ini = new Ini();
		ini.load(definitions); // 加载配置文件
		Ini.Section section = ini.getSection(IniFilterChainResolverFactory.URLS); // 使用默认节点
		if (CollectionUtils.isEmpty(section)) {
			section = ini.getSection(Ini.DEFAULT_SECTION_NAME); // 如不存在默认节点切割,则使用空字符转换
		}
		Map<String, String> permissionMap = this.initOtherFilterChains();//加载第三方配置
		if (permissionMap != null && !permissionMap.isEmpty()) {
			section.putAll(permissionMap);
		}
		section.put("/**", "authc");//其余路径全需要认证
		for(Map.Entry<String, String> e : section.entrySet()) {
			logger.info(e.getKey() + " = " + e.getValue());
		}
		return section;
	}

	@Override
	public void reCreateFilterChains() {
		synchronized (shiroFilterFactoryBean) {
			logger.info("reCreating FilterChains...");
			AbstractShiroFilter shiroFilter = null;
			try {
				shiroFilter = (AbstractShiroFilter) shiroFilterFactoryBean.getObject();
			} catch (Exception e) {
				logger.error(e.getMessage());
			}

			// 获取过滤管理器
			PathMatchingFilterChainResolver filterChainResolver = (PathMatchingFilterChainResolver) shiroFilter.getFilterChainResolver();
			DefaultFilterChainManager manager = (DefaultFilterChainManager) filterChainResolver.getFilterChainManager();

			// 清空初始权限配置
			manager.getFilterChains().clear();
			shiroFilterFactoryBean.getFilterChainDefinitionMap().clear();

			// 重新构建生成
			shiroFilterFactoryBean.setFilterChainDefinitionMap(this.loadFilterChainDefinitions());
			Map<String, String> chains = shiroFilterFactoryBean.getFilterChainDefinitionMap();
			for (Map.Entry<String, String> entry : chains.entrySet()) {
				String url = entry.getKey();
				String chainDefinition = entry.getValue().trim().replace(" ", "");
				manager.createChain(url, chainDefinition);
			}
			logger.info("update shiro permission succeed...");
		}
	}

	@Override
	public abstract Map<String, String> initOtherFilterChains();

	public String getDefinitions() {
		return definitions;
	}

	public void setDefinitions(String definitions) {
		this.definitions = definitions;
	}

}