package com.wondertek.mobilevideo.gke.ad.core.model;

import java.awt.*;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "ad_log")//广告位
public class AdLog {
			public enum AdLogOperType {
	        TYPE_101(301), TYPE_102(302),TYPE_103(303);
	        
	        private final int _type;
	
	        private AdLogOperType(int _type) {
	            this._type = _type;
	        }
	
	        public int get_type() {
	            return _type;
	        }
	    }
		private static final long serialVersionUID = 467620661858607767L;
		
		private Integer id;                          //日志Id
		private Integer operType;				     //操作名称
		private String operResult;					 //操作结果
		private String operName;				     //操作人
		private Date createTime;					 //创建时间
		
		@Id
		@GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_LOG_SEQ")
		@SequenceGenerator(name = "AD_LOG_SEQ", allocationSize = 1, sequenceName = "AD_LOG_SEQ")
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		@Column(name = "oper_type")
		public Integer getOperType() {
			return operType;
		}
		public void setOperType(Integer operType) {
			this.operType = operType;
		}
		@Column(name = "oper_result")
		public String getOperResult() {
			return operResult;
		}
		public void setOperResult(String operResult) {
			this.operResult = operResult;
		}
		@Column(name = "oper_name")
		public String getOperName() {
			return operName;
		}
		public void setOperName(String operName) {
			this.operName = operName;
		}
		@Column(name = "create_time")
		public Date getCreateTime() {
			return createTime;
		}
		public void setCreateTime(Date createTime) {
			this.createTime = createTime;
		}
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
			result = prime * result + ((id == null) ? 0 : id.hashCode());
			result = prime * result + ((operName == null) ? 0 : operName.hashCode());
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
			if (operName == null) {
				if (other.operName != null)
					return false;
			} else if (!operName.equals(other.operName))
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
			return "AdLog [id=" + id + ", operType=" + operType + ", operResult=" + operResult + ", operName="
					+ operName + ", createTime=" + createTime + "]";
		}
	 
	  
	 
	    
}
