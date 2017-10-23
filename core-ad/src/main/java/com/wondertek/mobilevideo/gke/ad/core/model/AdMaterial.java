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
    // 待审核
    private int WAIT_CHECK_STATUS = 101;
    // 审核通过
    private int CHECK_STATUS_SUCCESS = 102;
    //审核失败
    private int CHECK_STATUS_FAILED = 103;
    // 已删除
    private int ALREADY_DELETED_STATUS = 104;
    //已使用
    private int ALREADY_USED_STATUS = 105;

    @Id
    @Column(name = "id_")
    private int id;  // 素材ID
    @Column(name = "material_name")
    private String materialName; //广告素材名
    @Column(name = "type_")
    private int type;    //素材类型  1:图片;2:文字
    @Column(name = "click_href")
    private String clickHref;  // 链接地址
    @Column(name = "status_")
    private int status;  // 审核状态  101:待审核;102:审核通过;103:审核失败;104:已删除;105:已使用
    @Column(name = "create_time")
    private Date createTime = new Date();  //创建时间
    @Column(name = "create_id")
    private int createId;       //创建者ID
    @Column(name = "update_time")
    private Date updateTime = new Date();   //修改时间
    @Column(name = "update_id")
    private int updateId;   //修改者ID

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

    public int getWAIT_CHECK_STATUS() {
        return WAIT_CHECK_STATUS;
    }

    public void setWAIT_CHECK_STATUS(int WAIT_CHECK_STATUS) {
        this.WAIT_CHECK_STATUS = WAIT_CHECK_STATUS;
    }

    public int getCHECK_STATUS_SUCCESS() {
        return CHECK_STATUS_SUCCESS;
    }

    public void setCHECK_STATUS_SUCCESS(int CHECK_STATUS_SUCCESS) {
        this.CHECK_STATUS_SUCCESS = CHECK_STATUS_SUCCESS;
    }

    public int getCHECK_STATUS_FAILED() {
        return CHECK_STATUS_FAILED;
    }

    public void setCHECK_STATUS_FAILED(int CHECK_STATUS_FAILED) {
        this.CHECK_STATUS_FAILED = CHECK_STATUS_FAILED;
    }

    public int getALREADY_DELETED_STATUS() {
        return ALREADY_DELETED_STATUS;
    }

    public void setALREADY_DELETED_STATUS(int ALREADY_DELETED_STATUS) {
        this.ALREADY_DELETED_STATUS = ALREADY_DELETED_STATUS;
    }

    public int getALREADY_USED_STATUS() {
        return ALREADY_USED_STATUS;
    }

    public void setALREADY_USED_STATUS(int ALREADY_USED_STATUS) {
        this.ALREADY_USED_STATUS = ALREADY_USED_STATUS;
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
