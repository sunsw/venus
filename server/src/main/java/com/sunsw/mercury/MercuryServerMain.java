package com.sunsw.mercury;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

/**
 * Created by sunsw on 2016/4/1.
 */
public class MercuryServerMain {
	private static Logger logger = LoggerFactory.getLogger(MercuryServerMain.class);

	public static void main(String[] args) throws IOException {
		ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"/applicationContext.xml"});
		logger.info("Sunsw-Mercury service start...");
		context.start();
		logger.info("Sunsw-Mercury service start success");
		System.in.read();
	}
}
