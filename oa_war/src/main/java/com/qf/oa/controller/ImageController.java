package com.qf.oa.controller;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.UUID;

@Controller
@RequestMapping("/img")
public class ImageController {


    @Value("${uploadPath}")
    private String uploadPath;

    @RequestMapping("/upload")
    @ResponseBody
    public String imgUpload(MultipartFile file){

        InputStream is = null;
        OutputStream os = null;
        try {
             is = file.getInputStream();
             String path = uploadPath + "/" + UUID.randomUUID().toString();

             //本地输出流
            os = new FileOutputStream(path);

            //上传
            IOUtils.copy(is,os);
            //相应上传文件的路径
            return "{\"fileuploader\":\"" + path + "\"}";
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (is!=null){
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (os!=null){
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return null;
    }

    @RequestMapping("/getImg")
    public void getImg(String path, HttpServletResponse response){

        InputStream in = null;
        OutputStream out = null;
        try {
            in = new FileInputStream(path);
            out = response.getOutputStream();

            IOUtils.copy(in, out);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(in != null){
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            if(out != null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }
}
