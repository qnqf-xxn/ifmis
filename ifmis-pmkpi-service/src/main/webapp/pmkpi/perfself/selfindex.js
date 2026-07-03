if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.selfindex) {
    Ext.lt.pmkpi.selfindex = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _viewtype;
var _dxzbsource;//定性指标数据源
var _weight_sum;
var _isHebei;
var _is_JiangXi;
var _isZJ;
var _isSX;
var _isCheckWeightGtZero;
var _qualischeck;
var _kpi_remarkname;
var _actualweightname;
    Ext.lt.pmkpi.selfindex = function (config, service) {
    var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var  _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid,//审核定义guid，perf_t_busauditdefine表budguid
        _modelguid,//指标模板guid
        _scorepercentage,//自评指标完成情况当实际完成值超出指标值xx%，得分列得分标红可编辑
        _bustype = config.bustype,
        _projguid = config.projguid,
        _procode = config.procode,
        _rationscore = config.rationscore, //定量指标类型：1或null-不自动计算，可编辑；2-自动计算，可编辑；3-自动计算，不可编辑；（默认为null）
        _qualscore = config.qualscore, //定性指标类型：1或null-不自动计算，可编辑；2-自动计算，可编辑；3-自动计算，不可编辑；（默认为null）
        _signs = config.signs,
        _selfindexval = config.selfindexval,
        _ismergeindex = config.ismergeindex,
        _pagetype = config.pagetype,
        _isAH = config.isAH,
        _queryYear = config.queryYear,//跨年查询查询年度
        _queryProvince = config.queryProvince,//跨年查询查询区划
        _impguid,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;

    _isZJ = config.isZJ;
    _isGX = config.isGUANGXI; //是否广西模式
    _isSX = config.isSX;
    _is_JiangXi = config.is_JiangXi;
    _isHebei = config.isHebei;
    _dxzbsource = config.dxzbsource;
    _saveAgency = config.saveAgency;
    _mainguid = config.mainguid;
    _viewtype = config.viewtype;
    _isCheckWeightGtZero = config.isCheckWeightGtZero;
    _qualischeck = config.qualischeck; //是否校验定性指标区间： 1或null-是；2-否；（默认为null）
    serviceid = service;
    var cmp = {};
    var _ind_remarkname;


    /**
     * 表格获取.
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        _modelguid = config.modelguid;
        _scorepercentage = config.scorepercentage;
    });
    /**
     * 查询信息.
     */
    cmp.query = function (isquery) {
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.modelguid = _modelguid;
        params.projguid = _projguid; //项目绩效目标
        params.procode = _procode; //项目code
        params.bustype = _bustype;
        params.agencyguid = _saveAgency;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.viewtype = _viewtype;
        params.queryYear = _queryYear;
        params.queryProvince = _queryProvince;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function (rs) {
            datatable.setDatas(rs.data);
            setMidSaveHidButtons(rs);
            setTimeout(function () {
                var superid = "";
                for (var i = 0; i < rs.data.length; i++) {
                    var d = rs.data[i];
                    if (d.levelno == 3) {
                        if (d.superid != superid) {
                            gatherScore(d.superid);
                            gatherWeightAll(d.superid);
                        }
                        superid = d.superid;
                    }
                }
                amtTotal(datatable);
            }, 500);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }

    /**
     * 获取最新的绩效指标、目标数据
     */
    cmp.getindexAndGoal = function () {
        Ext.lt.ui.confirm('系统将自动清除页面已填报目标和指标数据，自评得分、结论信息重新计算(如有该信息需重新保存)，请确认？',null,function(is){
            if(is){
                var params = {};
                params.mainguid = _mainguid;
                params.bustype = _bustype;
                params.tablecode = _tablecode;
                params.procode = _procode;
                params.proguid = _projguid; //项目绩效目标
                params.agencyguid = _saveAgency;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service, "getindexAndGoal", params, function(rs) {
                    datatable.setDatas(rs["datas"]);
                    setMidSaveHidButtons(rs);
                    setTimeout(function () {
                        var superid = "";
                        for (var i = 0; i < rs["datas"].length; i++) {
                            var d = rs["datas"][i];
                            if (d.levelno == 3) {
                                if (d.superid != superid) {
                                    gatherScore(d.superid);
                                    gatherWeightAll(d.superid);
                                }
                                superid = d.superid;
                            }
                        }
                        amtTotal(datatable);
                    }, 200);
                    Ext.lt.ui.loadingClose();
                })
            }
        })
    }

    cmp.indexCheckAll = function (){
        var cols = datatable.getCols(); //获取列表所有列
        var datas = datatable.getRecordSet().toArray();
        for (var j = 0,lenj = cols.length; j < lenj; j++) {
            for (var i = 0,leni = datas.length; i < leni; i++) {
                if (datas[i]["levelno"] == 3) {
                    if (_isSX == "1"){
                        //山西自评成本指标若用默认的成本指标得分最高是5分，提示是"未填报成本指标的项目，成本指标得分不得超过5分"
                        if (datas[i]["wfstatus"] == "1" && datas[i]["score"] > 5){
                            Ext.lt.ui.alert("未填报成本指标的项目，成本指标得分不得超过5分");
                            return false;
                        }
                        //山西：如果年初指标有值，调整后指标（年度指标值）无值的情况整行不应该填写，也不应该提示让必录
                        if (datas[i]["ncindexval"] != null && (datas[i]["indexval"] == null || datas[i]["indexval"] == "")){

                        }else{
                            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                                    var value = datas[i][cols[j].colcode];
                                    if (value == 0) {
                                        value = value + "";
                                    }
                                    if (!value || value == null || value == "" || ("" + value).trim().length == 0) {
                                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                                        return false;
                                    }
                                }
                            }
                        }
                    } else {
                        for (var j = 0,lenj = cols.length; j < lenj; j++) {
                            if (cols[j].requirement == '1') {
                                var value = datas[i][cols[j].colcode];
                                if (value == 0) {
                                    value = value + "";
                                }
                                if (!value || value == null || value == "" || ("" + value).trim().length == 0) {
                                    Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                                    return false;
                                }
                            }
                        }
                        if (_isGX) {
                            var score_remark = datas[i].score_remark;
                            if (datas[i].computesign == "6" && (!score_remark ||  score_remark == null || score_remark == "") && datatable.getCol("score_remark")) {
                                Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + datatable.getCol("score_remark").alias + "为必录项，必须有值。",{timeout:1},function(){});
                                return false;
                            }
                        }
                    }
                }
            }
        }
        return true;
    }

    cmp.save = function () {
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var datas = datatable.getRecordSet().toArray();
        if (!datas || datas.length == 0) {
            return true;
        }
        if (!cmp.indexCheckAll()) return false;//先校验

        //获取列配置是否显示设定权重，用于判定是否校验权重合计
        var _ischeckweight = true;
        var columncfg = datatable.config.data[0].columns;
        for (var i=0; i<columncfg.length; i++) {
            if(columncfg[i].colcode == "weight" && columncfg[i].isvisiable == "0"){
                _ischeckweight = false;
            }
        }
        if (_ischeckweight && !weightCheckNew() && _isZJ != "1") {  //权重校验
            return false;
        }
        //广西校验
        if (_isGX && !actualValueCheck()){
            return false;
        }

        var j = 1;

        for (var i=0; i<datas.length; i++) {
            var data = datas[i];
            if (data.levelno == 3) {
                //山西：如果年初指标有值，调整后指标（年度指标值）无值的情况整行不应该填写，不校验
                if (_isSX == '1' && datas[i]["ncindexval"] != null && (datas[i]["indexval"] == null || datas[i]["indexval"] == "")){
                }else {
                    var computesign = data.computesign;
                    var actualweight;
                    if (_isZJ == "1") {
                        actualweight = data.weight ? getPointNum(parseFloat(data.weight)) : "0.00";
                    } else {
                        actualweight = data.actualweight ? getPointNum(parseFloat(data.actualweight)) : "0.00";
                    }
                    var score = data.score ? getPointNum(parseFloat(data.score)) : "0.00";
                    //处理得分必须小于权重
                    if (score < actualweight && (!data.kpi_remark || data.kpi_remark == "")) {
                        Ext.lt.ui.alert("第" + j + "行请填写" + _kpi_remarkname + "！", {timeout: 1}, function () {
                        });
                        return false;
                    }
                    //是否校验自评指标权重大于0:1-是，其它-否；
                    if (_isCheckWeightGtZero == "1" && actualweight <= 0) {
                        Ext.lt.ui.alert("第" + j + "行" + _actualweightname + "值需大于0！", {timeout: 1}, function () {
                        });
                        return false;
                    }
                    var deduct_score = data["deduct_score"] ? data["deduct_score"] : 0.00;
                    if (deduct_score == 0 && _qualischeck == "1" && (computesign != "1" && computesign != "2" && computesign != "3" && computesign != "4" && computesign != "5")) {
                        if (!qualCheck(datas[i])) {
                            return false;
                        }
                    }
                    if (_ind_remarkname && computesign == "6") {
                        var value = data.ind_remark;
                        if (!value || value == null || value == "") {
                            Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + _ind_remarkname + "为必录项，必须有值。",{timeout:1},function(){});
                            return false;
                        }
                    }
                }
            }
            j++;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.bustype = _bustype;
        params.mainguid = _mainguid; //主键GUID.
        params.projguid = _projguid; //项目GUID.
        params.procode = _procode; //项目code
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        if(!datas || datas.length == 0) {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }
        var rs = Ext.lt.RCP.asyncall(serviceid, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            if (_pagetype == "audit") {
                Ext.lt.ui.alert("保存成功", {timeout: 1}, function () { });
            }
            cmp.query();
        }
        return rs;
    }

    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var params = {};
        var datas = datatable.getRecordSet().toArray();
        params.data = datatable.getRecordSet().toArray();
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        if(!datas || datas.length == 0) {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        var oldvalue;
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if(col["colcode"] == "kpi_remark"){
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3") {
                        return false;
                    }
                }
            }

            if(col["colcode"] == "opinion_remark" || col["colcode"] == "audit_score"){
                upcols.push(col["colcode"]);
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1" || _pagetype != "audit") {
                        return false;
                    }
                }
            }

            if(col["colcode"]=="ncindexval"){
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1"){
                        var indexvalue = !data.ncindexval? "" : data.ncindexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data["meterunit"]){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.ncindexval ? computesignstr + unit :computesignstr + data.ncindexval + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
            }
            if(col["colcode"]=="indexval"){
                col.fn = function(l,c,data,col){
                    if(data.computesign == "6"|| data.computesign == "9" || data.computesign == "10" || _ismergeindex != "1"){
                        var indexvalue = !data.indexval? "" : data.indexval;
                        return "<font style=\"margin-left:10px;\">" + indexvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(data.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(data["meterunit"]){
                            unit = data.meterunit;
                        }
                        var returnstr = !data.indexval ? computesignstr + unit :computesignstr + data.indexval + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
            }
            if (col["colcode"] == "actualvalue") {
                upcols.push(col["colcode"]);
                col.fn = function(l,c,d,val){
                    if(d.computesign == "6"|| d.computesign == "9" || d.computesign == "10" || _ismergeindex != "1"){
                        var actualvalue = !d.actualvalue? "" : d.actualvalue;
                        return "<font style=\"margin-left:10px;\">" + actualvalue+"</font>";
                    } else {
                        var computesignstr ="";
                        for(var i =0; i<_signs.size() ; i++){
                            if(d.computesign == _signs[i].guid){
                                computesignstr = _signs[i].name;
                            }
                        }
                        var unit = "";
                        if(d.meterunit){
                            unit = d.meterunit;
                        }
                        var returnstr = !d.actualvalue ? computesignstr + unit :computesignstr + d.actualvalue + unit;
                        return "<font style=\"margin-left:10px;\">"+returnstr+"</font>";
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1") {
                        return false;
                    }
                    if(_isSX == '1' && (d.indexval == "" || d.indexval == null)){
                        //山西，年度指标值为空，指标完成之不填
                        return false;
                    }
                    if (_selfindexval != "1" && (d.computesign == "6" || d.computesign == "9" || d.computesign == "10")) {
                        doMapper(_dxzbsource, table.getCol(c));
                        this.config.isMulti = false;
                        return;
                    } else {
                        el.innerText = d.actualvalue != undefined ? d.actualvalue : '';
                        table.getCol(c).mapping = null;
                        table.nowtype="input";
                        table.getCol(c).format = "";
                        return;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if(d.computesign && d.computesign != '6' && d.computesign != '9' && d.computesign != '10'){
                        if (!d.actualvalue || d.actualvalue == "") {
                            d.warn = '';
                            return false;
                        }
                        if(!checkReferencepoles(d.actualvalue)){ // 数字校验
                            d.actualvalue = '';
                            d.warn = '';
                            return false;
                        }
                    }
                    var actualweight;
                    if(_isZJ == "1"){
                        actualweight = d.weight ? d.weight : 0;
                    }else {
                        actualweight = d.actualweight ? d.actualweight : 0;
                    }
                    var isnumber = false;
                    if(_isHebei == "1"){
                        if (d.computesign != "6" && actualweight != 0) {
                            isnumber = isNumber(Number(d.weight));
                        }
                    }else if(_isZJ == "1"){//浙江所有定向正向反向都走计算公式
                        if ( actualweight != 0) {
                            isnumber = isNumber(Number(d.weight));
                        }
                    } else { //通版、浙江所有定向正向反向都走计算公式
                        if ( actualweight != 0) {
                            isnumber = isNumber(Number(d.weight));
                        }
                    }
                    if (actualweight && isnumber && d.datatype !="selfframe"
                        && (((d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5") && _rationscore != "1")
                            || (d.computesign == "6" && _qualscore != "1"))) {
                        Ext.lt.pmkpi.warn(d);
                    }
                    var deduct_score = d.deduct_score ? getPointNum(parseFloat(d.deduct_score)) : 0.00;
                    if (deduct_score == 0 && d.datatype != "selfframe" && d.computesign == "6" && _qualischeck == "1" && d.actualweight && d.score) { //校验得分区间
                        qualCheck(d);
                    }
                    if (_isGX) {
                        if (deduct_score > 0 && (d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5")) {
                            var scores = d.score ? getPointNum(parseFloat(d.score)) : 0.00;
                            var s = floatSub(scores, deduct_score);
                            if (s <= 0) {
                                s = 0;
                            }
                            d.score = s;
                        }

                    }
                    gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if (col["colcode"] == "weight") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    var  weight = data.weight ? data.weight : 0.00;
                    if (data.isleaf == "0") {
                        return "<b>" + Math.round(weight * 100) / 100 + "</b>";
                    } else {
                        return weight;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1") {
                        return false;
                    }
                    var actualvalue = d.actualvalue ? d.actualvalue : 0;
                    var actualweight = d.actualweight ? d.actualweight : 0;
                    var isnumber = false;
                    if(_isHebei == "1"){
                        if (d.computesign != "6" && actualvalue != 0) {
                            isnumber = isNumber(Number(d.weight));
                        }
                    } else { //通版、浙江所有定向正向反向都走计算公式
                        if ( actualweight != 0) {
                            isnumber = isNumber(Number(d.weight));
                        }
                    }
                    if (actualvalue && isnumber && d.datatype !="selfframe"
                        && (((d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5") && _rationscore != "1")
                            || (d.computesign == "6" && _qualscore != "1"))) {
                        Ext.lt.pmkpi.warn(d);
                    }
                    var deduct_score = d.deduct_score ? getPointNum(parseFloat(d.deduct_score)) : 0.00;
                    if (deduct_score == 0 && d.datatype != "selfframe" && d.computesign == "6" && _qualischeck == "1" && d.actualweight && d.score) { //校验得分区间
                        qualCheck(d);
                    }
                    gatherScore(d.superid);
                    gatherWeightAll(d.superid); // 一二级汇总
                    amtTotal(datatable);  //汇总到合计行
                }
            }

            if (col["colcode"] == "actualweight") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    var  actualweight = data.actualweight ? data.actualweight : 0.00;
                    if (data.isleaf == "0") {
                        return "<b>" + Math.round(actualweight * 100) / 100 + "</b>";
                    } else {
                        return actualweight;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1") {
                        return false;
                    }
                    if(_isSX == '1' && (d.indexval == "" || d.indexval == null)){
                        //山西，年度指标值为空，指标完成之不填
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1") {
                        return false;
                    }
                    var actualvalue = d.actualvalue ? d.actualvalue : 0;
                    var actualweight = d.actualweight ? d.actualweight : 0;
                    var isnumber = false;
                    if(_isHebei == "1"){
                        if (d.computesign != "6") {
                            isnumber = isNumber(Number(d.actualvalue));
                        }
                    } else { //通版、浙江所有定向正向反向都走计算公式
                        if ( actualweight != 0) {
                            isnumber = isNumber(Number(d.weight));
                        }
                    }
                    var score = d.score ? getPointNum(parseFloat(d.score)) : 0.00;
                    //处理得分必须小于权重
                    if (score > actualweight) {
                        d.score = 0;
                        d.audit_score = 0;
                    }
                    if (actualvalue && isnumber && d.datatype !="selfframe"
                        && (((d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5") && _rationscore != "1")
                            || (d.computesign == "6" && _qualscore != "1"))) {
                        Ext.lt.pmkpi.warn(d);
                    }
                    var deduct_score = d.deduct_score ? getPointNum(parseFloat(d.deduct_score)) : 0.00;
                    if (deduct_score == 0 && d.datatype != "selfframe" && d.computesign == "6" && _qualischeck == "1" && d.actualweight && d.score) { //校验得分区间
                        qualCheck(d);
                    }
                    if (_isGX) {
                        if (deduct_score > 0 && (d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5")) {
                            var scores = d.score ? getPointNum(parseFloat(d.score)) : 0.00;
                            var s = floatSub(scores, deduct_score);
                            if (s <= 0) {
                                s = 0;
                            }
                            d.score = s;
                        }
                    }
                    gatherScore(d.superid);
                    gatherWeightAll(d.superid); // 一二级汇总
                    amtTotal(datatable);  //汇总到合计行
                }
            }

            if (col["colcode"] == "score") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    var score = data.score ? data.score : 0.00;
                    if (data.isleaf == "0") {
                        return "<b>" + Math.round(score * 100) / 100 + "</b>";
                    } else {
                        var scorepercentage = _scorepercentage != undefined ? _scorepercentage : 1.2;
                        var actualvalue = data.actualvalue ? getPointNum(parseFloat(data.actualvalue)) : 0.00;
                        var indexval = data.indexval ? getPointNum(parseFloat(data.indexval)) : 0.00;
                        if(_isHebei == "1" && (data.computesign == "1" || data.computesign == "2" )){
                            if (actualvalue >= floatMul(indexval,scorepercentage) && indexval != 0) {
                                data.isscoreEdit = 1;
                                return "<a style='color:#FF0000'>" + score + "</a>";
                            } else {
                                data.isscoreEdit = 0;
                            }
                        }
                        //2024-04-28 天津市局:反向指标，实际完成值如果大于指标指标值，实际得分需要标为红色并且可修改
                        if(_isHebei == "1" && (data.computesign == "4" || data.computesign == "5")){
                            if (actualvalue > indexval) {
                                data.isscoreEdit = 1;
                                return "<a style='color:#FF0000'>" + score + "</a>";
                            } else {
                                data.isscoreEdit = 0;
                            }
                        }
                        //2024-05-09 天津市局:计算符号为等于的指标，实际完成值如果不等于指标值，实际得分需要标为红色并且可修改
                        if(_isHebei == "1" && data.computesign == "3" ){
                            if (actualvalue != indexval) {
                                data.isscoreEdit = 1;
                                return "<a style='color:#FF0000'>" + score + "</a>";
                            } else {
                                data.isscoreEdit = 0;
                            }
                        }
                        if ((data.computesign == "1" || data.computesign == "2" || data.computesign == "3") && _isHebei != "1") {
                            if (actualvalue >= floatMul(indexval,scorepercentage) && indexval != 0) {
                                data.isscoreEdit = 1;
                                return "<a style='color:#FF0000'>" + score + "</a>";
                            } else {
                                data.isscoreEdit = 0;
                            }
                        }
                        return score;
                    }
                }
                //浙江正向指标需要可以手动更改得分
                col.oneditstart = function (table, el, l, c, d) {

                    if(_isHebei == "1"){
                        if ((d.computesign != "1" || d.computesign != "2" ) && d.isscoreEdit != 1 && d.computesign != "6") {
                            return false;
                        }
                        if(d.levelno != "3"){
                            return false;
                        }
                    }else{
                        if ((d.levelno != "3" || d.isedit != "1"
                            || ((d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5") && _rationscore == "3" && d.datatype !="selfframe")
                            || (d.computesign == "6" && _qualscore == "3" && d.datatype !="selfframe")
                            ) && d.isscoreEdit != 1) {
                            return false;
                        }
                        if(_isSX == '1' && (d.indexval == "" || d.indexval == null)){
                            //山西，年度指标值为空，得分不填
                            d.score = 0;
                            return false;
                        }
                    }
                }

                col.oneditend = function (table, el, l, c, d) {
                    var actualweight = 0;
                    if(_isZJ == "1"){
                        actualweight = d.weight ? getPointNum(parseFloat(d.weight)) : 0.00;
                    }else {
                        actualweight = d.actualweight ? getPointNum(parseFloat(d.actualweight)) : 0.00;
                    }
                    var score = d.score ? getPointNum(parseFloat(d.score)) : 0.00;
                    //处理得分必须小于权重
                    if (score > actualweight) {
                        Ext.lt.ui.alert("得分必须小于等于权重！", {timeout: 1}, function () { });
                        d.score = 0;
                    }
                    var deduct_score = d.deduct_score ? getPointNum(parseFloat(d.deduct_score)) : 0.00;
                    if (deduct_score == 0 && d.datatype != "selfframe" && d.computesign == "6" && _qualischeck == "1" && d.actualweight && d.score) { //校验得分区间
                        qualCheck(d);
                    }
                    gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if (col["colcode"] == "audit_score") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    var audit_score = !data.audit_score ? 0.00 : data.audit_score;
                    if (data.isleaf == "0") {
                        return "<b>" + Math.round(audit_score * 100) / 100 + "</b>";
                    } else {
                        return audit_score;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    var actualweight;
                    if(_isZJ == "1"){
                        actualweight = d.weight ? getPointNum(parseFloat(d.weight)) : 0.00;
                    }else {
                        actualweight = d.actualweight ? getPointNum(parseFloat(d.actualweight)) : 0.00;
                    }
                    var audit_score = d.audit_score ? getPointNum(parseFloat(d.audit_score)) : 0.00;
                    //处理得分必须小于权重
                    if (audit_score > actualweight) {
                        Ext.lt.ui.alert("核查分数必须小于等于权重！", {timeout: 1}, function () { });
                        d.audit_score = 0;
                    }
                    gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if (col["colcode"] == "deduct_score") {
                upcols.push(col["colcode"]);
                col.fn = function (l, c, data, col) {
                    var deduct_score = !data.deduct_score ? 0.00 : data.deduct_score;
                    if (data.isleaf == "0") {
                        return "<b>" + Math.round(deduct_score * 100) / 100 + "</b>";
                    } else {
                        return deduct_score;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    oldvalue = d["deduct_score"];
                    if (d.levelno != "3" || d.isedit != "1") {
                        return false;
                    }
                }

                col.oneditend = function (table, el, l, c, d) {
                    if (oldvalue == d.deduct_score) {
                        return;
                    }
                    if (_isGX) {
                        var deduct_score = d.deduct_score ? getPointNum(parseFloat(d.deduct_score)) : 0.00;
                        var actualvalue = d.actualvalue ? d.actualvalue : 0;
                        if (actualvalue
                            && (((d.computesign == "1" || d.computesign == "2" || d.computesign == "3" || d.computesign == "4" || d.computesign == "5") && _rationscore != "1"))) {
                            Ext.lt.pmkpi.warn(d);
                        }
                        if (deduct_score == 0 && d.datatype != "selfframe" && d.computesign == "6" && _qualischeck == "1" && d.actualvalue && d.score) { //校验得分区间
                            qualCheck(d);
                        }
                        var scores = d.score ? getPointNum(parseFloat(d.score)) : 0.00;
                        var s = floatSub(scores, deduct_score);
                        if (s <= 0) {
                            s = 0;
                        }
                        d.score = s;
                    }
                    gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if(col["colcode"]=="file"){
                col.style = " text-align:center;";
                col.fn = function(l, c, data, val){
                    var name = "上传附件"
                    if (_viewtype == "query") {
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
                    params.filetype = _bustype + "selfindexfile";
                    params.viewtype = _viewtype;
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

            if (_viewtype == 'query' && !config[col.colcode]  && col["name"] != "check" && col["colcode"] != "file") {
                if (_pagetype == "audit" && (col["colcode"] == "opinion_remark" || col["colcode"] == "audit_score")) {
                    continue;
                }
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
                            if (d.levelno != "3" || d.isedit != "1") {
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

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        commcmp.initDatatable();
        cmp.query(true);
        var col = datatable.getCol('opinion_remark');
        if (_pagetype == "audit" && col && col.isvisiable == 1) {
            datatable.getCol('opinion_remark').edit = true;
            datatable.getCol('audit_score').edit = true;
            commcmp.changToolShowbuttont("save,ahexpdoc");
        } else if (_viewtype == "query") {
            if (_isAH) {
                commcmp.changToolShowbuttont("ahexpdoc");
            } else {
                $("div[compid='toolbutton']").hide();
            }
        } else {
            commcmp.changTooltoolbuttontStatus(0,"保存");
        }
        var isShowbtn = false;
        var buttons = toolbutton.cfg.data.buttons;
        for(var i=0,length = buttons.length;i<length;i++){
            var btn = buttons[i];
            if(btn.isvisiable == 1){
                isShowbtn = true;
            }
        }
        if (!isShowbtn) {
            $("div[compid='toolbutton']").hide();
        }
        if (datatable.getCol("kpi_remark")) {
            _kpi_remarkname = datatable.getCol("kpi_remark").alias;
        } else {
            _kpi_remarkname = "偏差原因及改进措施";
        }
        if (datatable.getCol("actualweight")) {
            _actualweightname = datatable.getCol("actualweight").alias;
        } else {
            _actualweightname = "权重";
        }
        if (datatable.getCol("ind_remark") && datatable.getCol("ind_remark").display) {
            _ind_remarkname = datatable.getCol("ind_remark").alias;
        }
    })

    //模板导出
    cmp["expdoc"] = function(btn){
        var btnconfig = eval('(' + btn.config + ')');
        var _tempatecode;
        var reporttype;//导出报告类型，一般监控报告，项目、部门整体报告
        var guids = [_mainguid];
        var param = {};
        if (_bustype == "program") {
            _tempatecode = btnconfig.protempatecode;
            reporttype = btnconfig.proexptype
        } else if (_bustype == "dept") {
            _tempatecode = btnconfig.depttempatecode;
            reporttype = btnconfig.deptexptype
        }
        param.guids = guids;
        param.templatecode = _tempatecode;
        param.exptype = _bustype;
        param.reporttype = reporttype;
        param.bobeanid = "pmkpi.perfSelf.PerfSelfApplyBOTX";
        Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord',param,"downframe");
        var rcpconsole=document.getElementsByClassName('rcpconsole');
        for(i=0;i<rcpconsole.length;i++){
            rcpconsole.item(i).style.display = 'none';
        }
        Ext.lt.ui.loadingClose();
    }

    //导入
    cmp.impdata = function (btn) {
        var btnconfig = eval('(' + btn.config + ')');
        _impguid = createUUID().replace(/-/g, '');
        var params = {};
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid; //项目绩效目标
        params.procode = _procode; //项目code
        params.bustype = _bustype;
        params.agencyguid = _saveAgency;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        params.impexpcode = btnconfig[_bustype];
        params.beanid = "pmkpi.perfSelf.SelfIndexBOTX";
        params.expfilename = btnconfig[_bustype + "expname"];
        params.bustype = _bustype;
        params.impguid = _impguid;
        impexp.imp(params, function (){
            window.parent.Ext.lt.outfile.window.close();
            parent.Ext.lt.ui.alert("导入成功！", function () {
            });
            parent.Ext.lt.pmkpi.impsucess();
        });
    }

    Ext.lt.pmkpi.impsucess = function () {
        var params = {};
        params.impguid = _impguid;
        var datas = Ext.lt.RCP.asyncall(serviceid , "impDatas", params);
        if (datas.length > 0) {
            var filterdatas = datatable.getRecordSet().query({isleaf: 1});
            datatable.removeData(filterdatas);
            var indexdatas = datatable.getRecordSet().toArray();
            datatable.setDatas(indexdatas.concat(datas));
            setTimeout(function () {
                var superid = "";
                for (var i = 0; i < datas.length; i++) {
                    var d = datas[i];
                    if (d.superid != superid) {
                        gatherScore(d.superid);
                        gatherWeightAll(d.superid);
                    }
                    superid = d.superid;
                }
                amtTotal(datatable);
            }, 500);
        }
    }

    return cmp;
}

/**
 * 只能输入数字校验
 * @param referencepole
 * @returns {boolean}
 */
function checkReferencepoles (str){
    var re = /^(-?\d+)\.?(\d*)$/;//支持录入负数
    if(!re.test(str)){
        Ext.lt.ui.alert("定量指标的指标值为数值！");
        return false;
    }else{
        return true;
    }
}

/**
 * 自评得分计算规则
 * @param d
 */
Ext.lt.pmkpi.warn = function (d) {
    var params = {};
    params.indexval = d.indexval;  //指标值
    params.actualvalue = d.actualvalue;//实际完成值
    //判断实际完成值为负数，默认赋值为0
    if(d.actualvalue < "0"){
        params.actualvalue = "0";//实际完成值赋值为0
    }
    params.weight = d.actualweight;//实际权重值
    /**
     * 正向指标-绩效自评    selfpositiveindex
     * 等于指标-绩效自评    selfequalindex
     * 反向指标-绩效自评    selfreverseindex
     * 定性指标-绩效自评    selfqualitativeindex
     */
    if (d.computesign == "1" || d.computesign == "2") {
        params.warmtype = "selfpositiveindex"; //正向指标
    } else if (d.computesign == "3") { //等于指标
        if (d.indexval && d.indexval == 0) {
            params.warmtype = "selfindexequalzero";
        } else {
            params.warmtype = "selfequalindex";
        }
    } else if (d.computesign == "4" || d.computesign == "5") { //反向指标
        params.warmtype = "selfreverseindex";
    }
    if(_isHebei == "1"){
        if (d.computesign == "4") {
            params.warmtype = "selfreverseindex";
        }else if (d.computesign == "5") {
            params.warmtype = "selfreverseandequalindex";
        }
    }else if(_isZJ == "1") {
        params.weight = d.weight;//设定权重值
        if(d.computesign == "6"){
            params.warmtype = "selfqualitativeindex";
        }
    }
    if (!params.warmtype || params.warmtype == "") {
        return 0;
    }
    var warndata = Ext.lt.RCP.asyncall(serviceid, "getWarn", params);
    if (warndata && warndata != "") {
        var parent_sel_rows = datatable.getRecordset().query({guid: d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["score"] = warndata;
        datatable.reflash(_sortid);
    }
    return warndata;
}

function getPointNum(num) {
    var str = String(num);
    var index = str.split(".");
    var str1 = null;
    if (index.length == 2) {
        str1 = index[1].substring(0, 2);
        str1 = Number(index[0] + "." + str1);
    } else {
        str1 = Number(index[0]);
    }
    return str1;
}

function doMapper(rs, col) {
    var mapping = [];
    var columns = [];
    for (var i = 0; i < rs.size(); i++) {
        var arr = [];
        arr.push(rs[i].guid);
        arr.push(rs[i].code);
        arr.push(rs[i].name);
        columns.push(arr);
        mapping[rs[i].code] = arr;
    }
    col.mapping = mapping;
    col.mapper = {};
    col.mapper.columns = ['guid', 'code', 'name', 'supcode', 'pinyin'];
    col.mapper.datas = columns;
    col.mapper.regs = ['#guid', '#code', '#name', '#supcode', '#pinyin'];
    col.mapper.default_column = 'code';
    col.format = '#name';
}


function gatherScore(superid) {
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0;
            var audit_result = 0;
            var deduct_result = 0;
            var guid = '';
            for (var i = 0; i < datas.length; i++) {
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.score && !isNaN(selectDatas.score)) {
                    result += parseFloat(selectDatas.score);
                }
                if (selectDatas.superid == superid && selectDatas.audit_score && !isNaN(selectDatas.audit_score)) {
                    audit_result += parseFloat(selectDatas.audit_score);
                }
                if (selectDatas.superid == superid && selectDatas.deduct_score && !isNaN(selectDatas.deduct_score)) {
                    deduct_result += parseFloat(selectDatas.deduct_score);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['score'] = result == 0.00 ? "" : result.toFixed(2);
                    datas[i]['audit_score'] = audit_result == 0.00 ? "" : audit_result.toFixed(2);
                    datas[i]['deduct_score'] = deduct_result == 0.00 ? "" : deduct_result.toFixed(2);
                }
            });
            gatherScore(supguid);
        }
    }
    datatable.reflash();
}

/**
 * 合计列汇总权重和得分
 */
function amtTotal(table) {
    var totalrow = table.getRecordset();
    var weightsumamt = 0;
    var actualweightsumamt = 0;
    var ownscoresumamt = 0;
    var audit_scoresum = 0;
    var deduct_scoresum = 0;
    var rowarr = totalrow.toArray();
    var len = rowarr.length;
    for (var i = 0; i < len; i++) {
        if (rowarr[i].isleaf == "1" && rowarr[i].levelno == "3") {
            var ownscore = rowarr[i]["score"] ? rowarr[i]["score"] : 0.00;
            ownscoresumamt += parseFloat(ownscore);
            var audit_score = rowarr[i]["audit_score"] ? rowarr[i]["audit_score"] : 0.00;
            audit_scoresum += parseFloat(audit_score);
            var deduct_score = rowarr[i]["deduct_score"] ? rowarr[i]["deduct_score"] : 0.00;
            deduct_scoresum += parseFloat(deduct_score);
        }
        if (rowarr[i].levelno == "3") {
            var actualweight = rowarr[i]["actualweight"] ? rowarr[i]["actualweight"] : 0.00;
            actualweightsumamt += parseFloat(actualweight);
        }
        if (rowarr[i].levelno == "1") {
            var weight = rowarr[i]["weight"] ? rowarr[i]["weight"] : 0.00;
            weightsumamt += parseFloat(weight);
        }
    }
    var totalrs = {};
    _weight_sum = (weightsumamt ? weightsumamt.toFixed(2) : "0.00");
    totalrs["weight"] = _weight_sum;
    totalrs["actualweight"] = (actualweightsumamt ? actualweightsumamt.toFixed(2) : "0.00");
    totalrs["score"] = (ownscoresumamt ? ownscoresumamt.toFixed(2) : "0.00");
    totalrs["audit_score"] = (audit_scoresum ? audit_scoresum.toFixed(2) : "0.00");
    totalrs["deduct_score"] = (deduct_scoresum ? deduct_scoresum.toFixed(2) : "0.00");
    totalrs.datatable_do_sum = true;
    table.getClockRowSet().setData(totalrs, 0);
    if ((totalrow.size && totalrow.size() > 0) || (totalrow.length && totalrow.length > 0)) {
        table.reflashdata();
    }
}

/**
 * 权重三级汇总二级然后汇总一级
 * @param superid
 */
function gatherWeightAll(superid) {
    var datas = datatable.getRecordSet().toArray();
    if (superid) {
        if (datas != null && datas.length > 0) {
            var supguid = '';
            var result = 0;
            var guid = '';
            for (var i = 0; i < datas.length; i++) { //计算二级权重汇总
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if(_isZJ == "1"){
                    if (selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)) {
                        result += parseFloat(selectDatas.weight);
                    }
                }else {
                    if (selectDatas.superid == superid && selectDatas.actualweight && !isNaN(selectDatas.actualweight)) {
                        result += parseFloat(selectDatas.actualweight);
                    }
                }

            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    if(_isZJ == "1"){
                        datas[i]['weight'] = result == 0.00 ? "" : result.toFixed(2);
                    }else {
                        datas[i]['actualweight'] = result == 0.00 ? "" : result.toFixed(2);
                    }
                }
            });
            gatherWeightAll(supguid); //递归汇总一级的
        }
    }
    datatable.reflash();
}

/**
 * 权重校验并赋值
 */
function weightCheckNew() { // 不根据参数区分一二级权重，二级有设置权重则校验，无则校验一级权重设定值
    var flag = true;
    var datas = datatable.getRecordSet().toArray();
    if (datas != null && datas.length > 0) {
        var result = 0;
        var checkweight = 0;
        var index = "";
        var oldindex = "";
        var weightsum = 0;
        var indexname = "";
        for (var i = 0; i < datas.length; i++) { //校验二级指标
            var tempObj = datas[i];
            var levelno = tempObj.levelno;
            var actualweight = tempObj.actualweight;//权重
            if(_isZJ == "1"){
                actualweight = tempObj.weight;//权重
            }
            if (levelno == "2") {
                index = tempObj.guid;
                if (oldindex == "") {
                    oldindex = index;
                    indexname = tempObj.name;
                    checkweight = !tempObj.weight ? 0 : tempObj.weight;
                }
            }
            if (levelno == "3") {
                if (actualweight) {
                    result = floatAdd(result, actualweight);
                }
            }
            if (index != oldindex || i == datas.length-1) {
                if(checkweight != result && checkweight != 0){
                    if(i == datas.length-1){
                        levelno = "2";
                    }
                    Ext.lt.ui.alert(levelno + "级指标：" + indexname + "的下级指标" + _actualweightname + "录入合计应等于上级设置数", {timeout: 1}, function () { });
                    return false;
                }
                result = 0;
                oldindex = index;
                indexname = tempObj.name;
                checkweight = !tempObj.weight ? 0 : tempObj.weight;
            }
        }
        result = 0;
        checkweight = 0;
        index = "";
        oldindex = "";
        indexname = "";
        for (var i = 0; i < datas.length; i++) { //校验一级指标
            var tempObj = datas[i];
            var levelno = tempObj.levelno;
            var actualweight = tempObj.actualweight;//权重
            if(_isZJ == "1"){
                actualweight = tempObj.weight;//权重
            }
            if (levelno == "1") {
                index = tempObj.guid;
                if (oldindex == "") {
                    oldindex = index;
                    indexname = tempObj.name;
                    checkweight = !tempObj.weight ? 0 : tempObj.weight;
                }
            }
            if (levelno == "3") {
                if (actualweight) {
                    result = floatAdd(result, actualweight);
                    weightsum = floatAdd(weightsum, actualweight);
                }
            }
            if (index != oldindex || i == datas.length-1) {
                if(checkweight != result){
                    if(i == datas.length-1){
                        levelno = "1";
                    }
                    Ext.lt.ui.alert(levelno + "级指标：" + indexname + " 的下级指标" + _actualweightname + "录入应等于上级设置数！", {timeout: 1}, function () { });
                    return false;
                }
                result = 0;
                oldindex = index;
                indexname = tempObj.name;
                checkweight = !tempObj.weight ? 0 : tempObj.weight;
            }
        }
        weightsum = weightsum.toFixed(2);
        if(_weight_sum && weightsum != _weight_sum){ // 汇总三级不得大于九十
            Ext.lt.ui.alert("权重设定值合计为：" + weightsum + ", 总和应等于" + _weight_sum + "！", {timeout: 1}, function () { });
            flag = false;
        }
    }
    return flag;
}

/**
 * 定性指标区间规则
 */
function qualCheck(d) {
    var flag = true;
    var params = {};
    var indexname = d.name;
    var parent_sel_rows = datatable.getRecordset().query({guid: d.superid});
    var parent_sel_obj = parent_sel_rows[0];
    var sindexname = parent_sel_obj.name;
    params.warmtype = "selfqualscorecheck"; //正向指标
    params.weight = !d.actualweight ? 0 : d.actualweight;//实际权重值
    params.actualvalue = d.actualvalue;//实际完成值
    params.score = !d.score ? 0 : d.score;//实际完成值
    var warndata = Ext.lt.RCP.asyncall(serviceid, "getWarn", params);
    if (warndata && warndata != "1") {
        /**  XX-二级指标名称； MM-三级指标名称
         * 达成年度指标                XX指标：MM指标的实际得分区间为[权重*80%(含)-权重]，请调整后再保存。
         部分达成年度指标并具有一定效果    XX指标：MM指标的实际得分区间为[权重*60%(含)-权重*80%]，请调整后再保存。
         未达成年度指标且效果较差        XX指标：MM指标的实际得分区间为[0-权重*60%]，请调整后再保存。
         */
        d.score = 0;
        var parent_sel_rows = datatable.getRecordset().query({guid: d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["score"] = d.score;
        datatable.reflash(_sortid);
        Ext.lt.ui.alert(sindexname + "指标：" + indexname + "指标的实际得分区间为[" + warndata + "]，请调整后再保存。", {timeout: 1}, function () {});
        return false;
    }
    return flag;
}

function actualValueCheck(){
    //广西 实际完成值（ACTUALVALUE）大于等于指标值（INDEXVAL）的130%时，偏差原因及整改措施必填
    //130%可配置，考虑本次时间问题可以先写死，后面再优化，具体看任务安排)
    var datas = datatable.getRecordSet().toArray();
    if (datas != null && datas.length > 0) {
        for (var i = 0; i < datas.length; i++) { //校验一级指标
            var computesign = datas[i].computesign;  //计算符号
            var indexval = datas[i].indexval ? datas[i].indexval : 0;  //指标值
            indexval = parseFloat(indexval);
            var actualvalue = datas[i].actualvalue ? datas[i].actualvalue : 0;  //实际完成值
            actualvalue = parseFloat(actualvalue);
            var kpiremark = datas[i].kpi_remark;  //实际完成值
            if(datas[i].isleaf != "0" && (computesign != "" || computesign != null) && (kpiremark == null || kpiremark == "")
                && computesign != "6" && computesign != "9" && computesign != "10"){
                if (indexval == 0){
                    if (actualvalue >= 30){
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行" + _kpi_remarkname + "必填,（因实际完成情况超出指标值30%，需填写'实际完成情况超计划较大'的说明）");
                        return false;
                    }
                }else {
                    if (actualvalue >= (floatMul(indexval,1.3))){
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行" + _kpi_remarkname + "必填,（因实际完成情况超出指标值30%，需填写'实际完成情况超计划较大'的说明）");
                        return false;
                    }
                }
            }
        }
    }
    return true;
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