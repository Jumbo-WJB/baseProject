import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.ContextHierarchy;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.springframework.web.context.WebApplicationContext;

/** 
* @ClassName: BaseMockMvcTest 
* @Description: TODO(mockmvc测试Controller通用类) 
* @author EX-ZHAOZHENG700 
* @date 2016年4月28日 上午9:28:47  
*/
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration(value = "src/main/webapp")
@ContextHierarchy({
@ContextConfiguration(name = "parent", locations = "classpath:spring/applicationContext.xml"),
@ContextConfiguration(name = "child", locations = "classpath:spring/webmvc-config.xml")
}) 
//------------如果加入以下代码，所有继承该类的测试类都会遵循该配置，也可以不加，在测试类的方法上控制事务
//这个非常关键，如果不加入这个注解配置，事务控制就会完全失效！  
//@Transactional  
//这里的事务关联到配置文件中的事务控制器（transactionManager = "transactionManager"），同时//指定自动回滚（defaultRollback = true）。这样做操作的数据才不会污染数据库！  
//@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)  
//------------ 
public class BaseMockMvcTest {
    @Autowired
    protected WebApplicationContext wac;
    protected MockMvc mockMvc;

    @Before
    public void setUp() {
        this.mockMvc = webAppContextSetup(this.wac).alwaysExpect(status().isOk()).build();
        //.alwaysExpect定义全局的结果验证器，每次执行请求时都进行验证的规则
        //.setViewResolvers(ViewResolver...resolvers)：设置视图解析器；
    }
}
