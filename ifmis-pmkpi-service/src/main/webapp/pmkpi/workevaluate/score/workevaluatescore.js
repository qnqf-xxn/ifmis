if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workevaluate){
    Ext.lt.pmkpi.workevaluate = {};
}
var serviceid;
Ext.lt.pmkpi.workevaluate.score = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _mainguid = config.mainguid,//主单guid
        _viewtype = config.viewtype,
        _tasktype = config.tasktype,//任务类型
        _busguid = config.busguid,//审核定义guid
        _subprovince = config.subprovince,//下级财政区划编码
        _saveAgency = config.saveAgency,//部门guid
        _scoretype = config.scoretype,//评分类型
        _bustype = config.bustype,//业务类型
        _pagetype = config.pagetype,//页面类型
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    serviceid = service;

    $(function () {
        common.initDatatable();
        cmp.query(true);
    })
    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }
    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.tasktype = _tasktype;
        params.scoretype = _scoretype;
        params.pagetype = _pagetype;
        params.bustype = _bustype;
        params.subprovince = _subprovince;
        params.saveAgency = _saveAgency;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "getDatas", params, function(rs){
            var tempdatas = rs.data;
            datatable.setDatas(tempdatas);
            setTimeout(function(){
                var superid = "";
                for (var i=0; i<rs.data.length; i++) {
                    var d = rs.data[i];
                    if (d.isleaf == 1) {
                        if (d.superid != superid) {
                            gatherSelfScore(d.superid);
                            gatherRatiScore(d.superid);
                            gatherScore(d.superid);
                        }
                        superid = d.superid;
                    }
                }
                amtTotal(datatable);
            },1000);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var datas = datatable.getRecordSet().toArray();
        var params = {};
        params.datas = datas;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.tasktype = _tasktype;
        params.busguid = _busguid;
        params.scoretype = _scoretype;
        params.bustype = _bustype;
        params.pagetype = _pagetype;
        params.subprovince = _subprovince;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="file"){
                var type = "";
                if (_pagetype == "audit") {
                    type = "query";
                }
                col.style = " text-align:center;";
                col.fn = function(l,c,data,col){
                    var name = "上传附件"
                    if (_viewtype == "query" || type == "query") {
                        name = "查看附件";
                    }
                    var html = "";
                    if(data.isleaf == 1){
                        html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
                    }
                    return html;
                }
                col.onclick = function(td, el, l, c, d) {
                    if (d.isleaf != 1) {
                        return;
                    }
                    var params = {};
                    params.mainguid = d.guid + _mainguid;
                    params.filetype = _scoretype + "workscore";
                    params.viewtype = !_viewtype ? type : _viewtype;
                    params.queryYear = _queryYear;
                    params.queryProvince = _queryProvince;
                    if (isGreyStyle()) {
                        parent.window.Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = '/pmkpi/file/index.page';
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
                    }
                };
            }

            if(col["colcode"]=="score"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var score = 0;
                        if(data.score){
                            score = data.score;
                        }
                        return "<b>"+Math.round(score*100)/100+"</b>";
                    }else{
                        return data.score ? data.score : 0;
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    d.score = d.score != "" ? getPointNum(parseFloat(d.score)) : 0;
                    //处理得分必须小于权重
                    if(d.isleaf == "1" && d.selfscore > d.score){
                        Ext.lt.ui.alert("自评分数必须小于分值！",{timeout:1},function(){});
                        d.selfscore = "";
                    }
                    gatherScore(d.superid);
                }
            }

            if(col["colcode"]=="selfscore"){
                upcols.push(col["colcode"]);
                if (_pagetype == "audit") {
                    col.style = "background-color:#f2f2f2;";
                }
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var selfscore = 0;
                        if(data.selfscore){
                            selfscore = data.selfscore;
                        }
                        return "<b>"+Math.round(selfscore*100)/100+"</b>";
                    } else {
                        return data.selfscore ? data.selfscore : 0;
                    }
                }
                col.oneditstart = function(table,el,l,c,d){
                    if (d.isleaf != "1" || d.querysql || _pagetype == "audit" || _viewtype == "query") {
                        return false;
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    d.score = d.score != "" ? getPointNum(parseFloat(d.score)) : 0;
                    //处理得分必须小于权重
                    if(d.isleaf == "1" && d.selfscore > d.score){
                        Ext.lt.ui.alert("自评分数必须小于分值！",{timeout:1},function(){});
                        d.selfscore = "";
                        return false;
                    }
                    gatherSelfScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if(col["colcode"]=="ratiscore"){
                upcols.push(col["colcode"]);
                if (_pagetype != "audit") {
                    col.style = "background-color:#f2f2f2;";
                }
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var ratiscore = 0;
                        if(data.ratiscore){
                            ratiscore = data.ratiscore;
                        }
                        return "<b>"+Math.round(ratiscore*100)/100+"</b>";
                    }else{
                        return data.ratiscore ? data.ratiscore : 0;
                    }
                }
                col.oneditstart = function(table,el,l,c,d){
                    if (d.isleaf != "1" || d.querysql || !_pagetype) {
                        return false;
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    d.score = d.score != "" ? getPointNum(parseFloat(d.score)) : 0;
                    //处理得分必须小于权重
                    if(d.isleaf == "1" && d.ratiscore > d.score){
                        Ext.lt.ui.alert("评定分数必须小于分值！",{timeout:1},function(){});
                        d.ratiscore = "";
                        return false;
                    }
                    gatherRatiScore(d.superid);
                    amtTotal(datatable);
                }
            }
            if (_viewtype == 'query' && col["name"] != "check" && col["colcode"] != "file") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
        if (_viewtype != 'query') {
            for(var i=0; i<cols.length; i++){
                if (cols[i]["colcode"] && cols[i]["isvisiable"] == 1) {
                    var iscol = false;
                    for (var j=0; j<upcols.length; j++) {
                        if (cols[i]["colcode"] == upcols[j]) {
                            iscol = true;
                            break;
                        }
                    }
                    if (!iscol) {
                        cols[i].oneditstart = function (table, e, l, c, d) {
                            if (d.isleaf != "1" || d.isdeptadd != "1") {
                                return false;
                            }
                        }
                    }
                }
            }
        }
    });

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.isleaf == 0){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    /**
     * 列表附件名称显示进行刷新
     * @param filenames
     * @param billguid
     */
    Ext.lt.pmkpi.setFileName = function (filenames, billguid){
        billguid = billguid.substr(0, billguid.length -_mainguid.length);
        var parent_sel_rows = datatable.getRecordset().query({guid:billguid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["filename"] = filenames;
        datatable.reflash(_sortid);
    }

    return cmp;
}


function amtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var scoresumamt = 0;
        var ratiscoresumamt = 0;
        var selfscoresumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].isleaf == "1") {
                var ratiscore = rowarr[i]["ratiscore"] ? rowarr[i]["ratiscore"] : 0;
                var selfscore = rowarr[i]["selfscore"] ? rowarr[i]["selfscore"] : 0;
                selfscoresumamt += parseFloat(selfscore);
                ratiscoresumamt += parseFloat(ratiscore);
            }
            if (rowarr[i].levelno == "1"  && rowarr[i].istotal == 1) {
                var score = rowarr[i]["score"] ? rowarr[i]["score"] : 0;
                scoresumamt += parseFloat(score);
            }
        }
        var totalrs = {};
        totalrs["score"] = scoresumamt == 0 ? "" : scoresumamt.toFixed(2);
        totalrs["selfscore"] = selfscoresumamt == 0 ? "" : selfscoresumamt.toFixed(2);
        totalrs["ratiscore"] = ratiscoresumamt == 0 ? "" : ratiscoresumamt.toFixed(2);
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
            table.reflashdata();
        }
    }
}

