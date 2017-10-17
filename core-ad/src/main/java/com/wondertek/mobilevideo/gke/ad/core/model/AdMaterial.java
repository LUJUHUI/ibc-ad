package com.wondertek.mobilevideo.gke.ad.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ad_material")
public class AdMaterial implements Serializable {
    @Id
    @Column(name = "id_")
    private int id;
    @Column(name = "material_name")
    private String materialName;
    @Column(name = "type_")
    private int type;
    @Column(name = "click_href")
    private String clickHref;
    @Column(name = "status_")
    private int status;
    @Column(name = "create_time")
    private Date createTime = new Date();
    @Column(name = "create_id")
    private int createId;
    @Column(name = "update_time")
    private Date updateTime = new Date();
    @Column(name = "update_id")
    private int updateId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getClickHref() {
        return clickHref;
    }

    public void setClickHref(String clickHref) {
        this.clickHref = clickHref;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getCreateId() {
        return createId;
    }

    public void setCreateId(int createId) {
        this.createId = createId;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public int getUpdateId() {
        return updateId;
    }

    public void setUpdateId(int updateId) {
        this.updateId = updateId;
    }

    @Override
    public String toString() {
        return "AdMaterial{" +
                "id=" + id +
                ", materialName='" + materialName + '\'' +
                ", type=" + type +
                ", clickHref='" + clickHref + '\'' +
                ", status=" + status +
                ", createTime=" + createTime +
                ", createId=" + createId +
                ", updateTime=" + updateTime +
                ", updateId=" + updateId +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AdMaterial that = (AdMaterial) o;

        if (id != that.id) return false;
        if (type != that.type) return false;
        if (status != that.status) return false;
        if (createId != that.createId) return false;
        if (updateId != that.updateId) return false;
        if (materialName != null ? !materialName.equals(that.materialName) : that.materialName != null) return false;
        if (clickHref != null ? !clickHref.equals(that.clickHref) : that.clickHref != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        return updateTime != null ? updateTime.equals(that.updateTime) : that.updateTime == null;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (materialName != null ? materialName.hashCode() : 0);
        result = prime * result + type;
        result = prime * result + (clickHref != null ? clickHref.hashCode() : 0);
        result = prime * result + status;
        result = prime * result + (createTime != null ? createTime.hashCode() : 0);
        result = prime * result + createId;
        result = prime * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = prime * result + updateId;
        return result;
    }
}
