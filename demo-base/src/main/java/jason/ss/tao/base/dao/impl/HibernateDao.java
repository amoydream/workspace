package jason.ss.tao.base.dao.impl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

public class HibernateDao extends HibernateDaoSupport {
	/*@Autowired
	public void wireHibernateTemplate(HibernateTemplate hibernateTemplate) {
	  super.setHibernateTemplate(hibernateTemplate);
	}*/

	@Autowired
	public void wireSessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
}
