package com.lauvan.config;

import java.util.HashMap;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.dialect.OracleDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import com.lauvan.core.jfinal.plugin.MyRoutesUtil;
import com.lauvan.core.jfinal.plugin.TableBindPlugin;
import com.lauvan.core.jfinal.plugin.TableNameStyle;
import com.lauvan.interceptor.PermitInterceptor;
import com.mchange.v2.c3p0.ComboPooledDataSource;

public class JFWebConfig extends JFinalConfig {
	/** 配置全局变量 */
	public static int						pageSize		= 20;
	public static String					saveDirectory	= "";							// 上传文件目录，默认为upload
	public static int						maxPostSize		= 1024 * 1024 * 1024;			// 默认上传文件大小 1G

	public static HashMap<String, String>	attrMap			= new HashMap<String, String>();// 属性缓存
	public static HashMap<String, Object>	fileMap			= new HashMap<String, Object>();// 文件缓存

	// 配置文件中的变量
	private boolean							devMode			= false;
	private boolean							showSql			= false;
	private String							jdbcUrl, user, password, driverClass;

	/** 加载配置文件 */
	public JFWebConfig() {
		loadPropertyFile("config.properties");
		devMode = "true".equals(getProperty("devMode")) ? true : false;
		showSql = "true".equals(getProperty("showSql")) ? true : false;
		jdbcUrl = getProperty("jdbcUrl");
		user = getProperty("user");
		password = getProperty("password");
		driverClass = getProperty("driverClass");

		attrMap.put("superAdminRoleID", getProperty("superAdminRoleID"));
		attrMap.put("dbaType", getProperty("dbaType"));
		attrMap.put("dbaName", getProperty("dbaName"));
		attrMap.put("smsip", getProperty("smsip"));
		attrMap.put("smsaccount", getProperty("smsaccount"));
		attrMap.put("smspwd", getProperty("smspwd"));
		attrMap.put("masdbhost", getProperty("masdbhost"));
		attrMap.put("masdbport", getProperty("masdbport"));
		attrMap.put("masdbname", getProperty("masdbname"));
		attrMap.put("dutyDocPath", getProperty("dutyDocPath"));//值守传真目录
		attrMap.put("dutyDocUrl", getProperty("dutyDocUrl"));
		attrMap.put("dailyRptPath", getProperty("dailyRptPath"));
		attrMap.put("dailyRptUrl", getProperty("dailyRptUrl"));
		attrMap.put("weeklyRptPath", getProperty("weeklyRptPath"));
		attrMap.put("weeklyRptUrl", getProperty("weeklyRptUrl"));
		//邮件参数
		attrMap.put("mailhost", getProperty("mailhost"));
		attrMap.put("mailprot", getProperty("mailprot"));
		attrMap.put("mailhost_re", getProperty("mailhost_re"));
		attrMap.put("mailprotocol_re", getProperty("mailprotocol_re"));
		attrMap.put("mailprot_re", getProperty("mailprot_re"));
		attrMap.put("mailuser", getProperty("mailuser"));
		attrMap.put("mailpwd", getProperty("mailpwd"));
	}

	/** 配置常量 */
	@Override
	public void configConstant(Constants me) {
		me.setDevMode(devMode);
		me.setViewType(ViewType.JSP); // 设置视图类型为Jsp，否则默认为FreeMarker
		me.setBaseViewPath("/WEB-INF/jsp/");
	}

	/** 配置路由 */
	@Override
	public void configRoute(Routes me) {
		MyRoutesUtil.add(me);// 自动配置路由
	}

	/** 配置插件 */
	@Override
	public void configPlugin(Plugins me) {
		// 配置数据库连接池插件
		C3p0Plugin cp = new C3p0Plugin(jdbcUrl, user, password, driverClass);
		me.add(cp);

		// 添加自动绑定model与表插件
		TableBindPlugin autoTableBindPlugin = new TableBindPlugin(cp, TableNameStyle.LOWER);
		autoTableBindPlugin.setShowSql(showSql);
		autoTableBindPlugin.setContainerFactory(new CaseInsensitiveContainerFactory());
		me.add(autoTableBindPlugin);
		// 配置数据库方言
		autoTableBindPlugin.setDialect(new OracleDialect());
		// autoTableBindPlugin.setDialect(new MysqlDialect());
	}

	/** 配置全局拦截器 */
	@Override
	public void configInterceptor(Interceptors me) {
		me.add(new PermitInterceptor());
	}

	/** 配置处理器 */
	@Override
	public void configHandler(Handlers me) {
		me.add(new FrontHandler());
	}

	public void afterJFinalStart() {
		ComboPooledDataSource c = (ComboPooledDataSource)DbKit.getConfig().getDataSource();
		c.setBreakAfterAcquireFailure(false);//为true会导致连接池占满后不提供服务。所以必须为false
		c.setIdleConnectionTestPeriod(20);//每20秒检查一次空闲连接，加快释放连接
		c.setUnreturnedConnectionTimeout(30);//连接回收超时时间，设置比maxIdleTime大
		c.setCheckoutTimeout(10000);//获取连接超时时间为10秒，默认则无限等待。设置此值高并发时（连接数占满）可能会引发中断数据库操作风险。
	}
}
