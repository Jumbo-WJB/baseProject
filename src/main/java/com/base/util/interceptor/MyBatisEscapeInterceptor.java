package com.base.util.interceptor;

/**
* @ClassName: MyBatisEscapeInterceptor
* @Description: 用于将%和_过滤为/%/_ escape '/'
* @author LIUYUEFENG559
* @date 2016年6月9日 上午10:58:58
*/
@Intercepts({
        @Signature(type = StatementHandler.class, method = "prepare", args = {
                Connection.class }) })
public class MyBatisEscapeInterceptor implements Interceptor {
    protected static Logger log = LoggerFactory
            .getLogger(MyBatisEscapeInterceptor.class);
    private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
    private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();

    private static final ObjectFactory DEFAULT_OBJECT_FACTORY2 = new DefaultObjectFactory();
    private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY2 = new DefaultObjectWrapperFactory();

    private String dialect;
    private String pageSqlId;

    private String exampleDialect;
    private String examplePageSqlId;

    /** (非 Javadoc)
    * <p>Title: intercept</p>
    * <p>Description: </p>
    * @param invocation
    * @return
    * @throws Throwable
    * @see org.apache.ibatis.plugin.Interceptor#intercept(org.apache.ibatis.plugin.Invocation)
    */
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler statementHandler = (StatementHandler) invocation
                .getTarget();
        MetaObject metaStatementHandler = MetaObject.forObject(statementHandler,
                DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY);
        MappedStatement mappedStatement = (MappedStatement) metaStatementHandler
                .getValue("delegate.mappedStatement");
        MetaObject metaMappedStatement = MetaObject.forObject(mappedStatement,
                DEFAULT_OBJECT_FACTORY2, DEFAULT_OBJECT_WRAPPER_FACTORY2);

        Pattern pattern = Pattern.compile(pageSqlId, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(mappedStatement.getId());
        // MybatisPaging mybatisPaging = null;
        Pattern examplePattern = Pattern.compile(examplePageSqlId,
                Pattern.CASE_INSENSITIVE);
        Matcher exampleMatcher = examplePattern
                .matcher(mappedStatement.getId());
        String dialectName = "";
        if (matcher.find()) {
            // mybatisPaging = new PagingByCount();
            dialectName = dialect;
        } else if (exampleMatcher.find()) {
            // mybatisPaging = new PagingByExampl();
            dialectName = exampleDialect;
        } else {
            return invocation.proceed();
        }
        Dialect dialect = Dialect.of(dialectName.toLowerCase());
        if (dialect == null) {
            throw new RuntimeException(
                    "the value of the dialect property in configuration.xml is not defined : dialect");
        }

        BoundSql boundSql = statementHandler.getBoundSql();
        // 修改参数值
        SqlNode sqlNode = (SqlNode) metaMappedStatement
                .getValue("sqlSource.rootSqlNode");
        boundSql = updateBoundSql(mappedStatement.getConfiguration(),
                boundSql.getParameterObject(), sqlNode, boundSql);

        metaStatementHandler.setValue("delegate.boundSql.sql",
                boundSql.getSql());

        return invocation.proceed();
    }

    public static BoundSql updateBoundSql(Configuration configuration,
            Object parameterObject, SqlNode sqlNode, BoundSql boundSql) {
        DynamicContext context = new DynamicContext(configuration,
                parameterObject);

        sqlNode.apply(context);
        String countextSql = boundSql.getSql();
        // System.out.println("context.getSql():"+countextSql);

        SqlSourceBuilder sqlSourceParser = new SqlSourceBuilder(configuration);
        Class<?> parameterType = parameterObject == null ? Object.class
                : parameterObject.getClass();
        String sql = modifyLikeSqlOnly(countextSql, parameterObject);
        updateParameters(configuration, parameterObject, sqlNode);
        SqlSource sqlSource = sqlSourceParser.parse(sql, parameterType,
                context.getBindings());
        boundSql = sqlSource.getBoundSql(parameterObject);
        for (Map.Entry<String, Object> entry : context.getBindings()
                .entrySet()) {
            boundSql.setAdditionalParameter(entry.getKey(), entry.getValue());
        }

        return boundSql;
    }

