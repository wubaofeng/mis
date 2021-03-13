package me.wbf.mis.util;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConverter implements Converter<String, Date> {
    @Override
    public Date convert(String str) {
        //创建一个时间格式类型的字符串
        String param;
        if(str.length() > 10){//假设有时分秒
            if(str.indexOf("-") > 0){
                param = "YYYY-MM-dd HH:mm:ss";
            }else{
                param = "YYYY/MM/dd HH:mm:ss";
            }
        }else {
            if(str.indexOf("-") > 0){
                param = "YYYY-MM-dd";
            }else{
                param = "YYYY/MM/dd";
            }
        }
        //创建时间转化类
        SimpleDateFormat sdf = new SimpleDateFormat(param);
        //转化时间
        try {
            Date date = sdf.parse(str);
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
            return new Date();
        }
    }
}
