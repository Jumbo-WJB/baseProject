package com.base.util.excel;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Collection;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.base.util.stringutil.StringUtils;

/**
 * 
* @ClassName: ExcelUtilByPoi 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author liu.li 
* @date 2016年4月20日 上午9:07:21 
* @param <T> List集合的中FormBean
 */
public class ExcelUtilByPoi<T> {
    private static Logger logger = Logger.getLogger(ExcelUtilByPoi.class);
    public static final String xls = "xls"; // xls格式后缀
    public static final String xlsx = "xlsx"; // xlsx格式后缀

    /**
     * generateWorkbook:将传入的数据生成Excel，供页面面下载使用==默认文件名为:文件.xls格式
    * @Title: generateWorkbook 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param wfList List集合
    * @param sheetName sheet页的名称
    * @param columnArray Excel列中文名称
    * @param keyArray 集合中的Bean对应的各个字段,需要和columnArray数组的个数和顺序保持一致
    * @param fileName 文件名
    * @throws IOException 
     * @throws IntrospectionException 
     * @throws InvocationTargetException 
     * @throws IllegalArgumentException 
     * @throws IllegalAccessException 
    * @return
    * @throws
     */
    public void generateWorkbook(Collection<T> wfList, String sheetName,
            String[] columnArray, String[] keyArray, String fileName,
            HttpServletResponse response) {
        String tempfileName = fileName + "." + xls;
        if (wfList != null) {

            Workbook workbook;
            try {
                workbook = this.resultSetToExcel(wfList, sheetName, columnArray,
                        keyArray, tempfileName);
                this.write(workbook, response, tempfileName);
            } catch (IllegalAccessException e) {
                logger.error(e);
            } catch (IllegalArgumentException e) {
                logger.error(e);
            } catch (InvocationTargetException e) {
                logger.error(e);
            } catch (IntrospectionException e) {
                logger.error(e);
            } catch (IOException e) {
                logger.error(e);
            }

        }

    }

    /**
     * generateWorkbook:将传入的数据生成Excel，供页面面下载使用,该方法可以自己定义文件后缀
    * @Title: generateWorkbook 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param wfList List集合
    * @param sheetName sheet页的名称
    * @param columnArray Excel列中文名称
    * @param keyArray 集合中的Bean对应的各个字段,需要和columnArray数组的个数和顺序保持一致
    * @param fileName 文件名
    * @param response
    * @param suffix 文件后缀：请使用 ExcelUtilByPoi.xlsx
    * @throws IOException 
     * @throws IntrospectionException 
     * @throws InvocationTargetException 
     * @throws IllegalArgumentException 
     * @throws IllegalAccessException 
     */
    public void generateWorkbook(Collection<T> wfList, String sheetName,
            String[] columnArray, String[] keyArray, String fileName,
            HttpServletResponse response, String suffix) {
        String tempfileName = fileName + "." + suffix;
        if (wfList != null) {

            Workbook workbook;
            try {
                workbook = this.resultSetToExcel(wfList, sheetName, columnArray,
                        keyArray, tempfileName);
                this.write(workbook, response, tempfileName);
            } catch (IllegalAccessException e) {
                logger.error(e);
            } catch (IllegalArgumentException e) {
                logger.error(e);
            } catch (InvocationTargetException e) {
                logger.error(e);
            } catch (IntrospectionException e) {
                logger.error(e);
            } catch (IOException e) {
                logger.error(e);
            }

        }

    }

