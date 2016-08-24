package com.base.util.generator;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 文件上传
* @ClassName: UploadUtil 
* @author liu.li 
* @date 2016年4月27日 下午2:08:46
 */
public class UploadUtil {
    private static Logger logger = Logger.getLogger(UploadUtil.class);
    private static String FILEPATH = "/system.properties"; // 文件上传的配置文件
    private static String EXCELUPLOADPREFIX = "uploadExcel_";// 上传后存储的文件名称前缀
    private static String DEFAULT_FILEPATH = "D:\\UPLOAD\\";// 上传的路径

    /**
    
     * 文件上传
    * @Title: readUploadFiles 
    * @param request
    * @throws Exception
     * @throws IOException 
     * @throws IllegalStateException 
     * @throws UnsupportedEncodingException 
     */
    public String readUploadFiles(HttpServletRequest request)
            throws IllegalStateException, IOException {
        request.setCharacterEncoding("UTF-8"); // 处理中文乱码问题
        String path = null;
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 记录上传过程起始时的时间，用来计算上传时间
                int pre = (int) System.currentTimeMillis();
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    // 取得当前上传文件的文件名称
                    String fileName = file.getOriginalFilename();
                    // 如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if (fileName.trim() != "") {
                        logger.info("upload file name is " + fileName);
                        // 重命名上传后的文件名
                        String fileNamenew = EXCELUPLOADPREFIX + timeStr()
                                + file.getOriginalFilename();
                        // 定义上传路径
                        path = DEFAULT_FILEPATH
                                + fileNamenew;
                        logger.info("upload file path is" + path);
                        File localFile = new File(path);
                        file.transferTo(localFile);
                    }
                }
                // 记录上传该文件后的时间
                int finaltime = (int) System.currentTimeMillis();
                logger.info(
                        "process upload file user time" + (finaltime - pre));
            }

        }
        return path;
    }
    
    /**
    
     * 多文件对应多模板
     * 该方法会调用文件校验的方法，根据模板校验文件名称
    * @Title: readUploadFilesCheckFile 
    * @param request
    * @return Map<String, String> Map<文件名称, 存放路径>
     * @throws IOException 
     * @throws IllegalStateException 
     * @throws UnsupportedEncodingException 
     */
    public Map<String, String> readUploadManyFiles(
HttpServletRequest request)
            throws IllegalStateException, IOException {
        Map<String, String> resMap = new HashMap<String, String>();
        request.setCharacterEncoding("UTF-8"); // 处理中文乱码问题
        String path = null;
        // 创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        // 判断 request 是否有文件上传,即多部分请求
        if (multipartResolver.isMultipart(request)) {
            // 转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            // 取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // 记录上传过程起始时的时间，用来计算上传时间
                int pre = (int) System.currentTimeMillis();
                // 取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    // 取得当前上传文件的文件名称
                    String fileName = file.getOriginalFilename();
                    /*
                     * // 校验文件名,此处不再校验对于上传，所有的文件都处理 if (null ==
                     * excelModelMap.get(fileName)) { continue; }
                     */
                    // 如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if (fileName.trim() != "") {
                        logger.info("upload file name is " + fileName);
                        // 重命名上传后的文件名
                        String fileNamenew = EXCELUPLOADPREFIX + timeStr()
                                + file.getOriginalFilename();
                        // 定义上传路径
                        path = DEFAULT_FILEPATH + fileNamenew;
                        logger.info("upload file path is" + path);
                        File localFile = new File(path);
                        file.transferTo(localFile);
                        resMap.put(fileName.substring(0,
                                fileName.lastIndexOf(".")), path);
                    }
                }
                // 记录上传该文件后的时间
                int finaltime = (int) System.currentTimeMillis();
                logger.info(
                        "process upload file user time" + (finaltime - pre));
            }

        }
        return resMap;
    }

    /**
     * 采用apache.commons的FileUtils.copyInputStreamToFile方式
    * @Title: fileByteUpload 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param files
    * @return
    * @throws
     */
    public static Map<String, String> fileByteUpload(
MultipartFile[] files,
            HttpServletRequest request) {
        Map<String, String> resMap = new HashMap<String, String>();
        if (files.length > 0) {
            for (MultipartFile multipartFile : files) {
                String path = "";
                if (!multipartFile.isEmpty()) {
                    String fileNamenew = EXCELUPLOADPREFIX
 + timeStr()
                            + multipartFile.getOriginalFilename();
                    path = DEFAULT_FILEPATH + fileNamenew;
                    request.getServletContext().getContextPath();
                    File destFile = new File(DEFAULT_FILEPATH, fileNamenew);
                    try {
                        // FileUtils.copyInputStreamToFile()这个方法里对IO进行了自动操作，不需要额外的再去关闭IO流
                        FileUtils.copyInputStreamToFile(
                                multipartFile.getInputStream(), destFile);// 复制临时文件到指定目录下
                        resMap.put(
                                multipartFile.getOriginalFilename().substring(0,
                                        multipartFile.getOriginalFilename()
                                                .lastIndexOf(".")),
                                path);
                    } catch (IOException e) {
                        logger.error("上传文件异常：-->" + e);
                    }
                }
            }
        }
        return resMap;
    }

    /**
     * 时间获取到毫秒
    * @Title: timeStr 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @return
    * @throws
     */
    public static String timeStr() {
        Calendar c = Calendar.getInstance();// 可以对每个时间域单独修改
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int date = c.get(Calendar.DATE);
        int hour = c.get(Calendar.HOUR_OF_DAY);
        int minute = c.get(Calendar.MINUTE);
        int second = c.get(Calendar.SECOND);
        int MI = c.get(Calendar.MILLISECOND);
        String timestr = year + "" + month + "" + date + "" + hour + "" + minute
                + "" + second + "" + MI;
        return timestr;
    }
}
