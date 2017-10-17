package com.wondertek.mobilevideo.gke.ad.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ad_log")//广告位
public class AdLog {
		private static final long serialVersionUID = 467620661858607767L;
		@Id
		@Column(name = "id_")
		private Integer id;                          //广告位Id
		@Column(name = "oper_type")
		private Integer operType;				 //广告位名称
		@Column(name = "oper_result")
		private String operResult;						 //导航
		@Column(name = "oper_id")
		private Integer operId;				 //导航频道ID
		@Column(name = "create_time")
		private String createTime;					 //广告位类型
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public Integer getOperType() {
			return operType;
		}
		public void setOperType(Integer operType) {
			this.operType = operType;
		}
		public String getOperResult() {
			return operResult;
		}
		public void setOperResult(String operResult) {
			this.operResult = operResult;
		}
		public Integer getOperId() {
			return operId;
		}
		public void setOperId(Integer operId) {
			this.operId = operId;
		}
		public String getCreateTime() {
			return createTime;
		}
		public void setCreateTime(String createTime) {
			this.createTime = createTime;
		}
		public static long getSerialversionuid() {
			return serialVersionUID;
		}
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
			result = prime * result + ((id == null) ? 0 : id.hashCode());
			result = prime * result + ((operId == null) ? 0 : operId.hashCode());
			result = prime * result + ((operResult == null) ? 0 : operResult.hashCode());
			result = prime * result + ((operType == null) ? 0 : operType.hashCode());
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
			AdLog other = (AdLog) obj;
			if (createTime == null) {
				if (other.createTime != null)
					return false;
			} else if (!createTime.equals(other.createTime))
				return false;
			if (id == null) {
				if (other.id != null)
					return false;
			} else if (!id.equals(other.id))
				return false;
			if (operId == null) {
				if (other.operId != null)
					return false;
			} else if (!operId.equals(other.operId))
				return false;
			if (operResult == null) {
				if (other.operResult != null)
					return false;
			} else if (!operResult.equals(other.operResult))
				return false;
			if (operType == null) {
				if (other.operType != null)
					return false;
			} else if (!operType.equals(other.operType))
				return false;
			return true;
		}
		@Override
		public String toString() {
			return "AdLog [id=" + id + ", operType=" + operType + ", operResult=" + operResult + ", operId=" + operId
					+ ", createTime=" + createTime + "]";
		}
	 
	    
}
