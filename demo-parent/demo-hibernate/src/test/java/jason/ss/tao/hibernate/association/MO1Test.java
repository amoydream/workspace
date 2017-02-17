package jason.ss.tao.hibernate.association;

import jason.ss.tao.entity.association.MO1_Class;
import jason.ss.tao.entity.association.MO1_Student;
import jason.ss.tao.hibernate.HibernateTest;

//多对一单向关联，MO1_Student（多）端维护关联关系
//加载MO1_Student将自动加载MO1_Class
public class MO1Test extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	public void testSave() {
		MO1_Class clazz = new MO1_Class();
		clazz.setName("PCCW");
		MO1_Student std_song = new MO1_Student();
		std_song.setName("Song");
		std_song.setClazz(clazz);
		MO1_Student std_rong = new MO1_Student();
		std_rong.setName("Rong");
		std_rong.setClazz(clazz);
		save(clazz, std_song, std_rong);
	}

	public void testGet() {
		MO1_Student std_song = session.get(MO1_Student.class, 2);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getClazz().getName(), "PCCW");
	}

	public void testLoad() {
		MO1_Student std_song = session.load(MO1_Student.class, 2);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getClazz().getName(), "PCCW");
	}

	public void testUpdate() {
		MO1_Student std_song = session.load(MO1_Student.class, 2);
		std_song.setName("Jason");
		std_song.getClazz().setName("Microsoft");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_PY7HNSJW99MR3DMK993HK12PS) - 已找到子记录
	public void testDeleteClass() {
		MO1_Class clazz = session.load(MO1_Class.class, 1);
		session.delete(clazz);
	}

	public void testDeleteStudent() {
		MO1_Student std_song = session.load(MO1_Student.class, 2);
		session.delete(std_song);
	}

	public void testDeleteStudentClass() {
		MO1_Student std_song = session.load(MO1_Student.class, 2);
		MO1_Student std_rong = session.load(MO1_Student.class, 3);
		session.delete(std_song);
		session.delete(std_rong);
		session.delete(std_song.getClazz());
	}

}
