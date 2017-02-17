package jason.ss.tao.user.service;

import java.util.List;

import jason.ss.tao.base.service.BaseService;
import jason.ss.tao.user.entity.User;
import jason.ss.tao.user.model.UserDto;

public interface UserService extends BaseService<UserDto, User> {
	List<User> getAllUser();
}
