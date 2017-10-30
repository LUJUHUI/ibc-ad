package com.wondertek.mobilevideo.gke.ad.core.model;

import java.io.Serializable;
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
public class AdSlot implements Serializable {
	

	    public enum AdSlotStatus {
	        STATUS_101(101), STATUS_102(102),STATUS_103(103), STATUS_104(104), STATUS_105(105);
	        
	        private final int _status;
	
	        private AdSlotStatus(int _status) {
	            this._status = _status;
	        }
	
	        public int get_status() {
	            return _status;
	        }
	    }
	    private static final long serialVersionUID = 467620661858607767L;
		
		private int id;                          //广告位Id
		private String slotName;				 //广告位名称 
		private Integer navig;				     //导航   1.首页   2.直播   3.会员
		private Integer channelId;				 //导航频道ID
		private Integer type;					 //广告位类型 1.1：开机广告位  	2：频道广告位，漂浮形式存在 3：导航广告位，弹窗形式存在
		private String width;					 //广告位宽度
		private String height;					 //广告位高度
		private Integer status;					 //广告位状态  101 待审核、102 待使用、103使用中、104 审核失败、105 删除 
		private String remark;					 //备注
		private Date createTime;				 //创建时间
		private String createPeople;				 //创建人
		private Date updateTime;				 //修改时间
		private String updatePeople;				 //修改人
		
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
		public String getWidth() {
			return width;
		}
		public void setWidth(String width) {
			this.width = width;
		}
		@Column(name = "height_")
		public String getHeight() {
			return height;
		}
		public void setHeight(String height) {
			this.height = height;
		}
		@Column(name = "status_")
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
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
		@Column(name = "create_people")
		public String getCreatePeople() {
			return createPeople;
		}
		public void setCreatePeople(String createPeople) {
			this.createPeople = createPeople;
		}
		@Column(name = "update_time")
		public Date getUpdateTime() {
			return updateTime;
		}
		public void setUpdateTime(Date updateTime) {
			this.updateTime = updateTime;
		}
		@Column(name = "update_people")
		public String getUpdatePeople() {
			return updatePeople;
		}
		public void setUpdatePeople(String updatePeople) {
			this.updatePeople = updatePeople;
		}
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + ((channelId == null) ? 0 : channelId.hashCode());
			result = prime * result + ((createPeople == null) ? 0 : createPeople.hashCode());
			result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
			result = prime * result + ((height == null) ? 0 : height.hashCode());
			result = prime * result + id;
			result = prime * result + ((navig == null) ? 0 : navig.hashCode());
			result = prime * result + ((remark == null) ? 0 : remark.hashCode());
			result = prime * result + ((slotName == null) ? 0 : slotName.hashCode());
			result = prime * result + ((status == null) ? 0 : status.hashCode());
			result = prime * result + ((type == null) ? 0 : type.hashCode());
			result = prime * result + ((updatePeople == null) ? 0 : updatePeople.hashCode());
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
			if (createPeople == null) {
				if (other.createPeople != null)
					return false;
			} else if (!createPeople.equals(other.createPeople))
				return false;
			if (createTime == null) {
				if (other.createTime != null)
					return false;
			} else if (!createTime.equals(other.createTime))
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
			if (updatePeople == null) {
				if (other.updatePeople != null)
					return false;
			} else if (!updatePeople.equals(other.updatePeople))
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
					+ remark + ", createTime=" + createTime + ", createPeople=" + createPeople + ", updateTime="
					+ updateTime + ", updatePeople=" + updatePeople + "]";
		}
	    
		
		
}
