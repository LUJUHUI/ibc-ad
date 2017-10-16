<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<%
    String id = request.getParameter("id");
    request.setAttribute("id", id);
%>

<style>
    .form-horizontal .control-label {
        text-align: right;
        margin-bottom: 0;
        padding-top: 3px;
    }
    .preview-container {
        margin-left: 30px;
        background-color: #D0D0D0;
        box-shadow: 0 0 3px #000;
        width: auto;
        height: 430px;
        display: none;
    }
    .preview-container-active {
        display: block;
    }
    .img-class {
        width: 100%;
        height: 100%;
    }
</style>

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
            <fmt:message key="content.show"/>
        </li>
        <li class="">
            <span><fmt:message key="bestv.content.show"/></span>
        </li>
        <li class="active">
            <span><fmt:message key="bestv.content.detail.show"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
    <div class="nav-search">
        <button type="button" class="btn btn-danger btn-sm" id="backBtn">
            <i class="ace-icon fa fa-reply"></i><fmt:message key="button.back"/>
        </button>
    </div>
</div>

<input type="text" hidden value="${id}" id="contentId"/>

<div class="row" style="margin-left: 24px;">
    <div class="col-xs-11" id="content-detail">
        <form class="form-horizontal" role="form" id="detailForm">
            <fieldset>
                <legend><fmt:message key="content.basic.info"/> </legend>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="code"><fmt:message key="bestv.content.code"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="code" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="attrName"><fmt:message key="bestv.content.attr"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="attrName" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="epCnt"><fmt:message key="bestv.content.epCnt"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="epCnt" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="epTotal"><fmt:message key="bestv.content.epTotal"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="epTotal" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="title"><fmt:message key="bestv.content.title"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="title" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="searchName"><fmt:message key="bestv.content.searchName"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="searchName" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="duration"><fmt:message key="bestv.content.duration"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="duration" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="tags"><fmt:message key="bestv.content.tags"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="tags" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="directors"><fmt:message key="bestv.content.directors"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="directors" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="actors"><fmt:message key="bestv.content.actors"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="actors" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="area"><fmt:message key="bestv.content.area"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="area" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="language"><fmt:message key="bestv.content.language"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="language" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="pubDate"><fmt:message key="bestv.content.pubDate"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="pubDate" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="pcIdName"><fmt:message key="bestv.content.pcId.name"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="pcIdName" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="cIdName"><fmt:message key="bestv.content.cId.name"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="cIdName" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="statusName"><fmt:message key="bestv.content.status"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="statusName" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="descInfo"><fmt:message key="bestv.content.descInfo"/> </label>
                    <div class="col-sm-11">
                        <textarea class="form-control" id="descInfo" rows="3" readonly></textarea>
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend><fmt:message key="content.preview"/> </legend>
                <div class="row">
                    <div class="col-xs-6" id="related-info">
                        <div class="tabbable">
                            <ul class="nav nav-tabs" id="myTab">
                                <li class="active">
                                    <a data-toggle="tab" href="#img-list" aria-expanded="false"><fmt:message key="zte.content.imgList"/> </a>
                                </li>

                                <li class="">
                                    <a data-toggle="tab" href="#cdn-list" aria-expanded="true"><fmt:message key="zte.content.movieList"/> </a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                <div id="img-list" class="tab-pane fade active in" style="height: 400px;">
                                    <table id="grid-table-1"></table>
                                </div>

                                <div id="cdn-list" class="tab-pane fade" style="height: 400px;">
                                    <table id="grid-table-2"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6" id="preview-div">
                        <div style="margin-left: 30px;margin-top: 16px;" id="container-title"><small>图片预览</small></div>
                        <div class="preview-container preview-container-active" id="img-preview">
                            <img id="imgShow" src="" class="img-class">
                        </div>
                        <div class="preview-container" id="cdn-preview">
                            <object classid="clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921" codebase="http://download.videolan.org/pub/videolan/vlc/last/win32/axvlc.cab">
                                <param name='mrl' value='true' />
                                <param name='volume' value='50' />
                                <param name='autoplay' value='false' />
                                <param name='fullscreen' value='false' />
                                <param name='allowfullscreen' value='true'>
                                <%--<param name='windowless' value='true'>--%>
                                <param name='src' value=''>
                                <embed type="application/x-vlc-plugin" pluginspage="http://www.videolan.org" width="100%" height="100%" name="vlc" id="vlc"/>
                            </object>
                        </div>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</div>

