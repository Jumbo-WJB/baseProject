public class WithdrawalsControllerTest extends BaseMockMvcTest {

    /**
     * 实例化日志记录器
     */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(WithdrawalsControllerTest.class);

    /**
     * 
    * @Title: testQueryWithdrawals 
    * @Description: 测试WithdrawalsController的queryWithdrawals的请求访问
    *             执行耗时：761毫秒
    * @throws Exception
    * @throws
     */
    @Test
    public void testQueryWithdrawals() throws Exception {
        long begin_time = System.currentTimeMillis();
        String result = mockMvc
                .perform(get("/withdraw/ajax/query")
                        .param("startDate", "2016-04-03")
                        .param("endDate", "2016-04-14"))
                .andExpect(status().isOk()) // 请求成功
                .andReturn().getResponse().getContentAsString();
        WithdrawalsForm wf = new WithdrawalsForm();
        wf.setPageUtil(new PageUtils<WithDrawEntity, WitdrawalsConstants>());
        wf = (WithdrawalsForm) JSONHelper.jsonToObject(result,
                WithdrawalsForm.class);

        Assert.assertEquals(new BigDecimal(1255), wf.getTotalAccmount());// 比较提现总金额
        Assert.assertEquals(10, wf.getPageUtil().getPageSize());
        Assert.assertEquals(10, wf.getPageUtil().getTotal());
        Assert.assertEquals(10, wf.getPageUtil().getSize());
        Assert.assertEquals(1, wf.getPageUtil().getPageNum());
        Assert.assertEquals(1, wf.getPageUtil().getPages());
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     * 
    * @Title: testQueryWitdrawalsDetail 
    * @Description: 测试WithdrawalsController的queryWitdrawalsDetail的请求访问
    * @throws UnsupportedEncodingException
    * @throws Exception
    *           耗时：531毫秒
    * @throws
     */
    @Test
    public void testQueryWitdrawalsDetail()
            throws UnsupportedEncodingException, Exception {
        long begin_time = System.currentTimeMillis();
        String result = mockMvc
                .perform(get("/withdraw/ajax/query_detail")
                        .param("serialNumber", "213"))
                .andExpect(status().isOk()) // 请求成功
                .andReturn().getResponse().getContentAsString();
        WithdrawalsDetailForm wdf = (WithdrawalsDetailForm) JSONHelper
                .jsonToObject(result, WithdrawalsDetailForm.class);
        Assert.assertEquals(1.21d, wdf.getWithdrawAmount());// 比较提现总金额
        Assert.assertEquals(213, (int) wdf.getSerialNumber());// 比较提现总金额
        
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }
    /**
     * 查询方法
    * @Title: testselectAll 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @throws IOException
    * @throws
     */
    @Test
    public void testselectAll() throws IOException {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setMethod("POST");
        ModelAndView mav = presentAudit.selectAll(new PresentAuditForm());
        @SuppressWarnings("unchecked")
        List<PresentAuditForm> resList = (List<PresentAuditForm>) mav
                .getModelMap().get("listForm");
        Assert.assertTrue(resList.size() > 0);
        LOGGER.info(mav.toString());
    }

    /***
    * 测试文件下载
    * @Title: testDownloadExcel 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @throws Exception
    * @throws
    */
    @Test
    public void testDownloadExcel() throws Exception {
        long begin_time = System.currentTimeMillis();
        MvcResult result = mockMvc
                .perform(
get("/presentAudit/downexcel"))
                .andExpect(content()
                        .contentType(new MediaType("application", "ms-excel"))) // 验证响应contentType
                // .andExpect(content().bytes("1".getBytes()))
                .andExpect(status().isOk()) // 请求成功
                // .andDo(print())
                .andReturn();
        MockHttpServletResponse response = result.getResponse();
        response.setContentType("application/ms-excel");
        response.setCharacterEncoding("utf-8");
        String filename = new String(
                response.getHeader("Content-Disposition").getBytes("iso8859-1"),
                "utf-8").substring(9);
        LOGGER.info("文件：" + filename);
        byte[] bytes = response.getContentAsByteArray();
        File file = new File(new File("d:\\"), filename);
        FileOutputStream out;
        try {
            out = new FileOutputStream(file);
            out.write(bytes);
            out.flush();
            out.close();
        } catch (Exception e) {
            LOGGER.error("导出excel文件异常：" + e);
        }
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     *测试多文件上传
    * @Title: testUploadExcel 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @throws Exception
    * @throws
     */
    @Test
    public void testUploadExcel() throws Exception {
        long begin_time = System.currentTimeMillis();
        byte[] content = FileUtils
.readFileToByteArray(
new File("d:\\sss好的 - 副本 (2).xlsx"));
        MockMultipartFile file = new MockMultipartFile("file",
                "sss好的 - 副本 (2).xlsx",
                "application/ms-excel", content);
        byte[] content1 = FileUtils
                .readFileToByteArray(new File("d:\\sss好的 - 副本.xlsx"));
        MockMultipartFile file1 = new MockMultipartFile("file",
                "sss好的 - 副本.xlsx", "application/ms-excel", content1);
        byte[] content2 = FileUtils
                .readFileToByteArray(new File("d:\\sss好的.xlsx"));
        MockMultipartFile file2 = new MockMultipartFile("file",
                "sss好的.xlsx", "application/ms-excel", content2);
        mockMvc.perform(
                fileUpload("/presentAudit/upload").file(file).file(file1)
                        .file(file2).contentType(MediaType.MULTIPART_FORM_DATA))
                // .andExpect(content().contentType(new
                // MediaType("application","ms-excel"))) //验证响应contentType
                .andExpect(status().isOk()) // 请求成功
                .andDo(print()).andReturn();
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }
     @Test
    public void testReadFile(){
        try {
        String[] keyArray = { "iAutoId", "iAmount", "iDataTime",
                "iAuditStatus" };
        ExcelModel em = new ExcelModel("sss好的");
        List<String> sheetName = new ArrayList<String>();// sheet页
        sheetName.add("小额提现申请记录");
        em.setSheetName(sheetName);
        Map<String, Integer> startRowNum = new HashMap<String, Integer>();// 起始行
        startRowNum.put("小额提现申请记录", 1);
        em.setStartRowNum(startRowNum);
        Map<String, Map<Integer, String>> sheetcolume = new HashMap<String, Map<Integer, String>>();
        Map<Integer, String> colume = new HashMap<Integer, String>();
        for (int i = 0; i < keyArray.length; i++) {
            colume.put(i, keyArray[i]);
        }
        sheetcolume.put("小额提现申请记录", colume);
        em.setSheetColumeName(sheetcolume);
            String path = "D://sss好的.xlsx";
        List<Map<String, Object>> excellist = ExcelReadUtil.readExcel(path,
                em);// 去读存在本地的文件
        List<PresentAuditEntity> lastlist = new ArrayList<PresentAuditEntity>();
            for (Map<String, Object> map : excellist) {// 取List中的Map
                LOGGER.info("iAutoId:" + map.get("iAutoId") + "|iAmount："
                        + map.get("iAmount") + "|iDataTime："
                        + map.get("iDataTime") + "|iAuditStatus："
                        + map.get("iAuditStatus"));
                /*
                 * PresentAuditEntity pae = new PresentAuditEntity();
                 * BeanCopyMapUtil.transMapToBean(map, pae);
                 */
                // lastlist.add(pae);
        }
            LOGGER.info("==============List Map end============");
            for (PresentAuditEntity pae : lastlist) {
                LOGGER.info("iAutoId:" + pae.getiAutoId() + "|iAmount:"
                        + pae.getiAmount() + "|iDataTime:" + pae.getiDataTime()
                        + "|iAuditStatus:" + pae.getiAuditStatus());
            }
        } catch (Exception e) {
            LOGGER.error("error", e);
        }
        
    }

    /**
     * 单Sheet页
    * @Title: testLoadMode 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @throws
     */
    @Test
    public void testLoadMode(){
        try {
            String filepath = "D:/sss好的.xlsx";
            String fileName = "sss好的";

            LOGGER.info("去数据库中读取配置信息开始...");
            ExcelModel loadExcelModel = LoadExcelModel
                    .queryAllExcelConfigBySingleFile(jdbcTemplate, fileName);
            LOGGER.info("读取数据库配置信息结束");

            LOGGER.info("读取根据配置读取Excel文件内容开始....");
            List<Map<String, Object>> excellist = ExcelReadUtil
                    .readExcel(filepath, loadExcelModel);// 去读存在本地的文件
            LOGGER.info("读取Excel内容结束");

            LOGGER.info("直接读取List<Map>的内容开始....");
            for (Map<String, Object> map : excellist) {
                StringBuffer sbf = new StringBuffer();
                for (String key : map.keySet()) {
                    if (null != key)
                        sbf.append(key + ":" + map.get(key) + "==");
                }
                LOGGER.info(sbf.toString());
            }
            LOGGER.info("直接读取List<Map>的内容结束");
            LOGGER.info("读取的Excel结果封装为List<Map>，转换成List<Bean>开始");
            List<PresentAuditEntity> lastlist = new ArrayList<PresentAuditEntity>();
            for (Map<String, Object> map : excellist) {
                /*
                 * PresentAuditEntity pae = new PresentAuditEntity();
                 * BeanCopyMapUtil.transMapToBean(map, pae); lastlist.add(pae);
                 */
            }
            LOGGER.info("转换List<Bean>结束");
        } catch (Exception e) {
            LOGGER.error("load model data error", e);
        }

    }

    /**
     * 测试文件读取
    * @Title: testLoadModeMany 
    * @Description: TODO(这里用一句话描述这个方法的作用) 
    * @throws
     */
    @Test
    public void testLoadModeMany() {
        try {
            String filepath = "D:/sss好的.xlsx";
            String fileName = "sss好的";

            LOGGER.info("去数据库中读取配置信息开始...");
            ExcelModel loadExcelModel = LoadExcelModel
                    .queryAllExcelConfigBySingleFile(jdbcTemplate, fileName);
            LOGGER.info("读取数据库配置信息结束");

            LOGGER.info("读取根据配置读取Excel文件内容开始....");
            Map<String, List<Map<String, Object>>> excellist = ExcelReadUtil
                    .readExcelMoreSheet(filepath, loadExcelModel);// 去读存在本地的文件
            LOGGER.info("读取Excel内容结束");

            LOGGER.info("直接读取List<Map>的内容开始....");
            for (Map<String, Object> map : excellist.get("小额提现申请记录")) {
                StringBuffer sbf = new StringBuffer();
                for (String key : map.keySet()) {
                    if (null != key)
                        sbf.append(key + ":" + map.get(key) + "==");
                }
                LOGGER.info(sbf.toString());
            }
            LOGGER.info("直接读取List<Map>的内容结束");
            LOGGER.info("读取的Excel结果封装为List<Map>，转换成List<Bean>开始");
            List<PresentAuditEntity> lastlist = new ArrayList<PresentAuditEntity>();
            for (Map<String, Object> map : excellist.get("小额提现申请记录")) {
                /*
                 * PresentAuditEntity pae = new PresentAuditEntity();
                 * BeanCopyMapUtil.transMapToBean(map, pae); lastlist.add(pae);
                 */
            }
            LOGGER.info("转换List<Bean>结束");
        } catch (Exception e) {
            LOGGER.error("load model data error", e);
        }

    }
    /**
     * @category 小额提现情况审核列表信息
     * @category 开始时间:1461738826451
     * @category 结束时间:1461738826873
     * @category 时间差:422毫秒
     * @category JUnit运行时间3.342秒
     */
    @Test
    public void testList() throws Exception {
        long begin_time = System.currentTimeMillis();
        MvcResult result = mockMvc
                .perform(get("/loan/list")
                        .param("sGetCashTimeFrom", "2016-04-03")
                        .param("sGetCashTimeTo", "2016-04-14"))
                // .andExpect(view().name("/base/frame.ftl"))
                .andExpect(model().attributeExists("user"))// 判断model中是否有user属性存在
                .andExpect(model().attributeExists("loans"))
                .andExpect(model().attributeExists("pageInfo"))
                .andExpect(model().attributeExists("frontdata"))
                .andExpect(model().attributeExists("template"))
                .andExpect(status().isOk()) // 请求成功
                // .andDo(print())//打印请求、响应消息到控制台
                .andReturn();
        // String response = result.getResponse().getContentAsString();
        @SuppressWarnings("unchecked")
        List<LoanSummaryForm> pages = (List<LoanSummaryForm>) result
                .getModelAndView().getModel().get("loans");
        @SuppressWarnings("unchecked")
        HashMap<String, Object> map = (HashMap<String, Object>) result
                .getModelAndView().getModel().get("pageInfo");
        LoanSummaryForm frontdata = (LoanSummaryForm) result.getModelAndView()
                .getModel().get("frontdata");
        Assert.assertNotNull(pages);
        Assert.assertNotNull(map);
        Assert.assertNotNull(frontdata);
        Assert.assertNotNull(result.getModelAndView().getModel().get("user"));
        Assert.assertNotNull(
                result.getModelAndView().getModel().get("template"));
        Assert.assertEquals(result.getModelAndView().getModel().get("user"),
                "test");
        Assert.assertEquals(result.getModelAndView().getModel().get("template"),
                "loan/detail.ftl");
        Assert.assertEquals(pages.size(), 6);
        Assert.assertEquals(map.get("total") + "", "6");
        Assert.assertEquals(map.get("iGetCashTotal"), "2.10");
        Assert.assertEquals(map.get("pageNum"), 1);
        Assert.assertEquals(map.get("pageSize"), 20);
        Assert.assertEquals(map.get("pages"), 1);
        Assert.assertEquals(map.get("size"), 6);
        Assert.assertEquals(frontdata.getsGetCashTimeFrom(), "2016-04-03");
        Assert.assertEquals(frontdata.getsGetCashTimeTo(), "2016-04-14");
        Assert.assertEquals(frontdata.getiStatus(), null);
        Assert.assertEquals(frontdata.getsMobile(), null);
        Assert.assertEquals(frontdata.getiPageSize(), new Integer(20));
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     * @category 小额提现导出excel
     * @category 开始时间:1461738923834
     * @category 结束时间:1461738924192
     * @category 时间差:358毫秒
     * @category JUnit运行时间4.350秒
     * @category 注：excel文件生成在D盘根目录
     */
    @Test
    public void testDownload() throws Exception {
        long begin_time = System.currentTimeMillis();
        MvcResult result = mockMvc
                .perform(
                        get("/loan/downexcel?sGetCashTimeFrom=2016-04-03&sGetCashTimeTo=2016-04-14"))
                .andExpect(content()
                        .contentType(new MediaType("application", "ms-excel"))) // 验证响应contentType
                // .andExpect(content().bytes("1".getBytes()))
                .andExpect(status().isOk()) // 请求成功
                // .andDo(print())
                .andReturn();
        MockHttpServletResponse response = result.getResponse();
        response.setContentType("application/ms-excel");
        response.setCharacterEncoding("utf-8");
        String filename = new String(
                response.getHeader("Content-Disposition").getBytes("iso8859-1"),
                "utf-8").substring(9);
        LOGGER.info("文件：" + filename);
        byte[] bytes = response.getContentAsByteArray();
        File file = new File(new File("d:\\"), filename);
        FileOutputStream out;
        try {
            out = new FileOutputStream(file);
            out.write(bytes);
            out.flush();
            out.close();
        } catch (Exception e) {
            LOGGER.error("导出excel文件异常：" + e);
        }
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     * @category 小额提现多文件上传
     * @category 开始时间:1461899479502
     * @category 结束时间:1461899479564
     * @category 时间差:62毫秒
     * @category JUnit运行时间3.174秒
     * @category 注：上传文件在D盘\UPLOAD\TEMP目录
     */
    @Test
    public void testUpload() throws Exception {
        long begin_time = System.currentTimeMillis();
        byte[] content = FileUtils
                .readFileToByteArray(new File("d:\\data.txt"));
        MockMultipartFile file = new MockMultipartFile("uploadfile", "data.txt",
                "text/plain", content);
        byte[] content1 = FileUtils
                .readFileToByteArray(new File("d:\\财务系统GIT规范.pptx"));
        MockMultipartFile file1 = new MockMultipartFile("uploadfile",
                "财务系统GIT规范.pptx", "application/mspowerpoint", content1);
        byte[] content2 = FileUtils
                .readFileToByteArray(new File("d:\\小额提现.xls"));
        MockMultipartFile file2 = new MockMultipartFile("uploadfile",
                "小额提现.xls", "application/ms-excel", content2);
        mockMvc.perform(fileUpload("/loan/uploadexcel").file(file).file(file1)
                .file(file2).contentType(MediaType.MULTIPART_FORM_DATA))
                .andExpect(status().isOk()) // 请求成功
                .andDo(print()).andReturn();
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     * @category 测试查询单条详细信息返回json
     * @category 开始时间:1461756664854
     * @category 结束时间:1461756665153
     * @category 时间差:299毫秒
     * @category JUnit运行时间3.303秒
     * @category 返回的json数据
     *           {"data":{"iPageNum":1,"iPageSize":20,"iOpt":0,"iAutoID":"5",
     *           "sMobile":"30000000000","iAmount":"50","iMoney":"0.5",
     *           "sGetCashTimeFrom":null,"sGetCashTimeTo":null,"sBankName":
     *           "平安银行", "sBankCard":"6228481210208410423","sGetCashTime":
     *           "2016-04-10 12:34:36", "iStatus":"财务审核失败","iCreateTime":
     *           "2016-04-10 12:34:36", "iUpdateTime":"2016-04-10 12:34:36"
     *           },"success":"true"}
     */
    @Test
    public void testFindItem() throws Exception {
        long begin_time = System.currentTimeMillis();
        mockMvc.perform(get("/loan/findItem/?id=5")
                .contentType(MediaType.TEXT_HTML).characterEncoding("utf-8"))// 执行请求
                .andExpect(content().contentType(new MediaType("application",
                        "json", Charset.forName("UTF-8"))))
                // //验证响应contentType
                .andExpect(jsonPath("$.data").exists())// 使用Json
                                                       // path验证JSON,请参考http://goessner.net/articles/JsonPath/
                .andExpect(jsonPath("$.data.iPageNum").value(1))
                .andExpect(jsonPath("$.data.iPageSize").value(20))
                .andExpect(jsonPath("$.data.iAutoID").value("5"))
                .andExpect(jsonPath("$.data.sMobile").value("30000000000"))
                .andExpect(jsonPath("$.data.iAmount").value("50"))
                .andExpect(jsonPath("$.data.iMoney").value("0.5"))
                .andExpect(jsonPath("$.data.sGetCashTimeFrom").doesNotExist())
                .andExpect(jsonPath("$.data.sGetCashTimeTo").doesNotExist())
                .andExpect(jsonPath("$.data.sBankName").value("平安银行"))
                .andExpect(jsonPath("$.data.sBankCard")
                        .value("6228481210208410423"))
                .andExpect(jsonPath("$.data.sGetCashTime")
                        .value("2016-04-10 12:34:36"))
                // .andExpect(jsonPath("$.data.iStatus").value("财务审核失败"))
                .andExpect(jsonPath("$.data.iCreateTime")
                        .value("2016-04-10 12:34:36"))
                .andExpect(jsonPath("$.data.iUpdateTime")
                        .value("2016-04-10 12:34:36"))
                .andExpect(jsonPath("$.success").value("true"))
                .andExpect(status().isOk()) // 请求成功
                .andDo(print()).andReturn();
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     * @category 测试删除单条信息
     * @category 开始时间:1461910548558 结束时间:1461910548720 时间差:162毫秒
     * @category JUnit运行时间3.118秒
     */
    @Test
    public void testDeleteItem() throws Exception {
        long begin_time = System.currentTimeMillis();
        mockMvc.perform(get("/loan/delItem/?id=6"))// 执行请求
                .andExpect(content().contentType(new MediaType("application",
                        "json", Charset.forName("UTF-8"))))
                // //验证响应contentType
                .andExpect(jsonPath("$.success").value("true"))
                .andExpect(status().isOk()) // 请求成功
                .andDo(print()).andReturn();
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }

    /**
     * @category 测试审核单条信息
     * @category 开始时间:1461757718785
     * @category 结束时间:1461757718994
     * @category 时间差:209毫秒
     * @category JUnit运行时间3.183秒
     * @category 返回的json数据 {"success":"true","msg":"审核成功！"}
     */
    @Test
    public void testPassCheck() throws Exception {
        long begin_time = System.currentTimeMillis();
        mockMvc.perform(
                get("/loan/passCheck").param("id", "5").param("status", "2"))// 执行请求
                .andExpect(content().contentType(new MediaType("application",
                        "json", Charset.forName("UTF-8")))) // 验证响应contentType
                .andExpect(jsonPath("$.msg").exists())// 使用Json
                                                      // path验证JSON,请参考http://goessner.net/articles/JsonPath/
                .andExpect(jsonPath("$.msg").value("审核成功！"))
                .andExpect(jsonPath("$.success").exists())
                .andExpect(jsonPath("$.success").value("true"))
                .andExpect(status().isOk()) // 请求成功
                // .andDo(print())
                .andReturn();
        long end_time = System.currentTimeMillis();
        LOGGER.info("\n开始时间:" + begin_time + "\t结束时间:" + end_time + "\t时间差:"
                + (end_time - begin_time) + "毫秒");
    }
}
