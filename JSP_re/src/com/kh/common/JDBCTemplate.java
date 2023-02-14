package com.kh.common;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCTemplate {
	
	// 1. Connection 객체 생성한 후 해당 Connection 반환하는 메소드
	// Connection : DB와의 연결 정보를 담고 있는 객체(IP주소, PORT 번호, 계정명, 비밀번호)
	public static Connection getConnection() {
		
		// DB와 연결하고자하는 연결정보
		Properties prop = new Properties();
		
		String fileName = JDBCTemplate.class.getResource("/sql/driver/driver.properties").getPath();
		
		try {
			prop.load(new FileInputStream(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Connection conn = null;
		
		try {
			Class.forName(prop.getProperty("driver"));
			
			conn = DriverManager.getConnection(prop.getProperty("url"),
											   prop.getProperty("username"),
											   prop.getProperty("password"));
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}
