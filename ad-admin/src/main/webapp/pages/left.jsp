<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<div id="sidebar" class="sidebar responsive ace-save-state" data-sidebar="true" data-sidebar-scroll="true" data-sidebar-hover="true">
    <script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>

    <ul class="nav nav-list" style="top: 0px;" id="left_menu">
        <cas:havePerm url="/adslot.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-desktop"></i>
                    <span class="menu-text"> <fmt:message key="ad.slot" /> </span>
                    <b class="arrow fa fa-angle-down"></b>
                </a>
                <b class="arrow"></b>
               <ul class="submenu">
                    <cas:havePerm url="/json/adSlot_listAdSlots.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/adslot/startAdSlotShow.jsp' />">
                                <fmt:message key="start.slot.content.show" />
                            </a>
                            <b class="arrow"></b>
                        </li>
                        <c:if test="${empty mainIndex}">
                            <c:set var="mainIndex"
                                   value="/pages/adslot/startAdSlotShow.jsp" scope="session"></c:set>
                        </c:if>
                    </cas:havePerm>
                      <cas:havePerm url="/json/adSlot_listAdSlots.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/adslot/navigAdSlotShow.jsp' />">
                                <fmt:message key="navig.slot.content.show" />
                            </a>
                            <b class="arrow"></b>
                        </li>
                      
                    </cas:havePerm>  <cas:havePerm url="/json/adSlot_listAdSlots.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/adslot/channelAdSlotShow.jsp' />">
                                <fmt:message key="channel.slot.content.show" />
                            </a>
                            <b class="arrow"></b>
                        </li>
                        
                    </cas:havePerm>
                </ul>
            </li>
        </cas:havePerm>
    
          
        <cas:havePerm url="/adAd.do">
            <li class="">
                <a href="#" class="dropdown-toggle" menu-url="<c:url value='/pages/adAd/adShow.jsp' />">
                    <i class="menu-icon fa fa-cube"></i>
                    <span class="menu-text"> <fmt:message key="ad.ad" /> </span>
                </a>
            </li>
        </cas:havePerm>

        <cas:havePerm url="/adMaterial.do">
            <li class="">
                <a href="#" class="dropdown-toggle" menu-url="<c:url value='/pages/admaterial/adMaterial.jsp' />">
                    <i class="menu-icon fa  fa-tags"></i>
                    <span class="menu-text"> <fmt:message key="ad.material" /> </span>
                </a>
            </li>
        </cas:havePerm>

        <cas:havePerm url="/audit.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa  fa-pencil"></i>
                    <span class="menu-text"> <fmt:message key="ad.audit" /> </span>
                
                    <b class="arrow fa fa-angle-down"></b>
                </a>
            
                <b class="arrow"></b>
                
                    <%--<ul class="submenu">--%>
                    <%--<cas:havePerm url="/json/bestvContent_beanList.do">--%>
                    <%--<li>--%>
                    <%--<a href="#" menu-url="<c:url value='/pages/contentShow/bestvContentShow.jsp' />">--%>
                    <%--<fmt:message key="ad.slot.open" />--%>
                    <%--</a>--%>
                    <%----%>
                    <%--<b class="arrow"></b>--%>
                    <%--</li>--%>
                    <%--<c:if test="${empty mainIndex}">--%>
                    <%--<c:set var="mainIndex"--%>
                    <%--value="/pages/contentShow/bestvContentShow.jsp" scope="session"></c:set>--%>
                    <%--</c:if>--%>
                    <%--</cas:havePerm>--%>
                    <%--</ul>--%>
            </li>
        </cas:havePerm>
        
        <cas:havePerm url="/log.do">
            <li class="">
                <a href="#" class="dropdown-toggle">
                    <i class="menu-icon fa fa-book"></i>
                    <span class="menu-text"> <fmt:message key="ad.log" /> </span>
                
                    <b class="arrow fa fa-angle-down"></b>
                </a>
            
                <b class="arrow"></b>
                  <ul class="submenu">
                    <cas:havePerm url="/json/bestvContent_beanList.do">
                        <li>
                            <a href="#" menu-url="<c:url value='/pages/log/adLog.jsp' />">
                                <fmt:message key="ad.log" />
                            </a>
                            <b class="arrow"></b>
                        </li>
                    </cas:havePerm>
                    </ul>
            </li>
        </cas:havePerm>
    </ul><!-- /.nav-list -->

    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
        <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
</div>
