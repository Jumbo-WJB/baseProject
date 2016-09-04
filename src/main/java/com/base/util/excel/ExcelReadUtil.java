package com.base.util.excel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;

import com.base.util.stringutil.StringUtils;

/**
 * Excel的读取
* @ClassName: ExcelReadUtil 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author liu.li 
* @date 2016年4月27日 下午5:08:53
 */
public class ExcelReadUtil {
    private static Logger logger = Logger.getLogger(ExcelReadUtil.class);
    private static final String EXTENSION_XLS = "xls";
    private static final String EXTENSION_XLSX = "xlsx";

    /***
     * <pre>
     * 取得Workbook对象(xls和xlsx对象不同,不过都是Workbook的实现类)
     *   xls:HSSFWorkbook
     *   xlsx：XSSFWorkbook
     * @param filePath 文件路径
     * @return
     * @throws IOException
     * </pre>
     */
    private static Workbook getWorkbook(String filePath) throws IOException {
        Workbook workbook = null;
        InputStream is = new FileInputStream(filePath);
        if (filePath.endsWith(EXTENSION_XLS)) {
            workbook = new HSSFWorkbook(is);
        } else if (filePath.endsWith(EXTENSION_XLSX)) {
            workbook = new XSSFWorkbook(is);
        }
        // if (null != is) {// 关闭
            is.close();
        // }
        return workbook;
    }

    /**
     * 文件检查
     * @param filePath 文件路径
     * @throws FileNotFoundException
     * @throws FileFormatException
     */
    private static void preReadCheck(String filePath)
            throws FileNotFoundException, FileFormatException {
        // 常规检查
        File file = new File(filePath);
        if (!file.exists()) {
            throw new FileNotFoundException("传入的文件不存在：" + filePath);
        }

        if (!(filePath.endsWith(EXTENSION_XLS)
                || filePath.endsWith(EXTENSION_XLSX))) {
            throw new FileFormatException("传入的文件不是excel");
        }
    }

    /**
     * 读取excel文件内容
     * @param filePath
     * @throws FileNotFoundException
     * @throws FileFormatException
     */
    public static List<Map<String, Object>> readExcel(String filePath,
            ExcelModel excelModel) throws IOException, FileNotFoundException,
                    FileFormatException {
        if (null == excelModel) {
            logger.info(filePath + "excelModel为null");
            return null;
        }
        if (StringUtils.isEmpty(filePath)) {
            logger.info("filePath为null");
            return null;
        }
        List<Map<String, Object>> reslist = new ArrayList<Map<String, Object>>();
        // 检查
        try {
            preReadCheck(filePath);
        } catch (FileNotFoundException e1) {
            throw new FileNotFoundException("readExcel-FileNotFound");
        } catch (FileFormatException e1) {
            throw new FileFormatException("readExcel-FileFormatException");
        }
        // 获取workbook对象
        Workbook workbook = null;

        try {
            workbook = getWorkbook(filePath);
            // 读文件 一个sheet一个sheet地读取
            for (int numSheet = 0; numSheet < workbook
                    .getNumberOfSheets(); numSheet++) {
                Sheet sheet = workbook.getSheetAt(numSheet);
                if (sheet == null || null == excelModel
                        .getStartRowNum()
                        .get(sheet.getSheetName())) {
                    logger.info("sheet页不存在模板配置中");
                    continue;
                }
                logger.info("sheet name is" + sheet.getSheetName());
                // int firstRowIndex = sheet.getFirstRowNum(); // sheet的第一行
                int lastRowIndex = sheet.getLastRowNum(); // sheet的最后一行

                /*
                 * // 读取首行 即,表头 Row firstRow = sheet.getRow(firstRowIndex); for
                 * (int i = firstRow.getFirstCellNum(); i <= firstRow
                 * .getLastCellNum(); i++) { Cell cell = firstRow.getCell(i); //
                 * String cellValue = getCellValue(cell, true); }
                 */
                int startRowIndex = excelModel.getStartRowNum()
                        .get(sheet.getSheetName()); // 获取当前sheet页的起始行
                Map<Integer, String> sheetColume = excelModel
                        .getSheetColumeName().get(sheet.getSheetName()); // 获取当前sheet页的列配置信息
                // 读取数据行
                for (int rowIndex = startRowIndex; rowIndex <= lastRowIndex; rowIndex++) {
                    Map<String,Object> rowMap=new HashMap<String,Object>();
                    Row currentRow = sheet.getRow(rowIndex);// 当前行
                    int firstColumnIndex = currentRow.getFirstCellNum(); // 首列
                    int lastColumnIndex = currentRow.getLastCellNum();// 最后一列
                    for (int columnIndex = firstColumnIndex; columnIndex <= lastColumnIndex; columnIndex++) {
                        Cell currentCell = currentRow.getCell(columnIndex);// 当前单元格
                        try {
                        String currentCellValue = getCellValue(currentCell,
                                true);// 当前单元格的值
                        rowMap.put(sheetColume.get(columnIndex),
                                currentCellValue);
                        } catch (Exception e) {
                            logger.info("Sheet页" + sheetColume.get(columnIndex)
                                    + "第" + rowIndex + "行" + "第" + columnIndex
                                    + "列,读取异常", e);
                        }
                    }
                    reslist.add(rowMap);
                }
            }
        } catch (IOException e) {
            throw new IOException("读取文件异常" + e);
        } finally {
            if (workbook != null) {
                workbook = null;
            }
        }
        return reslist;
    }

