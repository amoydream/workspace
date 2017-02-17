package jason.ss.tao.user.model;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import jason.ss.tao.base.model.BaseDto;

@Component(value = "userDto")
@Scope(value = "prototype")
public class UserDto implements BaseDto {
	private static final long	serialVersionUID	= 1L;
	private Integer				id;
	@NotEmpty(message = "{validation.common.empty}")
	private String				name;
	private String				passwd;
	private Date				birthday;
	private String				gender;
	private String				address;
	private String				phone;
	@Email(message = "{validation.common.email}")
	private String				email;

	@Override
	public Serializable getDtoId() {
		return id;
	}

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

}
