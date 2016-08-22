package com.base.util.bean;
/**
 * Map he Bean 互相转换
* @ClassName: BeanCopyMapUtil 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author liu.li
* @date 2016年4月18日 下午1:41:03
 */
public class BeanCopyMapUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(BeanCopyMapUtil.class);

    /**
     * Map<String,Object>转为Bean
     * Map --> Bean 1: 利用Introspector,PropertyDescriptor实现 Map --> Bean 
    * @Title: transMapToBean 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param map Map参数
    * @param obj Bean对象
    * @throws
     */
    public static void transMapToBean(Map<String, Object> map, Object obj){

        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass()); //获取Bean的信息
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors(); //获取属性

            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName(); 

                if (map.containsKey(key)) { //判断Map中是否存在该Key
                    Object value = map.get(key);
                    if (null != value
                            && !StringUtils.isBlank(value.toString())) {
                    // 得到property对应的setter方法
                    Method setter = property.getWriteMethod(); //获取该属性对应的set方法
                    if (property.getPropertyType().toString()
                            .equals("class java.lang.String")) { // 首先判断String
                        setter.invoke(obj, value);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                                .equals("class java.lang.Integer")) { // Integer类型
                        Integer val = Integer.parseInt(value.toString());
                        setter.invoke(obj, val);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                            .equals("class java.math.BigDecimal")) {// BigDecimal类型
                        BigDecimal bd = new BigDecimal(value.toString());
                        setter.invoke(obj, bd);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                            .equals("class java.lang.Boolean")) {// Boolean值
                        Boolean bln = new Boolean(value.toString());
                        setter.invoke(obj, bln);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                            .equals("class java.lang.Double")) {// Double类型
                        Double d = new Double(value.toString());
                        setter.invoke(obj, d);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                            .equals("class java.util.Date")) {// Date类型
                            SimpleDateFormat sdf = new SimpleDateFormat(
                                    " yyyy-MM-dd HH:mm:ss ");
                            Date date = sdf.parse(value.toString());
                            setter.invoke(obj, date);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                            .equals("class java.lang.Short")) {// short类型
                        Short val = new Short(value.toString());
                        setter.invoke(obj, val);// 调用set方法赋值
                    } else if (property.getPropertyType().toString()
                            .equals("class java.lang.Long")) {
                        Long val = new Long(value.toString());
                        setter.invoke(obj, val);// 调用set方法赋值
                    } else {
                        setter.invoke(obj, value);// 调用set方法赋值
                    }
                }
                }
            }

        } catch (Exception e) {
           LOGGER.error("map to bean转换异常", e);
        }

    }

    /**
     * Bean对象转换为Map<String,Object>
     * Bean --> Map 1: 利用Introspector和PropertyDescriptor 将Bean --> Map
    * @Title: transBeanToMap 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param obj
    * @return
    * @throws Exception
    * @throws
     */
    public static Map<String, Object> transBeanToMap(Object obj){

        if(obj == null){
            return null;
        }        
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass()); //获取Bean信息
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors(); //获取属性
            Map<String, String> annoMap = new HashMap<String, String>();
            Field[] fields = obj.getClass().getDeclaredFields(); // 获取类的字段
            for (Field field : fields) { // 获取类中字段上有注解的
                if (field.isAnnotationPresent(MapForKey.class)) {
                    MapForKey mfk = field.getAnnotation(MapForKey.class);
                    annoMap.put(field.getName(), mfk.values());// 获取有注解的原始字段和对应的映射字段
                }
            }
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();

                // 过滤class属性
                if (!key.equals("class")) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    Object value = getter.invoke(obj);
                    if (null == annoMap.get(key)) { // 没有注解的字段直接将字段作为Map中的key
                        map.put(key, value);
                    } else {
                        map.put(annoMap.get(key), value);// 有注解的字段使用注解上配置的值作为key
                    }

                }

            }
        } catch (Exception e) {
             LOGGER.error("bean to map转换异常", e);
            
        }

        return map;

    }

}
