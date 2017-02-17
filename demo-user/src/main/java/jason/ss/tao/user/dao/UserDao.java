package jason.ss.tao.user.dao;

import jason.ss.tao.base.dao.BaseDao;
import jason.ss.tao.user.entity.User;

public interface UserDao extends BaseDao<User> {
	User getUserByName(String name);
}
