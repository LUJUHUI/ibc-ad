package com.wondertek.mobilevideo.gke.ad.core.model;

import java.awt.*;
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
@Table(name = "ad_material_picture")//广告位
public class AdMaterialPic implements Serializable {

    private static final long serialVersionUID = 467620661858607767L;
		
    private Long id;                          //Id
    private Long adMaterialId;                //广告素材ID
    private String picSrc;                    //图片来源
    private String picHref;                   //上传路径
    private String createPeople;              //创建人
    private Date createTime;
    

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_MATERIAL_PIC_SEQ")
    @SequenceGenerator(name = "AD_MATERIAL_PIC_SEQ", allocationSize = 1, sequenceName = "AD_MATERIAL_PIC_SEQ")
    @Column(name = "id_")
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@Column(name = "material_id")
	public Long getAdMaterialId() {
		return adMaterialId;
	}
	public void setAdMaterialId(Long adMaterialId) {
		this.adMaterialId = adMaterialId;
	}
	@Column(name = "src_")
	public String getPicSrc() {
		return picSrc;
	}
	public void setPicSrc(String picSrc) {
		this.picSrc = picSrc;
	}
	@Column(name = "click_href")
	public String getPicHref() {
		return picHref;
	}
	public void setPicHref(String picHref) {
		this.picHref = picHref;
	}
	@Column(name = "createPeople")
	public String getCreatePeople() {
		return createPeople;
	}
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}
	@Column(name = "createTime")
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}                  //创建时间
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adMaterialId == null) ? 0 : adMaterialId.hashCode());
		result = prime * result + ((createPeople == null) ? 0 : createPeople.hashCode());
		result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((picHref == null) ? 0 : picHref.hashCode());
		result = prime * result + ((picSrc == null) ? 0 : picSrc.hashCode());
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
		AdMaterialPic other = (AdMaterialPic) obj;
		if (adMaterialId == null) {
			if (other.adMaterialId != null)
				return false;
		} else if (!adMaterialId.equals(other.adMaterialId))
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
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (picHref == null) {
			if (other.picHref != null)
				return false;
		} else if (!picHref.equals(other.picHref))
			return false;
		if (picSrc == null) {
			if (other.picSrc != null)
				return false;
		} else if (!picSrc.equals(other.picSrc))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "AdMaterialPic [id=" + id + ", adMaterialId=" + adMaterialId + ", picSrc=" + picSrc + ", picHref="
				+ picHref + ", createPeople=" + createPeople + ", createTime=" + createTime + "]";
	}

    
}
