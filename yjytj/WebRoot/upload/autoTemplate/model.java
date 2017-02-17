${package}

import com.jfinal.plugin.activerecord.Model;
import com.lauvan.core.annotation.TableBind;

@TableBind(name="${tablename}",pk="${pkid}")
public class ${classname} extends Model<${classname}> {
	private static final long serialVersionUID = 1L;
	public static final ${classname} dao = new ${classname}();
	
}
