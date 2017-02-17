package jason.ss.tao.base.service;

import java.io.Serializable;
import java.util.List;

import jason.ss.tao.base.entity.BaseEntity;
import jason.ss.tao.base.model.BaseDto;

public interface BaseService<M extends BaseDto, E extends BaseEntity> {
	E save(M model);

	E get(Serializable id);

	List<E> getAll();

	void update(M model);

	void delete(Serializable id);
}
