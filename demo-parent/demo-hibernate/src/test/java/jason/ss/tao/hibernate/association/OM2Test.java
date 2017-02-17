package jason.ss.tao.hibernate.association;

import java.util.HashSet;
import java.util.Set;

import jason.ss.tao.entity.association.OM2_Class;
import jason.ss.tao.entity.association.OM2_Student;
import jason.ss.tao.hibernate.HibernateTest;

//与OM2的情况一致
public class OM2Test extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	public void testSave() {
		OM2_Class clazz = new OM2_Class();
		clazz.setName("PCCW");
		OM2_Student std_song = new OM2_Student();
		std_song.setName("Song");
		std_song.setClazz(clazz);
		OM2_Student std_rong = new OM2_Student();
		std_rong.setName("Rong");
		std_rong.setClazz(clazz);
		Set<OM2_Student> students = new HashSet<OM2_Student>();
		students.add(std_song);
		students.add(std_rong);
		clazz.setStudents(students);
		save(clazz, std_song, std_rong);
	}

	public void testGetStudent() {
		OM2_Student std_song = session.get(OM2_Student.class, 2);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getClazz().getName(), "PCCW");
	}

	public void testGetClass() {
		OM2_Class calzz = session.get(OM2_Class.class, 1);
		assertEquals(calzz.getName(), "PCCW");
		assertEquals(calzz.getStudents().size(), 2);
	}

	public void testLoadStudent() {
		OM2_Student std_song = session.load(OM2_Student.class, 2);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getClazz().getName(), "PCCW");
	}

	public void testLoadClass() {
		OM2_Class calzz = session.load(OM2_Class.class, 1);
		assertEquals(calzz.getName(), "PCCW");
		assertEquals(calzz.getStudents().size(), 2);
	}

	public void testUpdate() {
		OM2_Student std_song = session.load(OM2_Student.class, 2);
		std_song.setName("Jason");
		std_song.getClazz().setName("Microsoft");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_PY7HNSJW99MR3DMK993HK12PS) - 已找到子记录
	public void testDeleteClass() {
		OM2_Class clazz = session.load(OM2_Class.class, 1);
		session.delete(clazz);
	}

	public void testDeleteStudent() {
		OM2_Student std_song = session.load(OM2_Student.class, 2);
		session.delete(std_song);
	}

	public void testDeleteStudentClass() {
		OM2_Student std_song = session.load(OM2_Student.class, 2);
		OM2_Student std_rong = session.load(OM2_Student.class, 3);
		session.delete(std_song);
		session.delete(std_rong);
		session.delete(std_song.getClazz());
	}

}
