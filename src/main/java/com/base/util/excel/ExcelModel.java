package com.base.util.excel;
import java.util.List;
import java.util.Map;

/**
 * 鏂囦欢瀵煎叆鐨勬ā鏉�* @ClassName: ExcelModel 
* @Description: TODO(杩欓噷鐢ㄤ竴鍙ヨ瘽鎻忚堪杩欎釜绫荤殑浣滅敤) 
* @author liu.li 
* @date 2016骞�鏈�7鏃�涓嬪崍5:08:39
 */
public class ExcelModel {
    ExcelModel() {
    }

    public ExcelModel(String fileName) {
        this.fileName = fileName;
    }

    // Excel鐨勬枃浠跺悕
    private String fileName;
    // Sheet椤电殑鍚�    
    private List<String> sheetName;
    // 姣忎釜sheet椤电殑璧峰琛�   
    private Map<String, Integer> startRowNum;
    // 姣忎釜sheet椤靛搴旂殑鍒楃殑瀛楁
    private Map<String, Map<Integer, String>> sheetColumeName;

    public String getFileName() {
        return fileName;
    }

    public List<String> getSheetName() {
        return sheetName;
    }

    public Map<String, Integer> getStartRowNum() {
        return startRowNum;
    }

    public Map<String, Map<Integer, String>> getSheetColumeName() {
        return sheetColumeName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setSheetName(List<String> sheetName) {
        this.sheetName = sheetName;
    }

    public void setStartRowNum(Map<String, Integer> startRowNum) {
        this.startRowNum = startRowNum;
    }

    public void setSheetColumeName(
            Map<String, Map<Integer, String>> sheetColumeName) {
        this.sheetColumeName = sheetColumeName;
    }
}
