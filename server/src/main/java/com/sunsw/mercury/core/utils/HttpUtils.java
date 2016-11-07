package com.sunsw.mercury.core.utils;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis.encoding.XMLType;
import org.apache.commons.collections.map.HashedMap;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import javax.xml.namespace.QName;
import javax.xml.rpc.ParameterMode;
import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 用于处理http请求
 *
 * @author sunsw 2016/4/1
 */
public class HttpUtils {

	private static Logger logger = Logger.getLogger(HttpUtils.class);

	/**
	 * 用于发送get或post请求并返回请求结果
	 *
	 * @param url        请求地址 不能为null
	 * @param map        请求参数 可为null
	 * @param info       post其他参数
	 * @param auName     请求用户名 可为null
	 * @param auPassword 请求密码 可为null
	 * @param method     请求方法 get或post，默认get
	 * @return 请求结果
	 */
	public static String send(String url, Map<String, String> map, String info, String auName, String auPassword, String method) {
		if (StringUtils.isEmpty(url)) {
			logger.error("url不能为空！");
			return null;
		}
		if (StringUtils.isEmpty(method)) {
			method = "get";
		}

		String result = null;
		CloseableHttpResponse response = null;
		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpClientContext context = HttpClientContext.create();

		URI uri = URI.create(url);
		HttpHost host = new HttpHost(uri.getHost(), uri.getPort(), uri.getScheme());

		//用户名和密码都不为null时需要请求验证
		if (auName != null && auPassword != null) {
			//认证提供者
			CredentialsProvider credsProvider = new BasicCredentialsProvider();
			UsernamePasswordCredentials credentials = new UsernamePasswordCredentials(auName, auPassword);
			credsProvider.setCredentials(new AuthScope(host.getHostName(), AuthScope.ANY_PORT), credentials);
			//缓存
			AuthCache authCache = new BasicAuthCache();
			authCache.put(host, new BasicScheme());
			//提前填充认证信息缓存到上下文中，以这个上下文执行的方法，就会使用抢先认证。
			context.setAuthCache(authCache);
			context.setCredentialsProvider(credsProvider);
		}

		//参数
		List<NameValuePair> params = new ArrayList<>();
		if (map != null && !map.isEmpty()) {
			for (Map.Entry<String, String> entry : map.entrySet()) {
				params.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
			}
		}

		try {
			if (method.equalsIgnoreCase("get")) {
				String queryString = URLEncodedUtils.format(params, Consts.UTF_8);
				HttpGet get = new HttpGet(uri.getPath() + "?" + (uri.getQuery() == null ? "" : uri.getQuery()) + "&" + queryString);
				response = httpclient.execute(host, get, context);
			} else if (method.equalsIgnoreCase("post")) {
				HttpPost post = new HttpPost(uri.getPath() + "?" + (uri.getQuery() == null ? "" : uri.getQuery()));
				if (!params.isEmpty()) {
					post.setEntity(new UrlEncodedFormEntity(params, Consts.UTF_8));
				} else if (!StringUtils.isEmpty(info)) {
					post.setEntity(new StringEntity(info, Consts.UTF_8));
				}
				response = httpclient.execute(host, post, context);
			} else {
				logger.error("method必须为get或post！");
				return null;
			}
			//if (response.getStatusLine().getStatusCode() == 200) {
			HttpEntity entity = response.getEntity();
			result = EntityUtils.toString(entity, Consts.UTF_8);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		} finally {
			try {
				response.close();
			} catch (IOException e) {
				logger.error(e.getLocalizedMessage());
			}
		}
		return result;
	}

	public static String doGet(String url, Map<String, String> params, String auName, String auPassword) throws Exception {
		return HttpUtils.send(url, params, null, auName, auPassword, "get");
	}

	public static String doGet(String url, String auName, String auPassword) throws Exception {
		return HttpUtils.send(url, null, null, auName, auPassword, "get");
	}

	public static String doGet(String url, Map<String, String> params) throws Exception {
		return HttpUtils.send(url, params, null, null, null, "get");
	}

	public static String doGet(String url) throws Exception {
		return HttpUtils.send(url, null, null, null, null, "get");
	}

	public static String doPost(String url, Map<String, String> params, String auName, String auPassword) throws Exception {
		return HttpUtils.send(url, params, null, auName, auPassword, "post");
	}

	public static String doPost(String url, String auName, String auPassword) throws Exception {
		return HttpUtils.send(url, null, null, auName, auPassword, "post");
	}

	public static String doPost(String url, Map<String, String> params) throws Exception {
		return HttpUtils.send(url, params, null, null, null, "post");
	}

	public static String doPost(String url) throws Exception {
		return HttpUtils.send(url, null, null, null, null, "post");
	}

	public static String doPost(String url, String info, String auName, String auPassword) throws Exception {
		return HttpUtils.send(url, null, info, auName, auPassword, "post");
	}

	public static String doPost(String url, String info) throws Exception {
		return HttpUtils.send(url, null, info, null, null, "post");
	}

	/**
	 * wsdl调用
	 *
	 * @param namespace 命名空间
	 * @param endpoint  远程调用路径
	 * @param method    调用的方法名
	 * @param params    参数
	 * @return
	 */
	public static String invokeWsdl(String namespace, String endpoint, String method, Map<String, Object> params) {
		if (StringUtils.isEmpty(endpoint)) {
			logger.error("endpoint不能为空！");
			return null;
		}
		if (StringUtils.isEmpty(method)) {
			logger.error("method不能为空！");
			return null;
		}
		if (StringUtils.isEmpty(namespace)) {
			namespace = "http://tempuri.org/";
		}

		String result = null;
		Service service = new Service();
		try {
			Call call = (Call) service.createCall();
			call.setTargetEndpointAddress(endpoint);// 远程调用路径
			call.setOperationName(new QName(namespace, method));// 调用的方法名

			Object[] object = new Object[params.size()];
			if (params != null && !params.isEmpty()) {
				int i = 0;
				for (Map.Entry<String, Object> entry : params.entrySet()) {
					// 设置参数名:参数名、参数类型:String、参数模式：'IN' or 'OUT'
					call.addParameter(new QName(namespace, entry.getKey()), XMLType.XSD_STRING, ParameterMode.IN);
					object[i++] = entry.getValue();//Object是用来存储方法的参数
				}
			}
			call.setReturnType(XMLType.XSD_STRING);// 设置返回值类型：String
			call.setUseSOAPAction(true);
			call.setSOAPActionURI(namespace + method);
			result = (String) call.invoke(object);// 远程调用
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage());
		}
		return result;
	}

	public static void main(String[] args) {
		String namespace = "http://WebXml.com.cn/";
		String endpoint = "http://www.webxml.com.cn/webservices/qqOnlineWebService.asmx?wsdl";
		String method = "qqCheckOnline";
		Map<String, Object> params = new HashedMap();
		params.put("qqCode", "756535761");
		String res = HttpUtils.invokeWsdl(namespace, endpoint, method, params);
		System.out.println(res);
	}

}
