package com.wondertek.mobilevideo.gke.ad.core.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ad_slot")//广告位
public class AdSlot {
		private static final long serialVersionUID = 467620661858607767L;
		@Id
		@Column(name = "id")
		private int id;
		@Column(name = "slot_name")
		private String slotName;
		@Column(name = "navig")
		private Enum navig;
		@Column(name = "channel_id")
		private Integer channelId;
		@Column(name = "type_")
		private Integer type;
		@Column(name = "width_")
		private Integer width;
		@Column(name = "height_")
		private Integer height;
		@Column(name = "status_")
		private String status;
		@Column(name = "remark_")
		private String remark;
		@Column(name = "create_time")
		private String createTime;
		@Column(name = "create_id")
		private String createrId;
		@Column(name = "update_time")
		private String updateTime;
		@Column(name = "update_id")
		private String updateId;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getSlotName() {
			return slotName;
		}
		public void setSlotName(String slotName) {
			this.slotName = slotName;
		}
		public Enum getNavig() {
			return navig;
		}
		public void setNavig(Enum navig) {
			this.navig = navig;
		}
		public Integer getChannelId() {
			return channelId;
		}
		public void setChannelId(Integer channelId) {
			this.channelId = channelId;
		}
		public Integer getType() {
			return type;
		}
		public void setType(Integer type) {
			this.type = type;
		}
		public Integer getWidth() {
			return width;
		}
		public void setWidth(Integer width) {
			this.width = width;
		}
		public Integer getHeight() {
			return height;
		}
		public void setHeight(Integer height) {
			this.height = height;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public String getRemark() {
			return remark;
		}
		public void setRemark(String remark) {
			this.remark = remark;
		}
		public String getCreateTime() {
			return createTime;
		}
		public void setCreateTime(String createTime) {
			this.createTime = createTime;
		}
		public String getCreaterId() {
			return createrId;
		}
		public void setCreaterId(String createrId) {
			this.createrId = createrId;
		}
		public String getUpdateTime() {
			return updateTime;
		}
		public void setUpdateTime(String updateTime) {
			this.updateTime = updateTime;
		}
		public String getUpdateId() {
			return updateId;
		}
		public void setUpdateId(String updateId) {
			this.updateId = updateId;
		}
		public static long getSerialversionuid() {
			return serialVersionUID;
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
