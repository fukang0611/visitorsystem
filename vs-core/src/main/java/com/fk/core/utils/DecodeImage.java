package com.fk.core.utils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.*;

/**
 * BASE64编码格式JPG图像的编码解码工具类
 * Created by fukang on 2016/1/15 0015.
 */
public class DecodeImage {

    /**
     * 解码图像数据,生成图像
     *
     * @param imgStr   图像数据字符串
     * @param path     图像保存路径
     * @param fileName 图像名称
     * @return 解码结果
     */
    public static boolean GenerateImage(String imgStr, String path, String fileName) {

        if (imgStr == null) {
            return false;
        }
        BASE64Decoder decoder = new BASE64Decoder();
        try {
            byte[] bytes = decoder.decodeBuffer(imgStr);
            for (int i = 0; i < bytes.length; ++i) {
                if (bytes[i] < 0) {//调整异常数据
                    bytes[i] += 256;
                }
            }
            String imgFilePath = path + fileName;
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(bytes);
            out.flush();
            out.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static String GetImageStr(String imgFilePath) {
        InputStream in;
        byte[] data = null;
        try {
            in = new FileInputStream(imgFilePath);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        BASE64Encoder encoder = new BASE64Encoder();
        return encoder.encode(data);
    }
}