<script>
    jQuery(function($) {

        $("#backBtn").on("click", function () {
            $("#main_page > div:last").remove();
            $("#main_page > div:last").removeClass("main-page-div-display");
            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
        })

        var grid_selector_1 = "#grid-table-1";
        var grid_selector_2 = "#grid-table-2";

        var parent_column_1 = $(grid_selector_1).closest('[class*="col-"]');
        var parent_column_2 = $(grid_selector_2).closest('[class*="col-"]');

        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector_1).jqGrid( 'setGridWidth', parent_column_1.width()-28);
            $(grid_selector_2).jqGrid( 'setGridWidth', parent_column_2.width()-28);
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector_1).jqGrid( 'setGridWidth', parent_column_1.width()-28);
                    $(grid_selector_2).jqGrid( 'setGridWidth', parent_column_2.width()-28);
                }, 20);
            }
        })

        var img_list_data;
        var cdn_list_data;

        $.get('<c:url value="/json/bestvContent_detail.do"/>', {"id": $("#contentId").val()}, function (data) {
            $("#detailForm input").each(function(){
                $(this).val(data.result[$(this).attr("id")]);
            })
            $("#descInfo").text(data.result["descInfo"]);
            img_list_data = data.result["imageList"];
            cdn_list_data = data.result["cdnList"];

            jQuery(grid_selector_1).jqGrid({
                data: img_list_data,
                datatype: "local",
                height: 350,
                colNames:['key',
                    'url'
                ],
                colModel:[
                    {name:'key',index:'key_', width : 30, align: 'center'},
                    {name : 'value', index : 'value_', width : 80, align:'center'},
                ],
                altRows : true,
                rowNum: 1000,
                rownumbers : true,
                onSelectRow: function (rowid) {
                    var src = $(grid_selector_1).getRowData(rowid).value;
                    $("#imgShow").attr("src", src);
                },
                loadComplete : function(data) {
                    if (data.rows.length > 0){
                        $("#imgShow").attr("src", data.rows[0].value);
                    }
                }

            });

            jQuery(grid_selector_2).jqGrid({
                data: cdn_list_data,
                datatype: "local",
                height: 350,
                colNames:['url'],
                colModel:[
                    {name:'url',index:'url_', align: 'center'}
                ],
                rowNum: 1000,
                altRows : true,
                rownumbers: true,
                ondblClickRow : function (rowid, iRow, iCol, e) {
                    var src = $(grid_selector_2).getRowData(rowid).url;
                    if (window.vlc) {
                        window.vlc = document.getElementById("vlc");
                    }
                    vlc.playlist.stop();
                    vlc.playlist.clear();
                    vlc.playlist.add(src);
                    vlc.playlist.play();
                },
                loadComplete : function(data) {
                }

            });

            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        });

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            if ($(e.target).attr("href").indexOf("cdn") != -1){
                $("#container-title small").html("视频预览");
                /*var playerHtml = '<object classid="clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921" codebase="http://download.videolan.org/pub/videolan/vlc/last/win32/axvlc.cab" id="vlc">'
                 + "<param name='mrl' value='true' />"
                 + "<param name='volume' value='50' />"
                 + "<param name='autoplay' value='false' />"
                 + "<param name='loop' value='false' />"
                 + "<param name='fullscreen' value='false' />"
                 + "<param name='allowfullscreen' value='true'>"
                 + "<param name='toolbar' value='true'>"
                 + "<param name='windowless' value='true'>"
                 + "<param name='src' value=''>"
                 + '<embed type="application/x-vlc-plugin" pluginspage="http://www.videolan.org" name="vlc" />'
                 + "</object>";*/
                //var playerHtml = '<embed type="application/x-vlc-plugin" src="" pluginspage="http://www.videolan.org" autostart=false id="vlc" name="vlc" width="100%" height="100%"/>';
                $("#img-preview").removeClass("preview-container-active");
                $("#cdn-preview").addClass("preview-container-active");
            }else {
                $("#container-title small").html("图片预览");
                $("#cdn-preview").removeClass("preview-container-active");
                $("#img-preview").addClass("preview-container-active");
            }
        });

    })
</script>