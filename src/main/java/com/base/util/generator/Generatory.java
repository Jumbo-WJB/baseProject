package com.base.util.generator;

/**
 * @ClassName: Generator
 * @Description: 自动生成MyBatis的实体类、实体映射XML文件、Mapper
 * @author EX-XIONGTAO600
 * @date 2016年4月20日 下午7:38:54
 */
public class Generator {
    private static final Logger logger = LoggerFactory
            .getLogger(Generator.class);
    public static void main(String[] args) throws InvalidConfigurationException,
            SQLException, InterruptedException {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config;
        try {
            config = cp.parseConfiguration(Generator.class.getResourceAsStream("generatorConfig.xml"));
            DefaultShellCallback callback = new DefaultShellCallback(overwrite);
            MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
                    callback, warnings);
            myBatisGenerator.generate(null);
        } catch (IOException e) {
            logger.error("Generator异常", e);
        } catch (XMLParserException e) {
            logger.error("Generator异常", e);
        }

    }
}
