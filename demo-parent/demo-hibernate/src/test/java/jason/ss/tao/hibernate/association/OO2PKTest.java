package jason.ss.tao.hibernate.association;

import jason.ss.tao.entity.association.OO2PK_Husband;
import jason.ss.tao.entity.association.OO2PK_Wife;
import jason.ss.tao.hibernate.HibernateTest;

//一对一双向主键关联，OO2PK_Husband端维护关联关系
//加载一端将自动加载另一端
public class OO2PKTest extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave();
	}

	// insert into OO2PK_Wife (name, id) values (?, ?)
	// insert into OO2PK_Husband (name, id) values (?, ?)
	public void testSave() {
		OO2PK_Wife wife = new OO2PK_Wife();
		wife.setName("Rong");
		OO2PK_Husband husband = new OO2PK_Husband();
		wife.setHusband(husband);
		husband.setName("Song");
		husband.setWife(wife);
		//先自动保存Wife
		save(husband);
	}

	// select oo2pk_husb0_.id as id1_0_0_, oo2pk_husb0_.name as name2_0_0_ from OO2PK_Husband oo2pk_husb0_ where oo2pk_husb0_.id=?
	// select oo2pk_wife0_.id as id1_1_0_, oo2pk_wife0_.name as name2_1_0_, oo2pk_husb1_.id as id1_0_1_, oo2pk_husb1_.name as name2_0_1_ from OO2PK_Wife oo2pk_wife0_, OO2PK_Husband oo2pk_husb1_ where oo2pk_wife0_.id=oo2pk_husb1_.id(+) and oo2pk_wife0_.id=?
	public void testGetHusband() {
		OO2PK_Husband husband = session.get(OO2PK_Husband.class, 1);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo2pk_wife0_.id as id1_1_0_, oo2pk_wife0_.name as name2_1_0_, oo2pk_husb1_.id as id1_0_1_, oo2pk_husb1_.name as name2_0_1_ from OO2PK_Wife oo2pk_wife0_, OO2PK_Husband oo2pk_husb1_ where oo2pk_wife0_.id=oo2pk_husb1_.id(+) and oo2pk_wife0_.id=?
	public void testGetWife() {
		OO2PK_Wife wife = session.get(OO2PK_Wife.class, 1);
		assertEquals(wife.getName(), "Rong");
		assertEquals(wife.getHusband().getName(), "Song");
	}

	// select oo2pk_husb0_.id as id1_0_0_, oo2pk_husb0_.name as name2_0_0_ from OO2PK_Husband oo2pk_husb0_ where oo2pk_husb0_.id=?
	// select oo2pk_wife0_.id as id1_1_0_, oo2pk_wife0_.name as name2_1_0_, oo2pk_husb1_.id as id1_0_1_, oo2pk_husb1_.name as name2_0_1_ from OO2PK_Wife oo2pk_wife0_, OO2PK_Husband oo2pk_husb1_ where oo2pk_wife0_.id=oo2pk_husb1_.id(+) and oo2pk_wife0_.id=?
	public void testLoadHusband() {
		OO2PK_Husband husband = session.load(OO2PK_Husband.class, 1);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo2pk_wife0_.id as id1_1_0_, oo2pk_wife0_.name as name2_1_0_, oo2pk_husb1_.id as id1_0_1_, oo2pk_husb1_.name as name2_0_1_ from OO2PK_Wife oo2pk_wife0_, OO2PK_Husband oo2pk_husb1_ where oo2pk_wife0_.id=oo2pk_husb1_.id(+) and oo2pk_wife0_.id=?
	public void testLoadWife() {
		OO2PK_Wife wife = session.load(OO2PK_Wife.class, 1);
		assertEquals(wife.getName(), "Rong");
		assertEquals(wife.getHusband().getName(), "Song");
	}

	// select oo2pk_husb0_.id as id1_0_0_, oo2pk_husb0_.name as name2_0_0_ from OO2PK_Husband oo2pk_husb0_ where oo2pk_husb0_.id=?
	// select oo2pk_wife0_.id as id1_1_0_, oo2pk_wife0_.name as name2_1_0_, oo2pk_husb1_.id as id1_0_1_, oo2pk_husb1_.name as name2_0_1_ from OO2PK_Wife oo2pk_wife0_, OO2PK_Husband oo2pk_husb1_ where oo2pk_wife0_.id=oo2pk_husb1_.id(+) and oo2pk_wife0_.id=?
	// update OO2PK_Husband set name=? where id=?
	// update OO2PK_Wife set name=? where id=?
	public void testUpdate() {
		OO2PK_Husband husband = session.load(OO2PK_Husband.class, 1);
		husband.setName("Jason");
		husband.getWife().setName("Vicky");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_GPC8A933U4WSRSKFRMUK57KS2) - 已找到子记录
	public void testDeleteWife() {
		OO2PK_Husband husband = session.load(OO2PK_Husband.class, 1);
		session.delete(husband.getWife());
	}

	// delete from OO2PK_Husband where id=?
	public void testDeleteHusband() {
		OO2PK_Husband husband = session.load(OO2PK_Husband.class, 1);
		session.delete(husband);
	}

	// delete from OO2PK_Husband where id=?
	// delete from OO2PK_Wife where id=?
	public void testDeleteHusbandWife() {
		OO2PK_Husband husband = session.load(OO2PK_Husband.class, 1);
		session.delete(husband);
		session.delete(husband.getWife());
	}

}
