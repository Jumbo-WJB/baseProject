
import java.util.List;
import java.util.Map;

/**
 * 文件导入的模板
* @ClassName: ExcelModel 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author liu.li 
* @date 2016年4月27日 下午5:08:39
 */
public class ExcelModel {
    ExcelModel() {
    }

    public ExcelModel(String fileName) {
        this.fileName = fileName;
    }

    // Excel的文件名
    private String fileName;
    // Sheet页的名
    private List<String> sheetName;
    // 每个sheet页的起始行
    private Map<String, Integer> startRowNum;
    // 每个sheet页对应的列的字段
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
