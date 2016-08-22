/**
 * 
 */
/**
 * @author Administrator
 *
 */
package com.base.service;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;


import org.springframework.context.support.ClassPathXmlApplicationContext;


/**
 * 订阅服务类
 * 
 * @author nibili 2015年5月14日
 * 
 */
public class RedisMessageListenerService {
   


    public void handleMessage(Serializable message) {
        // 什么都不做,只输出
        if (message == null) {
            System.out.println("收到的消息1："+"null");
        } else if (message.getClass().isArray()) {
            System.out.println("收到的消息2："+Arrays.toString((Object[]) message));
        } else if (message instanceof List<?>) {
            System.out.println("收到的消息3："+message);
        } else if (message instanceof Map<?, ?>) {
            System.out.println("收到的消息4："+message);
        } else {
             System.out.println("收到的消息5："+message.toString());
    }
    }
    public void handleMessagejava(Serializable message) {
        // 什么都不做,只输出
        if (message == null) {
            System.out.println("T收到的消息1："+"null");
        } else if (message.getClass().isArray()) {
            System.out.println("T收到的消息2："+Arrays.toString((Object[]) message));
        } else if (message instanceof List<?>) {
            System.out.println("T收到的消息3："+message);
        } else if (message instanceof Map<?, ?>) {
            System.out.println("T收到的消息4："+message);
        } else {
             System.out.println("T收到的消息5："+message.toString());
    }
    }
}