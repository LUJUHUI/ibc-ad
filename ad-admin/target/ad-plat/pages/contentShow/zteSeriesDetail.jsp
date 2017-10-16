<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<%
    String programCode = request.getParameter("code");
    request.setAttribute("code", programCode);
%>

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
            <span><fmt:message key="zte.content.show"/></span>
        </li>
        <li class="">
            <span><fmt:message key="zte.series.show"/></span>
        </li>
        <li class="active">
            <span><fmt:message key="zte.series.detail"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
    <div class="nav-search">
        <button type="button" class="btn btn-danger btn-sm" id="backBtn">
            <i class="ace-icon fa fa-reply"></i><fmt:message key="button.back"/>
        </button>
    </div>
</div>

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

<input type="text" hidden value="${code}" id="seriesCode"/>
<div class="row" style="margin-left: 24px;">
    <div class="col-xs-11" id="content-detail">
        <form class="form-horizontal" role="form" id="seriesDetailForm">
            <fieldset>
                <legend><fmt:message key="content.basic.info"/> </legend>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="code"><fmt:message key="zte.content.code"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="code" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="orderNumber"><fmt:message key="zte.content.orderNumber"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="orderNumber" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="action"><fmt:message key="zte.content.action"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="action" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="name"><fmt:message key="zte.content.name"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="name" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="originalName"><fmt:message key="zte.content.originalName"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="originalName" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="searchName"><fmt:message key="zte.content.searchName"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="searchName" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="orgAirDate"><fmt:message key="zte.content.orgAirDate"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="orgAirDate" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="licensingWindowStart"><fmt:message key="zte.content.licensingWindowStart"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="licensingWindowStart" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="licensingWindowEnd"><fmt:message key="zte.content.licensingWindowEnd"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="licensingWindowEnd" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="displayAsNew"><fmt:message key="zte.content.displayAsNew"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="displayAsNew" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="displayAsLastChance"><fmt:message key="zte.content.displayAsLastChance"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="displayAsLastChance" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="macrovisionStr"><fmt:message key="zte.content.macrovision"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="macrovisionStr" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="price"><fmt:message key="zte.content.price"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="price" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="volumnCount"><fmt:message key="zte.content.volumnCount"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="volumnCount" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="statusStr"><fmt:message key="zte.content.status"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="statusStr" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="type"><fmt:message key="zte.content.type"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="type" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="bestvStatusStr"><fmt:message key="zte.content.bcStatus"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="bestvStatusStr" type="text" value="" readonly/>
                    </div>
                    <label class="col-sm-1 control-label" for="tags"><fmt:message key="zte.content.tags"/> </label>
                    <div class="col-sm-3">
                        <input class="form-control input-sm" id="tags" type="text" value="" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label" for="description"><fmt:message key="zte.content.description"/> </label>
                    <div class="col-sm-11">
                        <textarea class="form-control" id="description" rows="3" readonly></textarea>
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
        var program_list_data;

        $.get('<c:url value="/json/zteSeries_seriesDetail.do"/>', {"code": $("#seriesCode").val()}, function (data) {
            $("#seriesDetailForm input").each(function(){
                $(this).val(data.series[$(this).attr("id")]);
            })
            $("#description").text(data.series["description"]);
            img_list_data = data.pictures;
            program_list_data = data.programs;

            jQuery(grid_selector_1).jqGrid({
                data: img_list_data,
                datatype: "local",
                height: 350,
                colNames:['唯一标识',
                    '状态',
                    'URL'
                ],
                colModel:[
                    {name:'code',index:'code_', width : 30, align: 'center'},
                    {name : 'bestvStatusStr', index : 'bestv_status', width : 30, align:'center'},
                    {name : 'fileURL', index : 'file_url', width : 100, align:'center'},
                ],
                //shrinkToFit : false,
                altRows : true,
                rowNum: 1000,
                rownumbers : true,
                onSelectRow: function (rowid) {
                    var src = $(grid_selector_1).getRowData(rowid).fileURL;
                    $("#imgShow").attr("src", src);
                },
                loadComplete : function(data) {
                    if (data.rows.length > 0){
                        $("#imgShow").attr("src", data.rows[0].fileURL);
                    }
                }

            });

            jQuery(grid_selector_2).jqGrid({
                data: program_list_data,
                datatype: "local",
                height: 350,
                colNames:['唯一标识','名称','关键字','状态','操作'],
                colModel:[
                    {name:'code',index:'code_', width : 20, align: 'center'},
                    {name:'name',index:'name_', width : 80, align: 'center'},
                    {name:'keyWords',index:'key_words', width : 50, align: 'center'},
                    {name:'bestvStatusStr',index:'bestv_status', width : 30, align: 'center'},
                    {name:'operation',index:'operation', width : 30, align: 'center',
                        formatter: function (cellvalue, options, rowObject) {
                            return '<button type="button" class="btn btn-info btn-minier" onclick="openProgramDetail('+rowObject.code+')">详细</button>';
                        }
                    }
                ],
                //shrinkToFit : false,
                rowNum: 1000,
                altRows : true,
                rownumbers: true,
                loadComplete : function(data) {
                }

            });

            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        });

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {

        });
    })
    function openProgramDetail(code) {
        openMainPage("/pages/contentShow/zteSeriesProgramDetail.jsp", {"code": code}, function () {
        });
    }
</script>