<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div id="sidebar" class="sidebar responsive ace-save-state" data-sidebar="true" data-sidebar-scroll="true" data-sidebar-hover="true">
    <script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>

    <ul class="nav nav-list" style="top: 0px;" id="left_menu">
        <cas:havePerm url="/contentShow.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-desktop"></i>
                    <span class="menu-text"> <fmt:message key="content.show" /> </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <cas:havePerm url="/json/bestvContent_beanList.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/contentShow/bestvContentShow.jsp' />">
                                <fmt:message key="bestv.content.show" />
                            </a>

                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/contentShow/bestvContentShow.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>

                    <cas:havePerm url="/zteContentShow.do">
                        <li>
                            <a href="#" class="dropdown-toggle">
                                <i class="menu-icon fa fa-caret-right"></i>
                                <fmt:message key="zte.content.show" />
                                <b class="arrow fa fa-angle-down"></b>
                            </a>

                            <b class="arrow"></b>

                            <ul class="submenu">
                                <li class="">
                                    <a href="#" menu-url="<c:url value='/pages/contentShow/zteMovieShow.jsp' />">
                                        <i class="menu-icon fa fa-film"></i>
                                        <fmt:message key="zte.movie.show" />
                                    </a>

                                    <b class="arrow"></b>
                                </li>
                                <c:if test="${empty mainIndex}">
                                    <c:set var="mainIndex"
                                           value="/pages/contentShow/zteMovieShow.jsp" scope="session"></c:set>
                                </c:if>

                                <li class="">
                                    <a href="#" menu-url="<c:url value='/pages/contentShow/zteSeriesShow.jsp' />">
                                        <i class="menu-icon fa fa-video-camera"></i>
                                        <fmt:message key="zte.series.show" />
                                    </a>

                                    <b class="arrow"></b>
                                </li>
                                <c:if test="${empty mainIndex}">
                                    <c:set var="mainIndex"
                                           value="/pages/contentShow/zteSeriesShow.jsp" scope="session"></c:set>
                                </c:if>
                            </ul>
                        </li>
                    </cas:havePerm>

                </ul>
            </li>
        </cas:havePerm>
        
        <cas:havePerm url="/liveChannel.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-book"></i>
                    <span class="menu-text"> <fmt:message key="live.channel.title" /> </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <cas:havePerm url="/json/live_channel_list.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/liveChannel/liveChannelShow.jsp' />">
                                <fmt:message key="live.channel.title" />
                            </a>

                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/liveChannel/liveChannelShow.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>
                </ul>
            </li>
        </cas:havePerm>

        <cas:havePerm url="/dataDict.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-book"></i>
                    <span class="menu-text"> <fmt:message key="data.dict" /> </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <cas:havePerm url="/json/dataDict_dictList.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/dataDict/dataDictManage.jsp' />">
                                <fmt:message key="data.dict.manage" />
                            </a>

                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/dataDict/dataDictManage.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>
                </ul>
            </li>
        </cas:havePerm>
        
        <cas:havePerm url="/logsShow.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-pencil"></i>
                    <span class="menu-text"> <fmt:message key="logs.manage" /> </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <cas:havePerm url="/json/bestvLog_inputLogList.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/logsShow/inputLogsShow.jsp' />">
                                <fmt:message key="business.input.logs.show" />
                            </a>

                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/logsShow/logsShow.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>
                    <cas:havePerm url="/json/bestvLog_authLogList.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/logsShow/authVerifyLogsShow.jsp' />">
                                <fmt:message key="business.auth.logs.show" />
                            </a>

                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/logsShow/authVerifyLogsShow.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>
                </ul>
            </li>
        </cas:havePerm>
        
        <cas:havePerm url="/systemTool.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-book"></i>
                    <span class="menu-text"> <fmt:message key="system.tool.title" /> </span>

                    <b class="arrow fa fa-angle-down"></b>
                </a>

                <b class="arrow"></b>

                <ul class="submenu">
                    <cas:havePerm url="/json/cont_error_Tool.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/systemTool/bestvContErrorList.jsp' />">
                                <fmt:message key="system.tool.bestv.cont.error" />
                            </a>

                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/systemTool/bestvContErrorList.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>
                </ul>
            </li>
        </cas:havePerm>

    </ul><!-- /.nav-list -->

    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
        <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
</div>
