package jason.ss.tao.hibernate.association;

import java.util.HashSet;
import java.util.Set;

import jason.ss.tao.entity.association.OM1_Class;
import jason.ss.tao.entity.association.OM1_Student;
import jason.ss.tao.hibernate.HibernateTest;

//一对多单向关联，OM1_Class（一）端维护关联关系
//加载OM1_Class将自动加载OM1_Student
public class OM1Test extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	public void testSave() {
		OM1_Class clazz = new OM1_Class();
		clazz.setName("PCCW");
		OM1_Student std_song = new OM1_Student();
		std_song.setName("Song");
		OM1_Student std_rong = new OM1_Student();
		std_rong.setName("Rong");
		Set<OM1_Student> students = new HashSet<OM1_Student>();
		students.add(std_song);
		students.add(std_rong);
		clazz.setStudents(students);
		//save(std_song, std_rong, clazz);
		save(clazz, std_song, std_rong);
	}

	public void testGet() {
		OM1_Class clazz = session.get(OM1_Class.class, 1);
		assertEquals(clazz.getName(), "PCCW");
		assertEquals(clazz.getStudents().size(), 2);
	}

	public void testLoad() {
		OM1_Class clazz = session.load(OM1_Class.class, 1);
		assertEquals(clazz.getName(), "PCCW");
		assertEquals(clazz.getStudents().size(), 2);
	}

	public void testUpdate() {
		OM1_Class clazz = session.load(OM1_Class.class, 1);
		clazz.setName("Microsoft");
		clazz.getStudents().iterator().next().setName("Jason");
	}

	// 如果OM1_Student的外键CLASS_ID为Not Null，则将发生
	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_PY7HNSJW99MR3DMK993HK12PS) - 已找到子记录
	// 否则可以删除clazz，并且对应的OM1_Student的CLASS_ID将被update为null
	public void testDeleteClass() {
		OM1_Class clazz = session.load(OM1_Class.class, 1);
		session.delete(clazz);
	}

	public void testDeleteStudent() {
		OM1_Student std_song = session.load(OM1_Student.class, 2);
		session.delete(std_song);
	}

	public void testDeleteStudentClass() {
		OM1_Student std_song = session.load(OM1_Student.class, 2);
		OM1_Student std_rong = session.load(OM1_Student.class, 3);
		session.delete(std_song);
		session.delete(std_rong);
		session.delete(session.load(OM1_Class.class, 1));
	}

}
