package jason.ss.tao.user.model.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import jason.ss.tao.base.model.validator.BaseValidator;
import jason.ss.tao.user.entity.User;
import jason.ss.tao.user.model.UserDto;

@Component(value = "userValidator")
public class UserValidator extends BaseValidator<UserDto> {
	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.equals(User.class);
	}

	@Override
	public void baseValidate(UserDto user, Errors errors) {
		ValidationUtils.rejectIfEmpty(errors, "name", "validation.common.empty", new String[]{"Username"});
		errors.rejectValue("email", "validation.common.email");
	}

}
