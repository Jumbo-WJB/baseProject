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
 * ���ķ�����
 * 
 * @author nibili 2015��5��14��
 * 
 */
public class RedisMessageListenerService {
   


    public void handleMessage(Serializable message) {
        // ʲô������,ֻ���
        if (message == null) {
            System.out.println("�յ�����Ϣ1��"+"null");
        } else if (message.getClass().isArray()) {
            System.out.println("�յ�����Ϣ2��"+Arrays.toString((Object[]) message));
        } else if (message instanceof List<?>) {
            System.out.println("�յ�����Ϣ3��"+message);
        } else if (message instanceof Map<?, ?>) {
            System.out.println("�յ�����Ϣ4��"+message);
        } else {
             System.out.println("�յ�����Ϣ5��"+message.toString());
    }
    }
    public void handleMessagejava(Serializable message) {
        // ʲô������,ֻ���
        if (message == null) {
            System.out.println("T�յ�����Ϣ1��"+"null");
        } else if (message.getClass().isArray()) {
            System.out.println("T�յ�����Ϣ2��"+Arrays.toString((Object[]) message));
        } else if (message instanceof List<?>) {
            System.out.println("T�յ�����Ϣ3��"+message);
        } else if (message instanceof Map<?, ?>) {
            System.out.println("T�յ�����Ϣ4��"+message);
        } else {
             System.out.println("T�յ�����Ϣ5��"+message.toString());
    }
    }
}