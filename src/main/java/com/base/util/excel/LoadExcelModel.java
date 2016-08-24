/**
 * 加载数据库中的模板
* @ClassName: LoadExcelModel 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author liu.li 
* @date 2016年4月28日 上午9:37:53
 */
public class LoadExcelModel {
    /**
     * 根据文件名称去数据库中查询对应的配置信息
    * @Title: queryAllExcelConfig 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @param jdbcTemplate 此处暂时使用jdbcTemplate查询
    * @param fileName
    * @return
    * @throws Exception
    * @throws
     */
    public static Map<String, ExcelModel> queryAllExcelConfig(
            JdbcTemplate jdbcTemplate, String fileName) {
        StringBuffer fileconfig = new StringBuffer();
        fileconfig.append(
                "select t.iautoId as 'iautoId',t.sfileName as 'sfileName',t.ssheetName as 'ssheetName',t.istartRowNum as 'istartRowNum' from t_excel_config t");
        if (StringUtils.isNotEmpty(fileName)) {
            fileconfig.append(" where t.sfileName ='" + fileName + "'");
        }
        List<Map<String, Object>> list = jdbcTemplate
.queryForList(
fileconfig.toString());
        if (list.isEmpty()) {
            return null;
        }
        Map<String, ExcelModel> resMap = new HashMap<String, ExcelModel>();
        ExcelModel em = new ExcelModel(fileName);
        List<String> sheetName = new ArrayList<String>();// sheet页
        Map<String, Integer> startRowNum = new HashMap<String, Integer>();// 起始行
        Map<String, Map<Integer, String>> sheetcolume = new HashMap<String, Map<Integer, String>>();

        for (Map<String, Object> map : list) {
            Map<Integer, String> colume = new HashMap<Integer, String>();
            sheetName.add(map.get("ssheetName").toString()); // sheetname
            startRowNum
                    .put(map.get("ssheetName").toString(),
                            Integer.parseInt(map.get("istartRowNum") == null
                                    ? "0"
                                    : map.get("istartRowNum").toString())); // sheet起始行
            StringBuffer sbf = new StringBuffer();
            sbf.append("SELECT ");
            sbf.append(" te.sfileName AS 'sfileName', ");
            sbf.append(" te.ssheetName as 'ssheetName', ");
            sbf.append(" te.istartRowNum as 'istartRowNum', ");
            sbf.append(" ts.icolumeNum as 'icolumeNum', ");
            sbf.append(" ts.scolume as 'scolume'  ");
            sbf.append(" FROM  ");
            sbf.append(" t_excel_config te,  ");
            sbf.append(" t_excel_sheet_colume ts  ");
            sbf.append(" WHERE  ");
            sbf.append(" te.iautoId = ts.iexcelId  and te.iautoId="
                    + map.get("iautoId"));
            List<Map<String, Object>> filecolume = jdbcTemplate.queryForList(
sbf.toString());

            for (Map<String, Object> fileColumeMap : filecolume) {

                colume.put(
                        Integer.parseInt(
                                fileColumeMap.get("icolumeNum").toString()),
                        fileColumeMap.get("scolume").toString());

            }
            sheetcolume.put(map.get("ssheetName").toString(), colume);
        }
        em.setSheetName(sheetName);
        em.setStartRowNum(startRowNum);
        em.setSheetColumeName(sheetcolume);
        resMap.put(fileName, em);
        return resMap;
    }

    /**
     * 根据文件名称去数据库中查询对应的配置信息
     * 返回单个文件的配置
     * @Title: queryAllExcelConfig 
     * @Description: TODO(这里用一句话描述这个方法的作用) 
     * @param jdbcTemplate 此处暂时使用jdbcTemplate查询
     * @param fileName
     * @return
     * @throws Exception
     * @throws
     */
    public static ExcelModel queryAllExcelConfigBySingleFile(
            JdbcTemplate jdbcTemplate, String fileName) {
        StringBuffer fileconfig = new StringBuffer();
        fileconfig.append(
                "select t.iautoId as 'iautoId',t.sfileName as 'sfileName',t.ssheetName as 'ssheetName',t.istartRowNum as 'istartRowNum' from t_excel_config t");
        if (StringUtils.isNotEmpty(fileName)) {
            fileconfig.append(" where t.sfileName ='" + fileName + "'");
        }
        List<Map<String, Object>> list = jdbcTemplate
                .queryForList(fileconfig.toString());
        if (list.isEmpty()) {
            return null;
        }
        ExcelModel em = new ExcelModel(fileName);
        List<String> sheetName = new ArrayList<String>();// sheet页
        Map<String, Integer> startRowNum = new HashMap<String, Integer>();// 起始行
        Map<String, Map<Integer, String>> sheetcolume = new HashMap<String, Map<Integer, String>>();

        for (Map<String, Object> map : list) {
            Map<Integer, String> colume = new HashMap<Integer, String>();
            sheetName.add(map.get("ssheetName").toString()); // sheetname
            startRowNum
                    .put(map.get("ssheetName").toString(),
                            Integer.parseInt(map.get("istartRowNum") == null
                                    ? "0"
                                    : map.get("istartRowNum").toString())); // sheet起始行
            StringBuffer sbf = new StringBuffer();
            sbf.append("SELECT ");
            sbf.append(" te.sfileName AS 'sfileName', ");
            sbf.append(" te.ssheetName as 'ssheetName', ");
            sbf.append(" te.istartRowNum as 'istartRowNum', ");
            sbf.append(" ts.icolumeNum as 'icolumeNum', ");
            sbf.append(" ts.scolume as 'scolume'  ");
            sbf.append(" FROM  ");
            sbf.append(" t_excel_config te,  ");
            sbf.append(" t_excel_sheet_colume ts  ");
            sbf.append(" WHERE  ");
            sbf.append(" te.iautoId = ts.iexcelId  and te.iautoId="
                    + map.get("iautoId"));
            List<Map<String, Object>> filecolume = jdbcTemplate
                    .queryForList(sbf.toString());

            for (Map<String, Object> fileColumeMap : filecolume) {

                colume.put(
                        Integer.parseInt(
                                fileColumeMap.get("icolumeNum").toString()),
                        fileColumeMap.get("scolume").toString());

            }
            sheetcolume.put(map.get("ssheetName").toString(), colume);
        }
        em.setSheetName(sheetName);
        em.setStartRowNum(startRowNum);
        em.setSheetColumeName(sheetcolume);
        return em;
    }
}
