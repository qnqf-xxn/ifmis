if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.financialevaluation){
    Ext.lt.pmkpi.financialevaluation = {};
}
var serviceid;
var _mainguid;
var _deldatas = [];
Ext.lt.pmkpi.financialevaluation.deptfillscore = function(config, service){
    var cmp = {};
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    _mainguid = config.mainguid;//主单guid
    var _menuid = config.menuid,//菜单id
        _viewtype = config.viewtype,
        _pagetype = config.pagetype,
        _bustype = config.bustype,
        _busguid = config.busguid,
        _proguid = config.proguid,
        _saveAgency = config.saveAgency,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    serviceid = service;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        cmp.query(true);
    })

    cmp.query = function(isquery){
        var params = {};
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        params.saveAgency = _saveAgency;
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
                            gatherSelfScore(d.superid)
                            gatherScore(d.superid);
                        }
                        superid = d.superid;
                    }
                }
                amtTotal(datatable);
            },500);
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
        var flag = weightCheck();
        if (!flag){
            return false;
        }
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.deldatas = _deldatas;
        params.mainguid = _mainguid;
        params.saveAgency = _saveAgency;
        params.bustype = _bustype;
        params.busguid = _busguid;
        params.proguid = _proguid;
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(service , "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            _deldatas = [];
            cmp.query();
        }
        return rs;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        var name = "上传附件";
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="file"){
                col.style = " text-align:center;";
                col.fn = function(l,c,data,col){
                    if (_viewtype == "query" || _viewtype == null || _viewtype == "") {
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
                    params.viewtype = _viewtype;
                    if(name =="查看附件"){
                        params.viewtype = "query";
                    }
                    params.mainguid = d.guid + _mainguid;
                    params.filetype = _bustype + "deptscore";
                    if (isGreyStyle()) {
                        parent.window.Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = '/pmkpi/file/index.page';
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
                    }
                };
            }

            //一二级指标不可修改
            if(col["colcode"]=="name" || col["colcode"]=="explain" || col["colcode"]=="evalstd" || col["colcode"]=="targetvalue"|| col["colcode"]=="evaluationrule" ){
                col.oneditstart = function(table,el,l,c,d){
                    if (d.isdeptadd != "1") {
                        return false;
                    }
                }
            }
            if( col["colcode"] == "remark" || col["colcode"] == "remarks" ){
                col.oneditstart = function(table,el,l,c,d){
                    if (d.isleaf != "1") {
                        return false;
                    }
                }
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
                col.oneditstart = function(table,el,l,c,d){
                    if (d.isleaf != "1" || d.isedit != "1") {
                        if (d.isdeptadd !="1"){
                            return false;
                        }
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    d.score = d.score != "" ? getPointNum(parseFloat(d.score)) : 0;
                    //处理得分必须小于权重
                    if(d.isleaf == "1" && d.selfscore > d.score){
                        Ext.lt.ui.alert("得分必须小于分值！",{timeout:1},function(){});
                        d.selfscore = "";
                    }
                    gatherScore(d.superid);
                }
            }

            if(col["colcode"]=="selfscore"){
                col.fn = function(l,c,data,col){
                    if(data.isleaf == "0"){
                        var selfscore = 0;
                        if(data.selfscore){
                            selfscore = data.selfscore;
                        }
                        return "<b>"+Math.round(selfscore*100)/100+"</b>";
                    }else{
                        return data.selfscore ? data.selfscore : 0;
                    }
                }
                col.oneditstart = function(table,el,l,c,d){
                    if (d.isleaf != "1" || d.isedit != "1") {
                        if (d.isdeptadd !="1"){
                            return false;
                        }
                    }
                }
                col.oneditend = function(table,el,l,c,d){
                    d.score = d.score != "" ? getPointNum(parseFloat(d.score)) : 0;
                    //处理得分必须小于权重
                    if(d.isleaf == "1" && d.selfscore > d.score){
                        Ext.lt.ui.alert("得分必须小于分值！",{timeout:1},function(){});
                        d.selfscore = "";
                        return false;
                    }
                    gatherSelfScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if(col["colcode"]=="obligate1"){
                if (_viewtype != "query" && _pagetype != "upfile"){
                    col.style = " text-align:center;";
                    col.fn = function(l,c,data,col){
                        var html = "";
                        if (data.isadd == "1") {
                            html = "<a title = '新增' style='color:#468ac9;cursor:pointer;' onclick='add(\""+data.guid+"\",\""+data.levelno+"\",\""+data.isleaf+"\")'>新增</a>";
                        }
                        if (data.isdeptadd == "1") {
                            html = "<a title = '新增' style='color:#468ac9;cursor:pointer;' onclick='add(\""+data.guid+"\",\""+data.levelno+"\",\""+data.isleaf+"\")'>新增</a>";
                            html += "          <a title = '删除' style='color:#468ac9;cursor:pointer;' onclick='del(\""+data.guid+"\")'>删除</a>";
                        }
                        return html;
                    }
                }
            }

            if ((_viewtype == "query" || _pagetype == "upfile") && col["name"] != "check" && col["name"] != "file") {
                if (_pagetype == "upfile") {
                    if(col["colcode"] == "file"){
                        return ;
                    }
                }
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function(table,el,l,c,d){
                    return false;
                }
            }
        }
    });

    //重画合计行，赋予新颜色
    Ext.lt.message.hook('datatable','buildLineStyle',function(paramobj){
        var rowdata = paramobj.rowdata;
        if(rowdata.isleaf == 0 && rowdata.isdeptadd != 1){
            paramobj.style=' style="background: #e9f0f"';
            paramobj.selfdefcolor = true;
        }
    });

    return cmp;
}

