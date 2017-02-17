package jason.ss.tao.hibernate.association;

import java.util.HashSet;
import java.util.Set;

import jason.ss.tao.entity.association.MM1_Student;
import jason.ss.tao.entity.association.MM1_Teacher;
import jason.ss.tao.hibernate.HibernateTest;

public class MM1Test extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	public void testSave() {
		MM1_Teacher tch_michael = new MM1_Teacher();
		tch_michael.setName("Michael");

		MM1_Teacher tch_jordan = new MM1_Teacher();
		tch_jordan.setName("Jordan");

		MM1_Student std_song = new MM1_Student();
		std_song.setName("Song");

		MM1_Student std_rong = new MM1_Student();
		std_rong.setName("Rong");

		Set<MM1_Student> students = new HashSet<MM1_Student>();
		students.add(std_song);
		students.add(std_rong);

		tch_michael.setStudents(students);
		tch_jordan.setStudents(students);

		save(tch_michael, tch_jordan, std_song, std_rong);
	}

	public void testGet() {
		MM1_Teacher tch_michael = session.get(MM1_Teacher.class, 1);
		assertEquals(tch_michael.getName(), "Michael");
		assertEquals(tch_michael.getStudents().size(), 2);
	}

	public void testLoad() {
		MM1_Teacher tch_michael = session.load(MM1_Teacher.class, 1);
		assertEquals(tch_michael.getName(), "Michael");
		assertEquals(tch_michael.getStudents().size(), 2);
	}

	public void testUpdate() {
		MM1_Teacher tch_michael = session.load(MM1_Teacher.class, 1);
		tch_michael.setName("Kobe");
		tch_michael.getStudents().iterator().next().setName("Jason");
	}

	public void testDeleteTeacher() {
		MM1_Teacher tch_michael = session.load(MM1_Teacher.class, 1);
		session.delete(tch_michael);
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_PY7HNSJW99MR3DMK993HK12PS) - 已找到子记录
	public void testDeleteStudent() {
		MM1_Student std_song = session.load(MM1_Student.class, 3);
		session.delete(std_song);
	}

	public void testDeleteTeacherStudent() {
		session.delete(session.load(MM1_Teacher.class, 1));
		session.delete(session.load(MM1_Teacher.class, 2));
		session.delete(session.load(MM1_Student.class, 3));
		session.delete(session.load(MM1_Student.class, 4));
	}

}
