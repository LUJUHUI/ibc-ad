<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/webuploader.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/uploadlist.css'/>"/>
<script type="text/javascript" src="<c:url value='/assets/js/webuploader.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/jquery-1.11.3.min.js'/>"></script>

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
                            <label class="col-sm-3 control-label no-padding-right" for="add_adMaterialName"> 素材名称 </label>

                            <div class="col-sm-9">
                                <input type="text" id="add_adMaterialName" placeholder="素材名称" class="col-xs-10 col-sm-5"
                                       name="adMaterial.materialName">
                            </div>
                        </div>
                        <div class="space-4"></div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="create_materialType">素材类型 </label>
                            <div class="col-sm-9">
                                <select class="col-xs-10 col-sm-5 chosen-select" id="create_materialType"
                                        data-placeholder="Choose a Country..." name="adMaterial.type">
                                    <option value="">--请选择--</option>
                                    <option value="1">图片</option>
                                    <option value="2">文字</option>
                                </select>
                            </div>
                        </div>
                        <div class="space-4"></div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_clickHref"> 链接地址 </label>
                            <div class="col-sm-9">
                                <input type="text" id="add_clickHref" class="col-xs-10 col-sm-5"
                                       name="adMaterial.clickHref">
                            </div>
                        </div>

                        <form action="<c:url value='/json/picUpload_createPicUpload.do'/>" method="post"
                              id="uploadPicForm" enctype="multipart/form-data">
                            <input type="file" id="picUpload" name="picUpload">
                            <button type="submit">提交</button>
                        </form>

                    </form>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div> <!-- /basicInfo -->

        <div class="row-fluid wizard-actions">
            <button type="button" id="save_addAdMaterial" class="btn btn-primary">保存</button>
            <button type="button" id="close_addAdMaterial" class="btn btn-default" data-dismiss="modal">取消</button>
        </div>
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
                $("#uploader").removeClass("hidden");
            } else if (val == "" || val == 2) {
                $("#uploader").addClass("hidden");
            }
        })


        var uploader = WebUploader.create({

            // 选完文件后，是否自动上传。
            auto: true,

            // swf文件路径
            swf: '/assets/swf/Uploader.swf',

            // 文件接收服务端。
            server: 'http://webuploader.duapp.com/server/fileupload.php',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#filePicker',

            // 只允许选择图片文件。
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });

        uploader.on('fileQueued', function (file) {
            var $li = $(
                '<div id="' + file.id + '" class="file-item thumbnail">' +
                '<img>' +
                '<div class="info">' + file.name + '</div>' +
                '</div>'
                ),
                $img = $li.find('img');


            // $list为容器jQuery实例
            $list.append($li);

            // 创建缩略图
            // 如果为非图片文件，可以不用调用此方法。
            // thumbnailWidth x thumbnailHeight 为 100 x 100
            uploader.makeThumb(file, function (error, src) {
                if (error) {
                    $img.replaceWith('<span>不能预览</span>');
                    return;
                }

                $img.attr('src', src);
            }, thumbnailWidth, thumbnailHeight);
        });

        uploader.on('uploadProgress', function (file, percentage) {
            var $li = $('#' + file.id),
                $percent = $li.find('.progress span');

            // 避免重复创建
            if (!$percent.length) {
                $percent = $('<p class="progress"><span></span></p>')
                    .appendTo($li)
                    .find('span');
            }

            $percent.css('width', percentage * 100 + '%');
        });

        // 文件上传成功，给item添加成功class, 用样式标记上传成功。
        uploader.on('uploadSuccess', function (file) {
            $('#' + file.id).addClass('upload-state-done');
        });

        // 文件上传失败，显示上传出错。
        uploader.on('uploadError', function (file) {
            var $li = $('#' + file.id),
                $error = $li.find('div.error');

            // 避免重复创建
            if (!$error.length) {
                $error = $('<div class="error"></div>').appendTo($li);
            }

            $error.text('上传失败');
        });

        // 完成上传完了，成功或者失败，先删除进度条。
        uploader.on('uploadComplete', function (file) {
            $('#' + file.id).find('.progress').remove();
        });


    });


</script>