    /**
     * 取单元格的值
     * @param cell 单元格对象
     * @param treatAsStr 为true时，当做文本来取值 (取到的是文本，不会把“1”取成“1.0”)
     * @return
     */
    private static String getCellValue(Cell cell, boolean treatAsStr) {
        if (cell == null) {
            return "";
        }

        if (treatAsStr) {
            // 虽然excel中设置的都是文本，但是数字文本还被读错，如“1”取成“1.0”
            // 加上下面这句，临时把它当做文本来读取
            cell.setCellType(Cell.CELL_TYPE_STRING);
        }

        if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
            return String.valueOf(cell.getBooleanCellValue());
        } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
            return String.valueOf(cell.getNumericCellValue());
        } else {
            return String.valueOf(cell.getStringCellValue());
        }
    }

    /**
     * 读取多sheet页文件的情况
     * @param filePath
     * @throws IOException 
     * @throws FileNotFoundException
     * @throws FileFormatException
     */
    public static Map<String, List<Map<String, Object>>> readExcelMoreSheet(
            String filePath,
 ExcelModel excelModel) throws IOException {
        if (null == excelModel) {
            logger.info(filePath + "excelModel为null");
            return null;
        }
        if (StringUtils.isEmpty(filePath)) {
            logger.info("filePath为null");
            return null;
        }
        Map<String, List<Map<String, Object>>> totalMap = new HashMap<String, List<Map<String, Object>>>();

        // 检查
        preReadCheck(filePath);
        // 获取workbook对象
        Workbook workbook = null;

        try {
            workbook = getWorkbook(filePath);
            // 读文件 一个sheet一个sheet地读取
            for (int numSheet = 0; numSheet < workbook
                    .getNumberOfSheets(); numSheet++) {
                List<Map<String, Object>> reslist = new ArrayList<Map<String, Object>>();
                Sheet sheet = workbook.getSheetAt(numSheet);
                if (sheet == null) {
                    logger.info("sheet为null");
                    continue;
                }
                if (null == excelModel.getStartRowNum()
                        .get(sheet.getSheetName())) {// 如果模板中不存在该配置直接跳过该sheet页
                    logger.info("sheet页" + sheet.getSheetName() + "不存在模板配置中");
                    continue;
                }
                logger.info("sheet name is" + sheet.getSheetName());
                // int firstRowIndex = sheet.getFirstRowNum(); // sheet的第一行
                int lastRowIndex = sheet.getLastRowNum(); // sheet的最后一行

                /*
                 * // 读取首行 即,表头 Row firstRow = sheet.getRow(firstRowIndex); for
                 * (int i = firstRow.getFirstCellNum(); i <= firstRow
                 * .getLastCellNum(); i++) { Cell cell = firstRow.getCell(i); //
                 * String cellValue = getCellValue(cell, true); }
                 */
                int startRowIndex = excelModel.getStartRowNum()
                        .get(sheet.getSheetName()); // 获取当前sheet页的起始行
                Map<Integer, String> sheetColume = excelModel
                        .getSheetColumeName().get(sheet.getSheetName()); // 获取当前sheet页的列配置信息
                // 读取数据行
                for (int rowIndex = startRowIndex; rowIndex <= lastRowIndex; rowIndex++) {
                    Map<String, Object> rowMap = new HashMap<String, Object>();
                    Row currentRow = sheet.getRow(rowIndex);// 当前行
                    int firstColumnIndex = currentRow.getFirstCellNum(); // 首列
                    int lastColumnIndex = currentRow.getLastCellNum();// 最后一列
                    for (int columnIndex = firstColumnIndex; columnIndex <= lastColumnIndex; columnIndex++) {
                        Cell currentCell = currentRow.getCell(columnIndex);// 当前单元格
                        try {
                        String currentCellValue = getCellValue(currentCell,
                                true);// 当前单元格的值
                        rowMap.put(sheetColume.get(columnIndex),
                                currentCellValue);
                        } catch (Exception e) {
                            logger.info("Sheet页" + sheetColume.get(columnIndex)
                                    + "第" + rowIndex + "行" + "第" + columnIndex
                                    + "列,读取异常", e);
                        }

                    }
                    reslist.add(rowMap);
                }
                totalMap.put(sheet.getSheetName(), reslist);
            }
        } catch (IOException e) {
            throw new IOException("读取文件异常" + e);
        } finally {
            if (workbook != null) {
                workbook = null;
            }
        }
        return totalMap;
    }
}
