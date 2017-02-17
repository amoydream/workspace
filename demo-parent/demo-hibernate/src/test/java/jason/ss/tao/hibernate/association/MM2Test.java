package jason.ss.tao.hibernate.association;

import java.util.HashSet;
import java.util.Set;

import jason.ss.tao.entity.association.MM2_Student;
import jason.ss.tao.entity.association.MM2_Teacher;
import jason.ss.tao.hibernate.HibernateTest;

public class MM2Test extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	public void testSave() {
		MM2_Teacher tch_michael = new MM2_Teacher();
		tch_michael.setName("Michael");

		MM2_Teacher tch_jordan = new MM2_Teacher();
		tch_jordan.setName("Jordan");

		MM2_Student std_song = new MM2_Student();
		std_song.setName("Song");

		MM2_Student std_rong = new MM2_Student();
		std_rong.setName("Rong");

		Set<MM2_Student> students = new HashSet<MM2_Student>();
		students.add(std_song);
		students.add(std_rong);
		tch_michael.setStudents(students);
		tch_jordan.setStudents(students);

		Set<MM2_Teacher> teachers = new HashSet<MM2_Teacher>();
		teachers.add(tch_michael);
		teachers.add(tch_jordan);
		std_song.setTeachers(teachers);
		std_rong.setTeachers(teachers);

		save(tch_michael, tch_jordan, std_song, std_rong);
	}

	public void testGetTeacher() {
		MM2_Teacher tch_michael = session.get(MM2_Teacher.class, 1);
		assertEquals(tch_michael.getName(), "Michael");
		assertEquals(tch_michael.getStudents().size(), 2);
	}

	public void testGetStudent() {
		MM2_Student std_song = session.get(MM2_Student.class, 3);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getTeachers().size(), 2);
	}

	public void testLoadTeacher() {
		MM2_Teacher tch_michael = session.load(MM2_Teacher.class, 1);
		assertEquals(tch_michael.getName(), "Michael");
		assertEquals(tch_michael.getStudents().size(), 2);
	}

	public void testLoadStudent() {
		MM2_Student std_song = session.load(MM2_Student.class, 3);
		assertEquals(std_song.getName(), "Song");
		assertEquals(std_song.getTeachers().size(), 2);
	}

	public void testUpdate() {
		MM2_Teacher tch_michael = session.load(MM2_Teacher.class, 1);
		tch_michael.setName("Kobe");
		tch_michael.getStudents().iterator().next().setName("Jason");
	}

	public void testDeleteTeacher() {
		MM2_Teacher tch_michael = session.load(MM2_Teacher.class, 1);
		session.delete(tch_michael);
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_PY7HNSJW99MR3DMK993HK12PS) - 已找到子记录
	public void testDeleteStudent() {
		MM2_Student std_song = session.load(MM2_Student.class, 3);
		session.delete(std_song);
	}

	public void testDeleteTeacherStudent() {
		session.delete(session.load(MM2_Teacher.class, 1));
		session.delete(session.load(MM2_Teacher.class, 2));
		session.delete(session.load(MM2_Student.class, 3));
		session.delete(session.load(MM2_Student.class, 4));
	}
}
