package jason.ss.tao.hibernate.association;

import java.util.HashSet;
import java.util.Set;

import jason.ss.tao.entity.association.MO2_Class;
import jason.ss.tao.entity.association.MO2_Student;
import jason.ss.tao.hibernate.HibernateTest;

//多对一双向关联，MO2_Student（多）端维护关联关系
//加载一端将自动加载另一端
public class MO2Test extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	public void testSave() {
		MO2_Class clazz = new MO2_Class();
		clazz.setName("PCCW");
		MO2_Student std_song = new MO2_Student();
		std_song.setName("Song");
		std_song.setClazz(clazz);
		MO2_Student std_rong = new MO2_Student();
		std_rong.setName("Rong");
		std_rong.setClazz(clazz);
		Set<MO2_Student> students = new HashSet<MO2_Student>();
		students.add(std_song);
		students.add(std_rong);
		clazz.setStudents(students);
		save(clazz, std_song, std_rong);
	}

	public void testGetStudent() {
		MO2_Student std_song = session.get(MO2_Student.class, 2);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getClazz().getName(), "PCCW");
	}

	public void testGetClass() {
		MO2_Class calzz = session.get(MO2_Class.class, 1);
		assertEquals(calzz.getName(), "PCCW");
		assertEquals(calzz.getStudents().size(), 2);
	}

	public void testLoadStudent() {
		MO2_Student std_song = session.load(MO2_Student.class, 2);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getClazz().getName(), "PCCW");
	}

	public void testLoadClass() {
		MO2_Class calzz = session.load(MO2_Class.class, 1);
		assertEquals(calzz.getName(), "PCCW");
		assertEquals(calzz.getStudents().size(), 2);
	}

	public void testUpdate() {
		MO2_Student std_song = session.load(MO2_Student.class, 2);
		std_song.setName("Jason");
		std_song.getClazz().setName("Microsoft");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_PY7HNSJW99MR3DMK993HK12PS) - 已找到子记录
	public void testDeleteClass() {
		MO2_Class clazz = session.load(MO2_Class.class, 1);
		session.delete(clazz);
	}

	public void testDeleteStudent() {
		MO2_Student std_song = session.load(MO2_Student.class, 2);
		session.delete(std_song);
	}

	public void testDeleteStudentClass() {
		MO2_Student std_song = session.load(MO2_Student.class, 2);
		MO2_Student std_rong = session.load(MO2_Student.class, 3);
		session.delete(std_song);
		session.delete(std_rong);
		session.delete(std_song.getClazz());
	}

}