/**
 * 新增
 */
add = function(guid,levelno,isleaf){
    var data = {};
    var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
    data.guid = newguid;
    data.rowtype = "add";
    data.superid = guid;
    data.levelno = parseInt(levelno) + 1;
    data.isleaf = 1;
    data.isedit = "1";
    data._isleaf = 1;
    data.isdeptadd = "1";
    var parent_sel_rows = datatable.getRecordset().query({guid:guid});
    var parent_sel_obj = parent_sel_rows[0];
    var _sortid = parent_sel_obj._sortid;
    parent_sel_obj["isleaf"] = 0;
    parent_sel_obj["_isleaf"] = 0;
    if (parent_sel_obj[FOLDING_FILED] == 'close') {
        parent_sel_obj[FOLDING_FILED] = 'open';
        datatable.getViewRecordSet().showChildren(parent_sel_obj, _sortid);
    }
    datatable.getRecordSet().addData(data);
    datatable.reflash(_sortid);
}

del = function (guid){
    var subdata = datatable.getRecordset().query({superid:guid});
    if (subdata && subdata.length > 0) {
        Ext.lt.ui.confirm("将删除该指标及其下级所有指标，是否确认删除？",{icon:"warn"},function(ret){
            if(ret){
                var parent_sel_rows = datatable.getRecordset().query({guid:guid});
                subdeldata(guid);
                reflashscore();
                //上级是否得分是否置为可编辑
                var parent_sel_obj = datatable.getRecordset().query({guid:parent_sel_rows[0]["superid"]});
                if (parent_sel_obj && parent_sel_obj.isdeptadd == "1") {
                    parent_sel_obj["_isleaf"] = 1;
                    parent_sel_obj["isleaf"] = 1;
                    var _sortid = parent_sel_obj._sortid;
                    datatable.reflash(_sortid);
                }
            }
        })
    } else {
        Ext.lt.ui.confirm("确认要删除选中指标？",{icon:"warn"},function(ret){
            if(ret){
                var parent_sel_rows = datatable.getRecordset().query({guid:guid});
                var parent_sel_obj = parent_sel_rows[0];
                var _sortid = parent_sel_obj._sortid;
                datatable.getRecordset().remove(parent_sel_obj);
                _deldatas.push(parent_sel_obj);
                //查询是否存在末级数据
                var subparent_sel_rows = datatable.getRecordset().query({superid:parent_sel_rows[0]["superid"]});
                if (subparent_sel_rows.length == 0) {//不存在把父级数据改为末级
                    //上级是否得分是否置为可编辑
                    parent_sel_rows = datatable.getRecordset().query({guid:parent_sel_rows[0]["superid"]});
                    parent_sel_obj = parent_sel_rows[0];
                    if (parent_sel_obj && (parent_sel_obj.isdeptadd == "1" || parent_sel_obj.isadd == "1")) {
                        parent_sel_obj["_isleaf"] = 1;
                        parent_sel_obj["isleaf"] = 1;
                        _sortid = parent_sel_obj._sortid;
                        datatable.reflash(_sortid);
                    }
                }
            }
        })
    }
}
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


function subdeldata(guid){
    //删除选中数据
    var parent_sel_rows = datatable.getRecordset().query({guid:guid});
    var parent_sel_obj = parent_sel_rows[0];
    datatable.removeData(parent_sel_obj);
    _deldatas.push(parent_sel_obj);
    //查询选中数据下级
    var datas = datatable.getRecordset().query({superid:guid});
    //循环查询删除最末级
    for (var i = 0; i < datas.length; i++) {
        subdeldata(datas[i].guid);
    }
}

function amtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var scoresumamt = 0;
        var selfscoresumamt = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            if (rowarr[i].levelno == "1") {
                var selfscore = rowarr[i]["selfscore"] ? rowarr[i]["selfscore"] : 0;
                selfscoresumamt += parseFloat(selfscore);
            }
            if (rowarr[i].levelno == "1") {
                var score = rowarr[i]["score"] ? rowarr[i]["score"] : 0;
                scoresumamt += parseFloat(score);
            }
        }
        var totalrs = {};
        totalrs["score"] = scoresumamt == 0 ? "" : scoresumamt.toFixed(2);
        totalrs["selfscore"] = selfscoresumamt == 0 ? "" : selfscoresumamt.toFixed(2);
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
                    datas[i]['score'] = result==0 ? "" : result.toFixed(2);
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

/**
 * 得分汇总.
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
 * 一级权重
 */
function weightCheck(){
    var col = "superid";
    var levno = 1;
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
                        Ext.lt.ui.alert(tempObj["levelno"] + "级指标：" + tempObj["name"] + " 得分录入应等于上级设置数！", {timeout: 1}, function () { });
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