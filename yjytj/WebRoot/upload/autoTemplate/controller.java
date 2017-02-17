${package}

import java.util.List;
import com.lauvan.base.basemodel.controller.BaseController;
import com.lauvan.core.annotation.RouteBind;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.lauvan.util.JsonUtil;
import com.lauvan.base.main.model.LoginModel;
import com.lauvan.base.main.model.Paginate;
/**
 * ${viewname}控制类
 * */
@RouteBind(path="${path}",viewPath="${viewPath}")
public class ${className} extends BaseController {
	/**
	 *模块主页方法
	 */
	public void index(){
		render("main.jsp");
	}
	/**
	 *模块列表查询方法
	 */
	public void getGridData(){
		Integer pageSize=getParaToInt("rows");
		Integer pageNumber=getParaToInt("page");
		//查询字段
		StringBuffer str = new StringBuffer();
		Page<Record> page=Paginate.dao.getPage("${table_name}", pageSize, pageNumber, str.toString(), null, null);
		/*LoginModel login = getSessionAttr("loginModel");
		Page<Record> page = Paginate.dao.getServicePage(pageSize, pageNumber, "${servicename}", login.getOrgId().toString(), str.toString(), null, null);*/
		List<Record> list=page.getList();
		int totalCount=page.getTotalRow();
		//调用JsonUtil函数返回datagrid表格json数据
		String jsonStr=JsonUtil.getGridData(list, totalCount);
		renderText(jsonStr);
	}
	/**
	 *新增
	 */
	public void add(){
		render("add.jsp");
	}
	/**
	 *修改
	 */
	public void edit(){
		render("edit.jsp");
	}
	/**
	 *删除
	 */
	public void delete(){
		
	}
	/**
	 *保存
	 */
	public void save(){
		
	}
	
}
