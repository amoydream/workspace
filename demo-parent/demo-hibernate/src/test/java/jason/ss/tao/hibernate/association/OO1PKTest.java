package jason.ss.tao.hibernate.association;

import jason.ss.tao.entity.association.OO1PK_Husband;
import jason.ss.tao.entity.association.OO1PK_Wife;
import jason.ss.tao.hibernate.HibernateTest;

//一对一单向主键关联，OO1PK_Husband端维护关联关系
//加载OO1PK_Husband将自动加载OO1PK_Wife
public class OO1PKTest extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	// select hibernate_sequence.nextval from dual
	// insert into OO1PK_Wife (name, id) values (?, ?)
	// insert into OO1PK_Husband (name, id) values (?, ?)
	public void testSave() {
		OO1PK_Wife wife = new OO1PK_Wife();
		wife.setName("Rong");
		OO1PK_Husband husband = new OO1PK_Husband();
		husband.setName("Song");
		husband.setWife(wife);
		//会自动保存Wife，這是一对一主键关联的特性
		//因此不会出现TrancientObjectException
		save(husband);
	}

	// select oo1pk_husb0_.id as id1_0_0_, oo1pk_husb0_.name as name2_0_0_ from OO1PK_Husband oo1pk_husb0_ where oo1pk_husb0_.id=?
	// select oo1pk_wife0_.id as id1_1_0_, oo1pk_wife0_.name as name2_1_0_ from OO1PK_Wife oo1pk_wife0_ where oo1pk_wife0_.id=?
	public void testGet() {
		OO1PK_Husband husband = session.get(OO1PK_Husband.class, 1);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo1pk_husb0_.id as id1_0_0_, oo1pk_husb0_.name as name2_0_0_ from OO1PK_Husband oo1pk_husb0_ where oo1pk_husb0_.id=?
	// select oo1pk_wife0_.id as id1_1_0_, oo1pk_wife0_.name as name2_1_0_ from OO1PK_Wife oo1pk_wife0_ where oo1pk_wife0_.id=?
	public void testLoad() {
		OO1PK_Husband husband = session.load(OO1PK_Husband.class, 1);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo1pk_husb0_.id as id1_0_0_, oo1pk_husb0_.name as name2_0_0_ from OO1PK_Husband oo1pk_husb0_ where oo1pk_husb0_.id=?
	// select oo1pk_wife0_.id as id1_1_0_, oo1pk_wife0_.name as name2_1_0_ from OO1PK_Wife oo1pk_wife0_ where oo1pk_wife0_.id=?
	// update OO1PK_Husband set name=? where id=?
	// update OO1PK_Wife set name=? where id=?
	public void testUpdate() {
		OO1PK_Husband husband = session.load(OO1PK_Husband.class, 1);
		husband.setName("Jason");
		husband.getWife().setName("Vicky");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_CI47KSXTE0YAEJWOY1YMTCMOL) - 已找到子记录
	public void testDeleteWife() {
		OO1PK_Husband husband = session.load(OO1PK_Husband.class, 1);
		session.delete(husband.getWife());
	}

	// select oo1pk_husb0_.id as id1_0_0_, oo1pk_husb0_.name as name2_0_0_ from OO1PK_Husband oo1pk_husb0_ where oo1pk_husb0_.id=?
	// delete from OO1PK_Husband where id=?
	public void testDeleteHusband() {
		OO1PK_Husband husband = session.load(OO1PK_Husband.class, 1);
		session.delete(husband);
	}

	// select oo1pk_husb0_.id as id1_0_0_, oo1pk_husb0_.name as name2_0_0_ from OO1PK_Husband oo1pk_husb0_ where oo1pk_husb0_.id=?
	// select oo1pk_wife0_.id as id1_1_0_, oo1pk_wife0_.name as name2_1_0_ from OO1PK_Wife oo1pk_wife0_ where oo1pk_wife0_.id=?
	// delete from OO1PK_Husband where id=?
	// delete from OO1PK_Wife where id=?
	public void testDeleteHusbandWife() {
		OO1PK_Husband husband = session.load(OO1PK_Husband.class, 1);
		session.delete(husband);
		session.delete(husband.getWife());
	}

}
