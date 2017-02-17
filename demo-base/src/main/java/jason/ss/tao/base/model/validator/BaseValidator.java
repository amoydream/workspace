package jason.ss.tao.base.model.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public abstract class BaseValidator<T> implements Validator {
	public abstract void baseValidate(T target, Errors errors);

	@SuppressWarnings("unchecked")
	@Override
	public void validate(Object target, Errors errors) {
		baseValidate((T)target, errors);
	}
}
