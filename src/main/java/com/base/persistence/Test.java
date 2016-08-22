package com.base.persistence;
import javax.persistence.*;

/**
 * 
 * 测试表
 * 
 **/
@Entity
@Table(name = "t_test")
public class Test{

	/****/
	@Column(name = "iAutoId")
	@Id
	private Integer iautoId;

	/**年龄**/
	@Column(name = "iValue")
	private Integer ivalue;

	/**姓名**/
	@Column(name = "sName")
	private String sname;

	/****/
	@Column(name = "itset")
	private Integer itset;



	public void setIautoId(Integer iautoId){
		this.iautoId=iautoId;
	}

	public Integer getIautoId(){
		return this.iautoId;
	}

	public void setIvalue(Integer ivalue){
		this.ivalue=ivalue;
	}

	public Integer getIvalue(){
		return this.ivalue;
	}

	public void setSname(String sname){
		this.sname=sname;
	}

	public String getSname(){
		return this.sname;
	}

	public void setItset(Integer itset){
		this.itset=itset;
	}

	public Integer getItset(){
		return this.itset;
	}

}
