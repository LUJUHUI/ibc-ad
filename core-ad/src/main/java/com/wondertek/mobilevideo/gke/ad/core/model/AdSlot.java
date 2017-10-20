package com.wondertek.mobilevideo.gke.ad.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "ad_slot")//广告位
public class AdSlot {
		private static final long serialVersionUID = 467620661858607767L;
	 
		private int id;                          //广告位Id
		private String slotName;				 //广告位名称
		private Integer navig;						 //导航
		private Integer channelId;				 //导航频道ID
		private Integer type;					 //广告位类型
		private Integer width;					 //广告位宽度
		private Integer height;					 //广告位高度
		private String status;					 //广告位状态
		private String remark;					 //备注
		private Date createTime;				 //创建时间
		private Integer createrId;				 //创建人
		private Date updateTime;				 //修改时间
		private Integer updateId;				 //修改人
		
		@Id
		@GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_SLOT_SEQ")
		@SequenceGenerator(name = "AD_SLOT_SEQ", allocationSize = 1, sequenceName = "AD_SLOT_SEQ")
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		@Column(name = "slot_name")
		public String getSlotName() {
			return slotName;
		}
		public void setSlotName(String slotName) {
			this.slotName = slotName;
		}
		@Column(name = "navig")
		public Integer getNavig() {
			return navig;
		}
		public void setNavig(Integer navig) {
			this.navig = navig;
		}
		@Column(name = "channel_id")
		public Integer getChannelId() {
			return channelId;
		}
		public void setChannelId(Integer channelId) {
			this.channelId = channelId;
		}
		@Column(name = "type_")
		public Integer getType() {
			return type;
		}
		public void setType(Integer type) {
			this.type = type;
		}
		@Column(name = "width_")
		public Integer getWidth() {
			return width;
		}
		public void setWidth(Integer width) {
			this.width = width;
		}
		@Column(name = "height_")
		public Integer getHeight() {
			return height;
		}
		public void setHeight(Integer height) {
			this.height = height;
		}
		@Column(name = "status_")
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		@Column(name = "remark_")
		public String getRemark() {
			return remark;
		}
		public void setRemark(String remark) {
			this.remark = remark;
		}
		@Column(name = "create_time")
		public Date getCreateTime() {
			return createTime;
		}
		public void setCreateTime(Date createTime) {
			this.createTime = createTime;
		}
		@Column(name = "create_id")
		public Integer getCreaterId() {
			return createrId;
		}
		public void setCreaterId(Integer createrId) {
			this.createrId = createrId;
		}
		@Column(name = "update_time")
		public Date getUpdateTime() {
			return updateTime;
		}
		public void setUpdateTime(Date updateTime) {
			this.updateTime = updateTime;
		}
		@Column(name = "update_id")
		public Integer getUpdateId() {
			return updateId;
		}
		public void setUpdateId(Integer updateId) {
			this.updateId = updateId;
		}
	 
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((channelId == null) ? 0 : channelId.hashCode());
			result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
			result = prime * result + ((createrId == null) ? 0 : createrId.hashCode());
			result = prime * result + ((height == null) ? 0 : height.hashCode());
			result = prime * result + id;
			result = prime * result + ((navig == null) ? 0 : navig.hashCode());
			result = prime * result + ((remark == null) ? 0 : remark.hashCode());
			result = prime * result + ((slotName == null) ? 0 : slotName.hashCode());
			result = prime * result + ((status == null) ? 0 : status.hashCode());
			result = prime * result + ((type == null) ? 0 : type.hashCode());
			result = prime * result + ((updateId == null) ? 0 : updateId.hashCode());
			result = prime * result + ((updateTime == null) ? 0 : updateTime.hashCode());
			result = prime * result + ((width == null) ? 0 : width.hashCode());
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
			AdSlot other = (AdSlot) obj;
			if (channelId == null) {
				if (other.channelId != null)
					return false;
			} else if (!channelId.equals(other.channelId))
				return false;
			if (createTime == null) {
				if (other.createTime != null)
					return false;
			} else if (!createTime.equals(other.createTime))
				return false;
			if (createrId == null) {
				if (other.createrId != null)
					return false;
			} else if (!createrId.equals(other.createrId))
				return false;
			if (height == null) {
				if (other.height != null)
					return false;
			} else if (!height.equals(other.height))
				return false;
			if (id != other.id)
				return false;
			if (navig == null) {
				if (other.navig != null)
					return false;
			} else if (!navig.equals(other.navig))
				return false;
			if (remark == null) {
				if (other.remark != null)
					return false;
			} else if (!remark.equals(other.remark))
				return false;
			if (slotName == null) {
				if (other.slotName != null)
					return false;
			} else if (!slotName.equals(other.slotName))
				return false;
			if (status == null) {
				if (other.status != null)
					return false;
			} else if (!status.equals(other.status))
				return false;
			if (type == null) {
				if (other.type != null)
					return false;
			} else if (!type.equals(other.type))
				return false;
			if (updateId == null) {
				if (other.updateId != null)
					return false;
			} else if (!updateId.equals(other.updateId))
				return false;
			if (updateTime == null) {
				if (other.updateTime != null)
					return false;
			} else if (!updateTime.equals(other.updateTime))
				return false;
			if (width == null) {
				if (other.width != null)
					return false;
			} else if (!width.equals(other.width))
				return false;
			return true;
		}
		@Override
		public String toString() {
			return "AdSlot [id=" + id + ", slotName=" + slotName + ", navig=" + navig + ", channelId=" + channelId
					+ ", type=" + type + ", width=" + width + ", height=" + height + ", status=" + status + ", remark="
					+ remark + ", createTime=" + createTime + ", createrId=" + createrId + ", updateTime=" + updateTime
					+ ", updateId=" + updateId + "]";
		}

		
}