function reflashscore(){
    var datas = datatable.getRecordset().toArray();
    setTimeout(function(){
        var superid = "";
        for (var i=0; i<datas.length; i++) {
            var d = datas[i];
            if (d.isleaf == 1) {
                if (d.superid != superid) {
                    gatherSelfScore(d.superid)
                    gatherScore(d.superid);
                }
                superid = d.superid;
            }
        }
        amtTotal(datatable);
    },500);
}

/**
 * 分值汇总
 * @param superid
 */
function gatherScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.score && !isNaN(selectDatas.score)){
                    result += parseFloat(selectDatas.score);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid && ((data.levelno != 1 && data.levelno != 2) || data.isdeptadd == "1")){
                    datas[i]['score'] = result==0 ? "" : result.toFixed(1);
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

/**
 * 自评分数汇总.
 * @param superid
 */
function gatherSelfScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.selfscore && !isNaN(selectDatas.selfscore)){
                    result += parseFloat(selectDatas.selfscore);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['selfscore'] = result == 0 ? "" : result.toFixed(2);
                }
            });
            gatherSelfScore(supguid);
        }
    }
    datatable.reflash();
}

/**
 * 评定分数汇总.
 * @param superid
 */
function gatherRatiScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var sortid = 0;
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.ratiscore && !isNaN(selectDatas.ratiscore)){
                    result += parseFloat(selectDatas.ratiscore);
                }
            }
            datas.each(function(data,i){
                if(data.guid == guid){
                    datas[i]['ratiscore'] = result == 0 ? "" : result.toFixed(2);
                }
            });
            gatherRatiScore(supguid);
        }
    }
    datatable.reflash();
}

/**
 * 一级权重
 */
function weightCheck(){
    var col = "superid";
    var levno = 2;
    var flag = true;
    var datas = datatable.getRecordSet().toArray();
    if(datas!=null && datas.length > 0){
        //获取上级得分
        for(var i=0;i<datas.length;i++){
            var tempObj = datas[i];
            if (tempObj["levelno"]  == levno) {
                var score = getSumScore(tempObj.guid);
                if(tempObj.score != 0 ){
                    if (parseFloat(tempObj.score) != score){
                        flag = false;
                        break;
                    }
                }
            }
        }
    }
    return flag;
}

function getPointNum(num){
    var str = String(num);
    var index = str.split(".");
    var str1 = null;
    if(index.length == 2){
        str1 = index[1].substring(0,1);
        str1 = Number(index[0]+"."+str1);
    } else {
        str1 = Number(index[0]);
    }
    return str1;
}

/**
 * 得分汇总.
 * @param superid
 */
function getSumScore(superid){
    var datas = datatable.getRecordSet().toArray();
    if(superid){
        if(datas!=null && datas.length > 0){
            var supguid = '';
            var result = 0;
            var guid = '';
            for(var i=0;i<datas.length;i++){
                var selectDatas = datas[i];
                if(superid == selectDatas.guid){
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(selectDatas.superid == superid && selectDatas.score && !isNaN(selectDatas.score)){
                    result += parseFloat(selectDatas.score);
                }
            }
            getSumScore(supguid);
            return result;
        }
    }
}