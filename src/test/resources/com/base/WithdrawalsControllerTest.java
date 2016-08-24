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
}
