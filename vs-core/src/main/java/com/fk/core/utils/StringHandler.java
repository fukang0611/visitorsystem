package com.fk.core.utils;

/**
 * 工具类--字符串处理器
 */
public class StringHandler {

    /**
     * 判断字符串是否空或null
     *
     * @param str 待判断字符串
     * @return true:空或null;false:不为空或false
     */
    public boolean isStrNullOrEmpty(String str) {
        return (str == null || str.equals(""));
    }
}
