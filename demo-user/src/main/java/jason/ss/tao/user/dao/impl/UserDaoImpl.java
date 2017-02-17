package jason.ss.tao.user.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import jason.ss.tao.base.dao.impl.HibernateDao;
import jason.ss.tao.user.dao.UserDao;
import jason.ss.tao.user.entity.User;

@Repository(value = "userDao")
@SuppressWarnings("unchecked")
public class UserDaoImpl extends HibernateDao implements UserDao {

	@Override
	public User getUserByName(String name) {
		List<User> userList = (List<User>)getHibernateTemplate().find("from User where name = ?", name);
		if(userList != null && userList.size() > 0) {
			return userList.get(0);
		}

		return null;
	}

}
