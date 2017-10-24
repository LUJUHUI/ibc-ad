package com.wondertek.mobilevideo.gke.ad.core.model;

import org.apache.struts2.json.annotations.JSON;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ad_ad")
public class AdAd implements Serializable {


    public enum AdadStatus {
        STATUS_101(101), STATUS_102(102),STATUS_103(103), STATUS_104(104), STATUS_105(105);
        
        private final int adStatus;

        private AdadStatus(int _status) {
            this.adStatus = _status;
        }

        public int getAdStatus() {
            return adStatus;
        }
    }

    private Long id;			//id
	private Long soltId;		//广告位id
	private String adName;		//广告名称
	private Date startTime;		//广告生效时间 
	private Date endTime;		//广告结束时间
	private int status;			//状态 101:草稿，102：待投放，103：投放中，104：投放完成，105：删除
	private String remark;		//备注
	private Date createTime = new Date();	//创建时间
	private String createId;	//创建人
	private Date updateTime = new Date();	//更新时间
	private String updateId;	//更新人

	public AdAd() {
		super();
	}

	public AdAd(Long id) {
		this.id = id;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_AD_SEQ")
	@SequenceGenerator(name = "AD_AD_SEQ", allocationSize = 1, sequenceName = "AD_AD_SEQ")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "solt_id")
	public Long getSoltId() {
		return soltId;
	}

	public void setSoltId(Long soltId) {
		this.soltId = soltId;
	}

	@Column(name = "ad_name")
	public String getAdName() {
		return adName;
	}

	public void setAdName(String adName) {
		this.adName = adName;
	}

	@JSON(format = "yyyy-MM-dd HH:mm")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="start_time")
	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	@JSON(format = "yyyy-MM-dd HH:mm")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "end_time")
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	@Column(name = "status_")
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Column(name = "remark_")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSON(format = "yyyy-MM-dd HH:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_time")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "create_id")
	public String getCreateId() {
		return createId;
	}

	public void setCreateId(String createId) {
		this.createId = createId;
	}
	@JSON(format = "yyyy-MM-dd HH:mm:ss")
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_time")
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	@Column(name = "update_id")
	public String getUpdateId() {
		return updateId;
	}

	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}

	@Override
	public String toString() {
		return "AdAd{" +
				"id=" + id +
				", soltId=" + soltId +
				", adName='" + adName + '\'' +
				", startTime=" + startTime +
				", endTime=" + endTime +
				", status=" + status +
				", remark='" + remark + '\'' +
				", createTime=" + createTime +
				", createId='" + createId + '\'' +
				", updateTime=" + updateTime +
				", updateId='" + updateId + '\'' +
				'}';
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		AdAd adAd = (AdAd) o;

		if (status != adAd.status) return false;
		if (id != null ? !id.equals(adAd.id) : adAd.id != null) return false;
		if (soltId != null ? !soltId.equals(adAd.soltId) : adAd.soltId != null) return false;
		if (adName != null ? !adName.equals(adAd.adName) : adAd.adName != null) return false;
		if (startTime != null ? !startTime.equals(adAd.startTime) : adAd.startTime != null) return false;
		if (endTime != null ? !endTime.equals(adAd.endTime) : adAd.endTime != null) return false;
		if (remark != null ? !remark.equals(adAd.remark) : adAd.remark != null) return false;
		if (createTime != null ? !createTime.equals(adAd.createTime) : adAd.createTime != null) return false;
		if (createId != null ? !createId.equals(adAd.createId) : adAd.createId != null) return false;
		if (updateTime != null ? !updateTime.equals(adAd.updateTime) : adAd.updateTime != null) return false;
		return updateId != null ? updateId.equals(adAd.updateId) : adAd.updateId == null;
	}

	@Override
	public int hashCode() {
		int result = id != null ? id.hashCode() : 0;
		result = 31 * result + (soltId != null ? soltId.hashCode() : 0);
		result = 31 * result + (adName != null ? adName.hashCode() : 0);
		result = 31 * result + (startTime != null ? startTime.hashCode() : 0);
		result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
		result = 31 * result + status;
		result = 31 * result + (remark != null ? remark.hashCode() : 0);
		result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
		result = 31 * result + (createId != null ? createId.hashCode() : 0);
		result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
		result = 31 * result + (updateId != null ? updateId.hashCode() : 0);
		return result;
	}
}
