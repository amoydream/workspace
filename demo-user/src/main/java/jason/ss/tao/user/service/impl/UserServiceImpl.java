package jason.ss.tao.user.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Service;

import jason.ss.tao.base.service.impl.CommonService;
import jason.ss.tao.user.dao.UserDao;
import jason.ss.tao.user.entity.User;
import jason.ss.tao.user.exception.UserException;
import jason.ss.tao.user.model.UserDto;
import jason.ss.tao.user.service.UserService;

@Service(value = "userService")
public class UserServiceImpl extends CommonService<User> implements UserService {
	@Resource(name = "userDao")
	private UserDao userDao;

	@Override
	public User save(UserDto model) throws UserException {
		User user = userDao.getUserByName(model.getName());
		if(user != null) {
			throw new UserException("Can not save user[" + "name=" + user.getName() + "]" + ", user exist!");
		}

		user = new User();
		try {
			PropertyUtils.copyProperties(user, model);
			Serializable userId = getCommonDao().save(user);
			user = getCommonDao().get(User.class, userId);
		} catch(Exception e) {
			throw new UserException(e.getMessage());
		}

		return user;
	}

	@Override
	public User get(Serializable id) {
		return getCommonDao().get(User.class, id);
	}

	@Override
	public List<User> getAll() {
		return getCommonDao().getAll(User.class);
	}

	@Override
	public void update(UserDto model) {
		User user = getCommonDao().get(User.class, model.getDtoId());
		if(user == null) {
			throw new UserException("Can not update user[" + "id=" + model.getDtoId() + "]" + ", user does not exist!");
		}

		try {
			user.setAddress(model.getAddress());
			user.setPhone(model.getPhone());
			user.setEmail(model.getEmail());
			getCommonDao().update(user);
		} catch(Exception e) {
			throw new UserException(e.getMessage());
		}
	}

	@Override
	public void delete(Serializable id) {
		getCommonDao().delete(User.class, id);
	}

	@Override
	public List<User> getAllUser() {
		return getCommonDao().getAll(User.class);
	}
}
