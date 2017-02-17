package com.lauvan.dutymanage.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lauvan.base.vo.QueryResult;
import com.lauvan.dutymanage.criteria.DutyScheduleCriteria;
import com.lauvan.dutymanage.dao.DutyScheduleDao;
import com.lauvan.dutymanage.dao.DutyScheduleTmplDao;
import com.lauvan.dutymanage.entity.T_Duty_Schedule;
import com.lauvan.dutymanage.entity.T_Duty_Schedule_Tmpl;
import com.lauvan.dutymanage.service.DutyScheduleService;
import com.lauvan.dutymanage.vo.DutyScheduleVo;
import com.lauvan.organ.entity.C_Organ_Person;
import com.lauvan.util.ValidateUtil;

/**
 * @describe 值班排班service层实现类
 * @author Tao
 * @version 1.0 2015-12-03
 */
@Service(value = "dutyScheduleService")
public class DutyScheduleServiceImpl implements DutyScheduleService {
	@Autowired
	private DutyScheduleDao		dutyScheduleDao;

	@Autowired
	private DutyScheduleTmplDao	dutyScheduleTmplDao;

	@Override
	public QueryResult<DutyScheduleVo> getScheduleRecords(DutyScheduleVo dutyScheduleVo) {
		QueryResult<DutyScheduleVo> queryResult = new QueryResult<DutyScheduleVo>();

		QueryResult<T_Duty_Schedule> result = dutyScheduleDao.getScheduleRecords(new DutyScheduleCriteria().copyProperties(dutyScheduleVo));

		if(result != null) {
			List<DutyScheduleVo> voList = new ArrayList<DutyScheduleVo>();
			List<T_Duty_Schedule> resultList = result.getResultlist();
			for(T_Duty_Schedule dutySchedule : resultList) {
				DutyScheduleVo vo = new DutyScheduleVo();

				BeanUtils.copyProperties(dutySchedule, vo);

				voList.add(vo);
			}

			queryResult.setResultlist(voList);
			queryResult.setTotalrecord(result.getTotalrecord());
		}

		return queryResult;
	}

	@Override
	public void addDutySchedule(DutyScheduleVo dutyScheduleVo) {
		T_Duty_Schedule dutySchedule = new T_Duty_Schedule();

		BeanUtils.copyProperties(dutyScheduleVo, dutySchedule);

		C_Organ_Person organPerson = new C_Organ_Person();
		organPerson.setPe_id(dutyScheduleVo.getPe_id());
		dutySchedule.setOrganPerson(organPerson);

		dutyScheduleDao.save(dutySchedule);
	}

	@Override
	public void deleteDutySchedule(Integer id) {
		dutyScheduleDao.delete(id);
	}

	@Override
	public List<DutyScheduleVo> getCalendarSchedule(DutyScheduleVo dutyScheduleVo) {
		List<DutyScheduleVo> voList = new ArrayList<DutyScheduleVo>();
		List<T_Duty_Schedule> list = dutyScheduleDao.getCalendarSchedules(new DutyScheduleCriteria().copyProperties(dutyScheduleVo));

		if(list != null) {
			for(T_Duty_Schedule o : list) {
				DutyScheduleVo vo = new DutyScheduleVo();
				BeanUtils.copyProperties(o, vo);
				BeanUtils.copyProperties(o.getOrganPerson(), vo);
				voList.add(vo);
			}
		}

		return voList;
	}

	@Override
	public DutyScheduleVo getDutyScheduleById(Integer id) {
		T_Duty_Schedule dutySchedule = dutyScheduleDao.find(id);
		DutyScheduleVo dutyScheduleVo = new DutyScheduleVo();
		BeanUtils.copyProperties(dutySchedule, dutyScheduleVo);
		BeanUtils.copyProperties(dutySchedule.getOrganPerson(), dutyScheduleVo);

		return dutyScheduleVo;
	}

	@Override
	public boolean isOnDuty(Integer pe_id, Date dutyDate) {
		DutyScheduleVo dutyScheduleVo = new DutyScheduleVo();
		dutyScheduleVo.setPe_id(pe_id);
		dutyScheduleVo.setDuty_date(dutyDate);
		QueryResult<DutyScheduleVo> result = getScheduleRecords(dutyScheduleVo);

		return result != null && result.getTotalrecord() > 0;
	}

	@Override
	public Integer saveDutySchedule(DutyScheduleVo dutyScheduleVo) {
		T_Duty_Schedule dutySchedule = new T_Duty_Schedule();

		BeanUtils.copyProperties(dutyScheduleVo, dutySchedule);
//		C_Organ_Person organPerson = new C_Organ_Person();
//		organPerson.setPe_id(dutyScheduleVo.getPe_id());
//		dutySchedule.setOrganPerson(organPerson);
		dutySchedule.setOrganPerson(new C_Organ_Person(dutyScheduleVo.getPe_id()));

		if(dutySchedule.getDuty_sch_id() == null) {
			dutyScheduleDao.save(dutySchedule);
		} else {
			dutyScheduleDao.update(dutySchedule);
		}

		return dutySchedule.getDuty_sch_id();
	}

	@Override
	public List<DutyScheduleVo> getScheduleTemplates() {
		List<DutyScheduleVo> voList = new ArrayList<DutyScheduleVo>();
		List<T_Duty_Schedule_Tmpl> list = dutyScheduleTmplDao.getListEntitys();

		if(list != null) {
			for(T_Duty_Schedule_Tmpl o : list) {
				DutyScheduleVo vo = new DutyScheduleVo();
				BeanUtils.copyProperties(o, vo);
				BeanUtils.copyProperties(o.getOrganPerson(), vo);
				voList.add(vo);
			}
		}

		return voList;
	}

	@Override
	public void saveScheduleTemplate(DutyScheduleVo dutyScheduleVo) {
		Integer pe_id = dutyScheduleVo.getPe_id();
		String dutyProp = dutyScheduleVo.getDuty_prop();
		String dutyType = dutyScheduleVo.getDuty_type();

		if(!ValidateUtil.isEmpty(pe_id) && !ValidateUtil.isEmpty(dutyProp) && !ValidateUtil.isEmpty(dutyType)) {
			T_Duty_Schedule_Tmpl tmpl = dutyScheduleTmplDao.getScheduleTemplate(pe_id, dutyProp, dutyType);

			if(tmpl == null) {
				T_Duty_Schedule_Tmpl schTmpl = new T_Duty_Schedule_Tmpl();
				schTmpl.setDuty_prop(dutyProp);
				schTmpl.setDuty_type(dutyType);
				C_Organ_Person organPerson = new C_Organ_Person();
				organPerson.setPe_id(pe_id);
				schTmpl.setOrganPerson(organPerson);
				dutyScheduleTmplDao.save(schTmpl);
			}
		}
	}

	@Override
	public void deleteScheduleTemplate(Integer id) {
		dutyScheduleTmplDao.delete(id);
	}
}