    /** (非 Javadoc)
    * <p>Title: plugin</p>
    * <p>Description: </p>
    * @param target
    * @return
    * @see org.apache.ibatis.plugin.Interceptor#plugin(java.lang.Object)
    */
    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    /** (非 Javadoc)
    * <p>Title: setProperties</p>
    * <p>Description: </p>
    * @param properties
    * @see org.apache.ibatis.plugin.Interceptor#setProperties(java.util.Properties)
    */
    @Override
    public void setProperties(Properties p) {
        dialect = p.getProperty("dialect");
        if (dialect == null || dialect.equals("")) {
            try {
                throw new PropertyException("dialect property is not found!");
            } catch (PropertyException e) {
                log.error("设置属性错误", e);
            }
        }
        pageSqlId = p.getProperty("pageSqlId");
        if (dialect == null || dialect.equals("")) {
            try {
                throw new PropertyException("pageSqlId property is not found!");
            } catch (PropertyException e) {
                log.error("设置属性错误", e);
            }
        }
        exampleDialect = p.getProperty("exampleDialect");
        examplePageSqlId = p.getProperty("examplePageSqlId");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static void setParameters(PreparedStatement ps,
            MappedStatement mappedStatement, BoundSql boundSql,
            Object parameterObject) throws SQLException {
        ErrorContext.instance().activity("setting parameters")
                .object(mappedStatement.getParameterMap().getId());
        List<ParameterMapping> parameterMappings = boundSql
                .getParameterMappings();
        if (parameterMappings != null) {
            Configuration configuration = mappedStatement.getConfiguration();
            TypeHandlerRegistry typeHandlerRegistry = configuration
                    .getTypeHandlerRegistry();
            MetaObject metaObject = parameterObject == null ? null
                    : configuration.newMetaObject(parameterObject);
            for (int i = 0; i < parameterMappings.size(); i++) {
                ParameterMapping parameterMapping = parameterMappings.get(i);
                if (parameterMapping.getMode() != ParameterMode.OUT) {
                    Object value;
                    String propertyName = parameterMapping.getProperty();
                    PropertyTokenizer prop = new PropertyTokenizer(
                            propertyName);
                    if (parameterObject == null) {
                        value = null;
                    } else if (typeHandlerRegistry
                            .hasTypeHandler(parameterObject.getClass())) {
                        value = parameterObject;
                    } else if (boundSql.hasAdditionalParameter(propertyName)) {
                        value = boundSql.getAdditionalParameter(propertyName);
                    } else if (propertyName
                            .startsWith(ForEachSqlNode.ITEM_PREFIX)
                            && boundSql
                                    .hasAdditionalParameter(prop.getName())) {
                        value = boundSql.getAdditionalParameter(prop.getName());
                        if (value != null) {
                            value = configuration.newMetaObject(value)
                                    .getValue(propertyName.substring(
                                            prop.getName().length()));
                        }
                    } else {
                        value = metaObject == null ? null
                                : metaObject.getValue(propertyName);
                    }
                    System.out.println(
                            "propertyName:" + propertyName + "value:" + value);
                    TypeHandler typeHandler = parameterMapping.getTypeHandler();
                    if (typeHandler == null) {
                        throw new ExecutorException(
                                "There was no TypeHandler found for parameter "
                                        + propertyName + " of statement "
                                        + mappedStatement.getId());
                    }
                    typeHandler.setParameter(ps, i + 1, value,
                            parameterMapping.getJdbcType());
                }
            }
        }
    }

    public static void updateParameters(Configuration configuration,
            Object parameterObject, SqlNode sqlNode) {
        DynamicContext context = new DynamicContext(configuration,
                parameterObject);
        sqlNode.apply(context);
        String countextSql = context.getSql();
        modifyLikeSql(countextSql, parameterObject);
    }

    public static BoundSql getBoundSql(Configuration configuration,
            Object parameterObject, SqlNode sqlNode) {
        DynamicContext context = new DynamicContext(configuration,
                parameterObject);
        // DynamicContext context = new
        // DynamicContext(mappedStatement.getConfiguration(),
        // boundSql.getParameterObject());
        // mappedStatement.getSqlSource().

        sqlNode.apply(context);
        String countextSql = context.getSql();
        // System.out.println("context.getSql():"+countextSql);

        SqlSourceBuilder sqlSourceParser = new SqlSourceBuilder(configuration);
        Class<?> parameterType = parameterObject == null ? Object.class
                : parameterObject.getClass();
        String sql = modifyLikeSql(countextSql, parameterObject);
        SqlSource sqlSource = sqlSourceParser.parse(sql, parameterType,
                context.getBindings());

        BoundSql boundSql = sqlSource.getBoundSql(parameterObject);
        for (Map.Entry<String, Object> entry : context.getBindings()
                .entrySet()) {
            boundSql.setAdditionalParameter(entry.getKey(), entry.getValue());
        }

        return boundSql;
    }

    public static String modifyLikeSqlOnly(String sql, Object parameterObject) {
        if (parameterObject instanceof HashMap) {
        } else {
            return sql;
        }
        if (!sql.toLowerCase().contains("like")) {
            return sql;
        }
        // sql=" and OPER_REMARK LIKE '%' || #{operRemark} || '%' \n " +"and
        // OPER_U_NAME LIKE #{operUName} || '%' ";
        // 原始表达式：\s\w+\sLIKE\s('%'\s\|{2})?\s*(#\{\w+\})\s*(\|{2}\s*'%')
        // String reg =
        // "\\s\\w+\\sLIKE\\s*('%'\\s*\\|{2}\\s*)?(#\\{\\w+\\})(\\s*\\|{2}\\s*'%')?";
        String reg = "LIKE\\s*(\"%\"\\s*)?(\\?)(\\s*\"%\")?";
        Pattern pattern = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(sql);

        List<String> replaceEscape = new ArrayList<String>();
        List<String> replaceFiled = new ArrayList<String>();

        while (matcher.find()) {
            replaceEscape.add(matcher.group());
            int n = matcher.groupCount();
            for (int i = 0; i <= n; i++) {
                String output = matcher.group(i);
                if (2 == i && output != null) {
                    replaceFiled.add(output.trim());
                }
            }
        }

        // sql = matcher.replaceAll(reg+" 1111");

        for (String s : replaceEscape) {
            sql = sql.replace(s, s + " ESCAPE '/' ");
        }
        return sql;
    }

    @SuppressWarnings("unchecked")
    public static String modifyLikeSql(String sql, Object parameterObject) {
        if (parameterObject instanceof HashMap) {
        } else {
            return sql;
        }
        if (!sql.toLowerCase().contains("like")) {
            return sql;
        }
        // sql=" and OPER_REMARK LIKE '%' || #{operRemark} || '%' \n " +"and
        // OPER_U_NAME LIKE #{operUName} || '%' ";
        // 原始表达式：\s\w+\sLIKE\s('%'\s\|{2})?\s*(#\{\w+\})\s*(\|{2}\s*'%')
        // String reg =
        // "\\s\\w+\\sLIKE\\s*('%'\\s*\\|{2}\\s*)?(#\\{\\w+\\})(\\s*\\|{2}\\s*'%')?";
        String reg = "LIKE\\s*(\"%\"\\s*)?(#\\{\\w+\\})(\\s*\"%\")?";
        Pattern pattern = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(sql);

        List<String> replaceEscape = new ArrayList<String>();
        List<String> replaceFiled = new ArrayList<String>();

        while (matcher.find()) {
            replaceEscape.add(matcher.group());
            int n = matcher.groupCount();
            for (int i = 0; i <= n; i++) {
                String output = matcher.group(i);
                if (2 == i && output != null) {
                    replaceFiled.add(output.trim());
                }
            }
        }

        // sql = matcher.replaceAll(reg+" 1111");

        for (String s : replaceEscape) {
            sql = sql.replace(s, s + " ESCAPE '/' ");
        }
        // 修改参数
        HashMap<String, Object> paramMab = (HashMap<String, Object>) parameterObject;
        for (String s : replaceFiled) {
            // sql=sql.replace(s, " ? ");
            // #{operUName} -->operUName
            String key = s.replace("#{", "").replace("}", "");
            Object val = paramMab.get(key);
            if (val != null && val instanceof String
                    && ((val.toString().contains("%")
                            && !val.toString().contains("/%"))
                            || (val.toString().contains("_")
                                    && !val.toString().contains("/_")))) { // 此处放置重复替换，否则出现//%或者//_等现象
                val = val.toString().replaceAll("%", "/%").replaceAll("_",
                        "/_");
                paramMab.put(key.toString(), val);
            }
        }
        return sql;
    }
}
