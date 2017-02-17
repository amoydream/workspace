package jason.ss.tao.user.entity;

import java.util.Date;

import jason.ss.tao.base.entity.BaseEntity;

public class User implements BaseEntity {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	private String				name;
	private String				passwd;
	private Date				birthday;
	private String				gender;
	private String				address;
	private String				phone;
	private String				email;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", passwd=" + passwd + ", birthday=" + birthday + ", gender=" + gender + ", address=" + address + ", phone=" + phone + ", email=" + email + "]";
	}
}
