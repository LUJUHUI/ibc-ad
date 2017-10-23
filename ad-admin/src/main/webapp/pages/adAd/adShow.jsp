<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

<div class="modal fade bs-example-modal-sm" tabindex="-1" id="addAdModel" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">添加广告</h4>
            </div>
            <div class="modal-body">
                <form id="add_adadForm">
                    <div class="form-group">
                        <label for="add_adName" class="control-label">广告名称:</label>
                        <input type="text" class="form-control" id="add_adName" name="adAd.adName">
                    </div>
                    <div class="form-group">
                        <label for="add_startTime" class="control-label">投放时间 :</label>
                        <input type="text" class="form-control" id="add_startTime">
                        <input type="hidden" class="form-control" id="add_st" name="adAd.startTime" value="">
                        <input type="hidden" class="form-control" id="add_et" name="adAd.endTime" value="">
                    </div>
                    <div class="form-group">
                        <label for="add_soltId" class="control-label">投放位置 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="add_soltId" name="adAd.soltId">
                            <option value="">请选择</option>
                            <option value="1">Alabama</option>
                            <option value="2">Alaska</option>
                            <option value="3">Arizona</option>
                            <option value="4">Arkansas</option>
                            <option value="6">California</option>
                            <option value="7">Colorado</option>
                            <option value="8">Connecticut</option>
                            <option value="9">Delaware</option>
                            <option value="10">Florida</option>
                            <option value="11">Georgia</option>
                            <option value="12">Hawaii</option>
                            <option value="13">Idaho</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="add_material" class="control-label">使用素材 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="add_material" name="adAd.materialId">
                            <option value="">请选择</option>
                            <option value="AL">Alabama</option>
                            <option value="AK">Alaska</option>
                            <option value="AZ">Arizona</option>
                            <option value="AR">Arkansas</option>
                            <option value="CA">California</option>
                            <option value="CO">Colorado</option>
                            <option value="CT">Connecticut</option>
                            <option value="DE">Delaware</option>
                            <option value="FL">Florida</option>
                            <option value="GA">Georgia</option>
                            <option value="HI">Hawaii</option>
                            <option value="ID">Idaho</option>
                        </select>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" id="close_adad" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" id="save_adad" class="btn btn-primary">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>
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
            <fmt:message key="ad.ad"/>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>

<style type="text/css">
    .ui-jqgrid .ui-jqgrid-bdiv {
        overflow: auto;
    }
    .ui-jqgrid .ui-userdata {
        border-left: 1px solid #D3D3D3;
        border-right: 1px solid #D3D3D3;
        height: 44px;
        overflow: hidden;
    }
    .ui-jqgrid .topnavtable td {
        font-weight: 400;
        vertical-align: middle;
        padding: 0 8px;
    }
</style>

<div class="page-content">
    <div class="page-header">
        <form class="form-inline">

            <label class="control-label" for="status">状态</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="status">
                <option value="">全部</option>
                <option value="101">草稿</option>
                <option value="102">待投放</option>
                <option value="103">投放中</option>
                <option value="104">投放完成</option>
                <option value="104">已删除</option>
            </select>

            <label class="control-label" for="adName">广告名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="adName">

            <label class="control-label" for="startTime">广告开始时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="startTime"/>
            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
            </button>
        </form>
    </div>
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
        </div>
    </div>
    <!-- /.row -->


</div>

