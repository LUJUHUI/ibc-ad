<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="breadcrumbs" id="breadcrumbs">
    <script type="text/javascript">
        try {
            ace.settings.check('breadcrumbs', 'fixed')
        } catch (e) {
        }
    </script>
    <ul class="breadcrumb">
        <li><i class="ace-icon fa fa-home home-icon"></i>
            <a href=""><fmt:message key="webapp.home"/></a>
        </li>
        <li>
            <fmt:message key="ad.material"/>
        </li>
        <li>
            <fmt:message key="ad.ad.createMaterial"/>
        </li>
    </ul>
    <!-- /.breadcrumb -->
    <div class="nav-search">
        <button type="button" class="btn btn-danger btn-sm" id="backBtn">
            <i class="ace-icon fa fa-reply"></i>
            <fmt:message key="button.back"/>
        </button>
    </div>
</div>

<div class="page-content">

    <div class="page-content">
        <div id="basicInfo" class="">
            <div class="page-header">
                <h1>
                    新建素材
                    <small>
                        <i class="icon-double-angle-right"></i>
                        基本信息
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="col-xs-12">
                    <form class="form-horizontal" role="form" id="createAdMaterialform">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="add_adMaterialName"> 素材名称 </label>
                            <div class="col-sm-9">
                                <input type="text" id="add_adMaterialName" placeholder="素材名称" class="col-xs-10 col-sm-5"
                                       name="adMaterial.materialName">
                            </div>
                        </div>
                        <div class="space-4"></div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="create_materialType"> 素材类型 </label>
                            <div class="col-sm-9">
                                <select class="col-xs-10 col-sm-5 chosen-select" id="create_materialType"
                                        data-placeholder="Choose a Country..." name="adMaterial.type" ;>
                                    <option value="">--请选择--</option>
                                    <option value="1">图片</option>
                                    <option value="2">文字</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_clickHref"> 链接地址 </label>
                            <div class="col-sm-9">
                                <input type="text" id="add_clickHref" class="col-xs-10 col-sm-5"
                                       name="adMaterial.clickHref">
                            </div>
                        </div>

                        <%-- <div class="form-group hidden" style="margin-left:25%;width: 50%;height: 50%; "
                              id="save_uploadPic1">
                             <div action="<c:url value='/json/picUp_picUpload.do'/>" method="post"
                                  id="uploadPicForm" enctype="multipart/form-data">
                                 <div>
                                     <input type=file name="picUpload" id="picUpload" style="display: inline;"
                                            onchange="showImage()">
                                     <input type="submit" value="上传"/>
                                 </div>
                                 <div id="localImag">
                                     <img id="preview" width=-1 height=-1 style="diplay:none"/>
                                 </div>
                             </div>
                         </div>--%>

                        <hr>
                        <div class="form-group hidden" id="save_uploadPic">
                            <label class="col-sm-3 control-label no-padding-right" id="create_upPic"></label>
                            <div class="col-sm-9">
                                <div action="<c:url value='/json/picUpload_createPicUpload.do'/>" method="post"
                                     id="uploadPicForm" enctype="multipart/form-data">
                            <span class="editable-container editable-inline">
                    <div>
                        <div class="editableform-loading" style="display: none;">
                            <i class="ace-icon fa fa-spinner fa-spin fa-2x light-blue"></i>
                        </div>
                            <form class="form-inline editableform" style="">
                                <div class="control-group form-group">
                                    <div>
                                        <div class="editable-input editable-image">
                                            <span>
                                                <label class="ace-file-input ace-file-multiple"
                                                       style="width: 150px;">
                                                    <input type="file" name="materialPicture" id="materialPicture"
                                                           style="display: inline;" onchange="showImage()">
                                                    <span class="ace-file-container"
                                                          data-title="Material Picture">
                                                        <span class="ace-file-name"
                                                              data-title="No File ...">
                                                            <div id="localImag">
                                                            <img class=" ace-icon fa fa-picture-o" id="preview" width=-1
                                                                 height=-1 style="diplay:none"/>
                                                            </div>
                                                        </span>
                                                        请选择素材图片
                                                    </span>
                                                    <a class="remove" href="#">
                                                        <i class=" ace-icon fa fa-times"></i>
                                                    </a>
                                                </label>
                                                <textarea id="add_upload" style="width: 150px;height: 50px;"></textarea>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </span><hr>
                                </div>
                            </div>
                        </div>
                    </form>
                </div><!-- /.col -->
            </div><!-- /.row -->
            <div class="row-fluid wizard-actions">
                <button type="button" id="save_addAdMaterial" class="btn btn-primary">保存</button>
                <button type="button" id="close_addAdMaterial" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div> <!-- /basicInfo -->
    </div>
</div>

<script type="text/javascript">
    jQuery(function ($) {
        $("#backBtn").on("click", function () {
            $("#main_page > div:last").remove();
            $("#main_page > div:last").removeClass("main-page-div-display");
            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
        });

        $("#create_materialType").on("change", function () {
            var val = $("#create_materialType").val();
            if (val == 1) {
                $("#save_uploadPic").removeClass("hidden");
            } else if (val == "" || val == 2) {
                $("#save_uploadPic").addClass("hidden");
            }
        })
    });

    function showImage() {
        var picObj = document.getElementById("materialPicture");
        var imgObjPreview = document.getElementById("preview");
        if (picObj.files && picObj.files[0]) {
            //火狐下，直接设img属性
            imgObjPreview.style.display = 'block';
            imgObjPreview.style.width = '150px';
            imgObjPreview.style.height = '100px';
            imgObjPreview.src = window.URL.createObjectURL(picObj.files[0]);
        } else {
            //IE下，使用滤镜
            picObj.select();
            var imgSrc = document.selection.createRange().text;
            var localImagId = document.getElementById("localImag");
            //必须设置初始大小
            localImagId.style.width = "150px";
            localImagId.style.height = "100px";
            //图片异常的捕捉，防止用户修改后缀来伪造图片
            try {
                localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                localImagId.filters
                    .item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
            } catch (e) {
                alert("您上传的图片格式不正确，请重新选择!");
                return false;
            }
            imgObjPreview.style.display = 'none';
            document.selection.empty();
        }
        return true;
    }

    $("#save_addAdMaterial").on("click", function () {
        if ($("#add_adMaterialName").val() == "") {
            $("#add_adMaterialName").tips({side: 2, msg: '此项必填', time: 3});
            return false;
        }
        if ($("#create_materialType").val() == "") {
            $("#create_materialType").tips({side: 2, msg: '此项必填', time: 3});
            return false;
        }
        if ($("#add_clickHref").val() == "") {
            $("#add_clickHref").tips({side: 2, msg: '此项必填', time: 3});
            return false;
        }
    })

</script>


