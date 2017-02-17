package jason.ss.tao.hibernate.association;

import jason.ss.tao.entity.association.OO1UFK_Husband;
import jason.ss.tao.entity.association.OO1UFK_Wife;
import jason.ss.tao.hibernate.HibernateTest;

//一对一单向唯一外键关联，OO1UFK_Husband端维护关联关系
//加载OO1UFK_Husband将自动加载OO1UFK_Wife
public class OO1UFKTest extends HibernateTest {
	@Override
	protected void setUp() throws Exception {
		super.setUp();
		initData();
	}

	private void initData() {
		testSave2();
	}

	// org.hibernate.TransientObjectException: object references an unsaved transient instance - save the transient instance before flushing: jason.ss.tao.entity.association.OO1UFK_Wife
	public void testSave1() {
		OO1UFK_Wife wife = new OO1UFK_Wife();
		wife.setName("Rong");
		OO1UFK_Husband husband = new OO1UFK_Husband();
		husband.setName("Song");
		husband.setWife(wife);
		//必须先保存wife,否则出现TransientObjectException
		save(husband);
	}

	// insert into OO1UFK_Wife (name, id) values (?, ?)
	// insert into OO1UFK_Husband (name, WIFE_ID, id) values (?, ?, ?)
	public void testSave2() {
		OO1UFK_Wife wife = new OO1UFK_Wife();
		wife.setName("Rong");
		OO1UFK_Husband husband = new OO1UFK_Husband();
		husband.setName("Song");
		husband.setWife(wife);
		save(wife, husband);
	}

	// select oo1ufk_hus0_.id as id1_0_0_, oo1ufk_hus0_.name as name2_0_0_, oo1ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO1UFK_Husband oo1ufk_hus0_ where oo1ufk_hus0_.id=?
	// select oo1ufk_wif0_.id as id1_1_0_, oo1ufk_wif0_.name as name2_1_0_ from OO1UFK_Wife oo1ufk_wif0_ where oo1ufk_wif0_.id=?
	public void testGet() {
		OO1UFK_Husband husband = session.get(OO1UFK_Husband.class, 2);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo1ufk_hus0_.id as id1_0_0_, oo1ufk_hus0_.name as name2_0_0_, oo1ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO1UFK_Husband oo1ufk_hus0_ where oo1ufk_hus0_.id=?
	// select oo1ufk_wif0_.id as id1_1_0_, oo1ufk_wif0_.name as name2_1_0_ from OO1UFK_Wife oo1ufk_wif0_ where oo1ufk_wif0_.id=?
	public void testLoad() {
		OO1UFK_Husband husband = session.load(OO1UFK_Husband.class, 2);
		assertEquals(husband.getName(), "Song");
		assertEquals(husband.getWife().getName(), "Rong");
	}

	// select oo1ufk_hus0_.id as id1_0_0_, oo1ufk_hus0_.name as name2_0_0_, oo1ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO1UFK_Husband oo1ufk_hus0_ where oo1ufk_hus0_.id=?
	// select oo1ufk_wif0_.id as id1_1_0_, oo1ufk_wif0_.name as name2_1_0_ from OO1UFK_Wife oo1ufk_wif0_ where oo1ufk_wif0_.id=?
	// update OO1UFK_Husband set name=?, WIFE_ID=? where id=?
	// update OO1UFK_Wife set name=? where id=?
	public void testUpdate() {
		OO1UFK_Husband husband = session.load(OO1UFK_Husband.class, 2);
		husband.setName("Jason");
		husband.getWife().setName("Vicky");
	}

	// ERROR SqlExceptionHelper:146 - ORA-02292: 违反完整约束条件 (DEMO.FK_2HRKS5IMD5FP0JBDK4T981F71) - 已找到子记录
	public void testDeleteWife() {
		OO1UFK_Husband husband = session.load(OO1UFK_Husband.class, 2);
		session.delete(husband.getWife());
	}

	// select oo1ufk_hus0_.id as id1_0_0_, oo1ufk_hus0_.name as name2_0_0_, oo1ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO1UFK_Husband oo1ufk_hus0_ where oo1ufk_hus0_.id=?
	// delete from OO1UFK_Husband where id=?
	public void testDeleteHusband() {
		OO1UFK_Husband husband = session.load(OO1UFK_Husband.class, 2);
		session.delete(husband);
	}

	// select oo1ufk_hus0_.id as id1_0_0_, oo1ufk_hus0_.name as name2_0_0_, oo1ufk_hus0_.WIFE_ID as WIFE_ID3_0_0_ from OO1UFK_Husband oo1ufk_hus0_ where oo1ufk_hus0_.id=?
	// select oo1ufk_wif0_.id as id1_1_0_, oo1ufk_wif0_.name as name2_1_0_ from OO1UFK_Wife oo1ufk_wif0_ where oo1ufk_wif0_.id=?
	// delete from OO1UFK_Husband where id=?
	// delete from OO1UFK_Wife where id=?
	public void testDeleteHusbandWife() {
		OO1UFK_Husband husband = session.load(OO1UFK_Husband.class, 2);
		session.delete(husband);
		session.delete(husband.getWife());
	}

}