<script type="text/javascript">

    jQuery(function($) {
       
        //$('.chosen-select').chosen({allow_single_deselect:true});
        var grid_selector = "#grid-table";
        var pager_selector = "#grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                }, 20);
            }
        })

        $('#startTime').daterangepicker({
            "ableToNull": true,
            "showDropdowns":true,
            "showCustomRangeLabel":false,
            "alwaysShowCalendars": true,
            "startDate": moment().subtract('days', 30),
            "endDate": moment().subtract('days', 0),
            "opens": "right",
            "drops": "down"
        }, function(start, end, label) {//时间改变后执行该方法
            //alert(label);
        });
        $('#add_startTime').daterangepicker({
            startDate: moment().subtract('days', 30),
            endDate: moment().subtract('days', 0),
            timePicker: true,
            timePickerIncrement : 5, // 时间的增量，单位为分钟
            timePicker24Hour : true, // 是否使用12小时制来显   示时间
            locale: {
                format: 'YYYY-MM-DD h:mm'
            }
        }, function(start, end, label) {//时间改变后执行该方法
            console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
        });
        var startTime = $('#startTime').val().replace(/\s/g, "").split("至");
        var startDate = startTime[0];
        var endDate = startTime[1];

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/adad_getAd.do'/>",
            postData: {
                status:$("#status").val(),
                adName:$("#adName").val(),
                startTime: startDate,
                endTime: endDate
            },
            height: 560,
            colNames:[
                '<fmt:message key="ad.ad.id"/>',
                '<fmt:message key="ad.ad.name"/>',
                '<fmt:message key="ad.ad.status"/>',
                '<fmt:message key="ad.ad.remark"/>',
                '<fmt:message key="ad.ad.startTime"/>',
                '<fmt:message key="ad.ad.endTime"/>',
                '<fmt:message key="ad.ad.createTime"/>',
                '<fmt:message key="ad.ad.createId"/>',
                '<fmt:message key="ad.ad.updateTime"/>',
                '<fmt:message key="ad.ad.updateId"/>'
            ],
            colModel:[
                {name:'id',index:'id', width : 80,align:'center', sortable : true},
                {name: 'adName',index: 'adName', width : 200, align:'center', sortable : true},
                {name : 'status', index : 'status', width : 80, align:'center', sortable : false,formatter:statusFmt},
                {name : 'remark', index : 'remark', width : 280, align:'center', sortable : true},
                {name : 'startTime', index : 'startTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'endTime', index : 'endTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createTime', index : 'createTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createId', index : 'createId', width : 100, align:'center', sortable : true},
                {name : 'updateTime', index : 'updateTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'updateId', index : 'updateId', width : 100, align:'center', sortable : true},
            ],
            shrinkToFit : false,
            hidegrid : false,
            viewrecords : true,
            rowNum:20,
            rowList:[10,20,30],
            pager : pager_selector,
            altRows : true,
            multiselect: true,
            multiboxonly: true,
            jsonReader : {
                total : 'pageCount',
                records : 'records',
                root : 'rows',
                repeatitems : true
            },
            caption: '<fmt:message key="ad.ad.list" />',
            toolbar: [true,'top'],
            loadComplete : function(data) {
                var table = this;
                setTimeout(function(){
                    styleCheckbox(table);
                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            }

        });

        $("#t_grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
            '<td><button type="button" id="add" class="btn btn-xs btn-success"><i class="ace-icon fa fa-plus"></i>添加</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="addAdMaterial" class="btn btn-xs btn-success"><i class="ace-icon fa fa-plus"></i>关联广告素材</button></td>' +
            '<td>|</td>' +
            '<td><button type="button" id="remove" class="btn btn-xs btn-danger"><i class="ace-icon fa fa-trash-o bigger-120"></i>删除</button></td>' +
            '</tr></table>');

        $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        //navButtons
        jQuery(grid_selector).jqGrid('navGrid',pager_selector,
            { 	//navbar options
                edit: false,
                editicon : 'ace-icon fa fa-pencil blue',
                add: false,
                addicon : 'ace-icon fa fa-plus-circle purple',
                del: false,
                delicon : 'ace-icon fa fa-trash-o red',
                search: false,
                searchicon : 'ace-icon fa fa-search orange',
                refresh: true,
                refreshicon : 'ace-icon fa fa-refresh green',
                view: false,
                viewicon : 'ace-icon fa fa-search-plus grey',
            }
        )

        
        function styleCheckbox(table) {
            
        }

        function updateActionIcons(table) {
            
        }
        
        function updatePagerIcons(table) {
            var replacement =
                {
                    'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
                    'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
                    'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
                    'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
                };
            $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
                var icon = $(this);
                var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
            })
        }

        function enableTooltips(table) {
            $('.navtable .ui-pg-button').tooltip({container:'body'});
            $(table).find('.ui-pg-div').tooltip({container:'body'});
        }

        $(document).one('ajaxloadstart.page', function(e) {
            $.jgrid.gridDestroy(grid_selector);
            $('.ui-jqdialog').remove();
        });

        function statusFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 101:
                    result='草稿';
                case 102:
                    result = '待投放';
                case 103:
                    result = '投放中';
                case 104:
                    result = '投放完成';
                case 105:
                    result = '已删除';
            }
            return result;
        }

        $("#search").on("click", function () {

            if($('#startTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#startTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/adad_getAd.do'/>",
                postData : {
                    status:$("#status").val(),
                    adName:$("#adName").val(),
                    startTime: startDate,
                    endTime: endDate
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
        $("#add").on("click",function () {
            $("#addAdModel").modal();
            <%--openMainPage('<c:url value="/pages/adAd/adAddForm.jsp"/>', {"id": "addAd"}, function () {--%>
            <%--});--%>
        });

        $("#save_adad").on("click",function () {
            var st = $('#add_startTime').val().replace(/\s/g, "").split("至");
            $("#add_st").val(formatDate(st[0]));
            $("#add_et").val(formatDate(st[1]));
            var adName = $("#add_adName").val();
            if(adName == null || adName == ''){
                $("#add_adName").tips({side:2,msg:'此项必填 ',time:3});
                return false;
            }
            if($("#add_soltId").val() == ""){
                $("#add_soltId").tips({side:2,msg:'请选择广告位 ',time:3});
                return false;
            }
            $.ajax({
                url:"<c:url value='/json/adad_save.do'/>",
                data:$("#add_adadForm").serialize(),
                type:"post",
                success:function(data){
                    $("#addAdModel").modal('hide')
                    $("#search").click();
                },error:function(){
                    alert("保存失败，无法连接服务器");
                }
            });

        })
        
        function formatDate(str) {
            return str.substr(0, 10) + " " + str.substr(10, str.length);
        }
       
    });
</script>