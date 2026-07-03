if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprogram){
	Ext.lt.pmkpi.perfprogram = {};
}

Ext.lt.pmkpi.perfprogram.showhistrace = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _prolev = config.prolev,//项目级次
        _procode = config.procode,
        _saveAgency,//左侧树选择单位
        _deptwfststus = config.deptwfststus,//一般监控终审状态
        _jxwfststus = config.jxwfststus,//一般监控终审状态
        _bustype = config.bustype,
        _querytype = config.querytype,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var _displaycols = [];

    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.procode = _procode;
        params.deptwfststus = _deptwfststus;
        params.jxwfststus = _jxwfststus;
        params.querytype = _querytype;
        params.beanid = "pmkpi.perfprotrace.query.ProTraceQueryBOTX";
        Ext.lt.RCP.call(service, "showHisTrace", params, function (rs) {
            datatable.setDatas(rs.data);
        }, function () {
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }


    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "warndays"){
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,col){
                    if (data.warn == "red") {
                        return "<a style='color:#FF0000'>" + data.warndays + "</a>";
                    } else if (data.warn == "000") {
                        return "<a style='color:#FF0000'>已超时</a>";
                    } else if (data.warndays) {
                        return "<a>" + data.warndays + "</a>";
                    }
                }
            }

            if(col["colcode"]=="bgtwarn"){ //目标值构建符号和单位
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.bgtwarn? "" : data.bgtwarn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }

            if(col["colcode"]=="goalwarn"){ //目标值构建符号和单位
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.goalwarn? "" : data.goalwarn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }

            if(col["colcode"]=="compwarn"){ //全年预计完成情况预警
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.compwarn? "" : data.compwarn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }

            if (col["colcode"] == "wfstatusname") {
                col.fn = function(l, c, data, val){
                    var html = '<span>'+data.wfstatusname+'</span>';
                    if(data.wfstatus == '011'){
                        html = '<span>已终审</span>';
                    }else if (data.wfstatusname == undefined){
                        html = '<span></span>';
                    }
                    return html;
                }
            }
        }
    });


    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        Ext.lt.pmkpi.query();
    })



    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        var tasktype = data[0].tasktype;//任务类型 项目/部门/政策
        var provincetask = data[0].provincetask;
        var url = "";
        if (tasktype && "protrace" == tasktype) { //项目支出
            if (provincetask && provincetask == "1") {
                url = "/pmkpi/program/trace/report/edit.page";
            } else {
                url = "/pmkpi/program/trace/report/ordinaryedit.page";
            }
        } else if (tasktype && "depttrace" == tasktype) { //部门整体
            url = "/pmkpi/trace/report/deptedit.page";
            params.proguid = data[0].proguid;
        } else if (tasktype && "policytrace" == tasktype) { //重大政策
        }
        params.saveAgency = data[0].agencyguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.prolev = _prolev;
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.viewtype = "query";
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        params.bustype = "protrace";
        params.queryYear = data[0].year;
        params.queryProvince = data[0].province;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效监控申报-项目支出");
    }


    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        common.proinfoview(datatable,params);
    }


    return cmp;
}