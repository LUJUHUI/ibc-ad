package com.wondertek.mobilevideo.gke.ad.core.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ad_ad_material")
public class AdAdMaterial implements Serializable {

	private Long id;
	private AdAd adId;
	private AdMaterial materialId;
	private Date createTime;
	private String createId;
	private Date updateTime;
	private String updateId;

	public AdAdMaterial() {
		super();
	}

	public AdAdMaterial(AdAd adId, AdMaterial materialId, String createId, String updateId) {
		this.adId = adId;
		this.materialId = materialId;
		this.createId = createId;
		this.updateId = updateId;
		this.createTime = new Date();
		this.updateTime = new Date();
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_AD_MATERIAL_SEQ")
	@SequenceGenerator(name = "AD_AD_MATERIAL_SEQ", allocationSize = 1, sequenceName = "AD_AD_MATERIAL_SEQ")
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ad_id", nullable = false)
	public AdAd getAdId() {
		return adId;
	}

	public void setAdId(AdAd adId) {
		this.adId = adId;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "material_id", nullable = false)
	public AdMaterial getMaterialId() {
		return materialId;
	}

	public void setMaterialId(AdMaterial materialId) {
		this.materialId = materialId;
	}

	@Column(name = "create_time", nullable = false)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	@Column(name = "create_id", nullable = false)
	public String getCreateId() {
		return createId;
	}

	public void setCreateId(String createId) {
		this.createId = createId;
	}
	@Column(name = "update_time", nullable = false)
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	@Column(name = "update_id", nullable = false)
	public String getUpdateId() {
		return updateId;
	}

	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
}
