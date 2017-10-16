package com.wondertek.mobilevideo.bc.core.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.struts2.json.annotations.JSON;

@Entity
@Table(name = "auth_verify_log")
public class AuthVerifyLog implements Serializable {
	/**
	 * 播放鉴权日志
	 */
	private static final long serialVersionUID = 467620661858607767L;
	@Id
	@Column(name = "id")
	private int id;
	@Column(name = "code_")
	private String code;
	@Column(name = "type_")
	private String type;
	@Column(name = "req_text")
	private String reqText;
	@Column(name = "res_text")
	private String resText;
	@Column(name = "result_")
	private String result;
	@Column(name = "create_time")
	private Date createTime = new Date();
	@Column(name = "operate_time_ms")
	private long operateTimeMS;
	/** 1：百视通内容 */
	public static final String TYPE_1 = "1";
	/** 2：中兴ADI内容 */
	public static final String TYPE_2 = "2";
	public static final String RESULT_SUCCESS = "success";
	public static final String RESULT_FALURE = "falure";
	public static final String TYPE_STR = "type";
	public static final String CODE_STR = "code";

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getReqText() {
		return reqText;
	}

	public void setReqText(String reqText) {
		this.reqText = reqText;
	}

	public String getResText() {
		return resText;
	}

	public void setResText(String resText) {
		this.resText = resText;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	@JSON(format = "yyyy-MM-dd HH:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public long getOperateTimeMS() {
		return operateTimeMS;
	}
	public void setOperateTimeMS(long operateTimeMS) {
		this.operateTimeMS = operateTimeMS;
	}

	@Override
	public String toString() {
		return "AuthVerifyLog [id=" + id + ", code=" + code + ", type=" + type + ", reqText=" + reqText + ", resText="
				+ resText + ", result=" + result + ", createTime=" + createTime + ", operateTimeMS=" + operateTimeMS
				+ "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
		result = prime * result + id;
		result = prime * result + (int) (operateTimeMS ^ (operateTimeMS >>> 32));
		result = prime * result + ((reqText == null) ? 0 : reqText.hashCode());
		result = prime * result + ((resText == null) ? 0 : resText.hashCode());
		result = prime * result + ((this.result == null) ? 0 : this.result.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AuthVerifyLog other = (AuthVerifyLog) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (createTime == null) {
			if (other.createTime != null)
				return false;
		} else if (!createTime.equals(other.createTime))
			return false;
		if (id != other.id)
			return false;
		if (operateTimeMS != other.operateTimeMS)
			return false;
		if (reqText == null) {
			if (other.reqText != null)
				return false;
		} else if (!reqText.equals(other.reqText))
			return false;
		if (resText == null) {
			if (other.resText != null)
				return false;
		} else if (!resText.equals(other.resText))
			return false;
		if (result == null) {
			if (other.result != null)
				return false;
		} else if (!result.equals(other.result))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}
	
}
