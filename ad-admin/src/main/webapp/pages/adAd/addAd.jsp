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
            <fmt:message key="ad.ad"/>
        </li>
        <li>
            <fmt:message key="ad.ad.add"/>
        </li>
    </ul>
    <!-- /.breadcrumb -->
    <div class="nav-search">
        <button type="button" class="btn btn-danger btn-sm" id="backBtn">
            <i class="ace-icon fa fa-reply"></i><fmt:message key="button.back"/>
        </button>
    </div>
</div>

<div class="page-content">
    
    <div class="page-content">
        
        <div id="basicInfo" class="">
            
            <div class="page-header">
                <h1>
                    添加广告
                    <small>
                        <i class="icon-double-angle-right"></i>
                        基本信息
                    </small>
                </h1>
            </div><!-- /.page-header -->
            
            <div class="row">
                <div class="col-xs-12">
                    
                    <form class="form-horizontal" role="form" id="adform">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_adName"> 广告名称 </label>
                            
                            <div class="col-sm-9">
                                <input type="text" id="add_adName" placeholder="广告名称" class="col-xs-10 col-sm-5" name="adAd.adName">
                            </div>
                        </div>
                        <div class="space-4"></div>
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_startTime"> 投放时间 </label>
                            
                            <div class="col-sm-9">
                                <input type="text" class="col-xs-10 col-sm-5" readonly="readonly"  id="add_startTime" name="startTime">
                                <input type="hidden" class="form-control" id="add_st" name="adAd.startTime" value="">
                                <input type="hidden" class="form-control" id="add_et" name="adAd.endTime" value="">
                            </div>
                        </div>
                        <div class="space-4"></div>
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_soltId"> 广告位 </label>
                            
                            <div class="col-sm-9">
                                <select class="col-xs-10 col-sm-5 chosen-select" id="add_soltId" data-placeholder="Choose a Country..." name="adAd.soltId">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <div class="space-4"></div>
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_remark"> 备注 </label>
                            
                            <div class="col-sm-9">
                                <textarea id="add_remark" class="col-xs-10 col-sm-5" style="width: 700px;height: 100px;"  name="adAd.remark"></textarea>
                            </div>
                        </div>
                        <input type="hidden" class="form-control" id="materialId" name="materialId" value="">
                        <div class="space-4"></div>
                    
                    </form>
                
                </div><!-- /.col -->
            </div><!-- /.row -->
        
        </div> <!-- /basicInfo -->
        
        <div id="materialInfo" class="">
            
            <div class="row">
                <div class="page-header">
                    <h3 class="header smaller lighter blue">
                        素材管理
                        <small>
                            <i class="icon-double-angle-right"></i>
                            请选择要使用的素材
                        </small>
    
                    </h3>
                    
                    <form class="form-inline" id="search_from">
                        <label class="control-label" for="materialName">素材名称</label>
                        <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="materialName">
                        
                        <label class="control-label" for="type">素材类型</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="type">
                            <option value="">全部</option>
                            <option value="1">图片</option>
                            <option value="2">文字</option>
                        </select>
                        
                        <label class="control-label" for="createTime">创建时间</label>
                        <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime" readonly="readonly"/>
                        
                        <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search_material">
                            <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
                        </button>
    
                        <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search_reset">
                            <i class="ace-icon fa fa-reply bigger-110"></i><fmt:message key="icon-reset"/>
                        </button>
                    </form>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <table id="ad-add-material-grid-table"></table>
                    <div id="ad-add-material-grid-pager"></div>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div>
        <hr>
        <div class="row-fluid wizard-actions">
            
            <button class="btn btn-prev" id="reset">
                重置
            </button>
            <button class="btn btn-success hidden" id="Prev">
                上一步
            </button>
    
            <button class="btn btn-success btn-next" id="next">
                下一步
            </button>
            <button class="btn btn-success hidden" id="save">
                保存
            </button>
            
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

        $.get("<c:url value='/json/adad_getAdSlot.do'/>",function (result) {
            var soltStr = '';
            $(result.root).each(function (index,items) {
                soltStr+= '<option value="'+items.id+'">'+items.slotName+'</option>';
            });
            $("#add_soltId").append(soltStr);
            $("#add_soltId").chosen();

        });

        $("#add_startTime").daterangepicker({
            startDate: moment().subtract('days', 0),
            endDate: moment().subtract('days', 0),
            timePicker: true,
            timePickerIncrement : 5, // 时间的增量，单位为分钟
            timePicker24Hour : true, // 是否使用12小时制来显示时间
            locale: {
                format: 'YYYY-MM-DD HH:mm'
            }
        }, function(start, end, label) {//时间改变后执行该方法
        });

        $("#createTime").daterangepicker({
            startDate: moment().subtract('days', 10),
            endDate: moment().subtract('days', 0),
            locale: {
                format: 'YYYY-MM-DD'
            }
        }, function(start, end, label) {//时间改变后执行该方法
        });

        var grid_selector = "#ad-add-material-grid-table";
        var pager_selector = "#ad-add-material-grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
        })
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                }, 20);
            }
        })

        var startTime = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = startTime[0];
        var endDate = startTime[1];

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/adad_getAdMaterialByPage.do'/>",
            postData: {
                status:$("#status").val(),
                adName:$("#adName").val(),
                adId:$("#adId").val(),
                type:$("#type").val(),
                createTime: startDate +" 00:00:00",
                createTime_end: endDate+" 23:59:59"
            },
            height: 400,
            colNames:[
                '<fmt:message key="ad.material.id"/>',
                '<fmt:message key="ad.material.materialName"/>',
                '<fmt:message key="ad.material.type"/>',
                '<fmt:message key="ad.material.clickHref"/>',
                '<fmt:message key="ad.material.status"/>',
                '<fmt:message key="ad.material.createTime"/>',
                '<fmt:message key="ad.material.createPerson"/>'
            ],
            colModel:[
                {name:'id',index:'id', width : 80,align:'center', sortable : true},
                {name: 'materialName',index: 'materialName', width : 300, align:'center', sortable : true},
                {name : 'type', index : 'type', width : 270, align:'center', sortable : true,formatter:typeFmt},
                {name : 'clickHref', index : 'clickHref', width : 280, align:'center', sortable : true},
                {name : 'status', index : 'status', width : 108, align:'center', sortable : false,formatter:statusFmt},
                {name : 'createTime', index : 'createTime', width : 300, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createPerson', index : 'createPerson', width : 250, align:'center', sortable : true}
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
            <cas:havePerm url="/bestvContent_loadDetailPage.do">
            ondblClickRow : function (rowid, iRow, iCol, e) {
                openMainPage('<c:url value="/pages/adAd/adAddMaterial.jsp"/>', {"id": rowid}, function () {
                });
            },
            </cas:havePerm>
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

        $("#t_ad-add-material-grid-table").addClass("hidden");

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

        function typeFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 1:
                    result='图片';
                    break;
                case 2:
                    result = '文字';
                    break;
            }
            return result;
        }
        function statusFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 101:
                    result='<span class="green">待审核</span>';
                    break;
                case 103:
                    result = '<span class="red">审核驳回</span>';
                    break;
                case 104:
                    result = '<span class="orange">待使用</span>';
                    break;
                case 105:
                    result = '<span class="green">使用中</span>';
                    break;
                case 106:
                    result = '<span class="red">已删除</span>';
                    break;
            }
            return result;
        }
        $("#materialInfo").addClass("hidden");
        
        $("#search_material").on("click", function () {
            
            dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
            startDate = dateRange[0];
            endDate = dateRange[1];
            

            $("#ad-add-material-grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/adad_getAdMaterialByPage.do'/>",
                postData : {
                    adId:$("#adId").val(),
                    status:$("#status").val(),
                    type:$("#type").val(),
                    materialName:$("#materialName").val(),
                    createTime: startDate +" 00:00:00",
                    createTime_end: endDate+" 23:59:59"
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
       
        function formatDate(str) {
            return str.substr(0, 10) + " " + str.substr(10, str.length)+":00";
        }
        
        $("#next").on("click",function () {

            var adName = $("#add_adName").val();
            if(adName == null || adName == ''){
                $("#add_adName").tips({side:2,msg:'此项必填 ',time:3});
                return;
            }
            
            var st = $('#add_startTime').val().replace(/\s/g, "").split("至");
            $("#add_st").val(formatDate(st[0]));
            $("#add_et").val(formatDate(st[1]));
            var sTime =  new Date($("#add_st").val().replace("-", "/").replace("-", "/"));
            var eTime =  new Date($("#add_et").val().replace("-", "/").replace("-", "/"));
            if(sTime >= eTime){
                $('#add_startTime').tips({side:2,msg:'投放开始时间必须小于结束时间 ',time:3});
                return;
            }
            
            if($("#add_soltId").val() == ""){
                $("#add_soltId_chosen").tips({side:2,msg:'请选择广告位 ',time:3});
                return;
            }
            
            $("#basicInfo").addClass("hidden");
            $("#materialInfo").removeClass("hidden");
            $("#Prev").removeClass("hidden");
            $("#next").addClass("hidden");
            $("#save").removeClass("hidden");
            $("#reset").addClass("hidden");
        });
        
        $("#Prev").on("click",function () {
            
            $("#basicInfo").removeClass("hidden");
            $("#materialInfo").addClass("hidden");
            $("#Prev").addClass("hidden");
            $("#next").removeClass("hidden");
            $("#save").addClass("hidden");
            $("#reset").removeClass("hidden");
            
        });

        $("#reset").on("click",function () {
            $("#adform")[0].reset();
        });
        
        $("#search_reset").on("click",function () {
            $("#search_from")[0].reset();
        });
        
        $("#save").on("click",function () {
            var row = $("#ad-add-material-grid-table").jqGrid('getGridParam', 'selarrrow');
            if (row.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var materailIds = [];
            $.each(row,function (index,items) {
                var rowData = $("#ad-add-material-grid-table").jqGrid('getRowData',items);
                materailIds.push(rowData.id);
            });
            if(materailIds.length < 1){
                bootbox.alert("请选择要使用的素材！");
                return;
            }
            $("#materialId").val(materailIds);
            $.ajax({
                url:"<c:url value='/json/adad_save.do'/>",
                data:$("#adform").serialize(),
                type:"post",
                success:function(data){
                    if(data.success == true){
                        if(data.code == 101){
                            $("#search").click();
                            $("#backBtn").click();
                        }else if(data.code == 102){
                            bootbox.alert("保存失败，广告位在同一时间已存在广告！");
                        }
                    }else{
                        bootbox.alert("保存失败，系统发生错误！");
                    }
                    
                },error:function(){
                    bootbox.alert("保存失败，无法连接服务器！");
                }
            });
        });
    });
</script>
