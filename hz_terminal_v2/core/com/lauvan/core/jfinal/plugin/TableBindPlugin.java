package com.lauvan.core.jfinal.plugin;

import java.util.List;

import javax.sql.DataSource;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.IDataSourceProvider;
import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

public class TableBindPlugin extends ActiveRecordPlugin {
	private TableNameStyle tableNameStyle;

	public TableBindPlugin(DataSource dataSource) {
		super(dataSource);
	}

	public TableBindPlugin(IDataSourceProvider dataSourceProvider,
			TableNameStyle tableNameStyle) {
		super(dataSourceProvider);
		this.tableNameStyle = tableNameStyle;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public boolean start() {
		TableBind tb = null;
		boolean result = false;
		try {
			List<Class> modelClasses = ClassSearcher.findClasses(Model.class);
			for (Class modelClass : modelClasses) {
				tb = (TableBind) modelClass.getAnnotation(TableBind.class);
				if (tb == null) {
//					System.out.println(modelClass.getName()+" does not associate with database tables");
//					this.addMapping(tableName(modelClass), modelClass);
				} else {
					if (StrKit.notBlank(tb.name())) {
						if (StrKit.notBlank(tb.pk())) {
							this.addMapping(tb.name(), tb.pk(), modelClass);
						} else {
							this.addMapping(tb.name(), modelClass);
						}
					}
				}
			}
			result = super.start();
		} catch(Exception e) {
			System.out.println(e.getMessage() + tb.name());
		}
		return result;
	}

	@Override
	public boolean stop() {
		return super.stop();
	}

	private String tableName(Class<?> clazz) {
		String tableName = clazz.getSimpleName();
		if (tableNameStyle == TableNameStyle.UP) {
			tableName = tableName.toUpperCase();
		} else if (tableNameStyle == TableNameStyle.LOWER) {
			tableName = tableName.toLowerCase();
		} else {
			tableName = StrKit.firstCharToLowerCase(tableName);
		}
		return tableName;
	}
}
