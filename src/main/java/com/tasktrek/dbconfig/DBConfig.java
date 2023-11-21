package com.tasktrek.dbconfig;

import java.io.InputStream;
import java.util.Properties;

public class DBConfig {
    private static Properties properties = new Properties();

    static {
        try {
            InputStream inputStream = DBConfig.class.getClassLoader().getResourceAsStream("database.properties");
            properties.load(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getDbUrl() {
        return properties.getProperty("DB_URL");
    }

    public static String getUsername() {
        return properties.getProperty("USERNAME");
    }

    public static String getPassword() {
        return properties.getProperty("PASSWORD");
    }
}
