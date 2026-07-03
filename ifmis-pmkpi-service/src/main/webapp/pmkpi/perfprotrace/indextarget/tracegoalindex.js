if (!Ext)
    Ext = {};
if (!Ext.lt)
    Ext.lt = {};
if (!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if (!Ext.lt.pmkpi.protrace)
    Ext.lt.pmkpi.protrace = {};

var yeargoals = []; //年度目标
//绩效指标审核 --- 审核时应该是只读，目前也可改只是没有保存按钮，不合理
Ext.lt.pmkpi.protrace.goalindexservice = function (config, serviceid) {
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _mainguid = config.mainguid,//
        _taskguid = config.taskguid,//任务guid
        _qualtype = config.qualtype, //定性指标类型：1-下拉框（默认）；2-手动输入；
        _prolev = config.prolev,//项目级次
        _saveAgency = config.saveAgency,//单位
        _busguid = config.busguid,//审核定义guid
        _viewtype = config.viewtype, //区分是否查询:query是查询，其他可修改
        _signs = config.signs,//计算符号
        _bustype = config.bustype,//任务类型
        _procode = config.procode,//项目编码
        _istianjin = config.isTianjin, //是否天津模式
        _ismergeindex = config.ismergeindex,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _isSx = config.isSX,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _isdisplay, //[序时进度预警]列是否显示,不显示时,[偏差原因分析],不校验规则
        _indexvaldatas = config.indexvaldatas,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;


    var cmp = {};
    var firstpage =  true;

    $(function () {
        if (_viewtype == "query") {
            $("div[compid='toolbutton']").hide();
        }
        cmp.mainquery(true);
        common.initDatatable();
        if (_viewtype == "query") {
            for(var i=2; i<maintable.getCols().length; i++){
                maintable.getCols()[i].edit = false;
            }
            for(var i=2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            maintable.redraw();
            datatable.redraw();
            $("#add").hide();
            $("#del").hide();
        }
        cmp.resiztable();

    })

    /**
     * 主表的选中单选事件
     */
    Ext.lt.message.hook("fasp2datatable", "onRadioClick",function(d){
        //处理子表数据保存到主表上
        var datas = datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        //cmp.query(d[4]);
        var selectDatas = maintable.getSelected();
        cmp.query(selectDatas[0]);

    });

    /**
     * 子表查询
     * @param d -- 选中数据.
     */
    cmp.query = function(d){
        var indexs = d["#indexs"];
        if (indexs.length > 0){
            datatable.setDatas(indexs);
        } else {
            var params = {};
            params.mainguid = d.mainguid;
            params.goalguid = d.guid;
            params.compconfigid = "datatable";
            params.url = datatable.config.pageurl;
            params.viewtype = _viewtype;
            params.queryYear = _queryYear;
            params.queryProvince = _queryProvince;
            Ext.lt.RCP.call(serviceid , "getSubData", params, function(rs){
                datatable.setDatas(rs.data);
            },function(){
                Ext.lt.ui.alert('查询失败！',function(){
                });
            });
        }
    }

    /**
     * 主表查询.
     * goaltype -- 1 中长期， 0 年度
     */
    cmp.mainquery = function (isquery){
        if (firstpage || parent._issavetmp){
            var params = {};
            params.tablesql = _defquery;
            params.orderby = _orderby;
            params.tablecode = _tablecode;
            params.mainguid = _mainguid;
            params.proguid = _proguid;
            params.bustype = _bustype;
            params.procode = _procode;
            params.compconfigid = "maintable";
            params.url = maintable.config.pageurl;
            params.viewtype = _viewtype;
            params.queryYear = _queryYear;
            params.queryProvince = _queryProvince;
            Ext.lt.ui.loadingShow();
            Ext.lt.RCP.call(serviceid , "getMainDatas", params, function(rs){
                yeargoals = rs.yeargoals;
                maintable.setDatas(yeargoals);
                maintable.clearSelected();
                datatable.setDatas([]);
                setMidSaveHidButtons(rs);
                Ext.lt.ui.loadingClose();
                if (isquery) {
                    setTimeout(function(){
                        parent._isQuery = true;
                    },500);
                }
            },function(){
                Ext.lt.ui.loadingClose();
                Ext.lt.ui.alert('目标查询失败！',function(){
                });
            });
        } else {
            maintable.setDatas(yeargoals);
            maintable.clearSelected();
            datatable.setDatas([]);
        }
        firstpage = false;
    }

    cmp.save = function (){
        var params = {};
        //1 表格切换之前先保存一下子表到主表行。
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        //2将主表保存到全局变量上
        yeargoals = maintable.getRecordSet().toArray();
        if (!cmp.checkall()) return false;//先校验
        params.datas = maintable.getRecordSet().toArray();
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.proguid = _proguid;
        params.taskguid = _taskguid;
        params.compconfigid = "maintable";
        params.url = maintable.config.pageurl;
        var rs = Ext.lt.RCP.asyncall(serviceid , "savePrjIndex", params);
        if (rs && rs.success) {
            cmp.mainquery();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var params = {};
        //1 表格切换之前先保存一下子表到主表行。
        var datas = datatable.getRecordSet().toArray();
        if(!datas || datas.length == 0) {
            params.success = true;
            return params;
        }
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = maintable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        //2将主表保存到全局变量上
        yeargoals = maintable.getRecordSet().toArray();
        params.mainguid = _mainguid;
        params.data = maintable.getRecordSet().toArray();
        params.url = maintable.config.pageurl;
        params.componentid = maintable.config.server;
        params.compconfigid = "maintable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.mainquery();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.mainguid = _mainguid;
        params.url = maintable.config.pageurl;
        params.componentid = maintable.config.server;
        params.compconfigid = "maintable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.mainquery();
        }
        return rs;
    }

    /**
     * 重新刷新表格.
     */
    cmp.resiztable = function (){
        var width = $("#maintable").width;
        maintable.resize(width-20,_scrHeight*0.4);
        datatable.resize(width-20,_scrHeight);
    }

    cmp.checkall = function() {
        for (var k = 0,lenk = yeargoals.length; k < lenk; k++) {
            var datas = yeargoals[k]["#indexs"];
            var cols = datatable.getCols();
            for (var i = 0,leni = datas.length; i < leni; i++) {
                for (var j = 0,lenj = cols.length; j < lenj; j++) {
                    if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                        var value = datas[i][cols[j].colcode];
                        if (value == null || value == "" || ("" + value).trim().length == 0) {
                            alert("第"+(k+1)+"行目标的第" + (datas[i]["_sortid"] + 1) + "行的绩效指标" + cols[j].alias + "为必录项，必须有值。");
                            return false;
                        }
                    }
                }
                //处理计算符号为定性，单位不填情况
                if (datas[i]["computesign"] != "6" && (datas[i]["meterunit"] == ""||datas[i]["meterunit"] == null||datas[i]["meterunit"] == undefined) && datas[i]["levelno"] == 3 ){
                    alert("第"+(k+1)+"行目标的第" + (datas[i]["_sortid"] + 1) + "行的绩效指标单位必须有值。");
                    return false;
                }
            }
        }
        return true;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
        var cols = data.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if (col["colcode"] == "computesign") {
                col.fn = function (l, c, d, val) {
                    var computesignstr = "";
                    for (var i = 0; i < _signs.size(); i++) {
                        if (d.computesign == _signs[i].guid) {
                            computesignstr = _signs[i].name;
                        }
                    }
                    return "<font style=\"margin-left:10px;\">" + computesignstr + "</font>";
                }
            }
            if(col["colcode"]=="targetvalue"){ //目标值构建符号和单位
                col.fn = function(l,c,data,val){
                    if(data.computesign == "6" || data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1"){
                        var targetvalue = !data.targetvalue? "" : data.targetvalue;
                        return "<font style=\"margin-left:10px;\">" + targetvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data.meterunit){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.targetvalue ? computesignstr + unit :computesignstr + data.targetvalue + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
            }
            if(col["colcode"]=="indexval"){
                //处理指标值，计量单位合并显示
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6" || data.computesign == "9" ){ //定性
                        // var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + col+"</font>";
                    }else if(_ismergeindex != "1"){ //不合并
                        var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">"+indexvalue+"</font>";
                    } else {//合并
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data.meterunit){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    //是否可编辑 1是2否
                    if (!d.levelno || d.levelno != 3) {
                        return false;
                    }
                    /*if ((d.computesign == "6" || d.computesign == "9" || d.computesign == "10") && _qualtype == "1") {
                        doMapper(_indexvaldatas,table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {*/
                        el.innerText = d.indexval != undefined ? d.indexval : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        return;
                    //}
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6'){
                        if (!d.indexval || d.indexval == "") {
                            d.warn = '';
                            d.deviate = '';
                            return false;
                        }
                        if(!checkReferencepole(d.indexval)){
                            d.indexval = '';
                            d.warn = '';
                            return false;
                        }
                    }
                    Ext.lt.pmkpi.warn(d);
                    var parent_sel_rows = datatable.getRecordset().query({guid:d.guid});
                    var parent_sel_obj = parent_sel_rows[0];
                    var _sortid = parent_sel_obj._sortid;
                    if(d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                        if(d.indexval == '0' || d.targetvalue == '0'){
                            parent_sel_obj["indexcompletion"] = 0;
                        }else{
                            parent_sel_obj["indexcompletion"] = Math.round(d.indexval / d.targetvalue * 10000) / 100.00 + "%";
                        }
                    }
                    datatable.reflash(_sortid);
                }

            }
            if(col["colcode"] == 'completeanalysis'){//完成可能性分析
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑
                    if (!d.levelno || d.levelno != 3) {
                        return false;
                    }
                }
            }
            if(col["colcode"]=="deviationanalysis" || col["colcode"]=="otherreasons" || col["colcode"]=="remark" ){
                col.oneditstart = function(table,el,l,c,d){
                    //是否可编辑
                    if (!d.levelno || d.levelno != 3) {
                        return false;
                    }
                }
            }
            if(col["colcode"]=="warn"){ //目标值构建符号和单位
                _isdisplay = col.isvisiable;
                col.cseditfn = function(i,j,rs, style){ //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function(l,c,data,val){
                    var warn = !data.warn? "" : data.warn;
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


            if (_viewtype == 'query' && !config[col.colcode] && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });




    Ext.lt.pmkpi.warn = function (d){
        var params = {};
        if (d.computesign == "1" || d.computesign == "2" || d.computesign == "3") {
            params.warmtype = "positiveindex";
        } else if (d.computesign == "4") {
            params.warmtype = "reverselessindex";
        } else if(d.computesign == "5"){
            params.warmtype = "reverseindex";
        }else {
            params.warmtype = "qualitativeindex";
        }
        params.taskguid = _taskguid;
        params.indexval = d.indexval; //当前完成值
        params.targetvalue = d.targetvalue; //年度指标值
        params.mainguid = d.mainguid;
        params.findex = d.findex;
        params.sindex = d.sindex;
        var warndata = Ext.lt.RCP.asyncall(serviceid , "getWarn", params);
        var parent_sel_rows = datatable.getRecordset().query({guid:d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["warn"] = warndata;
        //deviate
        parent_sel_obj["deviate"] = warndata;
        datatable.reflash(_sortid);
    }



    /**
     * 获取最新的绩效指标、目标数据
     */
    cmp.getindexAndGoal = function () {
        Ext.lt.ui.confirm('系统将自动清除页面已填报目标和指标数据，监控预警信息重新计算(如有该信息需重新保存)，请确认？',{icon: "warn"},function(is){
            if(is){
                var params = {};
                params.mainguid = _mainguid;
                params.bustype = _bustype;
                params.tablecode = _tablecode;
                params.procode = _procode;
                params.proguid = _proguid;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(serviceid, "getindexAndGoal", params, function(rs) {
                    yeargoals = rs.yeargoals;
                    maintable.setDatas(yeargoals);
                    maintable.clearSelected();
                    datatable.setDatas([]);
                    setMidSaveHidButtons(rs);
                    Ext.lt.ui.loadingClose();
                })
            }
        })
    }


    return cmp;
}


