if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.gdfinindex) {
    Ext.lt.pmkpi.gdfinindex = {};
}
var serviceid;
var _mainguid;
var _saveAgency;
var _viewtype;
var _dxzbsource;//定性指标数据源
var _weight_sum;
var _isCheckWeightGtZero;
var _qualischeck;
var _kpi_remarkname;
var _actualweightname;
Ext.lt.pmkpi.gdfinindex = function (config, service) {
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
        _pagetype = config.pagetype;
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    _dxzbsource = config.dxzbsource;
    _saveAgency = config.saveAgency;
    _mainguid = config.mainguid;
    _viewtype = config.viewtype;
    _isCheckWeightGtZero = config.isCheckWeightGtZero;
    _qualischeck = config.qualischeck; //是否校验定性指标区间： 1或null-是；2-否；（默认为null）
    serviceid = service;
    var cmp = {};


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

    cmp.indexCheckAll = function (){
        var cols = datatable.getCols(); //获取列表所有列
        var datas = datatable.getRecordSet().toArray();
        for (var j = 0,lenj = cols.length; j < lenj; j++) {
            for (var i = 0,leni = datas.length; i < leni; i++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3 && _viewtype != 'query') {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        return false;
                    }
                }
            }
        }
        return true;
    }

    cmp.save = function () {
        if (!cmp.indexCheckAll()) return false;//先校验
        var datas = datatable.getRecordSet().toArray();
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.bustype = _bustype;
        params.mainguid = _mainguid; //主键GUID.
        params.projguid = _projguid; //项目GUID.
        params.procode = _procode; //项目code
        params.saveAgency = _saveAgency;
        params.url = datatable.config.pageurl;
        Ext.lt.ui.loadingShow();
        if(!datas || datas.length == 0) {

        }
        if (_viewtype != 'query'){
            var rs = Ext.lt.RCP.asyncall(serviceid, "save", params);
            Ext.lt.ui.loadingClose();
            if (rs && rs.success) {
                if (_pagetype == "audit") {
                    Ext.lt.ui.alert("保存成功", {timeout: 1}, function () { });
                }
                cmp.query();
            }
            return rs;
        } else {
            var rs = {};
            rs.success = true;
            Ext.lt.ui.loadingClose();
            return rs;
        }


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
        var flag = 1;
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (_viewtype == "query") {
                flag = 2;
                col.style = "background-color:#f2f2f2;";
            }
            if (col["colcode"] == "actualvalue") {
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
                    if (d.levelno != "3" || d.isedit != "1" || flag != 1) {
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
                    var actualweight = d.weight ? d.weight : 0;

                    var isnumber = false;
                    if (actualweight != 0) {
                        isnumber = isNumber(Number(d.weight));
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
                    gatherScore(d.superid);
                    amtTotal(datatable);
                }
            }

            if (col["colcode"] == "weight") {
                col.fn = function (l, c, data, col) {
                    var  weight = data.weight ? data.weight : 0.00;
                    if (data.isleaf == "0") {
                        return "<b>" + Math.round(weight * 100) / 100 + "</b>";
                    } else {
                        return weight;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1" || flag != 1) {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    var actualvalue = d.actualvalue ? d.actualvalue : 0;
                    var actualweight = d.actualweight ? d.actualweight : 0;
                    var isnumber = false;
                    if ( actualweight != 0) {
                        isnumber = isNumber(Number(d.weight));
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
            if (col["colcode"] == "eval_value") {
                col.fn = function (l, c, data, col) {
                    var  eval_value = data.eval_value ? data.eval_value : 0.00;
                    if (data._isleaf == "0") {
                        return "<b>" + Math.round(eval_value * 100) / 100 + "</b>";
                    } else {
                        return eval_value;
                    }
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1" || flag != 1) {
                        return false;
                    }
                }
                col.oneditend = function (table, el, l, c, d) {
                    gatherWeightAll(d.superid); // 一二级汇总
                    amtTotal(datatable);  //汇总到合计行
                }
            }
            if (col["colcode"] == "devi_analy") {
                col.fn = function (l, c, data, col) {
                    return data.devi_analy;
                }
                col.oneditstart = function (table, el, l, c, d) {
                    if (d.levelno != "3" || d.isedit != "1" || flag != 1) {
                        return false;
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
        if(datatable.getCol("actualweight")){
            _actualweightname = datatable.getCol("actualweight").alias;
        }else {
            _actualweightname = "权重";
        }
    })

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
    params.weight = d.weight;//设定权重值
    if(d.computesign == "6"){
        params.warmtype = "selfqualitativeindex";
    }
    if (!params.warmtype || params.warmtype == "") {
        return;
    }
    var warndata = Ext.lt.RCP.asyncall(serviceid, "getWarn", params);
    if (warndata && warndata != "") {
        var parent_sel_rows = datatable.getRecordset().query({guid: d.guid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["score"] = warndata;
        datatable.reflash(_sortid);
    }
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
    var eval_valueamt = 0;
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
            var eval_value = rowarr[i]["eval_value"] ? rowarr[i]["eval_value"] : 0.00;
            eval_valueamt += parseFloat(eval_value);
        }
    }
    var totalrs = {};
    _weight_sum = (weightsumamt ? weightsumamt.toFixed(2) : "0.00");
    totalrs["weight"] = _weight_sum;
    totalrs["eval_value"] =  (eval_valueamt ? eval_valueamt.toFixed(2) : "0.00");
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
            var eval_value = 0;
            var guid = '';
            for (var i = 0; i < datas.length; i++) { //计算二级权重汇总
                var selectDatas = datas[i];
                if (superid == selectDatas.guid) {
                    supguid = selectDatas.superid;
                    guid = selectDatas.guid;
                }
                if (selectDatas.superid == superid && selectDatas.weight && !isNaN(selectDatas.weight)) {
                    result += parseFloat(selectDatas.weight);
                }
                if (selectDatas.superid == superid && selectDatas.eval_value && !isNaN(selectDatas.eval_value)) {
                    eval_value += parseFloat(selectDatas.eval_value);
                }
            }
            datas.each(function (data, i) {
                if (data.guid == guid) {
                    datas[i]['weight'] = result == 0.00 ? "" : result.toFixed(2);
                    datas[i]['eval_value'] = eval_value == 0.00 ? "" : eval_value.toFixed(2);

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
            var actualweight = tempObj.weight;//权重
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
            var actualweight = tempObj.weight;//权重
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
        Ext.lt.ui.alert(sindexname + "指标：" + indexname + "指标的实际得分区间为[" + warndata + "]，请调整后再保存。", {timeout: 1}, function () {});
        return false;
    }
    return flag;
}

