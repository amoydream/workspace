package jason.ss.tao.hibernate.association;

import jason.ss.tao.entity.association.OO2UFK_Husband;
import jason.ss.tao.entity.association.OO2UFK_Wife;
import jason.ss.tao.hibernate.HibernateTest;

//一对一双向唯一外键关联，OO2UFK_Husband端维护关联关系
//加载一端将自动加载另一端
public class OO2UFKTest extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave2();
	}

	//org.hibernate.TransientObjectException: object references an unsaved transient instance - save the transient instance before flushing: jason.ss.tao.entity.association.OO2UFK_Wife
	public void testSave1() {
		OO2UFK_Wife wife = new OO2UFK_Wife();
		wife.setName("Rong");
		OO2UFK_Husband husband = new OO2UFK_Husband();
		wife.setHusband(husband);
		husband.setName("Song");
		husband.setWife(wife);
		// 必须先保存Wife，否则出现TransientObjectException
		save(husband);
	}

	// insert into OO2UFK_Wife (name, id) values (?, ?)
	// insert into OO2UFK_Husband (name, WIFE_ID, id) values (?, ?, ?)
	public void testSave2() {
		OO2UFK_Wife wife = new OO2UFK_Wife();
		wife.setName("Rong");
		OO2UFK_Husband husband = new OO2UFK_Husband();
		wife.setHusband(husband);
		husband.setName("Song");
		husband.setWife(wife);
		save(wife, husband);
	}

	// select oo2ufk_hus0_.id as id1_0_0_, oo2ufk_hus0_.name as name2_0_0_, oo2ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO2UFK_Husband oo2ufk_hus0_ where oo2ufk_hus0_.id=?
	// select oo2ufk_wif0_.id as id1_1_0_, oo2ufk_wif0_.name as name2_1_0_, oo2ufk_hus1_.id as id1_0_1_, oo2ufk_hus1_.name as name2_0_1_, oo2ufk_hus1_.WIFE_ID as WIFE_ID3_0_1_ from OO2UFK_Wife oo2ufk_wif0_, OO2UFK_Husband oo2ufk_hus1_ where oo2ufk_wif0_.id=oo2ufk_hus1_.WIFE_ID(+) and oo2ufk_wif0_.id=?
	// select oo2ufk_hus0_.id as id1_0_0_, oo2ufk_hus0_.name as name2_0_0_, oo2ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO2UFK_Husband oo2ufk_hus0_ where oo2ufk_hus0_.WIFE_ID=?
	public void testGetHusband() {
		OO2UFK_Husband husband = session.get(OO2UFK_Husband.class, 2);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo2ufk_wif0_.id as id1_1_0_, oo2ufk_wif0_.name as name2_1_0_, oo2ufk_hus1_.id as id1_0_1_, oo2ufk_hus1_.name as name2_0_1_, oo2ufk_hus1_.WIFE_ID as WIFE_ID3_0_1_ from OO2UFK_Wife oo2ufk_wif0_, OO2UFK_Husband oo2ufk_hus1_ where oo2ufk_wif0_.id=oo2ufk_hus1_.WIFE_ID(+) and oo2ufk_wif0_.id=?
	public void testGetWife() {
		OO2UFK_Wife wife = session.get(OO2UFK_Wife.class, 1);
		assertEquals(wife.getName(), "Rong");
		assertEquals(wife.getHusband().getName(), "Song");
	}

	// select oo2ufk_hus0_.id as id1_0_0_, oo2ufk_hus0_.name as name2_0_0_, oo2ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO2UFK_Husband oo2ufk_hus0_ where oo2ufk_hus0_.id=?
	// select oo2ufk_wif0_.id as id1_1_0_, oo2ufk_wif0_.name as name2_1_0_, oo2ufk_hus1_.id as id1_0_1_, oo2ufk_hus1_.name as name2_0_1_, oo2ufk_hus1_.WIFE_ID as WIFE_ID3_0_1_ from OO2UFK_Wife oo2ufk_wif0_, OO2UFK_Husband oo2ufk_hus1_ where oo2ufk_wif0_.id=oo2ufk_hus1_.WIFE_ID(+) and oo2ufk_wif0_.id=?
	// select oo2ufk_hus0_.id as id1_0_0_, oo2ufk_hus0_.name as name2_0_0_, oo2ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO2UFK_Husband oo2ufk_hus0_ where oo2ufk_hus0_.WIFE_ID=?
	public void testLoadHusband() {
		OO2UFK_Husband husband = session.load(OO2UFK_Husband.class, 2);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo2ufk_wif0_.id as id1_1_0_, oo2ufk_wif0_.name as name2_1_0_, oo2ufk_hus1_.id as id1_0_1_, oo2ufk_hus1_.name as name2_0_1_, oo2ufk_hus1_.WIFE_ID as WIFE_ID3_0_1_ from OO2UFK_Wife oo2ufk_wif0_, OO2UFK_Husband oo2ufk_hus1_ where oo2ufk_wif0_.id=oo2ufk_hus1_.WIFE_ID(+) and oo2ufk_wif0_.id=?
	public void testLoadWife() {
		OO2UFK_Wife wife = session.load(OO2UFK_Wife.class, 1);
		assertEquals(wife.getName(), "Rong");
		assertEquals(wife.getHusband().getName(), "Song");
	}

	// select oo2ufk_hus0_.id as id1_0_0_, oo2ufk_hus0_.name as name2_0_0_, oo2ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO2UFK_Husband oo2ufk_hus0_ where oo2ufk_hus0_.id=?
	// select oo2ufk_wif0_.id as id1_1_0_, oo2ufk_wif0_.name as name2_1_0_, oo2ufk_hus1_.id as id1_0_1_, oo2ufk_hus1_.name as name2_0_1_, oo2ufk_hus1_.WIFE_ID as WIFE_ID3_0_1_ from OO2UFK_Wife oo2ufk_wif0_, OO2UFK_Husband oo2ufk_hus1_ where oo2ufk_wif0_.id=oo2ufk_hus1_.WIFE_ID(+) and oo2ufk_wif0_.id=?
	// select oo2ufk_hus0_.id as id1_0_0_, oo2ufk_hus0_.name as name2_0_0_, oo2ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO2UFK_Husband oo2ufk_hus0_ where oo2ufk_hus0_.WIFE_ID=?
	// update OO2UFK_Husband set name=?, WIFE_ID=? where id=?
	// update OO2UFK_Wife set name=? where id=?
	public void testUpdate() {
		OO2UFK_Husband husband = session.load(OO2UFK_Husband.class, 2);
		husband.setName("Jason");
		husband.getWife().setName("Vicky");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_E1F6P9YMOU0OEUNOLQD5XKP2U) - 已找到子记录
	public void testDeleteWife() {
		OO2UFK_Wife wife = session.load(OO2UFK_Wife.class, 1);
		session.delete(wife);
	}

	// delete from OO2UFK_Husband where id=?
	public void testDeleteHusband() {
		OO2UFK_Husband husband = session.load(OO2UFK_Husband.class, 2);
		session.delete(husband);
	}

	// delete from OO2UFK_Husband where id=?
	// delete from OO2UFK_Wife where id=?
	public void testDeleteHusbandWife() {
		OO2UFK_Husband husband = session.load(OO2UFK_Husband.class, 2);
		session.delete(husband);
		session.delete(husband.getWife());
	}

}