    /**
     * 生成Excel文件
    * @Title: resultSetToExcel 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param objectList 集合
    * @param sheetName sheet名称
    * @param columnArray 中文列
    * @param keyArray 对应的Bean中的字段
    * @return
    * @throws IntrospectionException 
     * @throws InvocationTargetException 
     * @throws IllegalArgumentException 
     * @throws IllegalAccessException 
    * @throws
     */
    public Workbook resultSetToExcel(Collection<T> objectList,
            String sheetName,
            String[] columnArray, String[] keyArray, String fileName)
                    throws IllegalAccessException, IllegalArgumentException,
                    InvocationTargetException, IntrospectionException {

        int nColumn = columnArray.length;// 取得数据的列数
        String end = null;
        if (StringUtils.isNotBlank(fileName)) {
            String[] split = fileName.split("\\.");
            end = split[1];
        }
        Workbook workbook = null;
        if (end.equals(xls)) {
            workbook = new HSSFWorkbook();
        } else if (end.equals(xlsx)) {
            workbook = new XSSFWorkbook();
        } else {
            logger.info("您输入的excel格式不正确");
        }
        Sheet sheet = workbook.createSheet(sheetName);
        sheet.setVerticallyCenter(true);

        Row row = sheet.createRow((short) 0);
        Cell cell = null;

        // 设置表头字体
        Font font = workbook.createFont();
        font.setFontName("黑体");
        font.setFontHeightInPoints((short) 14);// 设置字体大小

        // 设置表头样式
        CellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        // 设置内容样式
        CellStyle cellStyleContent = workbook.createCellStyle();
        cellStyleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        for (int i = 1; i <= nColumn; i++) {
            cell = row.createCell(i - 1);
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
            String value = columnArray[i - 1];
            cell.setCellValue(columnArray[i - 1]);
            cell.setCellStyle(cellStyle);
            sheet.setColumnWidth(i - 1, (value.length() * 2) * 512); // 设置列宽
                                                                     // 根据字符串长度进行计算列宽。
        }

        int iRow = 1;
        // 写入各条记录，每条记录对应Excel中的一行
        if (objectList != null) {
            for (T t : objectList) {
                row = sheet.createRow((short) iRow);
                BeanInfo beanInfo = Introspector.getBeanInfo(t.getClass());
                // 获取Bean信息
                PropertyDescriptor[] propertyDescriptors = beanInfo
                        .getPropertyDescriptors(); // 获取属性
                for (int j = 0; j < keyArray.length; j++) {
                    cell = row.createCell(j);
                    cell.setCellStyle(cellStyleContent);
                    for (short i = 0; i < propertyDescriptors.length; i++) {
                        String key = propertyDescriptors[i].getName(); // 获取属性字段
                        if (keyArray[j].equals(key)) {
                            Method getter = propertyDescriptors[i]
                                    .getReadMethod();
                            Object value = getter.invoke(t);
                            // 下面的处理取代该行代码
                            // Excel中字段的类型取Bean中对应的类型 begin
                            if (propertyDescriptors[i].getPropertyType()
                                    .toString()
                                    .equals("class java.lang.String")) {
                                cell.setCellValue(value.toString());
                            } else if (propertyDescriptors[i].getPropertyType()
                                    .toString()
                                    .equals("class java.lang.Integer")) {
                                Integer val = Integer
                                        .parseInt(value.toString());
                                cell.setCellValue(val);
                            } else if (propertyDescriptors[i].getPropertyType()
                                    .toString()
                                    .equals("class java.math.BigDecimal")) {
                                BigDecimal bd = new BigDecimal(
                                        value.toString());
                                cell.setCellValue(bd.doubleValue());
                            } else if (propertyDescriptors[i].getPropertyType()
                                    .toString()
                                    .equals("class java.lang.Boolean")) {
                                Boolean bln = new Boolean(value.toString());
                                cell.setCellValue(bln);
                            } else {
                                cell.setCellValue(value.toString());
                            }
                            // end
                        }
                    }
                }
                iRow++;
            }
        }
        return workbook;
    }

    /**
     * 输出文件
    * @Title: write 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param workbook
    * @param response
    * @param fileName
    * @throws IOException 
     * @throws UnsupportedEncodingException 
     */
    public void write(Workbook workbook, HttpServletResponse response,
            String fileName) throws IOException {

            response.setContentType("application/ms-excel");
            response.setCharacterEncoding("utf-8");
            response.setHeader("Content-Disposition", "filename="
                    + new String(fileName.getBytes("utf-8"), "iso8859-1"));
            OutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.flush();
            outputStream.close();
    }
    }
