package jason.ss.tao.hibernate;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

import junit.framework.TestCase;

public class HibernateTest extends TestCase {
	protected SessionFactory	sessionFactory	= null;
	protected Session			session			= null;

	@Override
	protected void setUp() throws Exception {
		Configuration configuration = new Configuration().configure("hibernate.cfg.test.xml");
		ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties()).build();
		sessionFactory = configuration.buildSessionFactory(serviceRegistry);
		session = sessionFactory.openSession();
		session.getTransaction().begin();
	}

	@Override
	protected void tearDown() throws Exception {
		session.getTransaction().commit();
		session.close();
		sessionFactory.close();
	}

	public void testExportSchema() {
		//Configuration configuration = new Configuration().configure();
		//SchemaExport schemaExport = new SchemaExport();
		//schemaExport.create(true, true);
	}

	public void save(Object... objects) {
		for(Object obj : objects) {
			session.save(obj);
		}
	}
}
